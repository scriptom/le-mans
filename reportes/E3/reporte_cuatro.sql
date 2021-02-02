CREATE OR REPLACE FUNCTION public.reporte_cuatro_data(
	inp_ano integer)
    RETURNS TABLE(ano smallint, numero_equipo integer, equipo_nombre varchar, equipo_nacionalidad varchar, auto_categoria varchar, 
				  auto_foto varchar, auto_modelo varchar, auto_fabricante varchar, auto_hibrido char, auto_motor varchar,
				  auto_fabricante_cauchos varchar, piloto_nombre varchar, piloto_pais varchar, piloto_foto_pais varchar, piloto_foto varchar,
				 puesto_final integer, cantidad_vueltas integer, distancia_recorrida integer, velocidad_media integer,
				 diferencia_puesto_anterior_tiempo interval, diferencia_puesto_anterior_vueltas integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_participaciones record;
BEGIN

	IF inp_ano is NULL THEN

		FOR var_participaciones IN
		
		(
			select f.ano as ano, pa.numero_participacion as numero_equipo, e.nombre as equipo_nombre, e.nacionalidad as equipo_nacionalidad,
			v.categoria as auto_categoria, encode(v.foto::bytea, 'hex') as auto_foto, v.nombre as auto_modelo, pa.puesto_final as puesto_final,
			v.fabricante as auto_fabricante, v.hibrido as auto_hibrido, v.fabricante_caucho as auto_fabricante_cauchos, v.motor as auto_motor,
			pi1.id as id_piloto1, pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1, encode(pi1.foto::bytea, 'hex') as piloto_foto1,
			pi2.id as id_piloto2, pi2.nombre as piloto_nombre2, pi2.pais_origen as piloto_pais2, encode(pi2.foto_pais::bytea, 'hex') as piloto_foto_pais2, encode(pi2.foto::bytea, 'hex') as piloto_foto2,
			pi3.id as id_piloto3, pi3.nombre as piloto_nombre3, pi3.pais_origen as piloto_pais3, encode(pi3.foto_pais::bytea, 'hex') as piloto_foto_pais3, encode(pi3.foto::bytea, 'hex') as piloto_foto3,
			
			pa.cantidad_vueltas as cantidad_vueltas, pa.distancia_recorrida as distancia_recorrida, 
			pa.velocidad_media as velocidad_media, pa.diferencia_puesto_anterior_tiempo as diferencia_puesto_anterior_tiempo, 
			pa.diferencia_puesto_anterior_vueltas as diferencia_puesto_anterior_vueltas
			
			from d_equipo as e, d_fecha as f, d_vehiculo as v, h_participacion as pa,
			d_piloto as pi1, d_piloto as pi2, d_piloto as pi3
			
			where pa.id_piloto1=pi1.id and pa.id_piloto2=pi2.id and pa.id_piloto3=pi3.id
			and pa.id_equipo=e.id 
			and pa.id_fecha=f.id
			and pa.id_vehiculo=v.id
			order by pa.numero_participacion asc
		)  
		
		LOOP
		

		if var_participaciones.id_piloto1<>0 then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_nacionalidad:= var_participaciones.equipo_nacionalidad;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre1; 
			piloto_pais:= var_participaciones.piloto_pais1; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
			piloto_foto:= var_participaciones.piloto_foto1;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			
			cantidad_vueltas:= var_participaciones.cantidad_vueltas;
			distancia_recorrida:= var_participaciones.distancia_recorrida; 
			velocidad_media:= var_participaciones.velocidad_media;
			diferencia_puesto_anterior_tiempo:= var_participaciones.diferencia_puesto_anterior_tiempo; 
			diferencia_puesto_anterior_vueltas:= var_participaciones.diferencia_puesto_anterior_vueltas;
			RETURN NEXT;	
		end if;
		if var_participaciones.id_piloto2<>0 then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_nacionalidad:= var_participaciones.equipo_nacionalidad;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre2; 
			piloto_pais:= var_participaciones.piloto_pais2; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais2;
			piloto_foto:= var_participaciones.piloto_foto2;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			
			cantidad_vueltas:= var_participaciones.cantidad_vueltas;
			distancia_recorrida:= var_participaciones.distancia_recorrida; 
			velocidad_media:= var_participaciones.velocidad_media;
			diferencia_puesto_anterior_tiempo:= var_participaciones.diferencia_puesto_anterior_tiempo; 
			diferencia_puesto_anterior_vueltas:= var_participaciones.diferencia_puesto_anterior_vueltas;			
			RETURN NEXT;
		end if;
		if var_participaciones.id_piloto3<>0 then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_nacionalidad:= var_participaciones.equipo_nacionalidad;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo;
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre3; 
			piloto_pais:= var_participaciones.piloto_pais3; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais3;
			piloto_foto:= var_participaciones.piloto_foto3;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			
			cantidad_vueltas:= var_participaciones.cantidad_vueltas;
			distancia_recorrida:= var_participaciones.distancia_recorrida; 
			velocidad_media:= var_participaciones.velocidad_media;
			diferencia_puesto_anterior_tiempo:= var_participaciones.diferencia_puesto_anterior_tiempo; 
			diferencia_puesto_anterior_vueltas:= var_participaciones.diferencia_puesto_anterior_vueltas;
			RETURN NEXT;	
		end if;
			
		END LOOP;
		
		
	
	ELSE
	

		FOR var_participaciones IN
		
		(
			select f.ano as ano, pa.numero_participacion as numero_equipo, e.nombre as equipo_nombre, e.nacionalidad as equipo_nacionalidad,
			v.categoria as auto_categoria, encode(v.foto::bytea, 'hex') as auto_foto, v.nombre as auto_modelo, pa.puesto_final as puesto_final,
			v.fabricante as auto_fabricante, v.hibrido as auto_hibrido, v.fabricante_caucho as auto_fabricante_cauchos, v.motor as auto_motor,
			pi1.id as id_piloto1, pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1, encode(pi1.foto::bytea, 'hex') as piloto_foto1,
			pi2.id as id_piloto2, pi2.nombre as piloto_nombre2, pi2.pais_origen as piloto_pais2, encode(pi2.foto_pais::bytea, 'hex') as piloto_foto_pais2, encode(pi2.foto::bytea, 'hex') as piloto_foto2,
			pi3.id as id_piloto3, pi3.nombre as piloto_nombre3, pi3.pais_origen as piloto_pais3, encode(pi3.foto_pais::bytea, 'hex') as piloto_foto_pais3, encode(pi3.foto::bytea, 'hex') as piloto_foto3,
			
			pa.cantidad_vueltas as cantidad_vueltas, pa.distancia_recorrida as distancia_recorrida, 
			pa.velocidad_media as velocidad_media, pa.diferencia_puesto_anterior_tiempo as diferencia_puesto_anterior_tiempo, 
			pa.diferencia_puesto_anterior_vueltas as diferencia_puesto_anterior_vueltas
			
			from d_equipo as e, d_fecha as f, d_vehiculo as v, h_participacion as pa,
			d_piloto as pi1, d_piloto as pi2, d_piloto as pi3
			
			where pa.id_piloto1=pi1.id and pa.id_piloto2=pi2.id and pa.id_piloto3=pi3.id
			and pa.id_equipo=e.id 
			and pa.id_fecha=f.id
			and pa.id_vehiculo=v.id
			and f.ano=inp_ano
			order by pa.numero_participacion asc
		)  
		
		LOOP
		

		if var_participaciones.id_piloto1<>0 then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_nacionalidad:= var_participaciones.equipo_nacionalidad;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre1; 
			piloto_pais:= var_participaciones.piloto_pais1; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
			piloto_foto:= var_participaciones.piloto_foto1;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			
			cantidad_vueltas:= var_participaciones.cantidad_vueltas;
			distancia_recorrida:= var_participaciones.distancia_recorrida; 
			velocidad_media:= var_participaciones.velocidad_media;
			diferencia_puesto_anterior_tiempo:= var_participaciones.diferencia_puesto_anterior_tiempo; 
			diferencia_puesto_anterior_vueltas:= var_participaciones.diferencia_puesto_anterior_vueltas;
			RETURN NEXT;	
		end if;
		if var_participaciones.id_piloto2<>0 then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_nacionalidad:= var_participaciones.equipo_nacionalidad;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre2; 
			piloto_pais:= var_participaciones.piloto_pais2; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais2;
			piloto_foto:= var_participaciones.piloto_foto2;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			
			cantidad_vueltas:= var_participaciones.cantidad_vueltas;
			distancia_recorrida:= var_participaciones.distancia_recorrida; 
			velocidad_media:= var_participaciones.velocidad_media;
			diferencia_puesto_anterior_tiempo:= var_participaciones.diferencia_puesto_anterior_tiempo; 
			diferencia_puesto_anterior_vueltas:= var_participaciones.diferencia_puesto_anterior_vueltas;			
			RETURN NEXT;
		end if;
		if var_participaciones.id_piloto3<>0 then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			equipo_nacionalidad:= var_participaciones.equipo_nacionalidad;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo;
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre3; 
			piloto_pais:= var_participaciones.piloto_pais3; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais3;
			piloto_foto:= var_participaciones.piloto_foto3;
			auto_motor:= var_participaciones.auto_motor;
			auto_fabricante:= var_participaciones.auto_fabricante;
			auto_fabricante_cauchos:= var_participaciones.auto_fabricante_cauchos;
			auto_hibrido:= var_participaciones.auto_hibrido;
			
			cantidad_vueltas:= var_participaciones.cantidad_vueltas;
			distancia_recorrida:= var_participaciones.distancia_recorrida; 
			velocidad_media:= var_participaciones.velocidad_media;
			diferencia_puesto_anterior_tiempo:= var_participaciones.diferencia_puesto_anterior_tiempo; 
			diferencia_puesto_anterior_vueltas:= var_participaciones.diferencia_puesto_anterior_vueltas;
			RETURN NEXT;	
		end if;
			
		END LOOP;


	
	END IF;
		

END;
$BODY$;
