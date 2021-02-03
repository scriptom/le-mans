CREATE OR REPLACE FUNCTION public.reporte_nueve_contador(inp_id_piloto integer)
    RETURNS integer
    security definer
    as $$

DECLARE 
    var_r record;
	contador integer;
BEGIN
		contador:=0;
		FOR var_r IN
			(
				select pa.id_piloto1 as p1, pa.id_piloto2 as p2, pa.id_piloto3 as p3
				from h_participacion pa
			)  
			LOOP
			IF var_r.p1=inp_id_piloto or var_r.p2=inp_id_piloto or var_r.p3=inp_id_piloto THEN
				contador:= contador+1;
			END IF;		
		END LOOP;
		return contador;

END;
$$ language plpgsql;











CREATE OR REPLACE FUNCTION public.reporte_nueve_data()
    RETURNS TABLE(piloto_nombre varchar, piloto_pais varchar, piloto_foto_pais varchar, piloto_foto varchar,
				 piloto_participaciones integer)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS $BODY$
DECLARE
    var_r record;
	mayor_numero integer;
	id_piloto_mayor integer;
	aux integer;
BEGIN
		mayor_numero=-1;
		id_piloto_mayor=-1;
		FOR var_r IN
			(
				select pi.id as id from d_piloto pi
				where pi.id<>0
			)  
		LOOP
			select * INTO aux from reporte_nueve_contador(var_r.id);
			IF aux>mayor_numero then
				mayor_numero:=aux;
				id_piloto_mayor:=var_r.id;
			END IF;
		END LOOP;

		FOR var_r IN
		(
			select 
			pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, 
			encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1, encode(pi1.foto::bytea, 'hex') as piloto_foto1
			from d_piloto pi1
			where pi1.id= id_piloto_mayor
		)
		LOOP
			piloto_nombre:= var_r.piloto_nombre1; 
			piloto_pais:= var_r.piloto_pais1; 
			piloto_foto_pais:= var_r.piloto_foto_pais1; 
			piloto_foto:= var_r.piloto_foto1;
			piloto_participaciones:= mayor_numero;
			RETURN NEXT;
		END LOOP;
END;
$BODY$;