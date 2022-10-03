use emarket;

-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- ● Id de la factura
-- ● fecha de la factura
-- ● nombre de la empresa de correo
-- ● nombre del cliente
-- ● categoría del producto vendido
-- ● nombre del producto
-- ● precio unitario
-- ● cantidad

select 
	facturas.FacturaID,
    facturas.FechaFactura,
    correos.Compania as Compania_correo,
    clientes.Compania as compania_cliente,
    categorias.CategoriaNombre,
    productos.ProductoNombre,
    facturadetalle.PrecioUnitario,
    facturadetalle.Cantidad
from facturas
inner join clientes on facturas.ClienteID = clientes.ClienteID
inner join correos on facturas.EnvioVia = correos.CorreoID
inner join facturadetalle on facturas.FacturaID = facturadetalle.FacturaID
inner join productos on facturadetalle.ProductoID = productos.ProductoID
inner join categorias on productos.CategoriaID = categorias.CategoriaID;

-- Reportes parte II - INNER, LEFT Y RIGHT JOIN

-- 1. Listar todas las categorías junto con información de sus productos. Incluir todas
-- las categorías aunque no tengan productos.

select * from categorias
left join productos on categorias.CategoriaID = productos.CategoriaID;

-- 2. Listar la información de contacto de los clientes que no hayan comprado nunca
-- en emarket.

select * from clientes
left join facturas on facturas.ClienteID = clientes.ClienteID
where facturas.FacturaID is null;

-- 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
-- la información de contacto de su proveedor. Tener en cuenta que puede haber
-- productos para los cuales no se indicó quién es el proveedor.

select  
		productos.ProductoNombre,
		categorias.CategoriaNombre,
        productos.ProveedorID,
        proveedores.Contacto
from productos
left join proveedores on productos.ProveedorID = proveedores.ProveedorID
inner join categorias on productos.CategoriaID = categorias.CategoriaID
where proveedores.ProveedorID is not null;

-- 4. Para cada categoría listar el promedio del precio unitario de sus productos.

select CategoriaNombre, avg(facturadetalle.PrecioUnitario) as promedio from categorias
inner join productos on productos.CategoriaID = categorias.CategoriaID
inner join facturadetalle on facturadetalle.ProductoID = productos.ProductoID
group by categorias.CategoriaNombre;


-- 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
-- nunca hayan comprado en e-market.

select Compania,max(FechaFactura) from clientes
inner join facturas on clientes.ClienteID = facturas.ClienteID
group by clientes.Compania;


-- 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
-- listado con todas las empresas de correo, y la cantidad de facturas
-- correspondientes. Realizar la consulta utilizando RIGHT JOIN.



select correos.Compania, count(facturas.FacturaID) from facturas
right join correos on facturas.EnvioVia = correos.CorreoID
group by correos.Compania;
