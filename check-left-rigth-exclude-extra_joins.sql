use extra_joins;

-- Es momento de aplicar los conocimientos adquiridos. Para esto,
-- vamos a trabajar con una nueva base de datos, donde deberemos
-- crear consultas con las cláusulas INNER, LEFT, LEFT Excluding,
-- RIGHT y RIGHT Excluding. 

-- 1. Obtener los artistas que han actuado en una o más películas.

select a.*, ap.*,  count(ap.pelicula_id) as actuacion_x_pelicula from artista as a  
inner join artista_x_pelicula as ap on a.id = ap.artista_id
group by ap.artista_id;

-- 2. Obtener las películas donde han participado más de un artista según nuestra
-- base de datos.

select titulo from pelicula 
inner join artista_x_pelicula
on pelicula.id = artista_x_pelicula.pelicula_id
group by titulo having count(artista_x_pelicula.artista_id) > 1;


-- 3. Obtener aquellos artistas que han actuado en alguna película, incluso
-- aquellos que aún no lo han hecho, según nuestra base de datos.
select * from pelicula;
select * from artista_x_pelicula;

select * from pelicula 
left join artista_x_pelicula
on pelicula.id = artista_x_pelicula.pelicula_id;

-- 4. Obtener las películas que no se le han asignado artistas en nuestra base de
-- datos.

select * from artista_x_pelicula;
select * from pelicula 
right join artista_x_pelicula
on pelicula.id = artista_x_pelicula.pelicula_id
where artista_x_pelicula.artista_id is null;

-- 5. Obtener aquellos artistas que no han actuado en alguna película, según
-- nuestra base de datos.

select * from artista 
left join artista_x_pelicula
on artista.id = artista_x_pelicula.artista_id
where artista_x_pelicula.artista_id is null
;


-- 6. Obtener aquellos artistas que han actuado en dos o más películas según
-- nuestra base de datos.

select * from artista 
inner join artista_x_pelicula on artista.id = artista_x_pelicula.artista_id
inner join pelicula on  pelicula.id = artista_x_pelicula.pelicula_id
group by(artista.id)
having count(artista_x_pelicula.pelicula_id)>=2
;


-- 7. Obtener aquellas películas que tengan asignado uno o más artistas, incluso
-- aquellas que aún no le han asignado un artista en nuestra base de datos.


select *, count(artista_x_pelicula.artista_id) as cantidad_de_artistas from pelicula 
left join artista_x_pelicula on pelicula.id = artista_x_pelicula.pelicula_id
inner join artista on  artista.id = artista_x_pelicula.artista_id
group by(pelicula.id)
;