USE tarea_4;

-- SET SQL_SAFE_UPDATES = 0;


-- CLIENTES

ALTER TABLE clientes CHANGE Id IdCliente INT NOT NULL;
ALTER TABLE clientes ADD Latitud DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER Y,
					 ADD Longitud DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER Latitud;

UPDATE clientes SET X = 0 WHERE X = '';
UPDATE clientes SET Y = 0 WHERE Y = '';

SELECT * FROM clientes WHERE Y = '';
SELECT * FROM clientes;

UPDATE clientes SET Latitud = REPLACE(Y,',','.');
UPDATE clientes SET Longitud = REPLACE(X,',','.');

ALTER TABLE clientes DROP Y;
ALTER TABLE clientes DROP X;
ALTER TABLE clientes DROP Col10;


-- COMPRAS

SELECT * FROM compras;

ALTER TABLE compras ADD Precio2 DECIMAL(10,2) DEFAULT '0' NOT NULL AFTER Precio;
UPDATE compras SET Precio2 = REPLACE(Precio,',','.');
ALTER TABLE compras DROP Precio;
ALTER TABLE compras CHANGE Precio2 Precio DECIMAL(10,2) NOT NULL;


-- EMPLEADOS

SELECT * FROM empleados;

ALTER TABLE empleados CHANGE IDEmpleado IdEmpleado INT NOT NULL;

ALTER TABLE empleados ADD Salario2 DECIMAL(10,2) NOT NULL DEFAULT '0' AFTER Salario;
UPDATE empleados SET Salario2 = REPLACE(Salario,',','.');
ALTER TABLE empleados DROP Salario;
ALTER TABLE empleados CHANGE Salario2 Salario DECIMAL(10,2) NOT NULL;


-- GASTOS

SELECT * FROM gastos;

ALTER TABLE gastos ADD Monto2 DECIMAL(10,2) DEFAULT '0' NOT NULL;
UPDATE gastos SET Monto2 = REPLACE(Monto,',','.');
ALTER TABLE gastos DROP Monto;
ALTER TABLE gastos CHANGE Monto2 Monto DECIMAL(10,2) NOT NULL;


-- PRODUCTOS

SELECT * FROM productos;

ALTER TABLE productos CHANGE IDProducto IdProducto INT NOT NULL;
ALTER TABLE productos CHANGE Concepto Producto VARCHAR(100);
ALTER TABLE productos ADD Precio2 DECIMAL(10,2) DEFAULT '0' NOT NULL AFTER Precio;
ALTER TABLE productos CHANGE Precio2 Precio2 DECIMAL(15,2) DEFAULT '0' NOT NULL;
UPDATE productos SET Precio2 = REPLACE(Precio,',','.');
ALTER TABLE productos DROP Precio;
ALTER TABLE productos CHANGE Precio2 Precio DECIMAL(15,2) DEFAULT '0' NOT NULL;


-- PROVEEDORES

SELECT * FROM proveedores;

ALTER TABLE proveedores CHANGE IDProveedor IdProveedor INT NOT NULL;


-- SUCURSALES

SELECT * FROM sucursales;

ALTER TABLE sucursales CHANGE ID IdSucursal INT NOT NULL;
ALTER TABLE sucursales CHANGE Dirección Direccion VARCHAR(150) NOT NULL;
ALTER TABLE sucursales ADD Latitud2 DECIMAL(13,10) DEFAULT '0' NOT NULL,
						ADD Longitud2 DECIMAL(13,10) DEFAULT '0' NOT NULL;
                        
UPDATE sucursales SET Latitud2 = REPLACE(Latitud,',','.');
UPDATE sucursales SET Longitud2 = REPLACE(Longitud,',','.');
ALTER TABLE sucursales DROP Latitud, DROP Longitud;
ALTER TABLE sucursales CHANGE Latitud2 Latitud DECIMAL(13,10) NOT NULL,
						CHANGE Longitud2 Longitud DECIMAL(13,10) NOT NULL;
                        

-- TIPO GASTO

ALTER TABLE tipogasto CHANGE Descripcion TipoGasto VARCHAR (20) NOT NULL;


-- VENTAS

SELECT * FROM ventas;
SELECT * FROM ventas WHERE Cantidad = 0;

-- UPDATE ventas SET Cantidad = 0 WHERE Cantidad = '\r';

ALTER TABLE ventas ADD Precio2 DECIMAL(10,2) DEFAULT '0' NOT NULL AFTER Precio,
					ADD Cantidad2 TINYINT DEFAULT '0' NOT NULL AFTER Cantidad;
                    
ALTER TABLE ventas CHANGE Cantidad2 Cantidad2 INT DEFAULT 0 NOT NULL;
                    
UPDATE ventas SET Precio = '0' WHERE Precio = '';
UPDATE ventas SET Precio2 = REPLACE(Precio,',','.');
UPDATE ventas SET Cantidad2 = REPLACE(Cantidad,',','.'); -- ERROR

