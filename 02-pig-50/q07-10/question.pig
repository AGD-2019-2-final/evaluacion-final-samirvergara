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
--DUMP data;

data_rank = RANK data;
--DUMP data_rank;

data_rank_select = FOREACH data_rank GENERATE rank_data, letra;
--DUMP data_rank_select;


data_flatten_1 = FOREACH data_rank GENERATE rank_data, letra, FLATTEN(lista_letras) as bolsa;
--DUMP data_flatten_1;

grouped_data_flatten_1 = GROUP data_flatten_1 BY (rank_data);
--DUMP grouped_data_flatten_1;

count_data_flatten_1 = FOREACH grouped_data_flatten_1 GENERATE group, COUNT(data_flatten_1) as cant_1;
--DUMP count_data_flatten_1;


data_flatten_2 = FOREACH data_rank GENERATE rank_data, letra, FLATTEN(clave_valor) as maps;
--DUMP data_flatten_2;

grouped_data_flatten_2 = GROUP data_flatten_2 BY (rank_data);
--DUMP grouped_data_flatten_2;

count_data_flatten_2 = FOREACH grouped_data_flatten_2 GENERATE group, COUNT(data_flatten_2) as cant_2;
--DUMP count_data_flatten_2;


join_cantidades = JOIN count_data_flatten_1 BY group, count_data_flatten_2 BY group;
--DUMP join_cantidades;

join_cant_letra = JOIN join_cantidades BY $0, data_rank_select BY $0;
--DUMP join_cant_letra;

letra_cant_select = FOREACH join_cant_letra GENERATE $5,$1,$3;
--DUMP letra_cant_select;

letra_cant_order = ORDER letra_cant_select BY $0,$1,$2;
--DUMP letra_cant_order;

STORE letra_cant_order INTO 'output' using PigStorage(',');
