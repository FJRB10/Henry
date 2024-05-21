USE adventureworks;

/* Punto 1
	Obtener un listado contactos que hayan ordenado productos de la subcategoría 
    "Mountain Bikes", entre los años 2000 y 2003, cuyo método de envío sea 
    "CARGO TRANSPORT 5".
*/

SELECT 	-- DISTINCT sah.SalesOrderID, 
		DISTINCT CONCAT(c.FirstName ,' ', c.LastName) AS Nombre 
        -- p.ProductID, 
        -- sah.OrderDate
FROM salesorderheader sah 
	INNER JOIN contact c
		ON (sah.ContactID = c.ContactID)
	INNER JOIN salesorderdetail sad
		ON (sah.SalesOrderID = sad.SalesOrderID)
	INNER JOIN product p
		ON (sad.ProductID = p.ProductID)
	INNER JOIN productsubcategory ps
		ON (p.ProductSubcategoryID = ps.ProductSubcategoryID)
	INNER JOIN shipmethod s
		ON (sah.ShipMethodID = s.ShipMethodID)
WHERE YEAR(sah.OrderDate) BETWEEN '2000' AND '2003' AND
		ps.Name = 'Mountain Bikes' AND
        s.Name = 'CARGO TRANSPORT 5';

/* Punto 2
	Obtener un listado contactos que hayan ordenado productos de la subcategoría 
    "Mountain Bikes", entre los años 2000 y 2003 con la cantidad de productos adquiridos 
    y ordenado por este valor, de forma descendente.
*/

SELECT * FROM salesorderdetail;
SELECT * FROM salesorderheader;
SELECT * FROM product;

SELECT DISTINCT CONCAT(c.FirstName, ' ' , c.LastName) As Nombre,
		psc.Name,
        sod.OrderQty
FROM salesorderheader soh
	INNER JOIN contact c
		ON (soh.ContactID = c.ContactID)
	INNER JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	INNER JOIN product p
		ON (sod.ProductID = p.ProductID)
	INNER JOIN productsubcategory psc
		ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
WHERE YEAR(soh.OrderDate) BETWEEN '2000' AND '2003' AND
		psc.Name = 'Mountain Bikes'
ORDER BY sod.OrderQty DESC;

/* Punto 3
	Obtener un listado de cual fue el volumen de compra (cantidad) por año y método de 
    envío.
*/

SELECT * FROM salesorderdetail;
SELECT * FROM salesorderheader;
SELECT * FROM shipmethod;

SELECT YEAR(soh.OrderDate) AS año,
		s.Name AS MetodoEnvio,
        SUM(sod.OrderQty) AS Cantidad
FROM salesorderheader soh
	INNER JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	INNER JOIN shipmethod s
		ON (soh.ShipMethodID = s.ShipMethodID)
GROUP BY YEAR(soh.OrderDate), MetodoEnvio
ORDER BY YEAR(soh.OrderDate) ASC;

/* Punto 4
	Obtener un listado por categoría de productos, con el valor total de ventas y productos 
    vendidos.
*/

SELECT * FROM salesorderdetail;
SELECT * FROM product;
SELECT * FROM productsubcategory;
SELECT * FROM productcategory;

SELECT pc.Name AS Categoria,
		SUM(sod.OrderQty) AS Cantidad,
        SUM(sod.LineTotal) AS TotalVentas
FROM salesorderdetail sod
	INNER JOIN product p
		ON (sod.ProductID = p.ProductID)
	INNER JOIN productsubcategory psc
		ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
	INNER JOIN productcategory pc
		ON (psc.ProductCategoryID = pc.ProductCategoryID)
GROUP BY Categoria;

/* Punto 5
	Obtener un listado por país (según la dirección de envío), con el valor total de ventas 
    y productos vendidos, sólo para aquellos países donde se enviaron más de 15 mil productos.
*/

SELECT * FROM salesorderheader;

SELECT cr.Name AS Pais,
		SUM(sod.LineTotal) AS TotalVentas,
        SUM(sod.OrderQty) AS Cantidad
FROM salesorderheader soh
	INNER JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	INNER JOIN address ad
		ON (soh.ShipToAddressID = ad.AddressID)
	INNER JOIN stateprovince sp
		ON (ad.StateProvinceID = sp.StateProvinceID)
	INNER JOIN countryregion cr
		ON (sp.CountryRegionCode = cr.CountryRegionCode)
GROUP BY Pais
HAVING Cantidad > 15000
ORDER BY Cantidad;


/* Punto 6
	Obtener un listado de las cohortes que no tienen alumnos asignados, utilizando la base 
    de datos henry, desarrollada en el módulo anterior.
*/

USE henry;

SELECT * FROM alumno;
SELECT * FROM cohorte;

SELECT co.idCohorte 
FROM cohorte co
	LEFT JOIN alumno al
		ON (co.idCohorte = al.idCohorte)
WHERE al.idCohorte IS NULL;