use blockbuster;

-- Guia de Ejercicios N° 2

-- 1. Obtener un listado de socios (Apellido y nombre agrupados en un solo campo) con su correspondiente
-- sucursal, ciudad y pais.

select * from socios;

select
	socios.id,
	concat(socios.nombre, " ", socios.apellido) as nombreCompleto,
    socios.ciudad_id,
    ciudades.ciudad,
    sucursales.nombre,
    paises.pais    
from socios
inner join ciudades on  ciudades.id = socios.ciudad_id
inner join sucursales on sucursales.ciudad_id = ciudades.id
inner join paises on paises.id = ciudades.pais_id;

-- 2. Obtener un listado de articulos por sucursal, ordenados por el pais y la ciudad Ascendente.

select
	socios.id,
	concat(socios.nombre, " ", socios.apellido) as nombreCompleto,
    socios.ciudad_id,
    ciudades.ciudad,
    sucursales.nombre,
    paises.pais    
from socios
inner join ciudades on  ciudades.id = socios.ciudad_id
inner join sucursales on sucursales.ciudad_id = ciudades.id
inner join paises on paises.id = ciudades.pais_id
order by pais asc, ciudad asc;


-- 3. Obtener la cantidad de socios con prestamos que no han sido devueltos agrupados por el pais del
-- articulo.

select * from prestamos;

select 
	distinct(autores.pais),
    prestamos.id,
	count(distinct(prestamos.socio_id)) as socios_sin_devolucion     
from prestamos 
inner join socios on socios.id = prestamos.socio_id
inner join ciudades on ciudades.id = socios.ciudad_id
inner join paises on paises.id = ciudades.pais_id
inner join articulos on articulos.id = prestamos.articulo_id
inner join autores on autores.id = articulos.autor_id
where prestamos.fecha_devolucion is null
group by autores.pais;

select * from prestamos;

-- 4. Se solicita obtener la cantidad de articulos de tipo 'libro' por sucursal (Atencion: Existen multiples
-- sucursales con el mismo nombre pero distinto pais)


select  sucursales.nombre, paises.pais from articulos
inner join  sucursales on sucursales.id = articulos.sucursal_id
inner join ciudades on ciudades.id = sucursales.ciudad_id
inner join paises on paises.id = ciudades.pais_id
where articulos.tipo = "libro"
group by sucursales.nombre, paises.pais;

-- 5. Obtener todos los socios de Colombia cuyo apellido empiece con la letra A, S o P junto con la ciudad a
-- la que pertencen.

select * from socios
inner join ciudades on ciudades.id = socios.ciudad_id
inner join paises on paises.id = ciudades.pais_id
where pais = "Colombia" and 
(apellido like "a%" or apellido like "s%" or apellido  like "p%");

-- 6. Cuantos prestamos tuvo en total la sucursal 'Blockbuster Centro' de 'Montevideo'


select sucursales.nombre, ciudades.ciudad, count(*)as prestamos_x_sucursal_y_ciudad from prestamos
inner join articulos on articulos.id = prestamos.articulo_id
inner join sucursales on sucursales.id = articulos.sucursal_id
inner join ciudades on ciudades.id = sucursales.ciudad_id
where sucursales.nombre = "Blockbuster Centro" and ciudades.ciudad = "Montevideo";


-- 7. Que cantidad de empleados por ciudad posee nuestra empresa.

select ciudades.ciudad, count(empleados.id)as catnidadDeEmpleados from empleados
inner join sucursales on sucursales.id = empleados.sucursal_id
inner join ciudades on ciudades.id = sucursales.ciudad_id
group by ciudades.ciudad;

-- 8. Que empleados del sector 'Marketing' tienen un sueldo inferior al promedio para ese sector en todos los
-- paises.



create view sueldo_promedio_marketing as 
select sectores.sector, avg(empleados.sueldo)as promedio from empleados
inner join sectores on sectores.id = empleados.sector_id
where sectores.sector = "Marketing";

select  avg(empleados.sueldo)as promedio from empleados
inner join sectores on sectores.id = empleados.sector_id
where sectores.sector = "Marketing";

select * from  empleados, sueldo_promedio_marketing
where empleados.sueldo < sueldo_promedio_marketing.promedio ;

---------

SELECT DISTINCT 
	s.nombre, 
    c.ciudad, 
    p.pais,
    sec.sector,
    (select 
		count(e3.sector_id)
	FROM empleados AS e3 
	WHERE e3.sueldo < (
						SELECT AVG(e2.sueldo)
						FROM empleados AS e2 WHERE e2.sector_id = 2)
	AND e3.sucursal_id = e.sucursal_id
    AND e3.sector_id = e.sector_id
	) AS 'Cant empleados'
FROM empleados AS e
INNER JOIN sectores AS sec ON sec.id = e.sector_id
INNER JOIN sucursales AS s ON s.id = e.sucursal_id
INNER JOIN ciudades AS c ON s.ciudad_id = c.id
INNER JOIN paises AS p ON p.id = c.pais_id
WHERE sec.sector = "Marketing";

-- 9. Cuanto gasto en sueldos por sector y ciudad?

select sectores.sector,ciudades.ciudad, sum(empleados.sueldo)as gastos from empleados 
inner join sectores on sectores.id = empleados.sector_id 
inner join sucursales on sucursales.id = empleados.sucursal_id
inner join ciudades on ciudades.id = sucursales.ciudad_id
group by sectores.sector, ciudades.ciudad;


select sum(empleados.sueldo)as gastos from empleados 
inner join sectores on sectores.id = empleados.sector_id 
inner join sucursales on sucursales.id = empleados.sucursal_id
inner join ciudades on ciudades.id = sucursales.ciudad_id
where sectores.sector = "ventas" and ciudades.ciudad = "Santiago de Chile";


-- 10. Cual es el pais con mayor número de devoluciones tardías?

select paises.pais, count(prestamos.id) from prestamos
inner join socios on socios.id = prestamos.socio_id
inner join ciudades on ciudades.id = socios.ciudad_id
inner join paises on paises.id = ciudades.pais_id
where prestamos.fecha_devolucion > prestamos.fecha_tope
group by pais;

select * from prestamos
inner join socios on socios.id = prestamos.socio_id
inner join ciudades on ciudades.id = socios.ciudad_id
inner join paises on paises.id = ciudades.pais_id
where prestamos.fecha_devolucion > prestamos.fecha_tope and paises.pais = "ecuador";

-- 11. Que ciudades tienen más de 10 devoluciones tardías de articulos.

select * from prestamos;
select ciudades.ciudad, count(prestamos.id)as tardias from prestamos
inner join socios on socios.id = prestamos.socio_id
inner join ciudades on ciudades.id = socios.ciudad_id
where prestamos.fecha_devolucion > prestamos.fecha_tope
group by ciudad
having tardias > 10;


-- 12. Existen sucursales que no posean aún articulos?

select * from articulos
right join sucursales on sucursales.id = articulos.sucursal_id
where articulos.id is null;



