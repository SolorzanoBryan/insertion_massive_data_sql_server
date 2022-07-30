CREATE DATABASE jardineria;
USE jardineria;

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) DEFAULT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
);

CREATE TABLE gama_producto (
  gama VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256),
  PRIMARY KEY (gama)
);

CREATE TABLE cliente (
  codigo_cliente INTEGER NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30) DEFAULT NULL,
  apellido_contacto VARCHAR(30) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  pais VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) DEFAULT NULL,
  codigo_empleado_rep_ventas INTEGER DEFAULT NULL,
  limite_credito NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_cliente),
  FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado (codigo_empleado)
);

CREATE TABLE pedido (
  codigo_pedido INT NOT NULL,
  fecha_pedido date NOT NULL,
  fecha_esperada date NOT NULL,
  fecha_entrega date DEFAULT NULL,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT,
  codigo_cliente INTEGER NOT NULL,
  PRIMARY KEY (codigo_pedido),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);
CREATE TABLE producto (
  codigo_producto VARCHAR(15) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  gama VARCHAR(50) NOT NULL,
  dimensiones VARCHAR(25) NULL,
  proveedor VARCHAR(50) DEFAULT NULL,
  descripcion text NULL,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_producto),
  FOREIGN KEY (gama) REFERENCES gama_producto (gama)
);

CREATE TABLE detalle_pedido (
  codigo_pedido INTEGER NOT NULL,
  codigo_producto VARCHAR(15) NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unidad NUMERIC(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido),
  FOREIGN KEY (codigo_producto) REFERENCES producto (codigo_producto)
);

CREATE TABLE pago (
  codigo_cliente INTEGER NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago date NOT NULL,
  total NUMERIC(15,2) NOT NULL,
  PRIMARY KEY (codigo_cliente, id_transaccion),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);

USE jardineria
--Ingresar Datos en Oficina
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=2000000)
 BEGIN
INSERT INTO oficina ([codigo_oficina]
           ,[ciudad]
           ,[pais]
           ,[region]
           ,[codigo_postal]
           ,[telefono]
           ,[linea_direccion1]
           ,[linea_direccion2]) 
VALUES     ('Codigo'+convert(varchar(40),@cont)
           ,'Ciudad'
           ,'Pais'
           ,'Región'
           ,'Codigo'
           ,'Teléfono'
           ,'Linea Dirección 1'
           ,'Linea Dirección 2');
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
--Ingresar datos en Empleado
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=500000)
 BEGIN
INSERT INTO [dbo].[empleado]
           ([codigo_empleado]
           ,[nombre]
           ,[apellido1]
           ,[apellido2]
           ,[extension]
           ,[email]
           ,[codigo_oficina])
     VALUES
           (@cont
           ,'Empleado'
           ,'Apellido 1'
           ,'Apellido 2'
           ,'Extension'
           ,'email@email.com'
           ,'Codigo'+convert(varchar(40),@cont));
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
--Ingreso de datos en la tabla gama producto
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=2000000)
 BEGIN
INSERT INTO [dbo].[gama_producto]
           ([gama]
           ,[descripcion_texto]
           ,[descripcion_html]
           ,[imagen])
     VALUES
           ('Gama'+convert(varchar(50),@cont)
           ,'Descripcion Texto'
           ,'Descripcion HTML'
           ,'Imagen');
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
--Ingresar datos en cliente
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=2000000)
 BEGIN
INSERT INTO [dbo].[cliente]
           ([codigo_cliente]
           ,[nombre_cliente]
           ,[nombre_contacto]
           ,[apellido_contacto]
           ,[telefono]
           ,[fax]
           ,[linea_direccion1]
           ,[linea_direccion2]
           ,[ciudad]
           ,[region]
           ,[pais]
           ,[codigo_postal]
           ,[codigo_empleado_rep_ventas]
           ,[limite_credito])
     VALUES
           (@cont
           ,'Nombre Cliente'
           ,'Nombre Contacto'
           ,'Apellido Contacto'
           ,'000225555'
           ,'1213245654'
           ,'Dirección Línea 1'
           ,'Dirección Línea 2'
           ,'Ciudad'
           ,'Region'
           ,'País'
           ,'CodigoP'
           ,@cont
           ,3000);
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
--Ingresar datos en la tabla pedido
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=15)
 BEGIN
INSERT INTO [dbo].[pedido]
           ([codigo_pedido]
           ,[fecha_pedido]
           ,[fecha_esperada]
           ,[fecha_entrega]
           ,[estado]
           ,[comentarios]
           ,[codigo_cliente])
     VALUES
           (@cont
           ,'2022-07-21'
           ,'2022-08-01'
           ,'2022-08-01'
           ,'Entregado'
           ,'Comentarios'
           ,@cont);
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
--Ingreso de datos en la tabla producto
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=15)
 BEGIN
INSERT INTO [dbo].[producto]
           ([codigo_producto]
           ,[nombre]
           ,[gama]
           ,[dimensiones]
           ,[proveedor]
           ,[descripcion]
           ,[cantidad_en_stock]
           ,[precio_venta]
           ,[precio_proveedor])
     VALUES
           ('Id Producto'+convert(varchar(50),@cont)
           ,'Producto'
           ,'Gama'+convert(varchar(50),@cont)
           ,'35-45'
           ,'Proveedor'
           ,'Descripcion'
           ,120
           ,5
           ,4);
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
--Ingreso de datos en detalle_pedido
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=15)
 BEGIN
INSERT INTO [dbo].[detalle_pedido]
           ([codigo_pedido]
           ,[codigo_producto]
           ,[cantidad]
           ,[precio_unidad]
           ,[numero_linea])
     VALUES
           (@cont
           ,'Id Producto'+convert(varchar(50),@cont)
           ,10
           ,70
           ,3);
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO

--Ingreso de datos en la tabla pago
DECLARE @cont INT;
SET @cont=1;
BEGIN TRANSACTION
 WHILE(@cont<=15)
 BEGIN
INSERT INTO [dbo].[pago]
           ([codigo_cliente]
           ,[forma_pago]
           ,[id_transaccion]
           ,[fecha_pago]
           ,[total])
     VALUES
           (@cont
           ,'Efectivo'
           ,'ak-std-0000'++convert(varchar(50),@cont)
           ,'2022-07-21'
           ,2000);
SET @cont = @cont + 1;
END
IF(@@ERROR > 0)
BEGIN
 ROLLBACK TRANSACTION
END
ELSE
BEGIN
 COMMIT TRANSACTION
END
GO