ALTER TABLE ventas DROP Precio;
ALTER TABLE ventas DROP Cantidad;
ALTER TABLE ventas CHANGE Precio2 Precio DECIMAL(10,2) NOT NULL;
ALTER TABLE ventas CHANGE Cantidad2 Cantidad INT NOT NULL;


/*IMPUTACIÓN DE VALORES FALTANTES*/

SELECT * FROM clientes;

UPDATE clientes SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = '' OR ISNULL(Provincia);
UPDATE clientes SET NombreCompleto = 'Sin Dato' WHERE TRIM(NombreCompleto) = '' OR ISNULL(NombreCompleto);
UPDATE clientes SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = '' OR ISNULL(Direccion);
UPDATE clientes SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = '' OR ISNULL(Localidad);
UPDATE clientes SET UsuarioAlta = 'Sin Dato' WHERE TRIM(UsuarioAlta) = '' OR ISNULL(UsuarioAlta);
UPDATE clientes SET UsuarioUltimaModifcacion = 'Sin Dato' WHERE TRIM(UsuarioUltimaModifcacion) = '' OR ISNULL(UsuarioUltimaModifcacion);

SELECT * FROM empleados;

UPDATE empleados SET Apellido = 'Sin Dato' WHERE TRIM(Apellido) = '' OR ISNULL(Apellido);
UPDATE empleados SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = '' OR ISNULL(Nombre);
UPDATE empleados SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = '' OR ISNULL(Sucursal);
UPDATE empleados SET Sector = 'Sin Dato' WHERE TRIM(Sector) = '' OR ISNULL(Sector);
UPDATE empleados SET Cargo = 'Sin Dato' WHERE TRIM(Cargo) = '' OR ISNULL(Cargo);

SELECT * FROM productos;

UPDATE productos SET Producto = 'Sin Dato' WHERE TRIM(Producto) = '' OR ISNULL(Producto);
UPDATE productos SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = '' OR ISNULL(Tipo);

SELECT * FROM proveedores;

UPDATE proveedores SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = '' OR ISNULL(Nombre);
UPDATE proveedores SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = '' OR ISNULL(Direccion);
UPDATE proveedores SET Ciudad = 'Sin Dato' WHERE TRIM(Ciudad) = '' OR ISNULL(Ciudad);
UPDATE proveedores SET Estado = 'Sin Dato' WHERE TRIM(Estado) = '' OR ISNULL(Estado);
UPDATE proveedores SET Pais = 'Sin Dato' WHERE TRIM(Pais) = '' OR ISNULL(Pais);
UPDATE proveedores SET Departamento = 'Sin Dato' WHERE TRIM(Departamento) = '' OR ISNULL(Departamento);

SELECT * FROM sucursales;

UPDATE sucursales SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = '' OR ISNULL(Sucursal);
UPDATE sucursales SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = '' OR ISNULL(Direccion);
UPDATE sucursales SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = '' OR ISNULL(Localidad);
UPDATE sucursales SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = '' OR ISNULL(Provincia);


/*Normalizacion a Letra Capital*/

SELECT * FROM clientes;

UPDATE clientes SET NombreCompleto = UC_Words(TRIM(NombreCompleto)),
					Direccion = UC_Words(TRIM(Direccion)),
                    Localidad = UC_Words(TRIM(Localidad));
                    
SELECT * FROM productos;

UPDATE productos SET 	Producto = UC_Words(TRIM(Producto)),
						Tipo = UC_Words(TRIM(Tipo));
                        
SELECT * FROM proveedores;

UPDATE proveedores SET	Direccion = UC_Words(TRIM(Direccion)),
						Ciudad = UC_Words(TRIM(Ciudad)),
                        Estado = UC_Words(TRIM(Estado)),
                        Pais = UC_Words(TRIM(Pais)),
                        Departamento = UC_Words(TRIM(Departamento));


/*Tabla ventas limpieza y normalizacion*/

SELECT * FROM ventas;

SELECT * FROM ventas WHERE Cantidad IS NULL;

UPDATE ventas v 
INNER JOIN productos p 
	ON (v.IdProducto = p.IdProducto)
SET v.Precio = p.Precio
WHERE v.Precio = 0;


/*Tabla auxiliar donde se guardarán registros con problemas:
1-Cantidad en Cero
*/

