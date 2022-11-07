-- INDICES

-- ES UNA ESTRUCTURA DE DATOS QUE MEJORA LA VELOCIDAD DE LAS CONSULTAS
-- , POR MEDIO DE UN IDENTIFICADOR UNICO DE CADA FILA DE UNA TABLA
-- PERMITIENDO UN RAPIDO ACCESO A LOS REGISTROS DE UNA TABLA DE UNA BASE DE DATOS.

-- VENTAJAS
-- La utilización de índices puede mejorar el rendimiento de las consultas
-- ya que los datos necesarios para satisfacer las necesidades de la consulta existen en el propio índice.
-- Pueden mejorar de forma significativa el rendimiento si la consulta contiene agregaciones
-- (GROUP BY), combinaciones (JOINS) de tabla o una mezcla de agregaciones y combinaciones.


-- DESVENTAJAS
-- Las tablas utilizadas para almacenar los índices ocupan espacio.
-- Los índices consumen recursos ya que cada vez que se realiza una operación de actualización, inserción o borrado en la tabla indexada,
-- se tienen que actualizar todas las tablas de índice definidas sobre ella en la actualización solo es necesaria
-- la actualización de los índices definidos sobre las columnas que se actualizan.
-- Por estos motivos no es buena idea definir índices indiscriminadamente.


-- CONSIDERACIONES
-- Hay que evitar crear demasiados índices en tablas que se actualizan con mucha frecuencia 
-- y procurar definirlos con el menor número de columnas posible.
-- Es conveniente utilizar un número mayor de índices para mejorar el rendimiento de consultas en tablas con pocas necesidades de actualización,
-- pero con grandes volúmenes de datos.
-- Se recomienda utilizar una longitud corta en la clave de los índices agrupados.
-- Los índices agrupados también mejoran si se crean en columnas únicas o que no admiten valores NULL.
