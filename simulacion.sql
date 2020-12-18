-- Inscripción de participantes. Esta función se encarga de tomar una lista de candidatos
-- e inscribirlos de una vez en el evento en cuestión.
-- Toma los equipos, los pilotos por equipo, su vehículo a utilizar, y el evento al que se va a inscribir.ll
create or replace function inscripcion(equipo_ids integer[], pilotos_ids integer[][], vehiculo_ids integer[],
                                       evento_id integer) returns void
    language plpgsql
as
$func$
declare
    indice      integer; -- indice de iteración de ID de equipos
    part_id     integer; -- auxiliar para ID de participación generado
    eq_id       integer; -- auxiliar para el ID de equipo de cada row insertado
    pil_id      integer; -- auxiliar para la iteración de pilotos
    num_pilotos integer; -- Número de pilotos por equipo
begin
    num_pilotos := array_length(pilotos_ids, 2);
    -- Las longitudes de equipos, vehiculos y conjuntos de pilotos debe coincidir
    -- Comparamos las diferencias entre cada longitud.
    if array_length(equipo_ids, 1) - array_length(vehiculo_ids, 1) <>
       array_length(vehiculo_ids, 1) - array_length(pilotos_ids, 1) then
        raise EXCEPTION 'Las longitudes de los arrays debe coincidir: % % %', array_length(equipo_ids, 1), array_length(vehiculo_ids, 1), array_length(pilotos_ids,      1);
    end if;
    -- Dinámicamente creamos una vista que se utilizarán en los triggers para calcular, entre otras cosas,
    -- la posición en la parrilla
    execute 'create or replace view participantes as
        select p.finalizo as finalizo,
            p.numero_vueltas as numero_vueltas,
            p.numero_participacion as numero_participacion,
            p.tiempo_total as tiempo_total,
            p.estadisticas_hora as estadisticas_hora,
            p.abandono as abandono,
            p.equipo_tecnico as equipo_tecnico,
            p.puesto_inicio as puesto_inicio,
            e.nombre as nombre_equipo, p2.nombre as nombre_pais from "participacion" p
            join equipo e on p.equipo_id = e.id
            join pais p2 on p2.id = e.pais_id
            join vehiculo v on v.id = p.vehiculo_id
        where p.evento_id = ' || evento_id;
    -- Iteramos sobre todos los equipos que vamos a inscribir
    for indice in 1..array_length(equipo_ids, 1)
        loop
            -- en p_id guardamos el resultado de las inserciones: id y equipo_id
            with p_id as (
                insert into participacion (finalizo, numero_vueltas, numero_participacion,
                                           tiempo_total, estadisticas_hora,
                                           fallas,
                                           abandono, equipo_tecnico, puesto_inicio, vehiculo_id,
                                           equipo_id, evento_id)
                    VALUES (false, -1, -1,
                            interval '0 minutes', ARRAY []::estadistica[], ARRAY []::falla_tecnica[], null,
                            ARRAY []::datos_personales[], -1, vehiculo_ids[indice],
                            equipo_ids[indice], evento_id)
                    RETURNING id, equipo_id)
                 -- ingresamos los valores en nuestras variables temporales
            select id, equipo_id
            into part_id, eq_id
            from p_id;
            -- iteramos sobre los pilotos que están en el mismo índice que los equipos, para insertarlos como participantes de este evento
            for pil_id in 1..num_pilotos
                loop
                    insert into piloto_participacion(piloto_id, participacion_id, equipo_id)
                    VALUES (pilotos_ids[indice][pil_id], part_id, eq_id);
                end loop;
        end loop;
end;
$func$;

-- Función que calcula todas las posiciones por hora de todos los participantes de un id de evento dado
-- El algoritmo general de esta operación es el siguiente:
-- 1. Calculamos la distancia total recorrida
create or replace procedure posiciones_por_hora(ev_id integer)
    language plpgsql
as
$$
declare
    i integer; -- Auxiliar de las horas del evento
begin
    -- iteramos por todas las horas del evento
    for i in 1..24
        loop
            -- guardamos el ID y la posición calculadas en la selección de cada hora
            with est(id, posicion) as (
                select p_1.id, -- para tener un indentificador único
                       -- row_number() nos da el número de fila que está siendo procesado. el número debe ser calculado sobre el ordenamiento descendiente del acumulado de
                       -- las distancias recorridas de todos en la i-ésima hora
                       row_number()
                       over (order by calcular_distancia_recorrida(estadisticas_hora, i) desc) as posicion
                from participacion p_1
                where evento_id = ev_id
                  and estadisticas_hora[i] is not null
            ),
                 mod as (
                     select p_sub.id,
                            array_agg((e.vel_maxima, e.vel_minima, e.vel_media, e.mejor_tiempo_vuelta,
                                       e.peor_tiempo_vuelta,
                                       case when ordinality = i then est.posicion else e.posicion end,
                                       e.distancia_recorrida)::estadistica) as estadisticas_hora
                     from participacion p_sub
                              left join lateral unnest(estadisticas_hora) with ordinality e on true
                              join est on p_sub.id = est.id
                     where p_sub.id = est.id
                     group by p_sub.id
                 )
            update participacion p
            set estadisticas_hora = mod.estadisticas_hora
            from mod
            where p.id = mod.id;
        end loop;
end;
$$;

create or replace function simulacion(ano integer) returns void
    language plpgsql
as
$$
declare
    existe bool;
    eq_ids integer[];
    p_ids  integer[][];
    v_ids  integer[];
    e_id   integer;
begin
    select exists(select * from evento e where tipo = 'carrera' and e.ano = $1) into existe;
    if (existe) then
        select id from evento e where tipo = 'carrera' and e.ano = $1 limit 1 into e_id;
        select array_agg(eq.id)
        into eq_ids
        from equipo eq
                 join participacion p on eq.id = p.equipo_id
                 join evento e2 on p.evento_id = e2.id
        where e2.id = e_id;

        select array_agg(v.id)
        into eq_ids
        from vehiculo v
                 join participacion p on v.id = p.vehiculo_id
                 join evento e2 on p.evento_id = e2.id
        where e2.id = e_id;
        select array_agg(x.c)
        into p_ids
        from (select array_agg(piloto_id order by equipo_id) c from piloto_participacion pp group by equipo_id) x;
    else
        with t as (insert into evento (tipo, ano, longitud) values ('carrera', $1, 13.492) returning id)
        select id
        into e_id
        from t;
        select array_agg(eq.id) into eq_ids from (select e.id from equipo e order by random() limit 30) eq;
        select array_agg(v.id) into v_ids from (select _v.id from vehiculo _v order by random() limit 30) v;
        declare
            aux1 int[];
            aux2 int[];
        begin
            select array_agg(_p.id) into aux1 from (select p.id from piloto p order by random() limit 30) _p;
            select array_agg(_p.id) into aux2 from (select p.id from piloto p order by random() limit 30) _p;
            p_ids := transpose_2d(ARRAY [aux1, aux2]);
            raise notice '%', p_ids;
        end;
    end if;
    perform inscripcion(eq_ids, p_ids, v_ids, e_id);
    call posiciones_por_hora(e_id);
end;
$$;