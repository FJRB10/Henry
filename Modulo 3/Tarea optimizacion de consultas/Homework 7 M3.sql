USE tarea_4;

SELECT 	v.IdVenta,
		ca.Canal,
        cl.NombreCompleto,
        su.Sucursal,
        p.Producto,
        tp.TipoProducto
FROM ventas v
	INNER JOIN canalventas ca
		ON (v.IdCanal = ca.IdCanal)
	INNER JOIN clientes cl
		ON (v.IdCliente = cl.IdCliente)
	INNER JOIN sucursales su
		ON (v.IdSucursal = su.IdSucursal)
	INNER JOIN productos p
		ON (v.IdProducto = p.IdProducto)
	INNER JOIN tipoproducto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto);

-- Sin indices 0.063 sec / 0.671 sec

		
-- Creamos indices de las tablas determinando claves primarias y foraneas

ALTER TABLE ventas ADD PRIMARY KEY(IdVenta);
ALTER TABLE ventas ADD INDEX(Fecha);
ALTER TABLE ventas ADD INDEX(FechaEntrega);
ALTER TABLE ventas ADD INDEX(IdCanal);
ALTER TABLE ventas ADD INDEX(IdCliente);
ALTER TABLE ventas ADD INDEX(IdSucursal);
ALTER TABLE ventas ADD INDEX(IdEmpleado);
ALTER TABLE ventas ADD INDEX(IdProducto);

ALTER TABLE canalventas ADD PRIMARY KEY(IdCanal);

ALTER TABLE clientes ADD PRIMARY KEY(IdCliente);
ALTER TABLE clientes ADD INDEX(IdLocalidad);

ALTER TABLE compras ADD PRIMARY KEY(IdCompra);
ALTER TABLE compras ADD INDEX(Fecha);
ALTER TABLE compras ADD INDEX(IdProducto);
ALTER TABLE compras ADD INDEX(IdProveedor);

ALTER TABLE empleados ADD PRIMARY KEY(IdEmpleado);
ALTER TABLE empleados ADD INDEX(IdSucursal);
ALTER TABLE empleados ADD INDEX(IdSector);
ALTER TABLE empleados ADD INDEX(IdCargo);

ALTER TABLE gastos ADD PRIMARY KEY(IdGasto);
ALTER TABLE gastos ADD INDEX(IdSucursal);
ALTER TABLE gastos ADD INDEX(IdTipoGasto);
ALTER TABLE gastos ADD INDEX(Fecha);

ALTER TABLE localidades ADD INDEX(IdProvincia);

ALTER TABLE productos ADD PRIMARY KEY(IdProducto);
ALTER TABLE productos ADD INDEX(IdTipoProducto);

ALTER TABLE proveedores ADD PRIMARY KEY(IdProveedor);
ALTER TABLE proveedores ADD INDEX(IdLocalidad);

ALTER TABLE sucursales ADD PRIMARY KEY(IdSucursal);
ALTER TABLE sucursales ADD INDEX(IdLocalidad);

ALTER TABLE tipogasto ADD PRIMARY KEY(IdTipoGasto);


-- Creamos las relaciones entre las tablas, y con ellas las restricciones

ALTER TABLE ventas ADD CONSTRAINT ventas_fk_canal FOREIGN KEY(IdCanal) REFERENCES canalventas(IdCanal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE ventas ADD CONSTRAINT ventas_fk_clientes FOREIGN KEY(IdCliente) REFERENCES clientes(IdCliente) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE ventas ADD CONSTRAINT ventas_fk_sucursales FOREIGN KEY(IdSucursal) REFERENCES sucursales(IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE ventas ADD CONSTRAINT ventas_fk_empleados FOREIGN KEY(IdEmpleado) REFERENCES empleados(IdEmpleado) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE ventas ADD CONSTRAINT ventas_fk_productos FOREIGN KEY(IdProducto) REFERENCES productos(IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE clientes ADD CONSTRAINT clientes_fk_localidades FOREIGN KEY(IdLocalidad) REFERENCES localidades(IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE compras ADD CONSTRAINT compras_fk_productos FOREIGN KEY(IdProducto) REFERENCES productos(IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE compras ADD CONSTRAINT compras_fk_proveedores FOREIGN KEY(IdProveedor) REFERENCES proveedores(IdProveedor) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE empleados ADD CONSTRAINT empleados_fk_sucursales FOREIGN KEY(IdSucursal) REFERENCES sucursales(IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE empleados ADD CONSTRAINT empleados_fk_sector FOREIGN KEY(IdSector) REFERENCES sector(IdSector) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE empleados ADD CONSTRAINT empleados_fk_cargo FOREIGN KEY(IdCargo) REFERENCES cargo(IdCargo) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE gastos ADD CONSTRAINT gastos_fk_sucursales FOREIGN KEY(IdSucursal) REFERENCES sucursales(IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE gastos ADD CONSTRAINT gastos_fk_tipogasto FOREIGN KEY(IdTipoGasto) REFERENCES tipogasto(IdTipoGasto) ON DELETE RESTRICT ON UPDATE RESTRICT;


ALTER TABLE localidades ADD CONSTRAINT localidades_fk_provincias FOREIGN KEY(IdProvincia) REFERENCES provincias(IdProvincia) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE productos ADD CONSTRAINT productos_fk_tipoproducto FOREIGN KEY(IdTipoProducto) REFERENCES tipoproducto(IdTipoProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE proveedores ADD CONSTRAINT proveedores_fk_localidades FOREIGN KEY(IdLocalidad) REFERENCES localidades(IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE sucursales ADD CONSTRAINT sucursales_fk_localidades FOREIGN KEY(IdLocalidad) REFERENCES localidades(IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;