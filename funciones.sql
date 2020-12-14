----------------------------------
-- Definición de Funciones       -
----------------------------------  
create or replace function obtener_edad(persona datos_personales) returns smallint as
$$
declare
    intervalo_fechas interval;
    fecha_fin        timestamp;
begin
    if persona.fecha_fallecimiento is not null then
        fecha_fin := persona.fecha_fallecimiento::timestamp;
    else
        fecha_fin := now();
    end if;
    intervalo_fechas = age(fecha_fin, persona.fecha_nacimiento::timestamp);
    return ceil(date_part('year', intervalo_fechas))::smallint;
end;
$$ language plpgsql;

create or replace function obtener_identificacion(persona datos_personales) returns text as
$$
begin
    return persona.nombre || ' ' || persona.apellido;
end;
$$ language plpgsql;


create or replace function porcentaje_aleatorio_entre(l_inf real, l_sup real) returns real as
$$
begin
    return (random() * (l_sup - l_inf + 1) + l_inf) / 100;
end;
$$ language plpgsql;

create or replace function velocidad_maxima(velocidad_tope real) returns real as
$$
declare
    porcentaje real;
begin
    porcentaje := porcentaje_aleatorio_entre(85, 99);
    return velocidad_tope * porcentaje;
end;
$$ language plpgsql;

create or replace function velocidad_minima(velocidad_base real) returns real as
$$
declare
    porcentaje real;
begin
    porcentaje := porcentaje_aleatorio_entre(50, 69);
    return velocidad_base * porcentaje;
end;
$$ language plpgsql;


create or replace function velocidad_media(velocidad_base real) returns real as
$$
declare
    porcentaje real;
begin
    porcentaje := porcentaje_aleatorio_entre(70, 84);
    return velocidad_base * porcentaje;
end;
$$ language plpgsql;

create or replace function distancia_recorrida(velocidad_media real) returns real as
$$
declare
    porcentaje real;
begin
    porcentaje := porcentaje_aleatorio_entre(95, 105);
    return velocidad_media * porcentaje;
end;
$$ language plpgsql;

create or replace function cantidad_vueltas(distancia_recorrida real, longitud_circuito real) returns real as
$$
begin
    return distancia_recorrida / longitud_circuito;
end;
$$ language plpgsql;

create or replace function generar_estadistica(longitud_circuito real, velocidad_maxima_vehiculo real) returns estadistica as
$$
declare
    velocidad_maxima real;
    velocidad_minima real;
    velocidad_media real;
    cantidad_vueltas real;
    distancia_recorrida real;
begin
    velocidad_maxima := velocidad_maxima(velocidad_maxima_vehiculo);
    velocidad_minima := velocidad_minima(velocidad_maxima_vehiculo);
    velocidad_media := velocidad_media(velocidad_maxima_vehiculo);
    distancia_recorrida := distancia_recorrida(velocidad_media);
    cantidad_vueltas := cantidad_vueltas(distancia_recorrida, longitud_circuito);
    return row (velocidad_maxima,
        velocidad_minima,
        velocidad_media,
        mejor_tiempo_vuelta(cantidad_vueltas),
        peor_tiempo_vuelta(cantidad_vueltas),
        -1::smallint, -- Usamos un numero negativo para saber que tenemos que recalcular la posicion una vez hayamos generado todas las estadisticas de lahora
        distancia_recorrida);
end;
$$ language plpgsql;

create or replace function mejor_tiempo_vuelta(cantidad_vueltas real) returns interval as
$$
declare
    tiempo_mejor interval; -- tiempo medio (minutos)
    suma         interval; -- suma de tiempos parciales para promediar
begin
    tiempo_mejor := interval '60 minutes' / cantidad_vueltas;
    suma := interval '0 minutes';
    for _ in 1..5
        loop
            suma := suma + tiempo_mejor * porcentaje_aleatorio_entre(90, 99);
        end loop;
    return suma / 5;
end;
$$ language plpgsql;

create or replace function peor_tiempo_vuelta(cantidad_vueltas real) returns interval as
$$
declare
    tiempo_peor interval; -- tiempo medio (en minutos)
    suma        interval; -- suma de tiempos parciales para promediar
begin
    tiempo_peor := interval '60 minutes' / cantidad_vueltas;
    suma := interval '0 minutes';
    for _ in 1..5
        loop
            suma := suma + tiempo_peor * porcentaje_aleatorio_entre(101, 110);
        end loop;
    return suma / 5;
end;
$$ language plpgsql;

create or replace function aplicar_penalizacion(falla falla_tecnica, intervalo interval) returns interval as
$$
begin
    -- TODO: Levantar error cuando sea grave la falla
    return intervalo + falla.promedio_tiempo;
end;
$$ language plpgsql;

----------------------------------
-- Funciones de Equipo Tecnico   -
----------------------------------  

