CREATE OR REPLACE FUNCTION public.reporte_seis_data(
	inp_id_auto integer)
    RETURNS TABLE(ano smallint, numero_equipo integer, equipo_nombre varchar, auto_categoria varchar, 
				  auto_foto varchar, auto_modelo varchar, auto_fabricante varchar, auto_hibrido char, auto_motor varchar,
				  auto_fabricante_cauchos varchar, piloto_nombre varchar, piloto_pais varchar, piloto_foto_pais varchar,
				 puesto_final integer) 
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
			select f.ano as ano, pa.numero_participacion as numero_equipo, e.nombre as equipo_nombre,
			v.categoria as auto_categoria, encode(v.foto::bytea, 'hex') as auto_foto, v.nombre as auto_modelo, pa.puesto_final as puesto_final,
			v.fabricante as auto_fabricante, v.hibrido as auto_hibrido, v.fabricante_caucho as auto_fabricante_cauchos, v.motor as auto_motor,
			pi1.id as id_piloto1, pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1,
			pi2.id as id_piloto2, pi2.nombre as piloto_nombre2, pi2.pais_origen as piloto_pais2, encode(pi2.foto_pais::bytea, 'hex') as piloto_foto_pais2,
			pi3.id as id_piloto3, pi3.nombre as piloto_nombre3, pi3.pais_origen as piloto_pais3, encode(pi3.foto_pais::bytea, 'hex') as piloto_foto_pais3
			
			
			from d_equipo as e, d_fecha as f, d_vehiculo as v, h_participacion as pa,
			d_piloto as pi1, d_piloto as pi2, d_piloto as pi3
			
			where v.id=inp_id_auto
			and pa.id_piloto1=pi1.id and pa.id_piloto2=pi2.id and pa.id_piloto3=pi3.id
			and pa.id_equipo=e.id 
			and pa.id_fecha=f.id
			and pa.id_vehiculo=v.id
		)  
		
		LOOP
		


			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre2; 
			piloto_pais:= var_participaciones.piloto_pais1; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			RETURN NEXT;	
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre2; 
			piloto_pais:= var_participaciones.piloto_pais2; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais2;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			RETURN NEXT;
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo;
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre3; 
			piloto_pais:= var_participaciones.piloto_pais3; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais3;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			RETURN NEXT;	
	
				
		END LOOP;
		
		

END;
$BODY$;
