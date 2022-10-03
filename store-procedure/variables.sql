-- VARIABLES DECLARADAS POR EL USUARIO

set @FirstVar = 1, @SecondVar = 2;
select @FirstVar;


-- VARIABLES LOCALES
-- PUEDEN TENER VALOR DEFINIDO O NO.alter

delimiter $$

create procedure sp_ejemplo ( item int, nom_categoria varchar(15))

begin 
	declare factor decimal(5,2);
	declare n int;
    set factor = 3.45 * item;
    -- PODEMOS UTILIZAR LAS VARIABLES PARA ASIGNARLE VALOR DE FILAS O UTILIZARLAS EN PARAMETROS.
    SELECT CategoriaID INTO n FROM categorias WHERE CategoriaNombre = nom_categoria;
    -- A la variable n le asigno el id de una categoria especifica.
end $$



