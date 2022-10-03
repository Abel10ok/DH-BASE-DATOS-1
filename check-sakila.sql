-- Reportes 
-- Reportes parte 1: 
-- 1. Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar 
-- alias para mostrar los nombres de las columnas en español. 

select first_name as nombre , last_name as apellido from  actor
limit 5;


-- 2. Obtener un listado que incluya nombre, apellido y correo electrónico de los 
-- clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las 
-- columnas en español. 

select * from customer;

select concat(first_name," ",last_name) as nombre_apellido, email as correo, active from customer
where active !=1;

-- 3. Obtener un listado de films incluyendo título, año y descripción de los films 
-- que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de 
-- mayor a menor. Utilizar alias para mostrar los nombres de las columnas en 
-- español. 

select title as titulo, release_year as anio , f.description as descripcion, rental_duration as duracion from film as f
having duracion > 5
order by duracion desc;

-- 4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de 
-- mayo de 2005, incluir en el resultado todas las columnas disponibles. 

select * from rental
where month(rental_date) = "05" and year(rental_date)= "2005";


-- Reportes parte 2: Sumemos complejidad 
-- Si llegamos hasta acá, tenemos en claro la estructura básica de un SELECT. En los siguientes reportes vamos a sumar complejidad. 
-- ¿Probamos? 
-- 1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo en una columna llamada “cantidad”. 

select * from rental;
select count(*) as cantidad from rental;

-- 2. Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para mostrarlo en una columna llamada “total”,
--  junto a una columna con la cantidad de alquileres con el alias “Cantidad” y una columna que indique el “Importe promedio” por alquiler. 

select * from payment;

select sum(amount) as total, count(rental_id) as cantidad, avg(amount) as promedio from payment;

-- 3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen? 

select * from customer;

select customer_id as cliente, sum(amount) as gasto_x_cliente , count(rental_id) as alquiler from payment
group by cliente
order by gasto_x_cliente desc 
limit 10;


-- 4. Generar un reporte que indique: 
-- ID de cliente, cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres. 

select customer_id as cliente, count(rental_id) as cant_alquiler, sum(amount) as total from payment
group by cliente
having total > 150;

-- 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
-- la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el año de alquiler 2005 (rental_date de tabla rental). 

select extract(month FROM(rental_date)) as mes, count(payment.rental_id) as cantidad_alquileres, sum(amount) as total_pagado,extract(year from(rental_date)) as anio from payment 
inner join rental
on payment.rental_id = rental.rental_id
group by mes having anio = '2005';

-- 6. Generar un reporte que responda a la pregunta:
-- ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental). 
-- Para cada una de ellas indicar la cantidad de alquileres. 

select count(rental_id) as cantidad_de_alquileres, inventory_id as inventario from rental group by inventario order by rental_id limit 5;

