CREATE OR REPLACE FUNCTION public.reporte_diez_aux(inp_id_piloto integer)
    RETURNS integer
    security definer
as
$$

DECLARE
    ano integer;
BEGIN

    select f.ano
    into ano
    from h_participacion as pa,
         d_fecha as f
    where (pa.id_piloto1 = inp_id_piloto or pa.id_piloto2 = inp_id_piloto or pa.id_piloto3 = inp_id_piloto)
      and pa.puesto_final = 1
      and pa.id_fecha = f.id
      and f.id = (
        select faux.id
        from d_fecha as faux,
             h_participacion as paux
        where (paux.id_piloto1 = inp_id_piloto or paux.id_piloto2 = inp_id_piloto or paux.id_piloto3 = inp_id_piloto)
          and paux.id_fecha = faux.id
        order by 1 asc
        limit 1
    );


    return ano;

END;
$$ language plpgsql;



CREATE OR REPLACE FUNCTION public.reporte_diez_data(inp_ano integer)
    RETURNS TABLE
            (
                piloto_nombre    varchar,
                piloto_pais      varchar,
                piloto_foto_pais varchar,
                piloto_foto      varchar,
                out_ano          integer
            )
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
    security definer

AS
$BODY$
DECLARE
    var_r record;
    var_z record;
    ano   integer;
BEGIN

    FOR var_r IN
        (
            select pi.id as id
            from d_piloto pi
            where pi.id <> 0
        )
        LOOP
            IF inp_ano IS NULL THEN
                ano := (select * from reporte_diez_aux(var_r.id));
                IF ano IS NOT NULL THEN
                    FOR var_z IN (
                        select pi1.nombre                          as piloto_nombre1,
                               pi1.pais_origen                     as piloto_pais1,
                               encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1,
                               encode(pi1.foto::bytea, 'hex')      as piloto_foto1
                        from d_piloto as pi1
                        where pi1.id = var_r.id
                    )
                        LOOP
                            piloto_nombre := var_z.piloto_nombre1;
                            piloto_pais := var_z.piloto_pais1;
                            piloto_foto_pais := var_z.piloto_foto_pais1;
                            piloto_foto := var_z.piloto_foto1;
                            out_ano := ano;
                            RETURN NEXT;
                        END LOOP;
                END IF;

            ELSE
                ano := (select * from reporte_diez_aux(var_r.id));
                IF ano IS NOT NULL and ano = inp_ano THEN
                    FOR var_z IN (
                        select pi1.nombre                          as piloto_nombre1,
                               pi1.pais_origen                     as piloto_pais1,
                               encode(pi1.foto_pais::bytea, 'hex') as piloto_foto_pais1,
                               encode(pi1.foto::bytea, 'hex')      as piloto_foto1
                        from d_piloto as pi1
                        where pi1.id = var_r.id
                    )
                        LOOP
                            piloto_nombre := var_z.piloto_nombre1;
                            piloto_pais := var_z.piloto_pais1;
                            piloto_foto_pais := var_z.piloto_foto_pais1;
                            piloto_foto := var_z.piloto_foto1;
                            out_ano := ano;
                            RETURN NEXT;
                        END LOOP;
                END IF;


            END IF;
        END LOOP;

END;
$BODY$;