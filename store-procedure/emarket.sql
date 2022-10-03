-- 1) Empleados
-- a) Crear un SP que liste los apellidos y nombres de los empleados ordenados
-- alfabéticamente.
-- b) Invocar el SP para verificar el resultado.

DELIMITER $$ 

create procedure sp_ordenar_empleados ()

begin 
	 select concat(apellido," ", nombre) as nombre_completo from empleados
     order by nombre_completo;
end $$

call sp_ordenar_empleados();
---------------------------------------------------
-- 2) Empleados por ciudad
-- a) Crear un SP que reciba el nombre de una ciudad y liste los empleados de esa
-- ciudad.
-- b) Invocar al SP para listar los empleados de Seattle.

delimiter $$

create procedure sp_empleados_x_ciudad (in cd varchar(15))

begin 
	select * from empleados 
    where ciudad = cd;
end$$

call sp_empleados_x_ciudad("Seattle")
--------------------------------------------------------
-- 3) Clientes por país
-- a) Crear un SP que reciba el nombre de un país y devuelva la cantidad de clientes
-- en ese país.
-- b) Invocar el SP para consultar la cantidad de clientes en Portugal.
delimiter $$

create procedure sp_cantidad_clientes_x_pais (in cd varchar(15), out cant int)

begin 
    select count(clienteID) as cantidad from clientes
    where ciudad = cd;
	set cant = cantidad;
end $$

set @cant = 0;
call sp_cantidad_clientes_x_pais("Portugal",@cant);
set @cant;
-----------------------------------------------------
-- 4) Productos sin stock
-- a) Crear un SP que reciba un número y liste los productos cuyo stock está por
-- debajo de ese número. El resultado debe mostrar el nombre del producto, el
-- stock actual y el nombre de la categoría a la que pertenece el producto.
-- b) Listar los productos con menos de 10 unidades en stock.
-- c) Listar los productos sin stock.

delimiter $$ 

create procedure sp_stock_por_debajo (in num float)

begin
	select p.ProductoNombre, p.UnidadesStock, c.CategoriaNombre from productos as p 
    inner join categorias as c on p.CategoriaID = c.CategoriaID
    where p.UnidadesStock < num;
end$$

call sp_stock_por_debajo(1);

-- 5) Ventas con descuento
-- a) Crear un SP que reciba un porcentaje y liste los nombres de los productos que
-- hayan sido vendidos con un descuento igual o superior al valor indicado,
-- indicando además el nombre del cliente al que se lo vendió.
-- b) Listar la información de los productos que hayan sido vendidos con un
-- descuento mayor al 10%.

delimiter $$

create procedure sp_ventas_con_descuento (in num double)

begin
		select p.ProductoNombre, c.Compania from productos as p 
        inner join facturadetalle as fd on p.ProductoID = fd.ProductoID
        inner join facturas as f on f.FacturaID = fd.FacturaID
        inner join clientes as c on c.ClienteID = f.ClienteID
        where fd.Descuento >= num;
			
end $$

call sp_ventas_con_descuento(0.1);