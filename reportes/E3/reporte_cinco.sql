CREATE OR REPLACE FUNCTION public.reporte_cinco_data_piloto(var_id_piloto integer)
    RETURNS TABLE(id integer, nombre character varying, fecha_nacimiento date, fecha_muerte date, edad smallint,
				 genero varchar, foto varchar, pais_origen varchar, nacionalidad varchar, foto_pais varchar) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

-- funcion que retorna los pilotos
    FOR var_r IN(
select tabla1.id, tabla1.nombre, tabla1.fecha_nacimiento, tabla1.fecha_muerte, tabla1.edad, tabla1.genero,
		encode(tabla1.foto::bytea, 'hex') as foto, tabla1.pais_origen, tabla1.nacionalidad, encode(tabla1.foto_pais::bytea, 'hex') as foto_pais
from d_piloto as tabla1 
where tabla1.id=var_id_piloto

	)  
    LOOP
		id:= var_r.id;
		nombre:= var_r.nombre;
		fecha_nacimiento:= var_r.fecha_nacimiento;
		fecha_muerte:= var_r.fecha_muerte;
		edad:= var_r.edad;
		genero:= var_r.genero;
		foto:= var_r.foto;
		pais_origen:= var_r.pais_origen;
		nacionalidad:= var_r.nacionalidad;
		foto_pais:= var_r.foto_pais;
        RETURN NEXT;
    END LOOP;
END;
$BODY$;











CREATE OR REPLACE FUNCTION public.reporte_cinco_data_participaciones(
	inp_id_piloto integer)
    RETURNS TABLE(ano smallint, numero_equipo integer, equipo_nombre varchar, auto_categoria varchar, 
				  auto_foto varchar, auto_modelo varchar, piloto_nombre varchar, piloto_pais varchar, piloto_foto_pais varchar,
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
			pi1.id as id_piloto1, pi1.nombre as piloto_nombre1, pi1.pais_origen as piloto_pais1, encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1,
			pi2.id as id_piloto2, pi2.nombre as piloto_nombre2, pi2.pais_origen as piloto_pais2, encode(pi2.foto_pais::bytea, 'hex') as piloto_foto_pais2,
			pi3.id as id_piloto3, pi3.nombre as piloto_nombre3, pi3.pais_origen as piloto_pais3, encode(pi3.foto_pais::bytea, 'hex') as piloto_foto_pais3
			
			
			from d_equipo as e, d_fecha as f, d_vehiculo as v, h_participacion as pa,
			d_piloto as pi1, d_piloto as pi2, d_piloto as pi3
			
			where (pa.id_piloto1=inp_id_piloto or pa.id_piloto2=inp_id_piloto or pa.id_piloto3=inp_id_piloto)
			and pa.id_piloto1=pi1.id and pa.id_piloto2=pi2.id and pa.id_piloto3=pi3.id
			and pa.id_equipo=e.id 
			and pa.id_fecha=f.id
			and pa.id_vehiculo=v.id
		)  
		
		LOOP
		


			if var_participaciones.id_piloto1=inp_id_piloto then	
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
			RETURN NEXT;	
			
			elsif var_participaciones.id_piloto2=inp_id_piloto then
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre1; 
			piloto_pais:= var_participaciones.piloto_pais1; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
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
			RETURN NEXT;	
			
			else
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
			RETURN NEXT;
			ano:= var_participaciones.ano; 
			numero_equipo:= var_participaciones.numero_equipo; 
			equipo_nombre:= var_participaciones.equipo_nombre;
			auto_categoria:= var_participaciones.auto_categoria; 
			auto_foto:= var_participaciones.auto_foto; 
			auto_modelo:= var_participaciones.auto_modelo; 
			puesto_final:= var_participaciones.puesto_final; 
			piloto_nombre:= var_participaciones.piloto_nombre1; 
			piloto_pais:= var_participaciones.piloto_pais1; 
			piloto_foto_pais:= var_participaciones.piloto_foto_pais1;
			RETURN NEXT;	
			end if;
	
				
		END LOOP;
		
		

END;
$BODY$;
