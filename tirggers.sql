create or replace function numero_inscripcion() returns trigger as
$$
declare
    ultima_incripcion integer;
begin
    select count(*) + 1 from participantes into ultima_incripcion;
    new.numero_participacion = ultima_incripcion;
    return new;
end;
$$ language plpgsql;

create trigger numero_inscripcion
    before insert
    on participacion
    for each row
execute function numero_inscripcion();

create or replace function puesto_inicio() returns trigger as
$$
declare
    ultima_posicion integer;
begin
    -- usamos la función coalesce para convertir los NULL en 0
    select coalesce(max(puesto_inicio), 0) + 1 from participantes p into ultima_posicion;
    new.puesto_inicio = ultima_posicion;
    return new;
end;
$$ language plpgsql;

create trigger puesto_inicio
    before insert
    on participacion
    for each row
execute function puesto_inicio();