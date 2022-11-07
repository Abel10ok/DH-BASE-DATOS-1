-- TIPOS DE INDICES

-- Tenemos los tipos de índices: simple, compuesto, agrupado y no agrupado. Veamos un ejemplo de cada uno:
-- Simple: está definido sobre una sola columna:

create index "i_libros_autor"
on "libros" (autor);

-- Compuesto: está formado por varias columnas de la misma tabla.

create index "i_libros_autorEditorial"
on "libros" (autor,editorial);


-- Único: los valores deben ser únicos y diferentes.
-- Si intentamos agregar un registro con un valor ya existente, aparece un mensaje de error.
-- A su vez, puede ser simple o compuesto.

create unique index "i_libros_autor"
on "libros" (autor);

create unique index "i_libros_autorEditorial"
on "libros" (autor,editorial);


-- EN OTROS MOTORES SQL

-- Índice agrupado (CLUSTERED): 
-- almacena los datos de las filas en orden.
--  Solo se puede crear un único índice agrupado en una tabla de base de datos.
--  Esto funciona de manera eficiente únicamente si los datos se ordenan en orden creciente o decreciente.


create clustered index "i_libros_autor"
on "libros" (autor);


-- Índice no agrupado: organiza los datos de forma aleatoria, pero el índice específica internamente un orden lógico. 
-- El orden del índice no es el mismo que el ordenamiento físico de los datos. 
-- Los índices no agrupados funcionan bien con tablas donde los datos se modifican con frecuencia
--  y el índice se crea en las columnas utilizadas en orden por las declaraciones WHERE y JOIN.


-- SINTAXIS
-- crear indice

CREATE INDEX "NOMBRE_ÍNDICE" 
ON "NOMBRE_TABLA" (NOMBRE_COLUMNA);

-- eliminar indice
-- Con DROP INDEX podemos eliminar un índice de una determinada tabla:

ALTER TABLE "NOMBRE_TABLA"
DROP INDEX "NOMBRE_ÍNDICE";


-- Con ANALYZE TABLE analizamos y almacenamos la distribución de claves para una tabla:

ANALYZE TABLE "NOMBRE_TABLA";