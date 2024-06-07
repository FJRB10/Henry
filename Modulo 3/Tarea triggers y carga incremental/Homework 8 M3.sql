USE tarea_4;

/*1. Crear una tabla que permita realizar el seguimiento de los usuarios que ingresan nuevos 
registros en fact_venta.*/

CREATE TABLE ventas_auditoria (
	IdVentaAuditoria			INTEGER NOT NULL AUTO_INCREMENT,
	IdVenta						INT,
	Fecha						DATE,
    IdCliente					INT,
    IdEmpleado					INT,
    IdProducto					INT,
    Precio						DECIMAL(10,2),
    Cantidad					INT,
    Usuario						VARCHAR(80),
    FechaModificacion			DATETIME,
    PRIMARY KEY(IdVentaAuditoria)
);

SELECT NOW();
SELECT CURRENT_USER();

/*2. Crear una acción que permita la carga de datos en la tabla anterior.*/

CREATE TRIGGER aditoria_ventas_registro AFTER INSERT ON ventas
FOR EACH ROW
INSERT INTO ventas_auditoria(
	IdVenta,
    Fecha,
    IdCliente,
    IdEmpleado,
    IdProducto,
    Precio,
    Cantidad,
    Usuario,
    FechaModificacion)
VALUES (NEW.IdVenta, 
    NEW.Fecha,
    NEW.IdCliente,
    NEW.IdEmpleado,
    NEW.IdProducto,
    NEW.Precio,
    NEW.Cantidad,
    CURRENT_USER(),
	NOW());
    
SELECT * FROM ventas ORDER BY IdVenta DESC LIMIT 1;

INSERT INTO ventas
VALUES
('48242', '2020-12-30', '2021-01-02', '2', '226', '31', '31003205', '42810', '1282.82', '2', '1');

SELECT * FROM ventas_auditoria;

/*3. Crear una tabla que permita registrar la cantidad total registros, luego de cada ingreso 
la tabla fact_venta.*/

CREATE TABLE registros_ventas_auditoria(
	IdCantidadRegistros			INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CantidadRegistros			INT,
    Usuario						VARCHAR(80),
    FechaConsultaRegistro		DATETIME
);

/*4. Crear una acción que permita la carga de datos en la tabla anterior.*/

SELECT COUNT(*) FROM ventas;

CREATE TRIGGER auditoria_registros_ventas AFTER INSERT ON ventas
FOR EACH ROW
INSERT INTO registros_ventas_auditoria(CantidadRegistros, Usuario, FechaConsultaRegistro)
VALUES ((SELECT COUNT(*) FROM ventas), CURRENT_USER(), NOW());

INSERT INTO ventas
VALUES
('48243', '2020-12-30', '2021-01-02', '2', '226', '31', '31003205', '42810', '1282.82', '2', '1'),
('48244', '2020-12-30', '2021-01-02', '2', '226', '31', '31003205', '42810', '1282.82', '2', '1');

SELECT * FROM ventas_auditoria;
SELECT * FROM registros_ventas_auditoria;

/*5. Crear una tabla que agrupe los datos de la tabla del item 3, a su vez crear un proceso 
de carga de los datos agrupados.*/

CREATE TABLE registros_tablas(
	Id					INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tabla				VARCHAR(40),
    fecha				DATETIME,
    CantidadRegistros	INT
);

CREATE TRIGGER venta_registros_tablas AFTER INSERT ON registros_ventas_auditoria
FOR EACH ROW
INSERT INTO registros_tablas(tabla, fecha, CantidadRegistros)
VALUES(	'compras', NOW(), (SELECT COUNT(*) FROM compras)),
		('clientes', NOW(), (SELECT COUNT(*) FROM clientes));
        
INSERT INTO ventas
VALUES
('48245', '2020-12-30', '2021-01-02', '2', '226', '31', '31003205', '42810', '1282.82', '2', '1'),
('48246', '2020-12-30', '2021-01-02', '2', '226', '31', '31003205', '42810', '1282.82', '2', '1');

SELECT * FROM ventas_auditoria;
SELECT * FROM registros_ventas_auditoria;
SELECT * FROM registros_tablas;

/*6. Crear una tabla que permita realizar el seguimiento de la actualización de registros de la 
tabla fact_venta.*/

-- DROP TABLE venta_cambios;

CREATE TABLE venta_cambios (
	Fecha				DATE,
    IdCliente			INTEGER,
    IdProducto			INTEGER,
    Precio				DECIMAL(15,3),
    Cantidad			INTEGER,
    IdVenta				INTEGER,
    Usuario				VARCHAR(40),
    FechaUpdate			DATETIME
);

/*7. Crear una acción que permita la carga de datos en la tabla anterior, para su actualización.*/

CREATE TRIGGER auditoria_cambios_venta AFTER UPDATE ON ventas
FOR EACH ROW
INSERT INTO venta_cambios
VALUES (OLD.Fecha, OLD.IdCliente, OLD.IdProducto, OLD.Precio, OLD.Cantidad, NEW.IdVenta, CURRENT_USER(), NOW());

UPDATE ventas SET Cantidad = 2 WHERE IdVenta = 48246;

SELECT IdVenta, Fecha, IdCliente, IdProducto, Precio, Cantidad FROM venta_cambios
UNION ALL
SELECT IdVenta, Fecha, IdCliente, IdProducto, Precio, Cantidad FROM ventas WHERE IdVenta = 48246;

SELECT * FROM venta_cambios;