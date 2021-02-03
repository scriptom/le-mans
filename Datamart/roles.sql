-- Creación de roles
create role Desarrollador superuser; -- == Admin
create role "Analista de negocios 1";
create role "Analista de negocios 2";
create role "Analista de negocios 3";

-- Creación de usuarios
create user dev in role Desarrollador password 'dev1';
create user analista1 in role "Analista de negocios 1" password 'analista';
create user analista2 in role "Analista de negocios 2" password 'analista';
create user analista3 in role "Analista de negocios 3" password 'analista';

-- Quitar permisos publicos por defecto
revoke all on database lemans_datamart from public;
revoke all on database postgres from public;


-- Asignación permisos para Analista 1
\c postgres;
grant connect on database postgres to "Analista de negocios 1";
grant usage on schema public to "Analista de negocios 1";
grant select on all tables in schema public to "Analista de negocios 1";

\c lemans_datamart;
-- Permisos para rol Analista 2
grant connect on database lemans_datamart to "Analista de negocios 2";
grant usage on schema public to "Analista de negocios 2";
grant execute on function
    lemans_datamart.public.reporte_cuatro_data(integer),
    lemans_datamart.public.reporte_cinco_data_participaciones(integer),
    lemans_datamart.public.reporte_cinco_data_piloto(integer),
    lemans_datamart.public.reporte_seis_data(integer),
    lemans_datamart.public.reporte_seis_aplanar(integer),
    lemans_datamart.public.reporte_siete_data(integer),
    lemans_datamart.public.reporte_ocho_data(integer),
    lemans_datamart.public.reporte_nueve_contador(integer),
    lemans_datamart.public.reporte_nueve_data(),
    lemans_datamart.public.reporte_diez_data(integer),
    lemans_datamart.public.reporte_diez_aux(integer)
    to "Analista de negocios 2";

-- Permisos para rol Analista 3
grant connect on database lemans_datamart to "Analista de negocios 3";
grant usage on schema public to "Analista de negocios 3";
grant execute on function
    lemans_datamart.public.reporte_once_data(integer),
    lemans_datamart.public.reporte_doce_data(integer),
    lemans_datamart.public.reporte_trece(),
    lemans_datamart.public.reporte_catorce(),
    lemans_datamart.public.reporte_quince_autos(varchar),
    lemans_datamart.public.reporte_quince_cauchos(varchar),
    lemans_datamart.public.reporte_dieciseis_data_piloto(integer)
    to "Analista de negocios 3";
