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
--        color REGEXP '[aeiou]$';
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

data_select = FOREACH u GENERATE color, firstname, ENDSWITH(color,'a') AS flag_a, ENDSWITH(color,'e') AS flag_e, ENDSWITH (color,'i') AS flag_i, ENDSWITH(color,'o') AS flag_o, ENDSWITH(color,'u') AS flag_u;
-- DUMP data_select;

filter_data = FILTER data_select BY flag_a == true OR flag_e == true OR flag_i == true OR flag_o == true OR flag_u == true;
-- DUMP filter_data;

filter_data_select =  FOREACH filter_data GENERATE firstname, color;
--DUMP filter_data_select;

STORE filter_data_select INTO 'output' using PigStorage(',');