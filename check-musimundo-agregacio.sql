select * from clientes;

-- El área de estrategia de Musimundos está analizando cómo implementar una acción de marketing,
-- en la cual tiene que destinar un presupuesto acorde a la cantidad de clientes que tenga cada país.
-- Por esto te piden que los ayudemos a identificar la cantidad de clientes que son de Brazil. Seleccioná el número que obtuviste.


select count(*) from clientes 
where pais = "Brazil";


-- 
-- En Musimundos estamos muy atentos a que nuestros usuarios encuentren una cantidad apropiada de canciones del estilo que quieran escuchar.
-- Es por eso que en esta oportunidad nos están solicitando una lista de cuantas canciones tenemos por género.
-- Para esto, hacé una consulta a la base de datos que traiga el id del género y la cantidad de canciones que posee.
-- Seleccioná el número que te dio como resultado de la cantidad de canciones del género con id = 6.

select count(*) from canciones
where id_genero = 6;



-- Es época de balances, y en Musimundos queremos saber cuánto dinero llevan gastados los clientes en nuestra empresa.
-- Seleccioná el número que obtuviste. 

select sum(total) from facturas;

-- En el sitio web de Musimundos, queremos informar la duración promedio en milisegundos de cada álbum. 
-- Obtiene una lista de todos los álbumes y su duración (milisegundos) promedio. Inserta el número del promedio que obtuviste para el álbum  

select * from canciones;

select count(*) from albumes;

select id_album, avg(milisegundos) from canciones
group by id_album;


-- En el equipo de desarrollo están mudando de servidor a nuestra aplicación, y quieren saber cuál es el peso (bytes) de cada archivo de canciones
--  para buscar un servidor adecuado con capacidad suficiente.
-- Hace una consulta a la base de datos para saber cuál es el archivo con menor peso en bytes. Seleccioná el número que obtuviste.

select sum(bytes) from canciones;

select nombre, min(bytes) as menorPeso from canciones;


-- En el salón de Musimundos, estamos ofreciendo un descuento para todos aquellos clientes que tengan un total de facturación mayor a 45.
-- Hacé una consulta a la base de datos que nos traiga por id_cliente la suma total de sus facturas.
-- Filtra aquellos que la suma del total sea &gt;45. ¿Cuál es la suma total del cliente con id = 6? Por último, seleccioná el número que obtuviste.

select id_cliente, sum(total)  from facturas
where id_cliente = 6
group by id_cliente;


select * from album;



