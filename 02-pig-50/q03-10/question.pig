-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
data = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (letra:CHARARRAY, 
        fecha:CHARARRAY,
        cantidad:INT);
DUMP data;

cantidad = FOREACH data GENERATE cantidad;
DUMP cantidad;

dataorder = ORDER cantidad BY cantidad;
DUMP dataorder;

data_in_five = LIMIT dataorder 5;
DUMP data_in_five;

STORE data_in_five INTO 'output' using PigStorage('\t');
