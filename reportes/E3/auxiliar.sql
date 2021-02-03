CREATE OR REPLACE FUNCTION public.consultar_pilotos()
    RETURNS TABLE(id integer, nombre character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- funcion que retorna los pilotos
    FOR var_r IN(
		select d_piloto.id as Id, d_piloto.nombre as Nombre from d_piloto
		where d_piloto.id<>0

	)  
    LOOP
		id:= var_r.Id;
		nombre:= var_r.Nombre;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;





CREATE OR REPLACE FUNCTION public.consultar_modelos_autos()
    RETURNS TABLE(id integer, nombre varchar, fabricante varchar) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer
AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- funcion que retorna los pilotos
    FOR var_r IN(
select t1.id, t1.nombre, t1.fabricante from d_vehiculo as t1

	)  
    LOOP
		id:= var_r.id;
		nombre:= var_r.nombre;
		fabricante:= var_r.fabricante;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;


CREATE OR REPLACE FUNCTION public.consultar_anos()
    RETURNS TABLE(ano integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS $BODY$
DECLARE 
    var_r record;
BEGIN


    FOR var_r IN(
select distinct f.ano
from d_fecha as f, h_participacion as pa
where pa.id_fecha=f.id
order by 1 asc

	)  
    LOOP
		ano:= var_r.ano;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;



CREATE OR REPLACE FUNCTION public.consultar_fabricantes()
    RETURNS TABLE(fabricante varchar) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS $BODY$
DECLARE 
    var_r record;
BEGIN
    FOR var_r IN(
		select distinct v.fabricante from d_vehiculo as v
	)  
    LOOP
		fabricante:= var_r.fabricante;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;




CREATE OR REPLACE FUNCTION public.consultar_fabricantes_cauchos()
    RETURNS TABLE(fabricante_caucho varchar) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS $BODY$
DECLARE 
    var_r record;
BEGIN
    FOR var_r IN(
		select distinct v.fabricante_caucho from d_vehiculo as v
	)  
    LOOP
		fabricante_caucho:= var_r.fabricante_caucho;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;