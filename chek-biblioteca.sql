use biblioteca;

set sql_mode = "ONLY_FULL_GROUP_BY";

-- Guia de Ejercicios Prácticos.

-- Tomando como referencia la base de datos de bibliotecas, realizar los siguientes ejercicios.
-- En primera instancia, resolver las consultas sin realizar uniones entre tablas. Devolviendo los
-- campos solicitados, y en caso de corresponderse con un “ID” de referencia, devolver dicho ID.

-- Una vez finalizados los 20 ejercicios, en el punto 21 volverán a realizar todos los ejercicios
-- aplicando ahora si las uniones de tablas donde corresponde para obtener los datos reales.

-- Ejercicios:
-- 1- Obtener un listado de todos los articulos.

select * from articulos;

select * from articulos 
inner join autores  on articulos.autor_ID = autores.id
inner join prestamos on prestamos.articulo_id = articulos.id
inner join socios on prestamos.socio_id = socios.id;


-- 2- Obtener el nombre junto con el autor, código y año de los libros publicados entre 1990 y
-- 2000.

select 
	id,
    autor_id,
    nombre,
    cod_articulo,
    ano 
from articulos
having ano between 1990 and 2000;
 
 select 
	articulos.id,
    autor_id,
    articulos.nombre,
    cod_articulo,
    ano ,
    autores.id,
    autores.nombre
 from articulos
 inner join autores on autores.id = articulos.autor_id
 having ano between 1990 and 2000;
 
-- 3- Obtener el nombre junto con el autor, código, tipo y año de los articulos de tipo libro
-- publicados después del año 2000 o del tipo pelicula con una duración mayor a 120 minutos.

select 
	articulos.nombre,
	articulos.autor_id,
    cod_articulo,
    articulos.tipo,
    articulos.ano,
    articulos.duracion,
	autores.id,
    autores.nombre    
from articulos
inner join autores on  autores.id = articulos.autor_id
where tipo = "libro " and (ano > 2000) or (tipo="pelicula" and duracion>120);

-- 4- Obtener el articulo, tipo y año de los articulos publicados en el año 1991, 1998, 2017 y 2020.

select * from articulos
where ano in (1991,1998,2017,2020);

-- 5- Obtener el articulo, tipo, año y duracion de los articulos que no fueron publicados en 1999,
-- 2004 y 2017 o cuya duracion sea de 200 o más. Eliminar duplicados.

select nombre , tipo , ano, duracion from articulos
where ano not in (1999,2004,2007) or duracion > 200
group by nombre; 

-- 6- Obtener todos los autores cuyo pais de origen tenga la palabra "Bretaña".

select * from autores
where pais like "%Bretaña%";

-- 7- Obtener todos los préstamos que no hayan sido devueltos todavía.

select * from prestamos
where fecha_devolucion is null;

select * from prestamos
inner join articulos on articulos.id =prestamos.articulo_id 
where fecha_devolucion is null;

-- 8- Obtener todos los préstamos que se realizaron en el año 2020.

-- select extract(year from fecha_prestamo)  from prestamos;

select * from prestamos
where year(fecha_prestamo) = 2020;

-- 9- Validar si se ha prestado el articulo 49 alguna vez, y si su fecha de devolucion fue anterior a
-- la fecha tope.
select * from prestamos;

select articulo_id, count(*) as veces_prestado from prestamos
where articulo_id = 49 and fecha_devolucion < fecha_tope;

-- 10- Obtener todos los socios que han devuelto un préstamo posteriormente a la fecha tope.

select * from prestamos
where fecha_devolucion > fecha_tope;

-- 11- Obtener cuantas veces se ha prestado cada articulo que ya haya sido devuelto.
select * from prestamos;
select 
	articulo_id ,
    count(articulo_id)as veces
    from prestamos
where fecha_devolucion is not null
group by articulo_id;

-- 12- Obtener los articulos que han sido prestados 3 veces o más.

select 
	articulo_id ,
    count(articulo_id)as veces
    from prestamos
where fecha_devolucion is not null
group by articulo_id
having veces >= 3;

-- 13- Obtener el total de minutos (duracion) de todas las peliculas que tenemos en la biblioteca.

select sum(duracion)as minutos_total from articulos
where tipo = "pelicula";

-- 14- Obtener el promedio de paginas (duracion) de los libros.

select avg(duracion)as promedio from articulos
where tipo = "libro";


-- 15- Obtener cuantas copias de cada articulo poseo.
select * from articulos;

select autor_id,count(nombre)as copias from articulos
group by autor_id;

-- 15- Obtener cuantos articulos de cada tipo tengo cuyo año de publicación sea el mismo.

select * from articulos;


select tipo,ano, count(cod_articulo) as cantidad from  articulos
group by tipo, ano;

-- 16- A la consulta anterior, sumarle que sólo devuelva aquellos de los cuales tengo más de 2.

select 
	tipo,ano,
    count(cod_articulo) as cantidad
from  articulos
group by tipo, ano
having cantidad >=2;



-- 17- Obtener un listado de todos los socios.

select * from socios;

-- 18- Obtener los primeros 10 socios ordenados alfabeticamente. 

select * from socios
order by nombre asc
limit 10;

-- 19- Obtener todos los prestamos realizados en el año 2020.

select * from prestamos 
where year(fecha_prestamo) = 2020;

-- 20- Obtener todos los articulos de tipo pelicula anteriores al año 2010.
	select * from articulos;
    
    select * from articulos
    where tipo = "pelicula" ;
    
-- 21- Volver a realizar todas las consultas, estableciendo donde corresponda las relaciones con
-- tablas para obtener los datos significativos para los usuarios en vez de los ID de relacion.
-- Ejemplo: Obtener el nombre del socio que tomo prestado un articulo, o el nombre del articulo
-- que fue prestado.



