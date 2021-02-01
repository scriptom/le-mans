CREATE OR REPLACE FUNCTION public.reporte_dos_ensayo(
	var_ano integer,
	var_categoria_vehiculo character varying,
	var_hora integer)
    RETURNS TABLE(nombre_equipo character varying, numero_equipo smallint, nacionalidad_equipo character varying, nombre_piloto character varying, foto_piloto bytea[], nacionalidad_piloto character varying, nombre_vehiculo character varying, tipo_vehiculo character varying, foto_vehiculo bytea[], motor_vehiculo character varying, velocidad_media real, numero_vueltas real, distancia_recorrida real, mejor_tiempo_vuelta interval, posicion smallint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- esta funcion devuelve la data solicitada en el reporte 2 cuando el tipo de evento es ensayo
-- esta funcion es parecida a su homologa del reporte 1, solo que se diferencia porque esta retorna la data en la hora seleccionada
-- la hora deseada se pasa como parametro como un entero
-- para poder extraer la data de la hora seleccionada, se selecciona en el array participacion.estadisticas_hora[##hora_deseada##] ya que el indice del array corresponde a la hora correspondiente de la carrera

-- primero se itera en var_r basado en el query a continuacion que trae la data deseada. Notese se usan las propiedades de estadisticas_hora[##hora_deseada##]
    FOR var_r IN(
	
select 
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
(participacion.estadisticas_hora[var_hora]).vel_media as Velocidad_Media,
cantidad_vueltas((participacion.estadisticas_hora[var_hora]).distancia_recorrida, evento.longitud) as Numero_Vueltas,
(participacion.estadisticas_hora[var_hora]).distancia_recorrida as Distancia_Recorrida,
(participacion.estadisticas_hora[var_hora]).mejor_tiempo_vuelta as Mejor_Tiempo_Vuelta,
(participacion.estadisticas_hora[var_hora]).posicion as Posicion
		
		
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
and evento.tipo='ensayo' 
order by Numero_Vueltas desc
		

	)  
    LOOP
-- 	por cada atriubuto de var_r, se le asigna a su homologa salida
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
		velocidad_media:= var_r.Velocidad_Media;
		numero_vueltas:= var_r.Numero_Vueltas;
		distancia_recorrida:= var_r.Distancia_Recorrida;
		mejor_tiempo_vuelta:= var_r.Mejor_Tiempo_Vuelta;
		posicion:= var_r.Posicion;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;















CREATE OR REPLACE FUNCTION public.reporte_dos_carrera(
	var_ano integer,
	var_categoria_vehiculo character varying,
	var_hora integer)
    RETURNS TABLE(nombre_equipo character varying, numero_equipo smallint, nacionalidad_equipo character varying, nombre_piloto character varying, foto_piloto bytea[], nacionalidad_piloto character varying, nombre_vehiculo character varying, tipo_vehiculo character varying, foto_vehiculo bytea[], motor_vehiculo character varying, velocidad_media real, numero_vueltas real, distancia_recorrida real, mejor_tiempo_vuelta interval, posicion smallint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- esta funcion devuelve la data solicitada en el reporte 2 cuando el tipo de evento es ensayo
-- para mas informacion, revise la funcion reporte_dos_ensayo, ya que es la misma logica pero con datos desalida distintos

    FOR var_r IN(
	
select 
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
(participacion.estadisticas_hora[var_hora]).vel_media as Velocidad_Media,
cantidad_vueltas((participacion.estadisticas_hora[var_hora]).distancia_recorrida, evento.longitud) as Numero_Vueltas,
(participacion.estadisticas_hora[var_hora]).distancia_recorrida as Distancia_Recorrida,
(participacion.estadisticas_hora[var_hora]).mejor_tiempo_vuelta as Mejor_Tiempo_Vuelta,
(participacion.estadisticas_hora[var_hora]).posicion as Posicion
		
		
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
order by (participacion.estadisticas_hora[var_hora]).posicion

	)  
    LOOP
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
		velocidad_media:= var_r.Velocidad_Media;
		numero_vueltas:= var_r.Numero_Vueltas;
		distancia_recorrida:= var_r.Distancia_Recorrida;
		mejor_tiempo_vuelta:= var_r.Mejor_Tiempo_Vuelta;
		posicion:= var_r.Posicion;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;