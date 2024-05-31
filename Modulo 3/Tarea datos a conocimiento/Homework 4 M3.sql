-- CREATE DATABASE Tarea_4;
USE Tarea_4;

SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- SHOW VARIABLES LIKE 'secure_file_priv';

/*SUCURSALES*/

-- DROP TABLE sucursales;

CREATE TABLE sucursales (
ID 			INTEGER,
Sucursal 	VARCHAR(20),
Dirección 	VARCHAR(150),
Localidad 	VARCHAR(30),
Provincia 	VARCHAR(30),
Latitud 	VARCHAR(50),
Longitud 	VARCHAR(50)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;
                        
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Sucursales.csv"
INTO TABLE sucursales
CHARSET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM sucursales;

/*EMPLEADOS*/

-- DROP TABLE empleados;

CREATE TABLE empleados(
IDEmpleado		INTEGER,
Apellido		VARCHAR(50),
Nombre			VARCHAR(50),
Sucursal		VARCHAR(50),
Sector			VARCHAR(50),
Cargo			VARCHAR(50),
Salario			VARCHAR(30)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Empleados.csv"
INTO TABLE empleados
CHARSET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM empleados;

/*PROVEEDORES*/

-- DROP TABLE proveedores;

CREATE TABLE proveedores(
IDProveedor		INTEGER,
Nombre			VARCHAR(50),
Direccion		VARCHAR(50),
Ciudad			VARCHAR(50),
Estado			VARCHAR(50),
Pais			VARCHAR(50),
Departamento	VARCHAR(50)			
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Proveedores.csv"
INTO TABLE proveedores
CHARSET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM proveedores;

/*CLIENTES*/

-- DROP TABLE clientes;

CREATE TABLE clientes(
ID							INTEGER,
Provincia					VARCHAR(50),
NombreCompleto				VARCHAR(100),
Direccion					VARCHAR(150),
Telefono					VARCHAR(30),
Edad						TINYINT,
Localidad					VARCHAR(100),
X							VARCHAR(20),
Y							VARCHAR(20),
FechaAlta					DATE NOT NULL,
UsuarioAlta					VARCHAR(20),
FechaUltimaModificacion		DATE NOT NULL,
UsuarioUltimaModifcacion	VARCHAR(20),
MarcaBaja					TINYINT,
Col10						VARCHAR(1)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Clientes2.csv"
INTO TABLE clientes
CHARSET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/*PRODUCTOS*/

DROP TABLE productos;

CREATE TABLE productos(
IDProducto		INTEGER,
Concepto		VARCHAR(100),
Tipo			VARCHAR(30),
Precio			VARCHAR(20)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\PRODUCTOS.csv"
INTO TABLE productos
CHARSET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


/*VENTAS*/

-- DROP TABLE ventas;

CREATE TABLE ventas(
IdVenta			INTEGER,
Fecha			DATE,
FechaEntrega	DATE,
IdCanal			INTEGER,
IdCliente		INTEGER,
IdSucursal		INTEGER,
IdEmpleado		INTEGER,
IdProducto		INTEGER,
Precio			VARCHAR(20),
Cantidad		VARCHAR(10)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Venta.csv"
INTO TABLE ventas
CHARSET latin1
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/*GASTOS*/

-- DROP TABLE gastos;

CREATE TABLE gastos(
IdGasto			INTEGER,
IdSucursal		INTEGER,
IdTipoGasto		INTEGER,
Fecha			DATE,
Monto			VARCHAR(20)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Gasto.csv"
INTO TABLE gastos
CHARSET latin1
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/*COMPRAS*/

-- DROP TABLE compras;

CREATE TABLE compras(
IdCompra		INTEGER,
Fecha			DATE,
IdProducto		INTEGER,
Cantidad		TINYINT,
Precio			VARCHAR(20),
IdProveedor		INTEGER	
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\Compra.csv"
INTO TABLE compras
CHARSET latin1
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/*CANAL DE VENTA*/

-- DROP TABLE canalventa;

CREATE TABLE canalventas(
IdCanal			INTEGER,
Canal			VARCHAR(20)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\CanalDeVenta.csv"
INTO TABLE canalventas
CHARSET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/*TIPO DE GASTO*/

-- DROP TABLE tipogasto;

CREATE TABLE tipogasto(
IdTipoGasto			INTEGER,
Descripcion			VARCHAR(20),
MontoAproxiamdo		DECIMAL(10,2)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.4\\Uploads\\TiposDeGasto.csv"
INTO TABLE tipogasto
CHARSET latin1
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;