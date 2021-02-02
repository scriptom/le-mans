CREATE OR REPLACE FUNCTION public.reporte_dieciseis_data_piloto(inp_ano integer)
    RETURNS TABLE(id integer, nombre character varying, fecha_nacimiento date, fecha_muerte date, edad smallint,
				 foto varchar, pais_origen varchar, nacionalidad varchar, foto_pais varchar) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE 
    var_r record;
BEGIN

	IF inp_ano IS NOT NULL THEN
		FOR var_r IN(
			select distinct pi.id as id, pi.nombre as nombre, pi.fecha_nacimiento as fecha_nacimiento, pi.fecha_muerte as fecha_muerte,
			pi.edad as edad, encode(pi.foto::bytea, 'hex') as foto, pi.pais_origen as pais_origen, pi.nacionalidad as nacionalidad,
			encode(pi.foto_pais::bytea, 'hex') as foto_pais
			from h_participacion pa, d_piloto pi, d_fecha f
			where pa.id_fecha=f.id
			and f.ano=inp_ano
			and pa.id_piloto1=pi.id
			and pi.genero='M'
			UNION 
			select distinct pi.id as id, pi.nombre as nombre, pi.fecha_nacimiento as fecha_nacimiento, pi.fecha_muerte as fecha_muerte,
			pi.edad as edad, encode(pi.foto::bytea, 'hex') as foto, pi.pais_origen as pais_origen, pi.nacionalidad as nacionalidad,
			encode(pi.foto_pais::bytea, 'hex') as foto_pais
			from h_participacion pa, d_piloto pi, d_fecha f
			where pa.id_fecha=f.id
			and f.ano=inp_ano
			and pa.id_piloto2=pi.id
			and pi.genero='M'
			UNION
			select distinct pi.id as id, pi.nombre as nombre, pi.fecha_nacimiento as fecha_nacimiento, pi.fecha_muerte as fecha_muerte,
			pi.edad as edad, encode(pi.foto::bytea, 'hex') as foto, pi.pais_origen as pais_origen, pi.nacionalidad as nacionalidad,
			encode(pi.foto_pais::bytea, 'hex') as foto_pais
			from h_participacion pa, d_piloto pi, d_fecha f
			where pa.id_fecha=f.id
			and f.ano=inp_ano
			and pa.id_piloto3=pi.id
			and pi.genero='M'

		)  
		LOOP
			id:= var_r.id;
			nombre:= var_r.nombre;
			fecha_nacimiento:= var_r.fecha_nacimiento;
			fecha_muerte:= var_r.fecha_muerte;
			edad:= var_r.edad;
			foto:= var_r.foto;
			pais_origen:= var_r.pais_origen;
			nacionalidad:= var_r.nacionalidad;
			foto_pais:= var_r.foto_pais;
			RETURN NEXT;
		END LOOP;
		
	ELSE
		FOR var_r IN(
			select distinct pi.id as id, pi.nombre as nombre, pi.fecha_nacimiento as fecha_nacimiento, pi.fecha_muerte as fecha_muerte,
			pi.edad as edad, encode(pi.foto::bytea, 'hex') as foto, pi.pais_origen as pais_origen, pi.nacionalidad as nacionalidad,
			encode(pi.foto_pais::bytea, 'hex') as foto_pais
			from h_participacion pa, d_piloto pi, d_fecha f
			where pa.id_fecha=f.id
			and pa.id_piloto1=pi.id
			and pi.genero='M'
			UNION 
			select distinct pi.id as id, pi.nombre as nombre, pi.fecha_nacimiento as fecha_nacimiento, pi.fecha_muerte as fecha_muerte,
			pi.edad as edad, encode(pi.foto::bytea, 'hex') as foto, pi.pais_origen as pais_origen, pi.nacionalidad as nacionalidad,
			encode(pi.foto_pais::bytea, 'hex') as foto_pais
			from h_participacion pa, d_piloto pi, d_fecha f
			where pa.id_fecha=f.id
			and pa.id_piloto2=pi.id
			and pi.genero='M'
			UNION
			select distinct pi.id as id, pi.nombre as nombre, pi.fecha_nacimiento as fecha_nacimiento, pi.fecha_muerte as fecha_muerte,
			pi.edad as edad, encode(pi.foto::bytea, 'hex') as foto, pi.pais_origen as pais_origen, pi.nacionalidad as nacionalidad,
			encode(pi.foto_pais::bytea, 'hex') as foto_pais
			from h_participacion pa, d_piloto pi, d_fecha f
			where pa.id_fecha=f.id
			and pa.id_piloto3=pi.id
			and pi.genero='M'

		)  
		LOOP
			id:= var_r.id;
			nombre:= var_r.nombre;
			fecha_nacimiento:= var_r.fecha_nacimiento;
			fecha_muerte:= var_r.fecha_muerte;
			edad:= var_r.edad;
			foto:= var_r.foto;
			pais_origen:= var_r.pais_origen;
			nacionalidad:= var_r.nacionalidad;
			foto_pais:= var_r.foto_pais;
			RETURN NEXT;
		END LOOP;
	
	END IF;
		
		
END;
$BODY$;