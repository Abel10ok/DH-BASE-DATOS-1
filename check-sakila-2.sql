use sakila;

select * from customers;



-- Manos a la obra:
-- 1. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes
-- que más dinero gastan y en cuantos alquileres lo hacen?


select c.customer_id, concat(c.first_name," ",c.last_name) as nombre_completo, sum(p.amount)as total from customer as c
inner join payment as p on p.customer_id = c.customer_id
group by c.customer_id, nombre_completo
order by total desc
limit 10;

-- 2. Generar un reporte que indique: el id del cliente, la cantidad de alquileres y
-- el monto total para todos los clientes que hayan gastado más de 150 dólares
-- en alquileres.

select c.customer_id, count(*) as cantidad_alquileres,  sum(p.amount)as total from customer as c
inner join rental as r on r.customer_id = c.customer_id 
inner join payment as p on p.customer_id = c.customer_id
group by c.customer_id
having total >150
order by total;


-- 3. Generar un reporte que responda a la pregunta: ¿cómo se distribuyen la
-- cantidad y el monto total de alquileres en los meses pertenecientes al año
-- 2005? (tabla payment).

select year(r.rental_date) as ano,  count(*)as cantidad, sum(p.amount) as total from rental as r
inner join payment as p on p.rental_id = r.rental_id
where year(r.rental_date)=2005;


-- 4. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios
-- más alquilados? (columna inventory_id en la tabla rental) Para cada una de
-- ellas, indicar la cantidad de alquileres.

select i.inventory_id ,count(*) as veces_alquilados from rental as r
inner join inventory as i on i.inventory_id = r.inventory_id
group by i.inventory_id
order by veces_alquilados desc;


-- Parte 2:
-- 1. Generar un reporte que responda a la pregunta: Para cada tienda
-- (store), ¿cuál es la cantidad de alquileres y el monto total del dinero
-- recaudado por mes?

select  s.store_id as tienda, count(*)as alquileres, sum(p.amount) as dinero_recaudado from store as s
inner join inventory as i on i.store_id = s.store_id
inner join rental as r on r.inventory_id = i.inventory_id
inner join payment as p on p.rental_id = r.rental_id
group by tienda;
 

-- 2. Generar un reporte que responda a la pregunta: ¿cuáles son las 10 películas
-- que generan más ingresos? ¿ Y cuáles son las que generan menos ingresos?
-- Para cada una de ellas indicar la cantidad de alquileres.


select f.title ,count(*)as alquileres,sum(p.amount) as ingresos from   film as f
inner join inventory as i on i.film_id = f.film_id
inner join rental as r on r.inventory_id = i.inventory_id
inner join payment as p on p.rental_id = r.rental_id
group by f.title
order by ingresos desc
limit 10;


select f.title ,count(*)as alquileres,sum(p.amount) as ingresos from   film as f
inner join inventory as i on i.film_id = f.film_id
inner join rental as r on r.inventory_id = i.inventory_id
inner join payment as p on p.rental_id = r.rental_id
group by f.title
order by ingresos 
limit 10;


-- 3. ¿Existen clientes que no hayan alquilado películas?

select * from customer as c
left join rental as r on r.customer_id = c.customer_id 
where r.rental_id is null;


-- 4. Nivel avanzado: El jefe de stock quiere discontinuar las películas (film) con
-- menos alquileres (rental). ¿Qué películas serían candidatas a discontinuar?
-- Recordemos que pueden haber películas con 0 (Cero) alquileres.

select f.title, count(r.rental_id) as cantidad  from   film as f
left join inventory as i on i.film_id = f.film_id
left join rental as r on r.inventory_id = i.inventory_id
group by f.title
order by cantidad;


select f.title,r.*  from   film as f
left join inventory as i on i.film_id = f.film_id
left join rental as r on r.inventory_id = i.inventory_id;
