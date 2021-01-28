CREATE TABLE "h_participacion" (
  "id" int NOT NULL primary key,
  "id_equipo" int NOT NULL,
  "id_vehiculo" int NOT NULL,
  "id_fecha" int NOT NULL,
  "id_piloto1" int NOT NULL,
  "edad_p1" smallint NOT NULL,
  "id_piloto2" int NOT NULL,
  "edad_p2" smallint NOT NULL,
  "id_piloto3" int NOT NULL,
  "edad_p3" smallint NOT NULL,
  "numero_participacion" smallint NOT NULL,
  "puesto_final"  smallint NULL,
  "finalizo" char(1) NOT NULL,
  "cantidad_vueltas" int NOT NULL,
  "distancia_recorrida" int NOT NULL,
  "diferencia_puesto_anterior_tiempo" interval NOT NULL,
  "diferencia_puesto_anterior_vueltas" int NOT NULL,
  "velocidad_media" real NOT NULL,
  "velocidad_maxima" real NOT NULL
);

CREATE TABLE "d_piloto" (
  "id" int NOT NULL primary key,
  "nombre" character varying(50) NOT NULL,
  "fecha_nacimiento" date NOT NULL,
  "fecha_muerte" date NOT NULL,
  "edad" smallint NOT NULL,
  "genero" char varying(1) NOT NULL,
  "foto" bytea NOT NULL,
  "pais_origen" char varying(35) NOT NULL,
  "nacionalidad" char varying(35) NOT NULL,
  "foto_pais" bytea NOT NULL
);

CREATE TABLE "d_fecha" (
  "id" int NOT NULL primary key,
  "ano" int NOT NULL,
  "mes" smallint NOT NULL,
  "dia" smallint NOT NULL
);

CREATE TABLE "d_vehiculo" (
  "id" int NOT NULL primary key,
  "nombre" char varying(40) NOT NULL,
  "motor" char varying(40) NOT NULL,
  "categoria" char varying(20) NOT NULL,
  "hibrido" char(1) NOT NULL,
  "foto" bytea NOT NULL,
  "fabricante" char varying(40) NOT NULL,
  "pais_fabricante" char varying(40) NOT NULL,
  "fabricante_caucho" char varying(40) NOT NULL
);

CREATE TABLE "d_equipo" (
  "id" int NOT NULL primary key,
  "nombre" char varying(40) NOT NULL,
  "pais_origen" char varying(35) NOT NULL,
  "nacionalidad" char varying(35) NOT NULL
);

ALTER TABLE h_participacion add foreign key (id_equipo) references d_equipo(id) on delete restrict;

ALTER TABLE h_participacion add foreign key (id_vehiculo) references d_vehiculo(id) on delete restrict;

ALTER TABLE h_participacion add foreign key (id_fecha) references d_fecha(id) on delete restrict;

ALTER TABLE h_participacion add foreign key (id_piloto1) references d_piloto(id) on delete restrict;

ALTER TABLE h_participacion add foreign key (id_piloto2) references d_piloto(id) on delete restrict;

ALTER TABLE h_participacion add foreign key (id_piloto3) references d_piloto(id) on delete restrict;
