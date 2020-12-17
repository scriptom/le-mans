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
    return floor((random() * (l_sup - l_inf + 1) + l_inf)) / 100;
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
    velocidad_maxima    real;
    velocidad_minima    real;
    velocidad_media     real;
    cantidad_vueltas    real;
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
    -- Si la falla es grave, entonces vamos a simplemente arrijar una excepción con un código personalizado
    if falla.gravedad = 3::smallint then
        raise exception using
            errcode = 'GRAVE';
    end if;
    return intervalo + falla.promedio_tiempo;
end;
$$ language plpgsql;

----------------------------------
-- Funciones de Equipo Tecnico   -
----------------------------------  

CREATE OR REPLACE FUNCTION generador_equipo_tecnico() RETURNS DATOS_PERSONALES
AS
$$
DECLARE
    nombre       varchar(20);
    apellido     varchar(20);
    genero       sexo := 'M';
    fecha_nac    DATE;
    fecha_muerte DATE;
    random       smallint;
    random_dia   int;
    random_mes   int;
    random_ano   int;
BEGIN
    SELECT INTO random floor(random() * (11)); --Se crearan 10 nombres y apellidos, por lo cual el random tiene que estar entre 0 y 10
    SELECT INTO random_dia floor(random() * (28) + 1); -- Se crea un dia de 0 a 30 para las fechas
    SELECT INTO random_mes floor(random() * (12) + 1); -- Se genera un numero de 1 a 12 para los meses
    SELECT INTO random_ano floor(random() * (20 - 10) + 10); -- Para la generacion del año, tiene que tener al menos + de 20 años, por lo cualgeneramos un numero random y le sumamo 1890, para crear el año
    if (random < 6) then
        nombre := nombre_hombre(random);
        genero := 'M';
    else
        nombre := nombre_mujer(random);
        genero := 'F';
    end if;
    apellido := generar_apellido(random);
    fecha_nac := fecha_nacimiento(random_dia, random_mes, random_ano);
    fecha_muerte := fecha_muerte(random_dia, random_mes, random_ano);
    RETURN row (nombre,apellido,fecha_nac,genero,fecha_muerte);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nombre_hombre(random smallint) RETURNS varchar(20)
AS
$$
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
AS
$$
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
AS
$$
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

CREATE OR REPLACE FUNCTION fecha_nacimiento(dia int, mes int, ano int) RETURNS DATE
AS
$$
DECLARE
    fecha DATE;
BEGIN
    -- Generacion de la fecha de nacimiento, se pasan los randoms como ints y se usa la funcion make_date para crear un tipo date
    fecha := make_date(ano + 1890, mes, dia);
    RETURN fecha;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fecha_muerte(dia int, mes int, ano int) RETURNS DATE
AS
$$
DECLARE
    fecha DATE;
BEGIN
    -- Generacion de la fecha de muerte, se pasan los randoms como ints y se usa la funcion make_date para crear un tipo date
    fecha := make_date(ano + 1940, mes, dia);
    RETURN fecha;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION equipo_tecnico_completo() RETURNS DATOS_PERSONALES[][]
AS
$$
DECLARE
    equipo_tecnico DATOS_PERSONALES[][] := '{{NULL,NULL,NULL,NULL},{NULL,NULL,NULL,NULL}}' ;
    i              smallint;
BEGIN
    -- Procedimiento usado para crear la matriz de Equipo tecnico, donde la primera fila corresponde a los mecanicos y la segunda al director de los pits.
    FOR i IN 1..4
        LOOP
            equipo_tecnico[1][i] := generador_equipo_tecnico();
        END LOOP;
    equipo_tecnico[2][1] := generador_equipo_tecnico();
    RETURN equipo_tecnico;
END;
$$ LANGUAGE plpgsql;

-----------------------------------------
-- Fin de Funciones de Equipo Tecnico   -
-----------------------------------------

