-- Consultas queries ML - Parte I
-- Vamos a practicar sobre consultas SELECT, enfocándonos en SELECT,
-- WHERE, operadores de condición como AND, OR, BETWEEN, LIKE, IN, entre
-- otros. 


SHOW table status;
													-- CATEGORIAS Y PRODUCTOS --
describe productos;
-- 1. Queremos tener un listado de todas las categorías.
SELECT * FROM productos;


describe categorias;
-- 2. Cómo las categorías no tienen imágenes, solamente interesa obtener un  listado de CategoriaNombre y Descripcion.
SELECT CategoriaNombre, DESCRIPCION FROM CATEGORIAS; 

describe PRODUCTOS;
-- 3. Obtener un listado de los productos.
SELECT PRODUCTOID, PRODUCTONOMBRE FROM PRODUCTOS;

-- 4. ¿Existen productos discontinuados? (Discontinuado = 1).

SELECT * FROM PRODUCTOS
WHERE DISCONTINUADO = 1; 

-- 5. Para el viernes hay que reunirse con el Proveedor 8. ¿Qué productos son
-- los que nos provee?

SELECT ProductoNombre, ProveedorID FROM PRODUCTOS
WHERE  proveedorID= 8;

-- 6. Queremos conocer todos los productos cuyo precio unitario se encuentre
-- entre 10 y 22.

SELECT ProductoNombre, PrecioUnitario FROM productos 
WHERE PrecioUnitario BETWEEN 10 AND 22;

-- 7. Se define que un producto hay que solicitarlo al proveedor si sus unidades
-- en stock son menores al Nivel de Reorden. ¿Hay productos por solicitar?

SELECT ProductoNombre, UnidadesStock, NivelReorden FROM productos
WHERE UnidadesStock < NivelReorden;

-- 8. Se quiere conocer todos los productos del listado anterior, pero que
-- unidades pedidas sea igual a cero.

SELECT ProductoNombre, NivelReorden FROM productos
WHERE  NivelReorden = 0;

																-- CLIENTES --
                                                                
-- 1. Obtener un listado de todos los clientes con Contacto, Compania, Título,
-- País. Ordenar el listado por País.

SELECT Contacto FROM clientes ORDER BY Contacto, Compania, Titulo ASC;

-- 2. Queremos conocer a todos los clientes que tengan un título “Owner”.
SELECT Contacto, Titulo FROM clientes
WHERE Titulo = "Owner";

-- 3. El operador telefónico que atendió a un cliente no recuerda su nombre.
-- Solo sabe que comienza con “C”. ¿Lo ayudamos a obtener un listado con
-- todos los contactos que inician con la letra “C”?

SELECT Contacto FROM clientes 
WHERE Contacto LIKE "C%";


                                                          -- FACTURAS --
-- 1. Obtener un listado de todas las facturas, ordenado por fecha de factura
-- ascendente.

SELECT FechaFactura FROM facturas
ORDER BY FechaFactura ASC;

-- 2. Ahora se requiere un listado de las facturas con el país de envío “USA” y
-- que su correo (EnvioVia) sea distinto de 3.

SELECT PaisEnvio, EnvioVia FROM facturas
WHERE PaisEnvio = "USA" AND EnvioVia != 3;

-- 3. ¿El cliente 'GOURL' realizó algún pedido?

SELECT * FROM facturas
WHERE ClienteID = "GOURL";

-- 4. Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.

SELECT * FROM facturas
WHERE EmpleadoID = 2 OR EmpleadoID = 3 OR EmpleadoID = 5 OR EmpleadoID = 8 OR EmpleadoID = 9;

----------------------------------------------------------------------
-- Consultas queries ML - Parte II
-- En esta segunda parte vamos a intensificar la práctica de consultas
-- SELECT, añadiendo ALIAS, LIMIT y OFFSET.

                                                        -- Productos --
-- 1. Obtener el listado de todos los productos ordenados
-- descendentemente por precio unitario.

SELECT * FROM productos
ORDER BY PrecioUnitario DESC;

-- 2. Obtener el listado de top 5 de productos cuyo precio unitario es
-- el más caro.
SELECT * FROM productos
ORDER BY PrecioUnitario DESC
LIMIT 5;

-- 3. Obtener un top 10 de los productos con más unidades en stock.

SELECT * FROM productos
ORDER BY UnidadesStock DESC
LIMIT 10;

													-- FacturaDetalle --
-- 1. Obtener un listado de FacturaID, Producto, Cantidad.
SELECT FacturaID, ProductoID, Cantidad FROM facturadetalle;

-- 2. Ordenar el listado anterior por cantidad descendentemente.
SELECT FacturaID, ProductoID, Cantidad FROM facturadetalle
ORDER BY Cantidad DESC;

-- 3. Filtrar el listado solo para aquellos productos donde la cantidad
-- se encuentre entre 50 y 100.

SELECT * FROM facturadetalle
WHERE Cantidad BETWEEN 50 AND 100;

-- 4. En otro listado nuevo, obtener un listado con los siguientes
-- nombres de columnas: NroFactura (FacturaID), Producto
-- (ProductoID), Total (PrecioUnitario*Cantidad).

SELECT FacturaID AS NroFactura, ProductoID AS Producto, PrecioUnitario * Cantidad AS TOTAL 
FROM facturadetalle;
--------------------------------------------------------------------------------------------

														-- ¡Extras! --

-- ¿Te sobró tiempo? ¿Querés seguir practicando?
-- Te dejamos unos ejercicios extras a partir de la misma base:

-- 1. Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”,
-- o que tengan un título que empiece con “Sales”.

SELECT * FROM clientes
WHERE Pais = "BRAZIL" OR Pais = "MEXICO" OR Titulo = "SALES";

-- 2. Obtener un listado de todos los clientes que pertenecen a una compañía
-- que empiece con la letra "A".

SELECT * FROM clientes 
WHERE Compania LIKE "A%";

-- 3. Obtener un listado con los datos: Ciudad, Contacto y renombrarlo
-- como Apellido y Nombre, Titulo y renombrarlo como Puesto, de todos
-- los clientes que sean de la ciudad "Madrid".

SELECT Ciudad, Contacto AS APELLIDO_Y_NOMBRE, Titulo AS PUESTO
FROM clientes
WHERE Ciudad = "Madrid";

-- 4. Obtener un listado de todas las facturas con ID entre 10000 y 10500

SELECT * FROM facturas
WHERE FacturaID BETWEEN 10000 AND 10500;

-- 5. Obtener un listado de todas las facturas con ID entre 10000 y 10500 o de
-- los clientes con ID que empiecen con la letra “B”.

SELECT * FROM facturas
WHERE FacturaID BETWEEN 10000 AND 10500 OR ClienteID LIKE "B%";

-- 6. ¿Existen facturas que la ciudad de envío sea “Vancouver” o que
-- utilicen el correo 3?

SELECT * FROM facturas
WHERE CiudadEnvio = "Vancouver " OR EnvioVia = 3;

-- 7. ¿Cuál es el ID de empleado de “Buchanan”?

SELECT  EmpleadoID, Apellido FROM empleados
WHERE  Apellido = "Buchanan";
-- 5
-- 8. ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior?
-- (No relacionar, sino verificar que existan facturas)

SELECT * FROM facturas
WHERE EmpleadoID = 5;

