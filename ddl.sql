----------------------------------
-- Definición de TDA             -
----------------------------------

create type incompleto as (
    motivo varchar(255),
    vuelta smallint
);

create domain sexo as char(1) not null check (value = 'F' or value = 'M');

create type datos_personales as (
    nombre varchar(20),
    apellido varchar(20),
    fecha_nacimiento date,
    genero sexo, -- Por el domain, ya el sexo es not null
    fecha_fallecimiento date
);

create type estadistica as (
    vel_maxima real,
    vel_minima real,
    vel_media real,
    mejor_tiempo_vuelta interval,
    peor_tiempo_vuelta interval,
    posicion smallint,
    distancia_recorrida real
);


create type falla_tecnica as (
    parte_afectada varchar(20),
    gravedad smallint,
    promedio_tiempo interval
);

----------------------------------
-- Definición de tablas          -
----------------------------------

create table evento (
    id serial primary key,
    tipo varchar(15) not null,
    ano smallint not null,
    longitud real not null
);

create table equipo (
    id serial primary key,
    nombre varchar(40) not null,
    pais_id smallint not null
);

create table fabricante (
    id serial primary key,
    nombre varchar(40) not null,
    pais_id smallint not null
);

create table pais (
    id smallserial primary key,
    nombre varchar(35) not null,
    nacionalidad varchar(35) not null,
    foto bytea not null
);

create table piloto (
    id serial primary key,
    datos datos_personales not null,
    foto bytea[5],
    pais_id smallint not null
);

create table vehiculo (
    id smallserial primary key, 
    velocidad real not null,
    peso smallint not null,
    tipo varchar(40) not null,
    foto bytea[][],
    nombre_chasis varchar(40) not null,
    chasis_fabricante_id integer not null,
    neumaticos_fabricante_id integer not null,
    motor_id integer not null
);

create table motor (
    id smallserial primary key,
    caballos_fuerza smallint not null,
    modelo varchar(40) not null,
    es_hibrido boolean not null,
    fabricante_id integer not null
);

create table piloto_participacion (
    piloto_id integer not null,
    participacion_id integer,
    equipo_id integer,
    primary key (piloto_id, participacion_id, equipo_id)
);

create table participacion (
    id serial,
    finalizo boolean not null,
    numero_vueltas smallint not null,
    numero_participacion smallint not null,
    tiempo_total interval not null,
    estadisticas_hora estadistica[25] not null,
    fallas falla_tecnica[40],
    abandono incompleto,
    equipo_tecnico datos_personales[][] not null,
    puesto_inicio smallint not null,
    vehiculo_id smallint not null,
    equipo_id integer not null,
    evento_id integer not null,
    primary key (id, equipo_id)
);

----------------------------------
-- Definición de FKs             -
----------------------------------
alter table equipo add foreign key (pais_id) references pais(id) on delete restrict;

alter table fabricante add foreign key (pais_id) references pais(id) on delete restrict;

alter table piloto add foreign key (pais_id) references pais(id) on delete restrict;

alter table vehiculo add foreign key (chasis_fabricante_id) references fabricante(id) ;
alter table vehiculo add foreign key (neumaticos_fabricante_id) references fabricante(id);
alter table vehiculo add foreign key (motor_id) references motor(id) on delete restrict;

alter table motor add foreign key (fabricante_id) references fabricante(id) on delete restrict;

alter table piloto_participacion add foreign key (piloto_id) references piloto(id) on delete cascade;
alter table piloto_participacion add foreign key (participacion_id, equipo_id) references participacion(id, equipo_id) on delete cascade;

alter table participacion add foreign key (vehiculo_id) references vehiculo(id) on delete restrict;
alter table participacion add foreign key (equipo_id) references equipo(id) on delete cascade;
alter table participacion add foreign key (evento_id) references evento(id) on delete restrict;
