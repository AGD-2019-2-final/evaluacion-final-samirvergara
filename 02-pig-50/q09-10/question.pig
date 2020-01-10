-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.csv` escriba una consulta en Pig que genere la 
-- siguiente salida:
-- 
--   Vivian@Hamilton
--   Karen@Holcomb
--   Cody@Garrett
--   Roth@Fry
--   Zoe@Conway
--   Gretchen@Kinney
--   Driscoll@Klein
--   Karyn@Diaz
--   Merritt@Guy
--   Kylan@Sexton
--   Jordan@Estes
--   Hope@Coffey
--   Vivian@Crane
--   Clio@Noel
--   Hope@Silva
--   Ayanna@Jarvis
--   Chanda@Boyer
--   Chadwick@Knight
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 

fs -rm -f -r output;

data = LOAD 'data.csv' using PigStorage(',')
    AS (regId:INT,
        firstname:CHARARRAY,
        lastname:CHARARRAY,
        fecha:CHARARRAY,
        colour:CHARARRAY,
        cant:INT);
-- DUMP data;

name_last_concat = FOREACH data GENERATE CONCAT (firstname, '@', lastname);
-- DUMP name_last_concat;

STORE name_last_concat INTO 'output';
