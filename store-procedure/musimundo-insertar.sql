-- Tabla: Clientes
-- 1. Crear un stored procedure que solicite como parámetros de entrada el
-- nombre de un país y una ciudad, y que devuelva como resultado la
-- información de contacto de todos los clientes de ese país y ciudad.
-- En el caso que el parámetro de ciudad esté vacío, se debe devolver todos los
-- clientes del país indicado.
-- 2. Invocar el procedimiento para obtener la información de los clientes de
-- Brasilia en Brazil.
-- 3. Invocar el procedimiento para obtener la información de todos los clientes
-- de Brazil.

delimiter $$

create procedure sp_info_clientes (in p varchar(15), in c varchar(15))

begin
select * from clientes
where pais = p and   (ciudad = c or c = " ");

end $$

call sp_info_clientes("Brazil", " ");


-- SP: Géneros musicales
-- Tabla: Generos
-- 1. Crear un stored procedure que reciba como parámetro un nombre de
-- género musical y lo inserte en la tabla de géneros.
-- Además, el stored procedure debe devolver el id de género que se insertó.
-- TIP! Para calcular el nuevo id incluir la siguiente línea dentro del bloque de
-- código del SP: SET nuevoid = (SELECT MAX(id) FROM generos) + 1;

-- select * from generos;
-- insert into generos (id, nombre) values (26,"abel");

set @abel = "hola";

select @abel;

delimiter $$

create procedure sp_ingresar_genero (out numero int, in genero varchar(15))

begin
	select numero;
    set numero= (SELECT MAX(id) FROM generos) + 1;
	insert into generos (id, nombre) values (numero,genero);
end $$

set @n = 0;
call sp_ingresar_genero (@n, "ludmila");
select @n;

select * from generos;

