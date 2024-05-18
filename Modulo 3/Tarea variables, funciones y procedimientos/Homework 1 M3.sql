USE adventureworks;

/* Punto 1
	Crear un procedimiento que recibe como parámetro una fecha y muestre la cantidad 
    de órdenes ingresadas en esa fecha.
*/

DROP PROCEDURE OrdenesFecha;

DELIMITER $$
CREATE PROCEDURE OrdenesFecha (IN fecha DATE)
BEGIN
	SELECT COUNT(*) AS cantidad FROM salesorderheader
    WHERE DATE(OrderDate) = fecha;
END$$
DELIMITER ;

CALL OrdenesFecha('2001-06-30');

-- ------------------------------------------------------------------------------------------

/* Punto 2
	Crear una función que calcule el valor nominal de un margen bruto determinado 
    por el usuario a partir del precio de lista de los productos.
*/

SELECT * FROM product ORDER BY StandardCost DESC;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$

CREATE FUNCTION valorNominal(precio DECIMAL(10,3), margen DECIMAL(9,2)) RETURNS DECIMAL(10,3)
BEGIN
	DECLARE valor DECIMAL(10,3);
    
    SET valor = precio * margen;
    
    RETURN valor;
END $$

DELIMITER ;

SELECT valorNominal(1000,1.3);

/* Punto 3
	Obtner un listado de productos en orden alfabético que muestre cuál debería ser el valor
    de precio de lista, si se quiere aplicar un margen bruto del 20%, utilizando la función
    creada en el punto 2, sobre el campo StandardCost.
    Mostrando tambien el campo ListPrice y la diferencia con el nuevo campo creado.
*/

SELECT 	ProductID, 
		Name, 
        StandardCost, 
        Listprice, 
        valorNominal(StandardCost, 1.2) AS valorNominal, 
        (ListPrice - valorNominal(StandardCost, 1.2)) AS diferencia
FROM product;

/* Punto 4
	Crear un procedimiento que reciba como parámetro una fecha desde y una hasta, 
    y muestre un listado con los Id de los diez Clientes que más costo de transporte 
    tienen entre esas fechas (campo Freight).
*/

DELIMITER $$

CREATE PROCEDURE clientesCostoTransporte (IN fechaDesde DATE, IN fechaHasta DATE)
BEGIN
	SELECT SalesOrderID, OrderDate, Freight 
	FROM salesorderheader
	WHERE OrderDate BETWEEN fechaDesde AND fechaHasta
	ORDER BY Freight DESC LIMIT 10;
END $$

DELIMITER ; 

CALL clientesCostoTransporte('2001-06-30', '2001-11-13');

/* Punto 5
	Crear un procedimiento que permita realizar la insercción de datos en la tabla 
    shipmethod.
*/

DROP PROCEDURE InsertarMetodosEnvio;

DELIMITER $$

CREATE PROCEDURE InsertarMetodoEnvio (IN nombre VARCHAR(50), IN valorMinimo DOUBLE, IN costoPorLibra DOUBLE)
BEGIN
	INSERT INTO shipmethod (Name, ShipBase, ShipRate, ModifiedDate)
	VALUES (nombre, valorMinimo, costoPorLibra, NOW());
END $$

DELIMITER ;

CALL InsertarMetodoEnvio('EmpresaPrueba', 4, 0.5);

SELECT * FROM shipmethod;

INSERT INTO shipmethod (ShipMethodID, Name, ShipBase, ShipRate, ModifiedDate)
VALUES ('EmpresaPrueba', 4, 0.5, NOW());