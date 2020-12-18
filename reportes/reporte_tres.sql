CREATE OR REPLACE FUNCTION public.reporte_tres_detalle(
	var_ano integer,
	var_categoria_vehiculo character varying)
    RETURNS TABLE(ano smallint, nombre_equipo character varying, numero_equipo smallint, nacionalidad_equipo character varying, nombre_piloto character varying, foto_piloto bytea[], nacionalidad_piloto character varying, nombre_vehiculo character varying, tipo_vehiculo character varying, foto_vehiculo bytea[], motor_vehiculo character varying, puesto_inicio smallint, tiempo_total interval, velocidad_media integer, numero_vueltas smallint, finalizo boolean, distancia_recorrida real, mejor_tiempo_vuelta interval) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- esta funcion es llamada una o multiples veces por reporte_tres
-- el objetivo de esta funcion es retornar a los ganadores de la carrera de X categoria de Y anno
-- esta funcion retorna solo 2 tuplas (dos pilotos, ambos pertenecientes al equipo ganador de dicho anno)

-- se itera en var_r para consultar la data deseada mediante el query
    FOR var_r IN(
	
select 
evento.ano as Ano,
equipo.nombre as Nombre_Equipo, 
participacion.numero_participacion as Numero_Equipo,
pais.nombre as Nacionalidad_Equipo,
(piloto.datos).nombre || ' ' || (piloto.datos).apellido as Nombre_Piloto,
piloto.foto as Foto_Piloto,
pais2.nombre as Nacionalidad_Piloto,
vehiculo.nombre_chasis as Nombre_Vehiculo,
vehiculo.tipo as Tipo_Vehiculo,
vehiculo.foto as Foto_Vehiculo,
motor.modelo as Motor_Vehiculo,
participacion.puesto_inicio as Puesto_Inicio,
participacion.tiempo_total as Tiempo_Total,
consulta_velocidad_media(participacion.numero_vueltas::smallint, evento.longitud, consulta_horas_en_carrera(participacion.estadisticas_hora)) as Velocidad_Media,
participacion.numero_vueltas as Numero_Vueltas,
participacion.finalizo as Finalizo,

calcular_distancia_recorrida(participacion.estadisticas_hora, 25) as Distancia_Recorrida,
consulta_mejor_tiempo(participacion.estadisticas_hora, 25) as Mejor_Tiempo_Vuelta		
		
		
from
piloto_participacion, equipo, participacion, pais pais, piloto, vehiculo, motor, evento, pais pais2

where 
evento.ano=var_ano
and participacion.evento_id=evento.id
and participacion.equipo_id=equipo.id
and equipo.pais_id=pais.id
and participacion.vehiculo_id=vehiculo.id
and vehiculo.motor_id=motor.id
and piloto_participacion.piloto_id=piloto.id
and piloto_participacion.participacion_id=participacion.id
and piloto.pais_id=pais2.id
and vehiculo.tipo=var_categoria_vehiculo
and evento.tipo='carrera' 
-- se usa limit y order by para solo seleccionar a los ganadores
order by Numero_Vueltas desc
limit 2

	)  
    LOOP
		ano:= var_r.Ano;
        nombre_equipo:= var_r.Nombre_Equipo;
        numero_equipo:= var_r.Numero_Equipo;
		nacionalidad_equipo:= var_r.Nacionalidad_Equipo;
		nombre_piloto:= var_r.Nombre_Piloto;
		foto_piloto:= var_r.Foto_Piloto;
		nacionalidad_piloto:= var_r.Nacionalidad_Piloto;
		nombre_vehiculo:= var_r.Nombre_Vehiculo;
		tipo_vehiculo:= var_r.Tipo_Vehiculo;
		foto_vehiculo:= var_r.Foto_Vehiculo;
		motor_vehiculo:= var_r.Motor_Vehiculo;
		puesto_inicio:= var_r.Puesto_Inicio;
		tiempo_total:= var_r.Tiempo_Total;
		velocidad_media:= var_r.Velocidad_Media;
		numero_vueltas:= var_r.Numero_Vueltas;
		finalizo:= var_r.Finalizo;
		distancia_recorrida:= var_r.Distancia_Recorrida;
		mejor_tiempo_vuelta:= var_r.Mejor_Tiempo_Vuelta;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;



















