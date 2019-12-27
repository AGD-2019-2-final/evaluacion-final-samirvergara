-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;

data = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (letra:CHARARRAY, 
        lista_letras:BAG{t: tuple(a:CHARARRAY)},
        clave_valor:MAP[]);
DUMP data;

lista_clave_valor = FOREACH data GENERATE clave_valor;
DUMP lista_clave_valor;

claves = FOREACH lista_clave_valor GENERATE FLATTEN(clave_valor) AS clave_valor;
DUMP claves;

grouped = GROUP claves BY clave_valor;
DUMP grouped;

clave_count = FOREACH grouped GENERATE group, COUNT(claves);
DUMP clave_count;

STORE clave_count INTO 'output' using PigStorage(',');