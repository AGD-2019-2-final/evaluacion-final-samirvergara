-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
-- salida.
-- 
--    1971-07-08,08,8,jue,jueves
--    1974-05-23,23,23,jue,jueves
--    1973-04-22,22,22,dom,domingo
--    1975-01-29,29,29,mie,miercoles
--    1974-07-03,03,3,mie,miercoles
--    1974-10-18,18,18,vie,viernes
--    1970-10-05,05,5,lun,lunes
--    1969-02-24,24,24,lun,lunes
--    1974-10-17,17,17,jue,jueves
--    1975-02-28,28,28,vie,viernes
--    1969-12-07,07,7,dom,domingo
--    1973-12-24,24,24,lun,lunes
--    1970-08-27,27,27,jue,jueves
--    1972-12-12,12,12,mar,martes
--    1970-07-01,01,1,mie,miercoles
--    1974-02-11,11,11,lun,lunes
--    1973-04-01,01,1,dom,domingo
--    1973-04-29,29,29,dom,domingo
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

todate_data_format = FOREACH todate_data GENERATE $0, SUBSTRING($0,8,10) AS DD,  GetDay($1) AS D, ToString(ToDate(birthday,'yyyy-MM-dd'), 'EEE') AS date_format_EEE,ToString(ToDate(birthday,'yyyy-MM-dd'), 'EEEE') AS date_format_EEEE;
-- DUMP todate_data_format; 

todate_data_to_print = FOREACH todate_data_format GENERATE $0,$1,$2,LOWER($3),LOWER($4);
-- DUMP todate_data_to_print;

todate_data_to_print_spa = FOREACH todate_data_to_print GENERATE $0,$1,$2,
                            CASE $3
                            WHEN 'mon' THEN 'lun'
                            WHEN 'tue' THEN 'mar'
                            WHEN 'wed' THEN 'mie'
                            WHEN 'thu' THEN 'jue'
                            WHEN 'fri' THEN 'vie'
                            WHEN 'sat' THEN 'sab'
                            ELSE 'dom'
                            END,
                            CASE $3
                            WHEN 'mon' THEN 'lunes'
                            WHEN 'tue' THEN 'martes'
                            WHEN 'wed' THEN 'miercoles'
                            WHEN 'thu' THEN 'jueves'
                            WHEN 'fri' THEN 'viernes'
                            WHEN 'sat' THEN 'sabado'
                            ELSE 'domingo'
                            END;
-- DUMP todate_data_to_print_spa;

STORE todate_data_to_print_spa INTO 'output' using PigStorage(',');


