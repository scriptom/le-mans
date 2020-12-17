create or replace function inscripcion(equipo_ids integer[], pilotos_ids integer[][], vehiculo_ids integer[],
                                       evento_id integer) returns void
    language plpgsql
as
$func$
declare
    indice           integer;
    participacion_id integer;
    piloto_id        integer;
    num_pilotos      integer;
begin
    num_pilotos := array_length(pilotos_ids, 2);
    -- Las longitudes de equipos, vehiculos y conjuntos de pilotos debe coincidir
    -- Comparamos las diferencias entre cada longitud. Y si no
    if array_length(equipo_ids, 1) - array_length(vehiculo_ids, 1) <>
       array_length(vehiculo_ids, 1) - array_length(pilotos_ids, 1) then
        raise EXCEPTION 'Las longitudes de los arrays debe coincidir';
    end if;

    -- Creamos una vista que tendrá los participantes del evento
    execute 'create or replace view participantes as
        select p.finalizo as finalizo,
            p.numero_vueltas as numero_vueltas,
            p.numero_participacion as numero_participacion,
            p.tiempo_total as tiempo_total,
            p.abandono as abandono,
            p.equipo_tecnico as equipo_tecnico,
            p.puesto_inicio as puesto_inicio,
            e.nombre as nombre_equipo, p2.nombre as nombre_pais from "participacion" p
            join equipo e on p.equipo_id = e.id
            join pais p2 on p2.id = e.pais_id
            join vehiculo v on v.id = p.vehiculo_id
        where p.evento_id = ' || evento_id;
    with parts_id as (
        insert into participacion (finalizo, numero_vueltas, numero_participacion,
                                   tiempo_total, estadisticas_hora, fallas, abandono,
                                   equipo_tecnico, puesto_inicio, vehiculo_id, equipo_id, evento_id)
            select false,
                   -1,
                   -1,
                   interval '0 minutes',
                   '{}'::estadistica[],
                   '{}'::falla_tecnica[],
                   null,
                   '{}'::datos_personales[],
                   -1,
                   competidor.vehiculo,
                   competidor.equipo,
                   $4
            from (select unnest($1) as equipo, unnest($3) as vehiculo) as competidor
            returning id, equipo_id
    )
    insert
    into piloto_participacion(piloto_id, participacion_id, equipo_id)
        -- insertamos todas las participaciones de un golpe
    select t.piloto, t.id, t.equipo_id
    from (select unnest(unnest_2d_1d($2)) as piloto, p.id as id, p.equipo_id from parts_id p group by p.id, p.equipo_id) as t;
    --     select p_ids.id
--     into participacion_id
--     from p_ids;
--     for indice in 1..array_length(equipo_ids, 1)
--         loop
--             -- Insertamos los equipos que recibimos con valores por defecto manejables.
--             for piloto_id in 1..num_pilotos
--                 loop
--                     insert into piloto_participacion(piloto_id, participacion_id, equipo_id)
--                     VALUES (pilotos_ids[indice][piloto_id], participacion_id, equipo_ids[indice]);
--                 end loop;
--         end loop;
end;
$func$;
