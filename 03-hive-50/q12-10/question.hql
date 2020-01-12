-- 
-- Pregunta
-- ===========================================================================
--
-- Escriba una consulta que compute la cantidad de registros por letra de la 
-- columna 2 y clave de la columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `a` en la columna 2 y la clave `aaa` en la 
-- columna 3 es:
--
--     a    aaa    5
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
DROP TABLE IF EXISTS t0;

CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';

LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

CREATE TABLE resultado
AS
    SELECT c2_1, c3_1, count(*) 
    FROM (
        SELECT
            c2_1, c3_1
        FROM
            t0
        LATERAL VIEW explode(c2) t0 AS c2_1
        LATERAL VIEW explode(c3) t0 AS c3_1, c3_2
        ) t0
    GROUP BY c2_1, c3_1
    ORDER BY c2_1, c3_1;

!hdfs dfs -rm -r -f /output;

INSERT OVERWRITE DIRECTORY '/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT
    *
FROM
    resultado;

!hdfs dfs -copyToLocal /output  output;


