-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT 
--        birthday, 
--        DATE_FORMAT(birthday, "yyyy"),
--        DATE_FORMAT(birthday, "yy"),
--    FROM 
--        persons
--    LIMIT
--        5;
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

todate_data = FOREACH u GENERATE ToDate(birthday,'yyyy-MM-dd') AS birthday_date;
-- DUMP todate_data;

todate_data_select = FOREACH todate_data GENERATE GetYear(birthday_date) AS ANHO;
-- DUMP todate_data_select;

format_year_yy = FOREACH todate_data_select GENERATE ANHO, SUBSTRING((chararray)ANHO,2,4) AS YY;
-- DUMP format_year_yy;

STORE format_year_yy INTO 'output' using PigStorage(',');
