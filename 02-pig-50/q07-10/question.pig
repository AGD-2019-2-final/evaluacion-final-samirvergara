-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;

data = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (letra:CHARARRAY, 
        lista_letras:BAG{t: tuple(a:CHARARRAY)},
        clave_valor:MAP[]);
DUMP data;

data_count = FOREACH data GENERATE letra, COUNT(lista_letras), COUNT(clave_valor);
DUMP data_count;

claves = FOREACH lista_clave_valor GENERATE FLATTEN(clave_valor) AS clave_valor;
DUMP claves;

grouped = GROUP claves BY clave_valor;
DUMP grouped;

clave_count = FOREACH grouped GENERATE group, COUNT(claves);
DUMP clave_count;

STORE clave_count INTO 'output' using PigStorage(',');
