use la_aprobacion;

-- codigo 0522TDFE1N2C10LAED0522PT
-- camada 10

-- juan micozzi
-- cecilia carina cazon
-- josias briceño
-- abel alarcon 

-- 1. Listar los servicios básicos de la habitación número 25.
SELECT habitacion.numero, 
       servicio_basico_id
       
FROM habitacion
INNER JOIN habitacion_x_servicio_basico 
        ON habitacion_x_servicio_basico.habitacion_numero = habitacion.numero

WHERE habitacion.numero = 25
GROUP BY habitacion.numero
;

-- 2. Listar absolutamente todos los servicios básicos y la cantidad de habitaciones en
-- las que están instalados. Mostrar sólo el nombre del servicio básico y cantidad.

-- agrupar cantidad de servicio basico, por habitacion
SELECT  habitacion.numero               AS 'Habitación número',
        COUNT(habitacion.decoracion_id) AS 'Cantidad de servicios basicos'
     
FROM habitacion

INNER JOIN habitacion_x_servicio_basico 
        ON habitacion_x_servicio_basico.habitacion_numero = habitacion.numero

GROUP BY habitacion.numero
;


-- 3. Listar todos los huéspedes que tengan tres o más check-in. Mostrar el número
-- de huésped, apellido y nombre separado por un espacio dentro de una misma
-- columna denominada "Cliente" y, la cantidad de check-in que posee.


select huesped.id,concat(huesped.nombre , ",", huesped.apellido)as cliente, count(*)as cantidad from huesped
inner join checkin on checkin.huesped_id = huesped.id
group by huesped.id,cliente
having cantidad >=3;


-- 4. Listar todos los huéspedes que no tengan un check-in. Mostrar el número de
-- huésped, apellido y nombre en mayúsculas dentro de una misma columna
-- denominada "huésped sin check-in".

select huesped.id, concat(upper(apellido)," ", upper(nombre))as "huesped sin check-in" from huesped
left join checkin on checkin.huesped_id =  huesped.id
where checkin.id is null;

-- 7. Listar absolutamente todos los países y la cantidad de huéspedes que tengan.

select p.nombre, count(h.pais_id) from la_aprobacion.pais p
join huesped h on h.pais_id = p.id
group by p.nombre;


-- 8. Calcular el importe total y la cantidad de reservas realizadas en el mes de marzo
-- por cada huésped. Mostrar el apellido del huésped, importe total y cantidad de
-- reservas.

select huesped.apellido, importe, count(apellido)as cantidad from reserva
inner join huesped on huesped.id = reserva.huesped_id
where month(reserva.fecha) = 3
group by huesped.apellido;


-- 9. Calcular el importe total recaudado por mes (fecha de entrada) para la
-- habitación número 22. Mostrar el número de habitación, nombre de la
-- decoración, clase, nombre del mes y el importe total.

select habitacion.numero, month(fecha_entrada)as mes, sum(checkin.importe) mes from checkin 
inner join habitacion on habitacion.numero = checkin.habitacion_numero
inner join decoracion on decoracion.id = habitacion.decoracion_id
where habitacion.numero = 22
group by mes;



-- 11. Calcular la recaudación total de cada forma de pago para las reservas. Mostrar la
-- forma de pago y el total.

select forma_pago.nombre, sum(reserva.importe)as total  from forma_pago
inner join reserva on reserva.forma_pago_id = forma_pago.id
group by forma_pago.nombre;


/*12. Listar los empleados del sector 'administración' que su país de origen sea
'Argentina'. Mostrar el número de legajo, apellido, la primera inicial del primer
nombre y un punto, nombre de su país de origen y el nombre del sector.*/

SELECT legajo, apellido, empleado.nombre, pais.nombre, sector.nombre
FROM empleado
INNER JOIN sector ON sector.id = empleado.sector_id 
INNER JOIN pais ON pais.id = empleado.pais_id
WHERE (sector.nombre = "Administracion") AND (pais.nombre = "Argentina");


/*13. Listar todos los servicios básicos que tienen las habitaciones (desde la 20 hasta
la 24) y su clase. Mostrar número de habitación, clase y el nombre de los
servicios básicos. Ordenar por número de habitación y servicio.*/

SELECT habitacion_x_servicio_basico.habitacion_numero AS numero_habitacion, servicio_basico.nombre AS nombre_servicio, clase.nombre AS clase_de_servicio
FROM habitacion
INNER JOIN habitacion_x_servicio_basico ON habitacion.numero = habitacion_x_servicio_basico.habitacion_numero
INNER JOIN servicio_basico ON servicio_basico.id = habitacion_x_servicio_basico.servicio_basico_id
INNER JOIN clase ON habitacion.clase_id = clase.id
WHERE habitacion_x_servicio_basico.habitacion_numero >= 20 and habitacion_x_servicio_basico.habitacion_numero <=24
ORDER BY habitacion_x_servicio_basico.habitacion_numero, servicio_basico.nombre;

/*14. Listar las decoraciones que no están aplicadas en ninguna habitación.*/
SELECT decoracion.nombre, habitacion.decoracion_id
FROM decoracion
INNER JOIN habitacion ON decoracion.id = habitacion.decoracion_id 
WHERE habitacion.decoracion_id IS NULL;


-- 16. Calcular la cantidad y el promedio de cada forma de pago para los check-in.
-- Mostrar la forma de pago, cantidad y el promedio formateado con dos
-- decimales.

select checkin.forma_pago_id, sum(checkin.forma_pago_id)as forma_de_pago, round(avg(importe),2) from checkin
inner join forma_pago on forma_pago.id = checkin.forma_pago_id
group by checkin.forma_pago_id;


-- 17. Calcular la edad de los empleados de Argentina. Mostrar el apellido, nombre y la
-- edad del empleado.

select empleado.apellido, empleado.nombre, timestampdiff(year,empleado.fecha_nacimiento,curdate())as edad from empleado
inner join pais on empleado.pais_id = pais.id
where pais.nombre = "Argentina";


-- 18. Calcular el importe total para los check-in realizados por el huésped 'Mercado
-- Joel'. Mostrar apellido, nombre, importe total y el país de origen.

select
	huesped_id,
    concat(huesped.nombre," ",huesped.apellido) as nombre,
    sum(importe) as total,
    pais.nombre
from checkin 
inner join huesped on huesped.id = checkin.huesped_id
inner join pais on pais.id = huesped.pais_id
where huesped.apellido = "mercado" and huesped.nombre = "joel";

-- 19. Listar la forma de pago empleada por cada servicio extra. Se debe mostrar el
-- nombre del servicio extra, nombre de la forma de pago y calcular la cantidad y
-- total recaudado.

select servicio_extra.nombre, forma_pago.nombre,sum(importe)  from servicio_extra
inner join reserva on reserva.servicio_extra_id = servicio_extra.id
inner join forma_pago on forma_pago.id = reserva.forma_pago_id
group by servicio_extra.nombre, forma_pago.nombre;


-- 20 Listar la forma de pago empleada para el servicio extra "sauna" y los huespedes correspondientes.
-- se debe mostrar el nombre de servicio_extra, nombre de la forma de pago, numero del cliente importe total.

select servicio_extra.nombre, forma_pago.nombre,huesped.id as huesped , reserva.id as reserva,reserva.importe from servicio_extra
inner join reserva on reserva.servicio_extra_id = servicio_extra.id
inner join forma_pago on forma_pago.id = reserva.forma_pago_id
inner join huesped on huesped.id = reserva.huesped_id
where servicio_extra.nombre = "sauna";

