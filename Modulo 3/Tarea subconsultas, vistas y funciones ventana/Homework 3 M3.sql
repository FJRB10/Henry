USE adventureworks;

/* Punto 1
	Obtener un listado de cuál fue el volumen de ventas (cantidad) por año y método de 
    envío mostrando para cada registro, qué porcentaje representa del total del año. 
    Resolver utilizando Subconsultas y Funciones Ventana, luego comparar la diferencia en 
    la demora de las consultas.
*/

-- Subcosulta
SELECT YEAR(soh.OrderDate) AS Anio,
		sm.Name AS MetodoEnvio,
		SUM(sod.OrderQty) AS Cantidad,
        -- sc.CantidadAño AS CantidadPorAño
        ROUND( (SUM(sod.OrderQty) / sc.CantidadAño) * 100, 2) AS PorcentajeMetodoEnvioAño
FROM salesorderheader soh
	INNER JOIN shipmethod sm
		ON (soh.ShipMethodID = sm.ShipMethodID)
	INNER JOIN salesorderdetail sod
		ON (soh.SalesOrderID = sod.SalesOrderID)
	INNER JOIN (SELECT YEAR(soh.OrderDate) AS año,
						SUM(sod.OrderQty) AS CantidadAño
				FROM salesorderheader soh
					INNER JOIN salesorderdetail sod
						ON (soh.SalesOrderID = sod.SalesOrderID)
				GROUP BY Año) AS sc
		ON (YEAR(soh.OrderDate) = sc.año)
GROUP BY Anio, MetodoEnvio, sc.CantidadAño
ORDER BY Anio ASC;
-- 2.531 segundos

-- Función ventana
SELECT Anio,
		MetodoEnvio,
        Cantidad,
        ROUND( (Cantidad / SUM(Cantidad) OVER (PARTITION BY Anio) ) * 100, 2) AS PorcentajeAño
FROM (
		SELECT YEAR(soh.OrderDate) AS Anio,
				sm.Name AS MetodoEnvio,
				SUM(sod.OrderQty) AS Cantidad
		FROM salesorderheader soh
			INNER JOIN shipmethod sm
				ON (soh.ShipMethodID = sm.ShipMethodID)
			INNER JOIN salesorderdetail sod
				ON (soh.SalesOrderID = sod.SalesOrderID)
		GROUP BY Anio, MetodoEnvio
		ORDER BY Anio ASC) AS t
GROUP BY t.Anio, t.MetodoEnvio;
-- 1.157 segundos

/* Punto 2
	Obtener un listado por categoría de productos, con el valor total de ventas y 
    productos vendidos, mostrando para ambos, su porcentaje respecto del total.
*/

-- Funcion ventana
SELECT Categoria,
		TotalCantidad,
		TotalVentas,
        ROUND( (TotalCantidad / SUM(TotalCantidad) OVER ()) * 100, 2) AS PorcentajeUnidades,
		ROUND ( (TotalVentas / SUM(TotalVentas) OVER()) * 100, 2) AS PorcentajeVentas
FROM (	SELECT pc.Name AS Categoria,
			SUM(sod.OrderQty) AS TotalCantidad,
			SUM(sod.LineTotal) AS TotalVentas
			FROM salesorderdetail sod
				INNER JOIN product p
					ON (sod.ProductID = p.ProductID)
				INNER JOIN productsubcategory psc
					ON (p.ProductSubcategoryID = psc.ProductSubcategoryID)
				INNER JOIN productcategory pc
					ON (psc.ProductCategoryID = pc.ProductCategoryID)
			GROUP BY Categoria
			ORDER BY TotalVentas DESC) AS fv
GROUP BY Categoria;

/* Punto 3
	Obtener un listado por país (según la dirección de envío), con el valor total de ventas 
    y productos vendidos, mostrando para ambos, su porcentaje respecto del total.
*/

SELECT Pais,
		TotalProductos,
        TotalVentas,
        ROUND( (TotalProductos / SUM(TotalProductos) OVER()) * 100,2) AS PorcentajeProductos,
        ROUND( (TotalVentas / SUM(TotalVentas) OVER()) * 100,2) AS PorcentajeVentas
FROM(	SELECT cr.Name AS Pais,
			SUM(sod.OrderQty) AS TotalProductos,
			SUM(sod.LineTotal) AS TotalVentas
			FROM salesorderheader soh
				INNER JOIN address a
					ON (soh.ShipToAddressID = a.AddressID)
				INNER JOIN stateprovince sp
					ON (a.StateProvinceID = sp.StateProvinceID)
				INNER JOIN countryregion cr
					ON (sp.CountryRegionCode = cr.CountryRegionCode)
				INNER JOIN salesorderdetail sod
					ON (soh.SalesOrderID = sod.SalesOrderID)
			GROUP BY Pais
			ORDER BY TotalVentas DESC) AS fv
GROUP BY Pais
ORDER BY TotalVentas DESC;

/* Punto 4
	Obtener por ProductID, los valores correspondientes a la mediana de las ventas 
    (LineTotal), sobre las ordenes realizadas. Investigar las funciones FLOOR() y 
    CEILING().
*/

SELECT Producto,
		AVG(TotalVentas) AS MedianaVentas
FROM(	SELECT sod.ProductID AS Producto, 
				sod.LineTotal AS TotalVentas,
				COUNT(*) OVER (PARTITION BY sod.ProductID) AS Cantidad,
				ROW_NUMBER() OVER(PARTITION BY sod.ProductID ORDER BY sod.LineTotal) AS FilaNum
		FROM salesorderdetail sod) AS fv
WHERE (CEILING(fv.Cantidad / 2) = FLOOR(fv.Cantidad / 2)) AND ( (fv.FilaNum = FLOOR(fv.Cantidad / 2)) OR (fv.FilaNum = FLOOR(fv.Cantidad / 2) + 1) )
	OR (CEILING(fv.Cantidad / 2) != FLOOR(fv.Cantidad / 2)) AND (fv.FilaNum = CEILING(fv.Cantidad / 2))
GROUP BY Producto;