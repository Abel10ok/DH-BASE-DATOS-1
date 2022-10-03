use emarket;

set sql_mode = "ONLY_FULL_GROUP_BY";


-- Ejercicio 1

-- 1. Crear una vista para poder organizar los envíos de las facturas. Indicar número
-- de factura, fecha de la factura y fecha de envío, ambas en formato dd/mm/yyyy,
-- valor del transporte formateado con dos decimales, y la información del
-- domicilio del destino incluyendo dirección, ciudad, código postal y país, en una
-- columna llamada Destino.

create view vw_envios as
select 
	FacturaID,
	date_format( FechaFactura,"%d-%m-%y") as FechaFactura,
    date_format(FechaEnvio,"%d-%m-%y") as FechaEnvio,
    EnvioVia,
    concat(DireccionEnvio," ",CiudadEnvio," ",CodigoPostalEnvio," ", PaisEnvio) as Destino
    from facturas;

-- 2. Realizar una consulta con todos los correos y el detalle de las facturas que
-- usaron ese correo. Utilizar la vista creada.

select * from vw_envios
inner join correos on correos.CorreoID = vw_envios.EnvioVia;

-- Ejercicio 2

-- 1. Crear una vista con un detalle de los productos en stock. Indicar id, nombre del
-- producto, nombre de la categoría y precio unitario.


create view vw_detalles_productos as
select ProductoID, ProductoNombre, CategoriaNombre, PrecioUnitario from productos
inner join categorias on categorias.CategoriaID = productos.CategoriaID;

-- 2. Escribir una consulta que liste el nombre y la categoría de todos los productos
-- vendidos. Utilizar la vista creada.

	-- NO TENIA AGREGADA ESA COLUMNA.

alter view vw_detalles_productos as
select  ProductoID,
		ProductoNombre,
		CategoriaNombre,
        PrecioUnitario,
        UnidadesPedidas 
from productos
inner join categorias on categorias.CategoriaID = productos.CategoriaID;
;

select * from vw_detalles_productos;
-- 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna
-- alternativa o solución.

