USE Tarea_4;

-- SET SQL_SAFE_UPDATES = 0;

SELECT Provincia, Localidad FROM clientes WHERE Localidad = 'Avellaneda';
SELECT Localidad, Provincia FROM sucursales;
SELECT Ciudad, Estado, Departamento FROM proveedores;

DROP TABLE aux_localidades;

CREATE TABLE aux_localidades(
Localidad_Original			VARCHAR(80),
Provincia_Original			VARCHAR(50),
Localidad_Normalizada		VARCHAR(80),
Provincia_Normalizada		VARCHAR(50),
IdLocalidad					INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT DISTINCT Localidad, Provincia, Localidad, Provincia FROM clientes WHERE Localidad = 'Avellaneda'
UNION
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia FROM sucursales WHERE Localidad = 'Avellaneda'
UNION
SELECT DISTINCT Ciudad, Estado, Ciudad, Estado FROM proveedores WHERE Ciudad = 'Avellaneda';

SELECT DISTINCT Localidad, Provincia, Localidad, Provincia FROM clientes WHERE Localidad = 'Avellaneda'
UNION ALL
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia FROM sucursales WHERE Localidad = 'Avellaneda'
UNION ALL
SELECT DISTINCT Ciudad, Estado, Ciudad, Estado FROM proveedores WHERE Ciudad = 'Avellaneda';

INSERT INTO aux_localidades (Localidad_Original, Provincia_Original, Localidad_Normalizada, Provincia_Normalizada, IdLocalidad)
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 FROM clientes
UNION ALL
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 FROM sucursales
UNION ALL
SELECT DISTINCT Ciudad, Estado, Ciudad, Estado, 0 FROM proveedores;

-- TRUNCATE aux_localidades;

SELECT DISTINCT Provincia_Original FROM aux_localidades WHERE Provincia_Original LIKE 'Buenos%'
UNION
SELECT DISTINCT Provincia_Original FROM aux_localidades WHERE Provincia_Original LIKE '%Aires'
UNION
SELECT DISTINCT Provincia_Original FROM aux_localidades WHERE Provincia_Original LIKE 'Bs%'
UNION
SELECT DISTINCT Provincia_Original FROM aux_localidades WHERE Provincia_Original LIKE '%As'
ORDER BY 1;

UPDATE aux_localidades SET Provincia_Normalizada = 'Buenos Aires' 
WHERE Provincia_Original IN ('Buenos Aires', 
							'Ciudad de Buenos Aires',
							'C deBuenos Aires',
							'B. Aires',
							'B.Aires',
							'Provincia de Buenos Aires',
							'Bs As',
							'Bs.As. ',
                            'Bs As',
                            'Pcia Bs AS',
                            'Prov de Bs As.',
                            'CABA',
                            'Caba'
);

SELECT DISTINCT Provincia_Normalizada FROM aux_localidades;

UPDATE aux_localidades SET Provincia_Normalizada = 'Córdoba'
WHERE Provincia_Original IN ('CÃ³rdoba');

UPDATE aux_localidades SET Provincia_Normalizada = 'Tucumán'
WHERE Provincia_Original IN ('TucumÃ¡n', 'Tucuman');

UPDATE aux_localidades SET Provincia_Normalizada = 'Rio Negro'
WHERE Provincia_Original IN ('RÃ­o Negro');

SELECT * FROM aux_localidades WHERE Provincia_Normalizada = 'Sin Dato';

SELECT * FROM clientes WHERE Provincia = 'Sin Dato';			-- Solo hay 'Sin Dato' aqui.
SELECT * FROM sucursales WHERE Provincia = 'Sin Dato';
SELECT * FROM proveedores WHERE Estado = 'Sin Dato';

SELECT DISTINCT Localidad_Normalizada FROM aux_localidades ORDER BY 1;

SELECT * FROM aux_localidades WHERE Localidad_Normalizada IN (	'Cap.   Federal',
																'Cap. Fed.',
																'CapFed',
																'Capital',
																'Capital Federal',
                                                                'Caba',
																'Boca De Atencion Monte Castro',
																'Cdad De Buenos Aires',
																'Ciudad De Buenos Aires'
);

UPDATE aux_localidades SET Localidad_Normalizada = 'Capital Federal'
WHERE Localidad_Original IN (	'Cap.   Federal',
								'Cap. Fed.',
								'CapFed',
								'Capital',
                                'Caba',
                                'Boca De Atencion Monte Castro',
                                'Cdad De Buenos Aires',
								'Ciudad De Buenos Aires'
);

SELECT * FROM aux_localidades WHERE Localidad_Original IN (
'CÃ³rdoba',
'Cordoba',
'Coroba'
);

UPDATE aux_localidades SET Localidad_Normalizada = 'Cordoba'
WHERE Localidad_Original IN (
'CÃ³rdoba',
'Coroba'
);

SELECT * FROM aux_localidades WHERE Localidad_Original IN (
'MartÃ­nez',
'Martinez'
);

UPDATE aux_localidades SET Localidad_Normalizada = 'Martinez'
WHERE Localidad_Original IN ('MartÃ­nez');

SELECT * FROM aux_localidades WHERE Localidad_Original IN (
'San Miguel de TucumÃ¡n',
'San Miguel De Tucuman'
);

UPDATE aux_localidades SET Localidad_Normalizada = 'San Miguel De Tucuman'
WHERE Localidad_Original IN ('San Miguel de TucumÃ¡n');

SELECT * FROM aux_localidades WHERE Localidad_Original IN (
'Vicente LÃ³pez',
'Vicente Lopez'
);

UPDATE aux_localidades SET Localidad_Normalizada = 'Vicente Lopez'
WHERE Localidad_Original IN ('Vicente LÃ³pez');

CREATE TABLE localidades(
IdLocalidad				INTEGER NOT NULL AUTO_INCREMENT,
Localidad				VARCHAR(80) NOT NULL,
Provincia				VARCHAR(80) NOT NULL,
IdProvincia				INTEGER NOT NULL,
PRIMARY KEY(IdLocalidad)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE provincias(
IdProvincia				INTEGER NOT NULL AUTO_INCREMENT,
Provincia				VARCHAR(80) NOT NULL,
PRIMARY KEY(IdProvincia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT DISTINCT Localidad_Normalizada, Provincia_Normalizada FROM aux_localidades
ORDER BY Provincia_Normalizada, Localidad_Normalizada;

INSERT INTO localidades (Localidad, Provincia, IdProvincia)
SELECT DISTINCT Localidad_Normalizada, Provincia_Normalizada, 0 FROM aux_localidades
ORDER BY Provincia_Normalizada, Localidad_Normalizada;

SELECT * FROM localidades;

SELECT DISTINCT Provincia_Normalizada FROM aux_localidades ORDER BY 1;

INSERT INTO provincias (Provincia)
SELECT DISTINCT Provincia_Normalizada FROM aux_localidades ORDER BY 1;

SELECT * FROM provincias;

UPDATE localidades l INNER JOIN provincias p ON (l.Provincia = p.Provincia)
SET l.IdProvincia = p.IdProvincia;

UPDATE aux_localidades a INNER JOIN localidades l ON (a.Localidad_Normalizada = l.Localidad)
SET a.IdLocalidad = l.IdLocalidad;

SELECT * FROM aux_localidades ORDER BY 5;

ALTER TABLE clientes ADD IdLocalidad INTEGER NOT NULL DEFAULT 0 AFTER Localidad;
ALTER TABLE proveedores ADD IdLocalidad INTEGER NOT NULL DEFAULT 0 AFTER Departamento;
ALTER TABLE sucursales ADD IdLocalidad INTEGER NOT NULL DEFAULT 0 AFTER Provincia;

UPDATE clientes c 
INNER JOIN aux_localidades a ON (c.Localidad = a.Localidad_Original AND c.Provincia = a.Provincia_Original)
SET c.IdLocalidad = a.IdLocalidad;

UPDATE proveedores p
INNER JOIN aux_localidades a ON (p.Ciudad = a.Localidad_Original AND p.Estado = a.Provincia_Original)
SET p.IdLocalidad = a.IdLocalidad;

UPDATE sucursales s
INNER JOIN aux_localidades a ON (s.Localidad = a.Localidad_Original AND s.Provincia = a.Provincia_Original)
SET s.IdLocalidad = a.IdLocalidad;

ALTER TABLE clientes DROP Provincia, 
					DROP Localidad;
                    
ALTER TABLE proveedores DROP Ciudad,
						DROP Estado,
                        DROP Pais,
                        DROP Departamento;
                        
ALTER TABLE sucursales DROP Localidad,
						DROP Provincia;
                  

/*Discretización*/

ALTER TABLE clientes ADD Rango_Etario VARCHAR(20) NOT NULL DEFAULT '-' AFTER Edad;

UPDATE clientes SET Rango_Etario = '1_Hasta 30 años' WHERE Edad <= 30;
UPDATE clientes SET Rango_Etario = '2_De 31 a 40 años' WHERE Edad <= 40 AND Rango_Etario = '-';
UPDATE clientes SET Rango_Etario = '3_De 41 a 50 años' WHERE Edad <= 50 AND Rango_Etario = '-';
UPDATE clientes SET Rango_Etario = '4_De 51 a 60 años' WHERE Edad <= 60 AND Rango_Etario = '-';
UPDATE clientes SET Rango_Etario = '5_Desde 60 años' WHERE Edad > 60 AND Rango_Etario = '-';

SELECT Rango_Etario, COUNT(*) FROM clientes GROUP BY Rango_Etario ORDER BY 1;

/*Deteccion y corrección de Outliers sobre ventas*/
/*Motivos:
2-Outlier de Cantidad
3-Outlier de Precio
*/

SELECT IdProducto, AVG(Precio) AS Promedio, AVG(Precio) + (3 * STDDEV(Precio)) AS Maximo
FROM ventas GROUP BY IdProducto ORDER BY 1;

SELECT IdProducto, AVG(Precio) AS Promedio, AVG(Precio) - (3 * STDDEV(Precio)) AS Minimo
FROM ventas GROUP BY IdProducto ORDER BY 1;

SELECT v.*, o.Promedio, o.Minimo, o.Maximo
FROM ventas v
INNER JOIN (
			SELECT IdProducto, AVG(Precio) AS Promedio, AVG(Precio) + (3 * STDDEV(Precio)) AS Maximo,
					AVG(Precio) - (3 * STDDEV(Precio)) AS Minimo
			FROM ventas
            GROUP BY 1) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Precio > o.Maximo OR v.Precio < o.Minimo
ORDER BY v.IdProducto;

SELECT v.*, o.Promedio, o.Minimo, o.Maximo
FROM ventas v
INNER JOIN (
			SELECT IdProducto, AVG(Cantidad) AS Promedio, AVG(Cantidad) + (3 * STDDEV(Cantidad)) AS Maximo,
					AVG(Cantidad) - (3 * STDDEV(Cantidad)) AS Minimo
			FROM ventas
            GROUP BY 1) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.Maximo OR v.Cantidad < o.Minimo
ORDER BY v.IdProducto;

INSERT INTO aux_venta
SELECT v.IdVenta, v.Fecha, v.FechaEntrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, 
		v.Precio, v.Cantidad, 2
FROM ventas v
INNER JOIN(
		SELECT IdProducto, AVG(Cantidad) AS Promedio, AVG(Cantidad) + (3 * STDDEV(Cantidad)) AS Maximo,
				AVG(Cantidad) - (3 * STDDEV(Cantidad)) AS Minimo
		FROM ventas
		GROUP BY 1) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.Maximo OR v.Cantidad < o.Minimo;

INSERT INTO aux_venta
SELECT v.IdVenta, v.Fecha, v.FechaEntrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, 
		v.Precio, v.Cantidad, 3
FROM ventas v
INNER JOIN(
		SELECT IdProducto, AVG(Precio) AS Promedio, AVG(Precio) + (3 * STDDEV(Precio)) AS Maximo,
				AVG(Precio) - (3 * STDDEV(Precio)) AS Minimo
		FROM ventas
		GROUP BY 1) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Precio > o.Maximo OR v.Cantidad < o.Minimo;

SELECT * FROM aux_venta WHERE Motivo = 2;		-- Outliers Cantidad
SELECT * FROM aux_venta WHERE Motivo = 3;		-- Outliers Precio

ALTER TABLE ventas ADD Outlier TINYINT NOT NULL DEFAULT '1' AFTER Cantidad;

UPDATE ventas v INNER JOIN aux_venta a ON (v.IdVenta = a.IdVenta AND a.Motivo IN (2,3))
SET v.Outlier = 0;			-- NO SE PUEDE EJECUTAR POR FALTA DE TIEMPO, ARROJA EL SIGUEINTE ERROR. Error Code: 2013. Lost connection to MySQL server during query

SET SESSION net_read_timeout=600;
SET SESSION net_write_timeout=600;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM ventas WHERE Outlier != 1;

