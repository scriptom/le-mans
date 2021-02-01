CREATE OR REPLACE FUNCTION public.reporte_siete_data(
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
       pq.min_edad     as piloto_edad,
       dp.nombre       as piloto_nombre,
       dp.nacionalidad as piloto_pais,
       encode(dp.foto, 'hex')         as piloto_foto
from (select q.min_edad,
             (case q.min_edad
                  when p.edad_p1 then p.id_piloto1
                  when p.edad_p2 then p.id_piloto2
                  when p.edad_p3 then p.id_piloto3 end) as piloto_menor,
             p.id_fecha
      from (select least(
                           min(case when edad_p1 <= 0 then 100 else edad_p1 end),
                           min(case when edad_p2 <= 0 then 100 else edad_p2 end),
                           min(case when edad_p3 <= 0 then 100 else edad_p3 end)
                       ) as min_edad,
                   id_fecha
            from h_participacion h
      join d_fecha d on h.id_fecha = d.id
      where inp_ano is null or d.ano = inp_ano
            group by id_fecha
           ) as q
               right join h_participacion p on p.id_fecha = q.id_fecha) as pq
         join d_piloto dp on dp.id = pq.piloto_menor
         join d_fecha df on pq.id_fecha = df.id
where pq.piloto_menor is not null
order by ano;
END;
$BODY$;











CREATE OR REPLACE FUNCTION public.reporte_seis_aplanar(
	inp_id_ano integer)
    RETURNS TABLE(ano smallint,
				  piloto_edad integer, piloto_nombre varchar, piloto_pais varchar, piloto_foto_pais varchar)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    var_participaciones record;
BEGIN

	IF inp_ano IS NULL THEN

		FOR var_participaciones IN
		(
			select f.ano as ano,
			pa.edad_p1 as piloto_edad1, pi1.id as id_piloto1, pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1,
			pa.edad_p2 as piloto_edad2, pi2.id as id_piloto2, pi2.nombre as piloto_nombre2, pi2.pais_origen as piloto_pais2, encode(pi2.foto_pais::bytea, 'hex') as piloto_foto_pais2,
			pa.edad_p3 as piloto_edad3, pi3.id as id_piloto3, pi3.nombre as piloto_nombre3, pi3.pais_origen as piloto_pais3, encode(pi3.foto_pais::bytea, 'hex') as piloto_foto_pais3

			from d_fecha as f, h_participacion as pa,
			d_piloto as pi1, d_piloto as pi2, d_piloto as pi3

			where pa.id_piloto1=pi1.id and pa.id_piloto2=pi2.id and pa.id_piloto3=pi3.id
			and pa.id_fecha=f.id
		)
		LOOP
			ano:= var_participaciones.ano;
			piloto_nombre:= var_participaciones.piloto_nombre1;
			piloto_pais:= var_participaciones.piloto_pais1;
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
			piloto_edad:= var_participaciones.piloto_edad1;
			RETURN NEXT;
			ano:= var_participaciones.ano;
			piloto_nombre:= var_participaciones.piloto_nombre2;
			piloto_pais:= var_participaciones.piloto_pais2;
			piloto_foto_pais:= var_participaciones.piloto_foto_pais2;
			piloto_edad:= var_participaciones.piloto_edad2;
			RETURN NEXT;
			ano:= var_participaciones.ano;
			piloto_nombre:= var_participaciones.piloto_nombre3;
			piloto_pais:= var_participaciones.piloto_pais3;
			piloto_foto_pais:= var_participaciones.piloto_foto_pais3;
			piloto_edad:= var_participaciones.piloto_edad3;
			RETURN NEXT;
		END LOOP;


	ELSE
		FOR var_participaciones IN
		(
			select f.ano as ano,
			pa.edad_p1 as piloto_edad1, pi1.id as id_piloto1, pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1,
			pa.edad_p2 as piloto_edad2, pi2.id as id_piloto2, pi2.nombre as piloto_nombre2, pi2.pais_origen as piloto_pais2, encode(pi2.foto_pais::bytea, 'hex') as piloto_foto_pais2,
			pa.edad_p3 as piloto_edad3, pi3.id as id_piloto3, pi3.nombre as piloto_nombre3, pi3.pais_origen as piloto_pais3, encode(pi3.foto_pais::bytea, 'hex') as piloto_foto_pais3

			from d_fecha as f, h_participacion as pa,
			d_piloto as pi1, d_piloto as pi2, d_piloto as pi3

			where f.ano= inp_id_ano
			and pa.id_piloto1=pi1.id and pa.id_piloto2=pi2.id and pa.id_piloto3=pi3.id
			and pa.id_fecha=f.id
		)
		LOOP
			ano:= var_participaciones.ano;
			piloto_nombre:= var_participaciones.piloto_nombre1;
			piloto_pais:= var_participaciones.piloto_pais1;
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
			piloto_edad:= var_participaciones.piloto_edad1;
			RETURN NEXT;
			ano:= var_participaciones.ano;
			piloto_nombre:= var_participaciones.piloto_nombre2;
			piloto_pais:= var_participaciones.piloto_pais2;
			piloto_foto_pais:= var_participaciones.piloto_foto_pais2;
			piloto_edad:= var_participaciones.piloto_edad2;
			RETURN NEXT;
			ano:= var_participaciones.ano;
			piloto_nombre:= var_participaciones.piloto_nombre3;
			piloto_pais:= var_participaciones.piloto_pais3;
			piloto_foto_pais:= var_participaciones.piloto_foto_pais3;
			piloto_edad:= var_participaciones.piloto_edad3;
			RETURN NEXT;
		END LOOP;

	END IF




END;
$BODY$;
