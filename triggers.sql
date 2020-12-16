create or replace function numero_inscripcion() returns trigger as
$$
declare
    ultima_incripcion integer;
begin
    select count(*) + 1 from participantes into ultima_incripcion;
    new.numero_participacion = ultima_incripcion;
    return new;
end;
$$ language plpgsql;

create trigger numero_inscripcion
    before insert
    on participacion
    for each row
execute function numero_inscripcion();

create or replace function puesto_inicio() returns trigger as
$$
declare
    ultima_posicion integer;
begin
    -- usamos la función coalesce para convertir los NULL en 0
    select coalesce(max(puesto_inicio), 0) + 1 from participantes p into ultima_posicion;
    new.puesto_inicio = ultima_posicion;
    return new;
end;
$$ language plpgsql;

create trigger puesto_inicio
    before insert
    on participacion
    for each row
execute function puesto_inicio();

-- Función a ejecutar luego de la inserción de una participación, para generar
-- las 24 horas de estadísticas
create or replace function participar() returns trigger
    language plpgsql
as
$$
declare
    estadistica          estadistica; -- Auxiliar para la estadística que se genera cada hora
    longitud_circuito    real; -- Longitud del circuito del evento
    velocidad_vehiculo   real; -- Velocidad del vehículo del participante
    umbral_falla_tecnica integer; -- Variable de control para las fallas técnicas
    falla_tecnica        falla_tecnica; -- Auxiliar para fallas técnicas generadas

begin
    select longitud from evento where id = new.evento_id into longitud_circuito;
    select velocidad from vehiculo where id = new.vehiculo_id into velocidad_vehiculo;
    -- Inicializamos el umbral a 3. Cuando salga una falla técnica que afecte el tiempo.
    -- Mientras sea 0, podemos generar fallas técnicas, si no es 0, déjamos que no le pase nada en la carrera
    umbral_falla_tecnica := 0;
    -- Iteramos por las 24 horas de la participación
    for i in 1..24
        loop
            estadistica := generar_estadistica(longitud_circuito, velocidad_vehiculo);
            if umbral_falla_tecnica = 0 then
                falla_tecnica := generar_falla_tecnica();
                declare
                    num_fallas integer; -- Auxiliar para la cantidad de fallas en una participación
                begin
                    if falla_tecnica is not null then
                        umbral_falla_tecnica := 3; -- No es null, entonces aplicamos la falla técnica, y reestablecemos el umbral
                        num_fallas := coalesce(array_length(new.fallas, 1), 0); -- Aplicamos coalesce para igualar a 0 en caso de NULL
                        declare
                            distancia real; -- distancia parcial recorrida
                        begin
                            estadistica.peor_tiempo_vuelta :=
                                    aplicar_penalizacion(falla_tecnica, estadistica.peor_tiempo_vuelta);
                        exception
                            when sqlstate 'GRAVE' then
                                distancia := distancia_recorrida(estadistica.vel_media);
                                new.abandono :=
                                        row (falla_tecnica.parte_afectada, cantidad_vueltas(distancia, longitud_circuito));
                        end;
                        -- Atacamos el siguiente índice de las fallas técnicas
                        new.fallas[num_fallas+1] := falla_tecnica; -- Independientemente de lo que pase, agregamos la falla técnica al conjunto
                    end if;
                end;
            else
                umbral_falla_tecnica := umbral_falla_tecnica - 1; -- Descontamos 1 hora del umbral de fallas técnicas
            end if;
            -- Luego de que hemos modificado la estadística, la podemos agregar
            new.estadisticas_hora[i] := estadistica;
            -- Verificamos si abandonó
            exit when new.abandono is not null;
        end loop;
    if array_length(new.estadisticas_hora, 1) = 24 and
       new.abandono is not null then -- la comprobación con not null es por si acaso falló en la última hora
        new.finalizo := true;
    end if;
    return new;
end;
$$;

create trigger participar
    before insert
    on participacion
    for each row
execute function participar();