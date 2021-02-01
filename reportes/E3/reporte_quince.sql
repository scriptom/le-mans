CREATE OR REPLACE FUNCTION public.reporte_trece_autos(inp_fabricante varchar)
    RETURNS TABLE(nombre varchar, pais varchar, numero_victorias integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_participaciones record;
BEGIN

		FOR var_participaciones IN
		
		(
			select v.fabricante as nombre, v.pais_fabricante as pais, count(*) as numero_victorias
			from h_participacion pa, d_vehiculo v
			where pa.id_vehiculo=v.id
			and pa.puesto_final=1
			and v.fabricante= inp_fabricante
			group by 1, 2
		)  
		
		LOOP
		


			nombre:= var_participaciones.nombre;
			pais:= var_participaciones.pais;
			numero_victorias:= var_participaciones.numero_victorias;
			RETURN NEXT;	
				
		END LOOP;
		
END;
$BODY$;






CREATE OR REPLACE FUNCTION public.reporte_trece_cauchos(inp_fabricante varchar)
    RETURNS TABLE(nombre varchar, numero_victorias integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_participaciones record;
BEGIN



		FOR var_participaciones IN
		
		(
			select v.fabricante_caucho as nombre, count(*) as numero_victorias
			from h_participacion pa, d_vehiculo v
			where pa.id_vehiculo=v.id
			and pa.puesto_final=1
			and v.fabricante_caucho= inp_fabricante
			group by 1
		)  
		
		LOOP
		
			nombre:= var_participaciones.nombre;
			numero_victorias:= var_participaciones.numero_victorias;
			RETURN NEXT;	
				
		END LOOP;
		
		

END;
$BODY$;

