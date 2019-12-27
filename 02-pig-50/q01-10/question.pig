-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra. 
-- Escriba el resultado a la carpeta `output` del directorio actual.
--

fs -rm -f -r output;

data = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (letra:CHARARRAY, 
        fecha:CHARARRAY,
        cantidad:INT);
DUMP data;

groupletra = GROUP data BY letra;
DUMP groupletra;

conteo = FOREACH groupletra GENERATE $0, COUNT(data);
DUMP conteo;

STORE conteo INTO 'output' using PigStorage('\t');