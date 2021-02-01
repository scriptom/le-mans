CREATE OR REPLACE FUNCTION public.reporte_ocho_data(
	inp_ano integer)
    RETURNS TABLE(ano smallint,
				  piloto_edad integer, piloto_nombre varchar, piloto_pais varchar, piloto_foto text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
BEGIN
    return query
	select df.ano::smallint          as ano,
       pq.max_edad::integer     as piloto_edad,
       dp.nombre       as piloto_nombre,
       dp.nacionalidad as piloto_pais,
       encode(dp.foto, 'base64')         as piloto_foto
from (select q.max_edad,
             (case q.max_edad
                  when p.edad_p1 then p.id_piloto1
                  when p.edad_p2 then p.id_piloto2
                  when p.edad_p3 then p.id_piloto3 end) as piloto_mayor,
             p.id_fecha
      from (select greatest(
                           max(edad_p1),
                           max(edad_p2),
                           max(edad_p3)
                       ) as max_edad,
                   id_fecha
            from h_participacion h
      join d_fecha d on h.id_fecha = d.id
      where inp_ano is null or d.ano = inp_ano
            group by id_fecha
           ) as q
               right join h_participacion p on p.id_fecha = q.id_fecha) as pq
         join d_piloto dp on dp.id = pq.piloto_mayor
         join d_fecha df on pq.id_fecha = df.id
where pq.piloto_mayor is not null
order by ano;
END;
$BODY$