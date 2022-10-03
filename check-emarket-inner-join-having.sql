--  INNER JOIN

-- 1) Generar un listado de todas las facturas del empleado 'Buchanan'.

select * from facturas as f
inner join empleados as e on f.EmpleadoID = e.EmpleadoID
having e.Apellido = 'Buchanan';

-- 2) Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.

select * from facturas as f
inner join correos as c on f.EnvioVia = c.CorreoID
having c.Compania = "Speedy Express";

-- 3) Generar un listado de todas las facturas con el nombre y apellido de los empleados.

select f.FacturaID , e.EmpleadoID , concat(e.Nombre,e.Apellido) as nombre from facturas as f
inner join empleados as e on f.EmpleadoID= e.EmpleadoID;

-- 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.

select * from facturas as f
inner join clientes as c on f.ClienteID = c.ClienteID
having c.Titulo = "Owner" and F.PaisEnvio = "USA";

-- 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.

select * from facturas as f
inner join empleados as e on e.Apellido = "Leverling"
inner join facturadetalle as fd on f.FacturaID = fd.FacturaID
having fd.ProductoID = 42;


-- 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.

select * from facturas as f
inner join empleados as e on e.Apellido = "Leverling"
inner join facturadetalle as fd on f.FacturaID = fd.FacturaID
having fd.ProductoID = 80 or fd.ProductoID= 42;

-- 7) Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).

select * from facturadetalle;

select f.*, sum(fd.PrecioUnitario*fd.Cantidad) as total from facturadetalle as fd
inner join facturas as f on f.FacturaID = fd.FacturaID
inner join clientes as c on f.ClienteID = c.ClienteID
group  by f.ClienteID 
order by total desc
limit 5
;

select  f.ClienteID , f.FacturaID, sum(fd.PrecioUnitario*fd.Cantidad) as total from facturas as f, clientes as c , facturadetalle as fd
where f.ClienteID = c.ClienteID and fd.FacturaID = f.FacturaID
order by f.ClienteID desc , f.FacturaID desc;

-- 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
-- fecha de factura, país de envío, Total, ordenado de manera descendente por
-- fecha de factura y limitado a 10 filas.

-- select f.FacturaID, c.Contacto,FechaFactura, PaisEnvio, sum(fd.PrecioUnitario*fd.Cantidad) from facturas as f  , clientes as c , facturadetalle as fd
-- order by FechaFactura;


select * from facturadetalle;