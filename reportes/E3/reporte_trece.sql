create or replace function public.reporte_trece()
    returns table
            (
                nombre       varchar,
                nacionalidad varchar,
                foto         text,
                num_podiums  bigint
            )
    language 'plpgsql'
as
$body$
begin
    return query
        select dp.nombre                 as nombre,
               dp.nacionalidad           as nacionalidad,
               encode(dp.foto, 'hex') as foto,
               count(*)                  as num_podiums
        from h_participacion hp
                 join d_piloto dp on dp.id in (hp.id_piloto1, hp.id_piloto2, hp.id_piloto3)
        where dp.id <> 0
          and hp.puesto_final in (2, 3)
        group by dp.id;
end;
$body$