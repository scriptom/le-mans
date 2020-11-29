----------------------------------
-- Definición de TDA             -
----------------------------------

create type incompleto as (
    motivo varchar(255),
    vuelta smallint
);

create domain sexo as char(1) check (value = 'F' or value = 'M');

create type datos_personales as (
    nombre varchar(20),
    apellido varchar(20),
    fecha_nacimiento date,
    genero sexo not null,
    fecha_fallecimiento date
);

create type cronometro as (
    hora smallint,
    minutos smallint,
    segundos smallint,
    milisegundos smallint
)

create type estadistica as (
    vel_maxima real,
    vel_minima real,
    vel_media real,
    mejor_tiempo_vuelta cronometro,
    peor_tiempo_vuelta cronometro,
    posicion smallint,
    distancia_recorrida real
);


create type falla_tecnica as (
    parte_afectada varchar(20),
    gravedad smallint,
    promedio_tiempo cronometro
);

----------------------------------
-- Definición de tablas          -
----------------------------------

create or replace table evento (
    id serial primary key,
    tipo varchar(15) not null,
    ano smallint not null,
    longitud real not null
);

create or replace table equipo (
    id serial primary key,
    nombre varchar(20) not null,
    pais_id smallint not null
);

create or replace table fabricante (
    id serial primary key,
    nombre varchar(20) not null,
    pais_id smallint not null
);

create or replace table pais (
    id smallserial primary key,
    nombre varchar(20) not null,
    nacionalidad varchar(20) not null,
    foto bytea not null
);

create or replace table piloto (
    id serial primary key,
    datos datos_personales not null,
    foto bytea[5],
    pais_id smallint not null
);

create or replace table vehiculo (
    id smallserial primary key, 
    velocidad real not null,
    peso smallint not null,
    tipo varchar(40) not null,
    nombre_chasis varchar(40) not null,
    chasis_fabricante_id integer not null,
    neumaticos_fabricante_id integer not null,
    motor_id integer not null
);

create or replace table motor (
    id smallserial primary key,
    caballos_fuerza smallint not null,
    modelo varchar(40) not null,
    es_hibrido boolean not null,
    fabricante_id integer not null
);

create or replace table piloto_participacion (
    piloto_id integer not null,
    participacion_id integer,
    primary key(piloto_id, participacion_id)
);

create or replace table participacion (
    id serial,
    finalizo boolean not null,
    numero_vueltas smallint not null,
    numero_participacion smallint not null,
    tiempo_total cronometro not null,
    estadisticas_hora estadistica[25] not null,
    fallas falla_tecnica[40],
    abandono incompleto,
    equipo_tecnico datos_personales[][] not null,
    puesto_inicio smallint not null,
    vehiculo_id smallint not null,
    equipo_id integer not null,
    evento_id integer not null
    primary key(id, equipo_id)
);

----------------------------------
-- Definición de FKs             -
----------------------------------
alter table equipo add foreign key (pais_id) references pais(id);

alter table fabricante add foreign key (pais_id) references pais(id);

alter table piloto add foreign key (pais_id) references pais(id);

alter table vehiculo add foreign key (chasis_fabricante_id) references fabricante(id);
alter table vehiculo add foreign key (neumaticos_fabricante_id) references fabricante(id);
alter table vehiculo add foreign key (motor_id) references motor(id);

alter table motor add foreign key (fabricante_id) references fabricante(id);

alter table piloto_participacion add foreign key (piloto_id) references piloto(id);
alter table piloto_participacion add foreign key (participacion_id) references participacion(id);

alter table participacion add foreign key (vehiculo_id) references vehiculo(id);
alter table participacion add foreign key (equipo_id) references equipo(id);
alter table participacion add foreign key (evento_id) references evento(id);
----------------------------------
-- Definición de Funciones       -
----------------------------------

create or replace function obtener_edad(persona datos_personales) returns smallint as $$
declare
    intervalo_fechas interval,
    fecha_fin timestamp
begin
    if persona.fecha_fallecimiento is not null then 
        fecha_fin := persona.fecha_fallecimiento::timestamp;
    else 
        fecha_fin := now();
    end if;
    intervalo_fechas = age(fecha_fin, timestamp persona.fecha_nacimiento);
    return ceil(date_part('year', intervalo_fechas))::integer;
end; $$ language plpgsql;

create or replace function obtener_identificacion(persona datos_personales) returns text as $$
begin
    return persona.nombre || ' ' || persona.apellido;
end; $$ language plpgsql;


-- TODO: Agregar métodos diferencia y sumar (Cronometro)
-- TODO: Agregar métodos VelocidadMaxim, VelocidadMinima, DistanciaRecorrida, CantidadVueltas, MejorTiempo, PeorTiempo (Estadistica)
-- TODO: Agregar método AplicarPenalización (falla_tecnica)