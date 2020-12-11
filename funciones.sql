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
begin
    velocidad_maxima := velocidad_maxima(velocidad_maxima_vehiculo);
    return row (velocidad_maxima, velocidad_minima(velocidad_maxima), velocidad_media(velocidad_maxima), mejor_tiempo_vuelta, peor_tiempo_vuelta);
end;
$$ language plpgsql;

create or replace function mejor_tiempo_vuelta(cantidad_vueltas real) returns interval as
$$
declare
    tiempo_mejor real;
    suma         real;
begin
    tiempo_mejor := 60 / cantidad_vueltas;
    suma := 0;
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
    tiempo_peor real;
    suma        real;
begin
    tiempo_peor := 60 / cantidad_vueltas;
    suma := 0;
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