CREATE TABLE aux_venta(
IdVenta			INTEGER,
Fecha			DATE NOT NULL,
FechaEntrega	DATE NOT NULL,
IdCliente		INTEGER,
IdSucursal		INTEGER,
IdEmpleado		INTEGER,
IdProducto		INTEGER,
Precio			FLOAT,
Cantidad		INTEGER,
Motivo			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO aux_venta(IdVenta, Fecha, FechaEntrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, FechaEntrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM ventas WHERE Cantidad = 0;

UPDATE ventas SET Cantidad = 1 WHERE Cantidad = 0;

/*Chequeo de claves duplicadas*/

SELECT * FROM clientes;
SELECT * FROM compras;
SELECT * FROM empleados;
SELECT * FROM gastos;
SELECT * FROM productos;
SELECT * FROM proveedores;
SELECT * FROM sucursales;
SELECT * FROM ventas;

SELECT IdCliente, COUNT(*) AS Cantidad FROM clientes GROUP BY IdCliente HAVING Cantidad > 1;
SELECT IdCompra, COUNT(*) AS Cantidad FROM compras GROUP BY IdCompra HAVING Cantidad > 1;
SELECT IdEmpleado, COUNT(*) AS Cantidad FROM empleados GROUP BY IdEmpleado HAVING Cantidad > 1;		-- Si hay
SELECT IdGasto, COUNT(*) AS Cantidad FROM gastos GROUP BY Idgasto HAVING Cantidad > 1;
SELECT IdProducto, COUNT(*) AS Cantidad FROM productos GROUP BY IdProducto HAVING Cantidad > 1;
SELECT IdProveedor, COUNT(*) AS Cantidad FROM proveedores GROUP BY IdProveedor HAVING Cantidad > 1;
SELECT IdSucursal, COUNT(*) AS Cantidad FROM sucursales GROUP BY IdSucursal HAVING Cantidad > 1;
SELECT IdVenta, COUNT(*) AS Cantidad FROM ventas GROUP BY IdVenta HAVING Cantidad > 1;

SELECT DISTINCT Sucursal FROM sucursales;

SELECT DISTINCT Sucursal FROM empleados WHERE Sucursal NOT IN (SELECT DISTINCT Sucursal FROM sucursales);		-- Revisar después porque todavía hay dos que no son diferentes en la tabla de sucursales.

UPDATE sucursales SET Sucursal = 'Córdoba Centro' WHERE Sucursal = 'CÃ³rdoba Centro';
UPDATE sucursales SET Sucursal = 'Cordoba Quiroz' WHERE Sucursal = 'CÃ³rdoba Quiroz';

UPDATE empleados SET Sucursal = 'Mendoza1' WHERE Sucursal = 'Mendoza 1';
UPDATE empleados SET Sucursal = 'Mendoza2' WHERE Sucursal = 'Mendoza 2';

ALTER TABLE empleados ADD IdSucursal INTEGER DEFAULT 0 NOT NULL AFTER Sucursal;

UPDATE empleados e INNER JOIN sucursales s ON (e.Sucursal = s.Sucursal)
SET e.IdSucursal = s.IdSucursal;

SELECT * FROM empleados;

ALTER TABLE empleados DROP sucursal;

ALTER TABLE empleados ADD CodigoEmpleado INT NOT NULL DEFAULT 0 AFTER IdEmpleado;
UPDATE empleados SET CodigoEmpleado = IdEmpleado;
UPDATE empleados SET IdEmpleado = (IdSucursal * 1000000) + CodigoEmpleado;

SELECT * FROM ventas;

UPDATE ventas SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;


/*Normalizacion tabla empleado*/
SELECT * FROM empleados;

CREATE TABLE cargo(
IdCargo			INTEGER NOT NULL AUTO_INCREMENT,
Cargo			VARCHAR(50) NOT NULL,
PRIMARY KEY(IdCargo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE sector(
IdSector		INTEGER NOT NULL AUTO_INCREMENT,
Sector			VARCHAR(50) NOT NULL,
PRIMARY KEY(IdSector)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT DISTINCT Cargo FROM empleados ORDER BY Cargo;

INSERT INTO cargo (Cargo) SELECT DISTINCT Cargo FROM empleados ORDER BY Cargo;

SELECT * FROM cargo;

SELECT DISTINCT Sector FROM empleados ORDER BY Sector;

INSERT INTO sector (Sector) SELECT DISTINCT Sector FROM empleados ORDER BY Sector;

SELECT * FROM sector;

ALTER TABLE empleados 	ADD IdSector INTEGER NOT NULL DEFAULT 0 AFTER IdSucursal,
						ADD IdCargo INTEGER NOT NULL DEFAULT 0 AFTER IdSector;
                        
UPDATE empleados e INNER JOIN sector s ON (e.Sector = s.Sector) SET e.IdSector = s.IdSector;
UPDATE empleados e INNER JOIN cargo c ON (e.Cargo = c.Cargo) SET e.IdCargo = c.IdCargo;

ALTER TABLE empleados 	DROP sector,
						DROP Cargo;
                        
/*Normalización tabla producto*/

SELECT * FROM productos;

CREATE TABLE tipoproducto(
IdTipoProducto			INTEGER NOT NULL AUTO_INCREMENT,
TipoProducto			VARCHAR(50) NOT NULL,
PRIMARY KEY(IdTipoProducto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT * FROM productos;

INSERT INTO tipoproducto (TipoProducto) SELECT DISTINCT Tipo FROM productos ORDER BY Tipo;

SELECT * FROM tipoproducto;

ALTER TABLE productos ADD IdTipoProducto INTEGER NOT NULL DEFAULT 0 AFTER Precio;

UPDATE productos p INNER JOIN tipoproducto t ON (p.Tipo = t.TipoProducto) SET p.IdTipoProducto = t.IdTipoProducto;

ALTER TABLE productos DROP Tipo;