--Funcion utilizada para devolver la velocidad media en funcion a la cantidad de vueltas
CREATE OR REPLACE FUNCTION consulta_velocidad_media(cantidad_vueltas smallint, longitud_cir real,hora int) RETURNS REAL
AS $$
BEGIN
--Para los reportes se buscara la velocidad media en la carrera, par esto se necesita la cantidad de vueltas
--finales que se registraron y se dividira entre 24, se multiplicara por la distancia del circuito para
--tener una velocidad media aproximada, ya que eso dira cuanto recorrio aproximadamente cada hora
RETURN (cantidad_vueltas * longitud_cir)/ hora;
END;
$$ LANGUAGE plpgsql;

--Funcion utilizada para buscar el mejor tiempo de vuelta
CREATE OR REPLACE FUNCTION consulta_mejor_tiempo(estadisticas estadistica[], hora int) RETURNS interval
AS $$
DECLARE
    cont int = array_length(estadisticas,1);
    mejor interval = '24:00:00';
BEGIN
    -- Para buscar el mejor timpo, iteramos en el array de estadisticas hasta la hora seleccionada
    FOR i IN 1..hora LOOP
        if (i > array_length(estadisticas,1)) then
            -- Si el participante no estuvo las 24 horas, se compara el contador a la longitud del array para saber si hay que parar de iterar
            EXIT;
        end if;
        if (mejor > estadisticas[i].mejor_tiempo_vuelta) then
            -- Para saber si se tiene el tiempo mas bajo, se comprar con el mejor tiempo guardado a ver si este es menor al que se tiene guardado
            -- si es asi, se asigna a mejor y se sigue iterando hasta llegar a los 24
            mejor = estadisticas[i].mejor_tiempo_vuelta;
        end if;
    END LOOP;
RETURN mejor;
END;
$$ LANGUAGE plpgsql;

--Funcion usada para calcular la distancia en vueltas con el puesto anterior
--Los parametros serian: la distancia recorrida hasta la hora del participante anterior, la distancia recorrida del corredor y la longitud del circuito
CREATE OR REPLACE FUNCTION consultar_vueltas_anterior(distancia_anterior real,distancia real,longitud real) RETURNS smallint
AS $$
DECLARE
BEGIN
    --Para saber la distancia en vueltas se va a restar las distancias recorridas en la hora
    --y se dividiran entre la longitud del circuito par sacar la cantidad de vueltas
    --luego se les hara floor para devolver una cantidad entera
    RETURN FLOOR(cantidad_vueltas(distancia - distancia_anterior,longitud));
END;
$$ LANGUAGE plpgsql;

--Funcion utilizada para calcular la distancia que ha recorrido un participante en total
CREATE OR REPLACE FUNCTION calcular_distancia_recorrida(estadisticas estadistica[], hora int) RETURNS real
AS $$
DECLARE
    cont int = array_length(estadisticas,1);
    total real = 0;
BEGIN
    --Para calcular la distancia recorrdia, recorremos el array hasta la hora especificada
     FOR i IN 1..hora LOOP
        if (i > array_length(estadisticas,1)) then
            -- Si el participante no estuvo las 24 horas, se compara el contador a la longitud del array para saber si hay que parar de iterar
            EXIT;
        end if;
        --Se suma la distancia recorrida en cada iteracion del ciclo
        total = total + estadisticas[i].distancia_recorrida;
    END LOOP;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- funcion creada para calcualr el tiempo con respecto al piloto anterior
--los parametros serian: la distancia recorrida del piloto anterior, la velocidad media a la que iba en esa hora y la distancia recorrida por el piloto
CREATE OR REPLACE FUNCTION calcular_tiempo_anterior(distancia_recorrida_anterior real, velocidad_anterior real , distancia real) RETURNS time
AS $$
DECLARE
   tiempo interval = '00:00:00';
   distancia_faltante real = 0;
   tiempo_faltante real;
   minutos int;