CREATE OR REPLACE FUNCTION public.reporte_tres(
	var_ano integer,
	var_categoria_vehiculo character varying)
    RETURNS TABLE(ano smallint, nombre_equipo character varying, numero_equipo smallint, nacionalidad_equipo character varying, nombre_piloto character varying, foto_piloto bytea[], nacionalidad_piloto character varying, nombre_vehiculo character varying, tipo_vehiculo character varying, foto_vehiculo bytea[], motor_vehiculo character varying, puesto_inicio smallint, tiempo_total interval, velocidad_media integer, numero_vueltas smallint, finalizo boolean, distancia_recorrida real, mejor_tiempo_vuelta interval) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    anno record;
	var_r record;
BEGIN

-- esta funcion devuelve la data del reporte 3, dependiendo de los parametros de entrada

-- si el parametro var_ano (year) es null, se retornan todos los ganadores existentes
	IF var_ano IS NULL THEN
		FOR anno IN(

		select evento.ano as ano 
		from evento
		where evento.tipo='carrera' 

		)  
		LOOP

			FOR var_r in
			select * from reporte_tres_detalle(anno.ano, var_categoria_vehiculo)

			LOOP
				ano:= var_r.Ano;
				nombre_equipo:= var_r.Nombre_Equipo;
				numero_equipo:= var_r.Numero_Equipo;
				nacionalidad_equipo:= var_r.Nacionalidad_Equipo;
				nombre_piloto:= var_r.Nombre_Piloto;
				foto_piloto:= var_r.Foto_Piloto;
				nacionalidad_piloto:= var_r.Nacionalidad_Piloto;
				nombre_vehiculo:= var_r.Nombre_Vehiculo;
				tipo_vehiculo:= var_r.Tipo_Vehiculo;
				foto_vehiculo:= var_r.Foto_Vehiculo;
				motor_vehiculo:= var_r.Motor_Vehiculo;
				puesto_inicio:= var_r.Puesto_Inicio;
				tiempo_total:= var_r.Tiempo_Total;
				velocidad_media:= var_r.Velocidad_Media;
				numero_vueltas:= var_r.Numero_Vueltas;
				finalizo:= var_r.Finalizo;
				distancia_recorrida:= var_r.Distancia_Recorrida;
				mejor_tiempo_vuelta:= var_r.Mejor_Tiempo_Vuelta;
				RETURN NEXT;
			END LOOP;
		END LOOP;
		
		
-- si el parametro var_ano no es null, solo se retornan los ganadores de ese ano		
	ELSE
	
			FOR var_r in
			select * from reporte_tres_detalle(var_ano, var_categoria_vehiculo)

			LOOP
				ano:= var_r.Ano;
				nombre_equipo:= var_r.Nombre_Equipo;
				numero_equipo:= var_r.Numero_Equipo;
				nacionalidad_equipo:= var_r.Nacionalidad_Equipo;
				nombre_piloto:= var_r.Nombre_Piloto;
				foto_piloto:= var_r.Foto_Piloto;
				nacionalidad_piloto:= var_r.Nacionalidad_Piloto;
				nombre_vehiculo:= var_r.Nombre_Vehiculo;
				tipo_vehiculo:= var_r.Tipo_Vehiculo;
				foto_vehiculo:= var_r.Foto_Vehiculo;
				motor_vehiculo:= var_r.Motor_Vehiculo;
				puesto_inicio:= var_r.Puesto_Inicio;
				tiempo_total:= var_r.Tiempo_Total;
				velocidad_media:= var_r.Velocidad_Media;
				numero_vueltas:= var_r.Numero_Vueltas;
				finalizo:= var_r.Finalizo;
				distancia_recorrida:= var_r.Distancia_Recorrida;
				mejor_tiempo_vuelta:= var_r.Mejor_Tiempo_Vuelta;
				RETURN NEXT;
			END LOOP;		
	
	
		
	END IF;
END;
$BODY$;