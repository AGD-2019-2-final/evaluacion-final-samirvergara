-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
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


year_grouped = GROUP todate_data_select BY ANHO;
-- DUMP year_grouped;

year_count = FOREACH year_grouped GENERATE group, COUNT(todate_data_select);
-- DUMP year_count;

STORE year_count INTO 'output' using PigStorage(',');
