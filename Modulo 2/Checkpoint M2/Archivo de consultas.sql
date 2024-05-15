SELECT * FROM venta;
SELECT * FROM canal_venta;

SELECT IdCanal, SUM(Cantidad) AS cantidad FROM venta 
GROUP BY IdCanal ORDER BY cantidad ASC;

SELECT YEAR(Fecha) AS Fecha, IdCanal, SUM(Precio) AS Precio FROM venta 
GROUP BY Fecha, IdCanal HAVING Fecha = 2019;

SELECT IdCanal, SUM(Precio) AS Precio FROM venta
WHERE YEAR(Fecha) = 2019 GROUP BY IdCanal ORDER BY Precio DESC;

SELECT YEAR(Fecha), COUNT(*) AS Cantidad FROM venta 
WHERE TIMESTAMPDIFF(DAY, fecha, Fecha_Entrega) = 10 AND YEAR(Fecha) = 2021
GROUP BY YEAR(Fecha);

SELECT IdEmpleado, SUM(Cantidad) AS Cantidad FROM venta
GROUP BY IdEmpleado ORDER BY Cantidad ASC;

SELECT IdCanal, COUNT(*) AS Cantidad, YEAR(Fecha) FROM venta 
WHERE TIMESTAMPDIFF(DAY, fecha, Fecha_Entrega) > 2 AND YEAR(Fecha) = 2018
GROUP BY IdCanal, YEAR(Fecha);

SELECT COUNT(IdVenta) AS Cantidad FROM venta 
WHERE TIMESTAMPDIFF(DAY, fecha, Fecha_Entrega) > 2 AND YEAR(Fecha) = 2018;

SELECT COUNT(*) FROM producto WHERE Concepto LIKE '%JBL%';