use muestra_basica;


-- 1. Reportar los productos (nombre en mayúsculas), stock, unidad de
-- medida y precio (agregar el signo de la moneda). Ordenarlos por
-- nombre de producto

select 
	upper(producto.nombre) as producto_nombre,
    concat("$",producto.stock) as stock,
    producto.unidad_medida_id,
    unidad_medida.id,
    unidad_medida.nombre
from producto
inner join unidad_medida on unidad_medida.id = producto.unidad_medida_id
order by producto_nombre;


-- 2.1 Reportar los productos (nombre en minúsculas), stock y las
-- unidades de medidas sin importar si están o no asignadas a algún
-- producto. Mostrar la leyenda –Sin Asignación- para los productos que
-- figuren como nulos. Ordenarlos por el nombre de la unidad de medida.
select * from producto;
select 
	coalesce(lower(producto.nombre),"-Sin Asignacion") as producto,
    producto.stock,
    producto.unidad_medida_id ,
    unidad_medida.nombre
from producto
right join unidad_medida on unidad_medida.id = producto.unidad_medida_id
order by unidad_medida.nombre ;


-- 2.2 Modificar la consulta (2.1) para que muestre solamente los registros
-- donde las unidades de medida aún no fueron asignadas a algún
-- producto.

select 
	producto.id,
	coalesce(lower(producto.nombre),"-Sin Asignacion") as producto,
    producto.stock,
    producto.unidad_medida_id ,
    unidad_medida.nombre
from producto
right join unidad_medida on unidad_medida.id = producto.unidad_medida_id
where producto.id is null
order by producto.nombre;


-- 3.1 Listar todas las ventas mostrando el número de factura, nombre del
-- producto, cantidad, importe y total facturado. Ordenarlo por número de
-- factura.
select * from factura_detalle;
select 
	factura.id,
    factura_detalle.factura_id,
    factura_detalle.producto_id,
    producto.id,
    producto.nombre,
    factura_detalle.cantidad,
    factura_detalle.importe,
    factura.total
    from factura
inner join factura_detalle on factura_detalle.factura_id = factura.id
inner join producto on producto.id = factura_detalle.producto_id
order by factura.id;


-- 3.2 Modificar la consulta (3.1) para que muestre todas las ventas
-- incluyendo a aquellos productos que aún no han sido vendidos.
-- Finalmente, ordenarlo por número de Factura.

select 
	factura.id,
    factura_detalle.factura_id,
    factura_detalle.producto_id,
    producto.id,
    producto.nombre,
    factura_detalle.cantidad,
    factura_detalle.importe,
    factura.total
    from factura
inner join factura_detalle on factura_detalle.factura_id = factura.id
right join producto on producto.id = factura_detalle.producto_id
order by factura.id;



-- 4.1 Listar todas las ventas mostrando el número de factura, fecha,
-- nombre completo del cliente, nombre del producto, cantidad, unidad de
-- medida, importe y total facturado. Ordenarlo por el número de factura
-- de mayor a menor.

select 
	factura.id,
    factura.fecha,
    concat(cliente.nombre, " ", cliente.apellido) as nombre,
    producto.nombre,
    factura_detalle.cantidad,
    producto.unidad_medida_id,
    factura_detalle. importe,
    factura.total
from cliente
inner join factura on factura.cliente_id = cliente.id
inner join factura_detalle on factura_detalle.factura_id = factura.id
inner join producto on factura_detalle.producto_id = producto.id
inner join unidad_medida on unidad_medida.id =  producto.unidad_medida_id
order by factura.id desc;





