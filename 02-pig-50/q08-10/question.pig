-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
data = LOAD 'data.tsv' USING PigStorage('\t') 
    AS (letra:CHARARRAY, 
        lista_letras:BAG{t: tuple(a:CHARARRAY)},
        clave_valor:MAP[]);
--DUMP data;

data_flatten = FOREACH data GENERATE FLATTEN($1),FLATTEN($2);
--DUMP data_flatten;

data_select = FOREACH data_flatten GENERATE $0, $1;
--DUMP data_select;

grouped_data = GROUP data_select BY ($0, $1);
--DUMP grouped_data;

count_group = FOREACH grouped_data GENERATE group, COUNT(data_select) as cant;
--DUMP count_group;

group_order = ORDER count_group BY $0,$1;
--DUMP group_order;

STORE group_order INTO 'output' using PigStorage('\t');