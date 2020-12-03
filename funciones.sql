----------------------------------
-- Definición de Funciones       -
----------------------------------  
create or replace function obtener_edad(persona datos_personales) returns smallint as $$
declare
    intervalo_fechas interval,
    fecha_fin timestamp
begin
    if persona.fecha_fallecimiento is not null then 
        fecha_fin := persona.fecha_fallecimiento::timestamp;
    else 
        fecha_fin := now();
    end if;
    intervalo_fechas = age(fecha_fin, timestamp persona.fecha_nacimiento);
    return ceil(date_part('year', intervalo_fechas))::integer;
end; $$ language plpgsql;

create or replace function obtener_identificacion(persona datos_personales) returns text as $$
begin
    return persona.nombre || ' ' || persona.apellido;
end; $$ language plpgsql;


-- TODO: Agregar métodos diferencia y sumar (Cronometro)
-- TODO: Agregar métodos VelocidadMaxim, VelocidadMinima, DistanciaRecorrida, CantidadVueltas, MejorTiempo, PeorTiempo (Estadistica)
-- TODO: Agregar método AplicarPenalización (falla_tecnica)