-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Genere una relación con el apellido y su longitud. Ordene por longitud y 
-- por apellido. Obtenga la siguiente salida.
-- 
--   Hamilton,8
--   Garrett,7
--   Holcomb,7
--   Coffey,6
--   Conway,6
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

surname_size = FOREACH u GENERATE surname,SIZE(surname) ;
-- DUMP surname_size;

surname_size_order = ORDER surname_size BY $1 DESC, $0;
--DUMP surname_size_order;

surname_size_order_in_five = LIMIT surname_size_order 5;
-- DUMP surname_size_order_in_five;

STORE surname_size_order_in_five INTO 'output' using PigStorage(',');