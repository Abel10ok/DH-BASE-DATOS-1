use emarket;
-- Vistas - Parte I

-- Clientes

-- 1. Crear una vista con los siguientes datos de los clientes: ID, contacto, y el
-- Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por
-- ejemplo: “TEL: (01) 123-4567”.

select * from clientes;
create view datos_clientes as
select ClienteID, Contacto, if(fax= "", concat('TEL:',Telefono), fax ) as fax 
from clientes;


-- 2. Se necesita listar los números de teléfono de los clientes que no tengan
-- fax. Hacerlo de dos formas distintas:
-- a. Consultando la tabla de clientes.
-- b. Consultando la vista de clientes.

select * from clientes
where fax = " ";

select * from datos_clientes;

-- Proveedores
-- 1. Crear una vista con los siguientes datos de los proveedores: ID,
-- contacto, compañía y dirección. Para la dirección tomar la dirección,
-- ciudad, código postal y país.

create view datos_proveedor as
select p.ProveedorID as id , p.Contacto, concat(p.Direccion," - ",p.Ciudad, " - ",p.CodigoPostal, " - ", p.Pais) as direccion 
from proveedores as p;

-- 2. Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo
-- de dos formas distintas:
-- a. Consultando la tabla de proveedores.
-- b. Consultando la vista de proveedores.

select * from proveedores
where direccion like "%Americanas%" and Pais = "Brasil";

select  *from  datos_proveedores 
where (direccion like "%Americanas%" or  direccion like "%Brasil%" );


-- Vistas - Parte II
-- 1. Crear una vista de productos que se usará para control de stock. Incluir el ID
-- y nombre del producto, el precio unitario redondeado sin decimales, las
-- unidades en stock y las unidades pedidas. Incluir además una nueva
-- columna PRIORIDAD con los siguientes valores:

-- ■ BAJA: si las unidades pedidas son cero.
-- ■ MEDIA: si las unidades pedidas son menores que las unidades
-- en stock.
-- ■ URGENTE: si las unidades pedidas no duplican el número de
-- unidades.
-- ■ SUPER URGENTE: si las unidades pedidas duplican el número
-- de unidades en caso contrario.


create view control_stock as 
select 
	ProductoID,
    ProductoNombre,
    UnidadesStock,
    round(PrecioUnitario) as precioUnitario, 
    UnidadesPedidas,
    case
		when UnidadesPedidas = 0 then "Baja"
		when UnidadesPedidas < UnidadesStock then "Media"
		when UnidadesPedidas < (UnidadesStock + UnidadesStock) THEN "Urgente"
		else "MuyUrgente"
    end "Prioridad"
    from productos;
    
    


-- 2. Se necesita un reporte de productos para identificar problemas de stock.
-- Para cada prioridad indicar cuántos productos hay y su precio promedio.
-- No incluir las prioridades para las que haya menos de 5 productos.
select *,(sum(precioUnitario*UnidadesStock) / sum(UnidadesStock)) as promedio from control_stock
group by UnidadesStock
having UnidadesStock > 5;
select * ,avg(precioUnitario) as promedio from control_stock
group by ProductoID;