BEGIN
    --Para calcular el tiempo se usara una regla de 3, primero se calculara la distancia que debe recorrer
    -- para alcanzar al piloto, siendo una resta de distancias
    distancia_faltante = distancia - distancia_recorrida_anterior;
    --Luego se multiplicara por 60 y se dividira entra la velocidad a la que iba el piloto para saber en cuanto
    --tiempo lo alcanzara usando la velocidad media como referencia
    tiempo_faltante = ((distancia_faltante * 60) / velocidad_anterior);
    if (tiempo_faltante - FLOOR(tiempo_faltante) > 0.60) then
        tiempo_faltante = tiempo_faltante +  1 - 0.60;
    end if;
    --Luego se creara un tipo date armado con el tiempo
    minutos = FLOOR(tiempo_faltante::int);
    RETURN make_time(0,minutos,(tiempo_faltante - FLOOR(tiempo_faltante))*100);
END;
$$ LANGUAGE plpgsql;


-- funcion creada para calcualr el tiempo con respecto al piloto anterior
--los parametros serian: la distancia recorrida del piloto anterior, la velocidad media a la que iba en esa hora y la distancia recorrida por el piloto
CREATE OR REPLACE FUNCTION calcular_vueltas_hora(estadisticas estadistica[], hora int, longitud real) RETURNS real
AS $$
DECLARE
   distancia_recorrida real;
BEGIN
    distancia_recorrida = calcular_distancia_recorrida(estadisticas,hora);
    RETURN FLOOR(cantidad_vueltas(distancia_recorrida,longitud));
END;
$$ LANGUAGE plpgsql;

--funcion usada para convertir reals en tiempo
CREATE OR REPLACE FUNCTION convertir_tiempo(tiempo real) RETURNS interval
AS $$
DECLARE
    minutos int;
    segundos real;
BEGIN
    minutos = FLOOR(tiempo)::int;
    segundos = (tiempo - FLOOR(tiempo)) * 100;
 RETURN make_interval(mins => minutos,secs => segundos);
END;
$$ LANGUAGE plpgsql;

(select estadisticas_hora from participacion where id = 103)










-- DANIEL

-- funcion que devuelve la cantidad de horas que un participante estuvo en participacion
CREATE OR REPLACE FUNCTION consulta_horas_en_carrera(estadisticas estadistica[]) RETURNS integer
AS $$
DECLARE
    horas int = array_length(estadisticas,1);
BEGIN
RETURN horas;
END;
$$ LANGUAGE plpgsql;








--Funcion que crea la hora final
CREATE OR REPLACE FUNCTION convertir_tiempo_final(tiempo real) RETURNS interval
AS $$
DECLARE
    minutos int;
    segundos real;
BEGIN
    minutos = FLOOR(tiempo)::int;
    segundos = (tiempo - FLOOR(tiempo)) * 100;
    -- Como es la hora final, al real que le paso hay que agregarle las 24 horas, ya que es lo que determianara el excedente
 RETURN make_interval(hours =>24 ,mins => minutos,secs => segundos);
END;
$$ LANGUAGE plpgsql;

(select estadisticas_hora from participacion where id = 103)

create or replace function generar_falla_tecnica() returns falla_tecnica
    language plpgsql
as
$$
declare
    random integer;
    falla  falla_tecnica;
begin
    random := (porcentaje_aleatorio_entre(1, 20) * 100)::integer;
    raise notice 'random %', random;
    case
        when random between 1 and 14 then
            falla := null;
        when random between 15 and 17 then
            falla := row ('Cambio de cauchos', 1, make_interval(secs := porcentaje_aleatorio_entre(5, 12) * 100));
        when random between 18 and 19 then
            falla := row ('Cambio de frenos', 2, make_interval(secs := porcentaje_aleatorio_entre(15, 30) * 100));
        when random = 20 then
            falla := row ('Problema de motor', 3, null); -- este intervalo no importa, puesto que de todas formas
        end case;

    return falla;
end;
$$;

-- Fuente: https://stackoverflow.com/a/25997497
-- Devuelve las filas de un array bidimensional
CREATE OR REPLACE FUNCTION unnest_2d_1d(anyarray)
  RETURNS SETOF anyarray AS
$func$
SELECT array_agg($1[d1][d2])
FROM   generate_series(array_lower($1,1), array_upper($1,1)) d1
    ,  generate_series(array_lower($1,2), array_upper($1,2)) d2
GROUP  BY d1
ORDER  BY d1
$func$  LANGUAGE sql IMMUTABLE;
