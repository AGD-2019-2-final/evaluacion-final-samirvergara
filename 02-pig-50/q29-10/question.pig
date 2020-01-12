-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código en Pig para manipulación de fechas que genere la siguiente 
-- salida.
-- 
--    1971-07-08,jul,07,7
--    1974-05-23,may,05,5
--    1973-04-22,abr,04,4
--    1975-01-29,ene,01,1
--    1974-07-03,jul,07,7
--    1974-10-18,oct,10,10
--    1970-10-05,oct,10,10
--    1969-02-24,feb,02,2
--    1974-10-17,oct,10,10
--    1975-02-28,feb,02,2
--    1969-12-07,dic,12,12
--    1973-12-24,dic,12,12
--    1970-08-27,ago,08,8
--    1972-12-12,dic,12,12
--    1970-07-01,jul,07,7
--    1974-02-11,feb,02,2
--    1973-04-01,abr,04,4
--    1973-04-29,abr,04,4
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

todate_data = FOREACH u GENERATE birthday, ToDate(birthday,'yyyy-MM-dd') AS birthday_date;
-- DUMP todate_data;

todate_data_format = FOREACH todate_data GENERATE $0, ToString($1,'dd/MMM/yyyy') AS date_format_mmm, SUBSTRING($0,5,7) AS MM,  GetMonth($1) AS MMM;
-- DUMP todate_data_format;

todate_data_to_print = FOREACH todate_data_format GENERATE $0,LOWER(SUBSTRING($1,3,6)),$2,$3;
-- DUMP todate_data_to_print;

todate_data_to_print_spa = FOREACH todate_data_to_print GENERATE $0, 
                            CASE $3
                            WHEN 1 THEN 'ene'
                            WHEN 2 THEN 'feb'
                            WHEN 3 THEN 'mar'
                            WHEN 4 THEN 'abr'
                            WHEN 5 THEN 'may'
                            WHEN 6 THEN 'jun'
                            WHEN 7 THEN 'jul'
                            WHEN 8 THEN 'ago'
                            WHEN 9 THEN 'sep'
                            WHEN 10 THEN 'oct'
                            WHEN 11 THEN 'nov'
                            ELSE 'dic'
                            END, $2, $3;
-- DUMP todate_data_to_print_spa;

STORE todate_data_to_print_spa INTO 'output' using PigStorage(',');

