-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Construya una consulta que ordene la tabla por letra y valor (3ra columna).
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

!hdfs dfs -rm -r -f /data;

!hdfs dfs -rm -r -f /output;

!hdfs dfs -mkdir /data;

!hdfs dfs -copyFromLocal data.tsv  /data/data.tsv;

--!hdfs dfs -ls /data/*;

DROP TABLE IF EXISTS data;

CREATE TABLE data ( letra       STRING,
                    fecha       STRING,
                    valor    INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA INPATH '/data/data.tsv' OVERWRITE
INTO TABLE data;

DROP TABLE IF EXISTS resultado;

CREATE TABLE resultado
AS
    SELECT *
    FROM
        data
    ORDER BY letra, valor, fecha;

--SELECT * FROM resultado;

INSERT OVERWRITE DIRECTORY '/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT
    *
FROM
    resultado;

--!hdfs dfs -ls /output;
-- !hdfs dfs -tail /output/000000_0;

!hdfs dfs -copyToLocal /output  output;