CREATE OR REPLACE FUNCTION generador_equipo_tecnico() RETURNS DATOS_PERSONALES
AS $$
DECLARE
    nombre varchar(20);
    apellido varchar(20);
    genero sexo := 'M';
    fecha_nac DATE;
    fecha_muerte DATE;
    random smallint;
    random_dia int;
    random_mes int;
    random_ano int;
BEGIN
    SELECT INTO random floor(random()*(11)); --Se crearan 10 nombres y apellidos, por lo cual el random tiene que estar entre 0 y 10
    SELECT INTO random_dia floor(random()*(28)+1); -- Se crea un dia de 0 a 30 para las fechas
    SELECT INTO random_mes  floor(random()*(12)+1); -- Se genera un numero de 1 a 12 para los meses
    SELECT INTO random_ano floor(random()*(20-10)+10); -- Para la generacion del año, tiene que tener al menos + de 20 años, por lo cualgeneramos un numero random y le sumamo 1890, para crear el año
    if (random < 6) then
        nombre := nombre_hombre(random);
        genero := 'M';
    else
        nombre := nombre_mujer(random);
        genero := 'F';
    end if;
    apellido := generar_apellido(random);
    fecha_nac := fecha_nacimiento(random_dia,random_mes,random_ano);
    fecha_muerte := fecha_muerte(random_dia,random_mes,random_ano);
    RETURN row(nombre,apellido,fecha_nac,genero,fecha_muerte);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nombre_hombre(random smallint) RETURNS varchar(20)
AS $$
DECLARE
    nombre varchar(20);
BEGIN
    -- 5 nombres aleatorios de hombre, dependiendo del numero random que salga se asignara uno
    if random = 1 then
        nombre := 'John';
    elsif random = 2 then
        nombre := 'Frank';
    elsif random = 3 then
        nombre := 'Luis';
    elsif random = 4 then
        nombre := 'Marcos';
    else 
        nombre := 'Alejandro';
    end if;
    RETURN nombre;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nombre_mujer(random smallint) RETURNS varchar(20)
AS $$
DECLARE
    nombre varchar(20);
BEGIN
    -- 5 nombres aleatorios de mujer, dependiendo del numero random que salga se asignara uno
    -- Como los numeros randon que entren aqui seran mayores a 5, se les resta 5 para que cumplan las condiciones
    random := random - 5;
    if random = 1 then
        nombre := 'Andrea';
    elsif random = 2 then
        nombre := 'Valentina';
    elsif random = 3 then
        nombre := 'Luisa';
    elsif random = 4 then
        nombre := 'Cindy';
    else 
        nombre := 'Antonieta';
    end if;
    RETURN nombre;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generar_apellido(random smallint) RETURNS varchar(20)
AS $$
DECLARE
    apellido varchar(20);
BEGIN
    -- Apellidos random
    if random = 1 then
        apellido := 'Montilla';
    elsif random = 2 then
        apellido := 'Chineti';
    elsif random = 3 then
        apellido := 'Grande';
    elsif random = 4 then
        apellido := 'Canovas';
    elsif random = 5 then
        apellido := 'Quintero';
    elsif random = 6 then
        apellido := 'Valencia';
    elsif random = 7 then
        apellido := 'Serra';
    elsif random = 8 then
        apellido := 'Salas';
    elsif random = 9 then
        apellido := 'Mendez';
    else 
        apellido := 'Marin';
    end if;
    RETURN apellido;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fecha_nacimiento(dia int, mes int , ano int) RETURNS DATE
AS $$
DECLARE
    fecha DATE;
BEGIN
    -- Generacion de la fecha de nacimiento, se pasan los randoms como ints y se usa la funcion make_date para crear un tipo date
    fecha := make_date(ano + 1890, mes , dia);
   RETURN fecha;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fecha_muerte(dia int, mes int , ano int) RETURNS DATE
AS $$
DECLARE
    fecha DATE;
BEGIN
-- Generacion de la fecha de muerte, se pasan los randoms como ints y se usa la funcion make_date para crear un tipo date
    fecha := make_date(ano + 1940, mes , dia);
   RETURN fecha;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION equipo_tecnico_completo() RETURNS DATOS_PERSONALES[][]
AS $$
DECLARE
    equipo_tecnico DATOS_PERSONALES[][] := '{{NULL,NULL,NULL,NULL},{NULL,NULL,NULL,NULL}}' ;
    i smallint;
BEGIN
    -- Procedimiento usado para crear la matriz de Equipo tecnico, donde la primera fila corresponde a los mecanicos y la segunda al director de los pits.
    FOR i IN 1..4 LOOP
        equipo_tecnico[1][i] := generador_equipo_tecnico();
    END LOOP;
    equipo_tecnico[2][1] := generador_equipo_tecnico();
    RETURN equipo_tecnico;
END;
$$ LANGUAGE plpgsql;


-----------------------------------------
-- Fin de Funciones de Equipo Tecnico   -
-----------------------------------------