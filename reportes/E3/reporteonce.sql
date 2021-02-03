CREATE OR REPLACE FUNCTION public.reporte_once_data(
	inp_ano integer)
    RETURNS TABLE(ano smallint, numero_equipo integer, equipo_nombre varchar, equipo_pais varchar, 
				  auto_categoria varchar, auto_foto varchar, auto_modelo varchar, auto_fabricante varchar, 
				  velocidad_media integer
				 ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS $BODY$
DECLARE 
    var_participaciones record;
BEGIN


	IF inp_ano IS NULL THEN
		FOR var_participaciones IN
		
		(
			select f.ano as ano, pa.numero_participacion as numero_equipo, e.nombre as equipo_nombre, e.pais_origen as equipo_pais,
			v.categoria as auto_categoria, encode(v.foto::bytea, 'hex') as auto_foto, v.nombre as auto_modelo,
			v.fabricante as auto_fabricante, pa.velocidad_media as velocidad_media
			from d_equipo as e, d_fecha as f, d_vehiculo as v, h_participacion as pa
			where pa.id_equipo=e.id 
			and pa.id_fecha=f.id
			and pa.id_vehiculo=v.id
			order by velocidad_media desc
		)  
		
		LOOP
		
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_pais:= var_participaciones.equipo_pais;
			
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			auto_fabricante:= var_participaciones.auto_fabricante; 
		
			velocidad_media:= var_participaciones.velocidad_media; 
			RETURN NEXT;		
		END LOOP;
	
	ELSE
		FOR var_participaciones IN
		
		(
			select f.ano as ano, pa.numero_participacion as numero_equipo, e.nombre as equipo_nombre, e.pais_origen as equipo_pais,
			v.categoria as auto_categoria, encode(v.foto::bytea, 'hex') as auto_foto, v.nombre as auto_modelo,
			v.fabricante as auto_fabricante, pa.velocidad_media as velocidad_media
			from d_equipo as e, d_fecha as f, d_vehiculo as v, h_participacion as pa
			where pa.id_equipo=e.id 
			and pa.id_fecha=f.id
			and pa.id_vehiculo=v.id
			and f.ano= inp_ano
			order by velocidad_media desc
		)  
		
		LOOP
		
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_pais:= var_participaciones.equipo_pais;
			
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			auto_fabricante:= var_participaciones.auto_fabricante; 
		
			velocidad_media:= var_participaciones.velocidad_media; 
			RETURN NEXT;		
		END LOOP;
	END IF;

END;
$BODY$;
