-- 1) Cálculo de edad 
-- a) Crear un SP que muestre apellidos, nombres y edad de cada empleado, debe calcular la edad de los empleados a partir de la fecha de nacimiento y que tengan entre n y n años de edad. 
-- b) Ejecutar el SP indicando un rango de edad entre 50 y 60 años de edad.

delimiter $$

create procedure sp_nombres_x_edad (in edad1 int, in edad2 int)

begin

select apellido, nombre , timestampdiff(year,fechaNacimiento,curdate())as edad from empleados
having edad between edad1 and edad2;

end $$

call sp_nombres_x_edad(70,73);


-- 2) Actualización de productos .

-- a) Crear un SP que reciba un porcentaje y un nombre de categoría y actualice los productos pertenecientes a esa categoría,
-- incrementando las unidades pedidas según el porcentaje indicado. 
-- Por ejemplo: si un producto de la categoría Seafood tiene 30 unidades pedidas,
-- al invocar el SP con categoría Seafood y porcentaje 10%, el SP actualizará el valor de unidades pedidas con el nuevo valor 33. 

delimiter $$
DROP PROCEDURE IF EXISTS sp_actualizar_demanda_x_porcentaje_categoria;
CREATE PROCEDURE sp_actualizar_demanda_x_porcentaje_categoria(IN porcentaje INT, IN nom_categoria VARCHAR(30))
BEGIN
	DECLARE var_categoria INT;
	SELECT CategoriaID INTO var_categoria FROM categorias WHERE CategoriaNombre = nom_categoria;
    UPDATE productos SET UnidadesPedidas = UnidadesPedidas + (UnidadesPedidas / 100 * porcentaje) WHERE CategoriaID = var_categoria;
END $$
-- b) Listar los productos de la categoría Beverages para ver cuántas unidades pedidas hay de cada uno de ellos.
SELECT p.ProductoNombre, p.CategoriaID, p.UnidadesPedidas FROM productos AS p
INNER JOIN categorias AS c ON c.CategoriaID = p.CategoriaID WHERE c.CategoriaNombre = 'Beverages';
-- c) Invocar al SP con los valores Beverages como categoría y 15 como porcentaje.
-- d) Volver a listar los productos como en (a), y validar los resultados.
-- b) Listar los productos de la categoría Beverages para ver cuántas unidades pedidas hay de cada uno de ellos. 
CALL sp_actualizar_demanda_x_porcentaje_categoria(15, 'Beverages');



-- 3) Actualización de empleados 
-- a) Crear un SP que cree una tabla con los nombres, apellidos y teléfono de contacto de todos los empleados que hayan sido contratados 
-- con fecha anterior a una fecha dada. 
-- b) Ejecutar el SP para generar una tabla de empleados con fecha de contratación anterior a 01/01/1994. 
-- c) Consultar la tabla generada y validar los resultados. 

delimiter $$

create procedure sp_fecha_contratacion (in Fecha date)

begin

select Nombre, Apellido, Telefono, DATE_FORMAT(FechaContratacion,'%d -%m -%Y') as FechaContratacion from empleados
having FechaContratacion < DATE_FORMAT(Fecha,'%d-%m -%Y');

end $$


call sp_fecha_contratacion("1994-01-01");