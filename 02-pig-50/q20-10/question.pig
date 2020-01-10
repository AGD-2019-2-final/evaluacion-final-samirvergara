-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT
--        firstname,
--        color
--    FROM 
--        u 
--    WHERE 
--       color REGEXP '^[^b]';
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

data_select = FOREACH u GENERATE color, firstname, SUBSTRING(color,0,1) as first_letter;
-- DUMP data_select;

filter_data = FILTER data_select BY first_letter != 'b';
-- DUMP filter_data;

filter_data_select =  FOREACH filter_data GENERATE firstname, color;
--DUMP filter_data_select;

STORE filter_data_select INTO 'output' using PigStorage(',');