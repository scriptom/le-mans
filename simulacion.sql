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
    --     raise notice 'pilotos = %', pilotos_ids[1:1][1:num_pilotos];
    -- Las longitudes de equipos, vehiculos y conjuntos de pilotos debe coincidir
    -- Comparamos las diferencias entre cada longitud. Y si no
    if array_length(equipo_ids, 1) - array_length(vehiculo_ids, 1) <>
       array_length(vehiculo_ids, 1) - array_length(pilotos_ids, 1) then
        raise EXCEPTION 'Las longitudes de los arrays debe coincidir';
    end if;
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
    for indice in 1..array_length(equipo_ids, 1)
        loop
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
                    RETURNING id)
            select id
            into participacion_id
            from p_id;
            for piloto_id in 1..num_pilotos
                loop
                    --                     raise notice 'slice = %', pilotos_ids[indice][piloto_id];
                    insert into piloto_participacion(piloto_id, participacion_id, equipo_id)
                    VALUES (pilotos_ids[indice][piloto_id], participacion_id, equipo_ids[indice]);
                end loop;
            raise notice 'Pasado %', indice;
        end loop;
end;
$func$;
