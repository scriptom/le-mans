create or replace function public.reporte_catorce()
    returns table
            (
                nombre        varchar,
                nacionalidad  varchar,
                foto          text,
                num_abandonos bigint
            )
    language 'plpgsql'
    security definer
as
$body$
begin
    return query
        select q.nombre, q.nacionalidad, q.foto, q.num_abandonos
        from (select sum(case hp.finalizo when 'N' then 1 else 0 end) as num_abandonos,
                     sum(case hp.finalizo when 'S' then 1 else 0 end) as num_finales,
                     dp.nombre                                        as nombre,
                     dp.nacionalidad                                  as nacionalidad,
                     encode(dp.foto, 'hex')                        as foto
              from h_participacion hp
                       join d_piloto dp on dp.id in (hp.id_piloto1, hp.id_piloto2, hp.id_piloto3)
              where dp.id <> 0
              group by dp.id) as q
        where q.num_finales = 0;
end;
$body$