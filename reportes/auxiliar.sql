CREATE OR REPLACE FUNCTION public.consultar_anos()
    RETURNS TABLE(ano smallint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- funcion que retorna los anos de los que se tiene registro de carrera
    FOR var_r IN(
select distinct evento.ano as Ano from evento

	)  
    LOOP
		ano:= var_r.Ano;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;








CREATE OR REPLACE FUNCTION public.consultar_vehiculos_tipo()
    RETURNS TABLE(tipo character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- funcion que retorna las categorias de los vehiculos
    FOR var_r IN(
select distinct vehiculo.tipo as Tipo from vehiculo

	)  
    LOOP
		tipo:= var_r.Tipo;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;