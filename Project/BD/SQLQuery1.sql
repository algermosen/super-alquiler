--USANDO LA BD
USE GelmoDatabase

--CREANDO TABLA VEHICULOS
CREATE TABLE VEHICULOS(
ID_VEHICULO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
MARCA NVARCHAR(20) NOT NULL,
MODELO NVARCHAR(20) NOT NULL,
A�O INT NOT NULL,
COLOR NVARCHAR(15) NOT NULL,
PRECIO_POR_DIA MONEY NOT NULL,
TIPO NVARCHAR(15) NOT NULL,
CAPACIDAD_DE_CARGA INT NULL,
PASAJEROS INT NOT NULL,
MATRICULA NVARCHAR(30) NOT NULL,
NUMERO_DE_SEGURO NVARCHAR(30) NOT NULL,
FOTO IMAGE NULL,
LATITUD NVARCHAR(20) NOT NULL,
LONGITUD NVARCHAR(20) NOT NULL,
ESTATUS NVARCHAR(13) NOT NULL,
BORRADO BIT NOT NULL
--ESTABLECIENDO CAMPO UNICO
CONSTRAINT MODELO_UNICO UNIQUE(MODELO),
CONSTRAINT NUMERO_DE_SEGURO_UNICO UNIQUE(NUMERO_DE_SEGURO)
)

--CREANDO TABLA CLIENTES
CREATE TABLE CLIENTES(
ID_CLIENTE INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
CEDULA NVARCHAR(11) NOT NULL,
NOMBRES NVARCHAR(30) NOT NULL,
APELLIDOS NVARCHAR(30) NOT NULL,
CORREO NVARCHAR(40) NULL,
LICENCIA NVARCHAR(11) NOT NULL,
NACIONALIDAD NVARCHAR(15) NOT NULL,
TIPO_DE_SANGRE NVARCHAR(3) NOT NULL,
FOTO_CLIENTE IMAGE NULL,
FOTO_CEDULA IMAGE NULL,
ESTATUS BIT NOT NULL,
BORRADO BIT NOT NULL
--ESTABLECIENDO CAMPO UNICO
CONSTRAINT CEDULAS_UNICO UNIQUE(CEDULA)
)

--CREANDO TABLA RESERVAS
CREATE TABLE RESERVAS(
ID_RESERVAS INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
VEHICULO INT NOT NULL,
CLIENTE INT NOT NULL,
FECHA_INICIO DATE,
FECHA_FIN DATE,
BORRADO BIT NOT NULL
--ESTABLECIENDO LLAVES FORANEAS
CONSTRAINT FK_RESERVAS_VEHICULO FOREIGN KEY(VEHICULO) REFERENCES VEHICULOS(ID_VEHICULO),
CONSTRAINT FK_RESERVAS_CLIENTE FOREIGN KEY(CLIENTE) REFERENCES CLIENTES(ID_CLIENTE)
)

--CREANDO TABLA FACTURA
CREATE TABLE FACTURAS(
ID_FACTURA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
RESERVA INT NOT NULL,
MONTO_A_PAGAR MONEY,
PENDIENTE_DE_PAGO MONEY
--ESTABLECIENDO CAMPO UNICO
CONSTRAINT RESERVA_UNICO UNIQUE(RESERVA)
--ESTABLECIENDO LLAVES FORANEAS
CONSTRAINT FK_FACTURAS_RESERVA FOREIGN KEY(RESERVA) REFERENCES RESERVAS(ID_RESERVAS)
)

--VISTAS DE TABLAS
SELECT *FROM VEHICULOS
SELECT *FROM CLIENTES
SELECT *FROM RESERVAS
SELECT *FROM FACTURAS

--SELECT  *FROM FACTURAS JOIN RESERVAS ON FACTURAS.RESERVA = RESERVAS.ID_RESERVAS JOIN VEHICULOS ON RESERVAS.VEHICULO = VEHICULOS.ID_VEHICULO WHERE RESERVAS.ID_RESERVAS = 2 

--ELIMINAR LAS TABLAS
DROP TABLE VEHICULOS
DROP TABLE CLIENTES
DROP TABLE RESERVAS
DROP TABLE FACTURAS

--PROCEDMIENTO INSERTAR VEHICULOS
GO
CREATE PROCEDURE SP_INSERTAR_VEHICULO
@MARCA NVARCHAR(20),
@MODELO NVARCHAR(20),
@A�O INT,
@COLOR NVARCHAR(15),
@PRECIO_POR_DIA MONEY,
@TIPO NVARCHAR(15),
@CAPACIDAD_DE_CARGA INT,
@PASAJEROS INT,
@MATRICULA NVARCHAR(30),
@NUMERO_DE_SEGURO NVARCHAR(30),
@FOTO IMAGE,
@LATITUD NVARCHAR(20),
@LONGITUD NVARCHAR(20),
@ESTATUS BIT,
@BORRADO BIT = 0
AS
INSERT INTO VEHICULOS VALUES (@MARCA,@MODELO,@A�O,@COLOR,@PRECIO_POR_DIA,@TIPO,@CAPACIDAD_DE_CARGA,@PASAJEROS,@MATRICULA,@NUMERO_DE_SEGURO,@FOTO,@LATITUD,@LONGITUD,@ESTATUS,@BORRADO)
PRINT 'VEHICULO AGREGADO'

--PROCEDMIENTO MODIFICAR VEHICULOS
GO
CREATE PROCEDURE SP_MODIFICAR_VEHICULOS
@ID_VEHICULO INT,
@MARCA NVARCHAR(20),
@MODELO NVARCHAR(20),
@A�O INT,
@COLOR NVARCHAR(15),
@PRECIO_POR_DIA MONEY,
@TIPO NVARCHAR(15),
@CAPACIDAD_DE_CARGA INT,
@PASAJEROS INT,
@MATRICULA NVARCHAR(30),
@NUMERO_DE_SEGURO NVARCHAR(30),
@FOTO IMAGE,
@LATITUD NVARCHAR(20),
@LONGITUD NVARCHAR(20),
@ESTATUS BIT,
@BORRADO BIT
AS
UPDATE VEHICULOS SET MARCA=@MARCA,MODELO=@MODELO,A�O=@A�O,COLOR=@COLOR,PRECIO_POR_DIA=@PRECIO_POR_DIA,TIPO=@TIPO,CAPACIDAD_DE_CARGA=@CAPACIDAD_DE_CARGA,PASAJEROS=@PASAJEROS,MATRICULA=@MATRICULA,NUMERO_DE_SEGURO=@NUMERO_DE_SEGURO,FOTO=@FOTO,LATITUD=@LATITUD,LONGITUD=@LONGITUD,ESTATUS=@ESTATUS, BORRADO=@BORRADO WHERE ID_VEHICULO=@ID_VEHICULO
PRINT 'VEHICULO MODIFICADO'

--ELIMINAR VEHICULO
GO
CREATE PROCEDURE SP_ELIMINAR_VEHICULOS
@ID_VEHICULO INT
AS
UPDATE VEHICULOS SET BORRADO =1 WHERE ID_VEHICULO=@ID_VEHICULO
PRINT 'VEHICULO BORRADO'

--PROCEDMIENTO INSERTAR CLIENTES
GO
CREATE PROCEDURE SP_INSERTAR_CLIENTES
@CEDULA NVARCHAR(11),
@NOMBRES NVARCHAR(30),
@APELLIDOS NVARCHAR(30),
@CORREO NVARCHAR(40),
@LICENCIA NVARCHAR(11),
@NACIONALIDAD NVARCHAR(15),
@TIPO_DE_SANGRE NVARCHAR(3),
@FOTO_CLIENTE IMAGE,
@FOTO_CEDULA IMAGE,
@ESTATUS BIT,
@BORRADO BIT = 0
AS
INSERT INTO CLIENTES VALUES (@CEDULA,@NOMBRES,@APELLIDOS,@CORREO,@LICENCIA,@NACIONALIDAD,@TIPO_DE_SANGRE,@FOTO_CLIENTE,@FOTO_CEDULA,@ESTATUS,@BORRADO)
PRINT 'CLIENTE AGREGADO'

--PROCEDMIENTO MODIFICAR CLIENTES
GO
CREATE PROCEDURE SP_MODIFICAR_CLIENTES
@ID_CLIENTE INT,
@CEDULA NVARCHAR(11),
@NOMBRES NVARCHAR(30),
@APELLIDOS NVARCHAR(30),
@CORREO NVARCHAR(40),
@LICENCIA NVARCHAR(11),
@NACIONALIDAD NVARCHAR(15),
@TIPO_DE_SANGRE NVARCHAR(3),
@FOTO_CLIENTE IMAGE,
@FOTO_CEDULA IMAGE,
@ESTATUS BIT,
@BORRADO BIT = 0
AS
UPDATE CLIENTES SET CEDULA=@CEDULA,NOMBRES=@NOMBRES,APELLIDOS=@APELLIDOS,CORREO=@CORREO,LICENCIA=@LICENCIA,NACIONALIDAD=@NACIONALIDAD,TIPO_DE_SANGRE=@TIPO_DE_SANGRE,FOTO_CLIENTE=@FOTO_CLIENTE,FOTO_CEDULA=@FOTO_CEDULA,ESTATUS=@ESTATUS, BORRADO=@BORRADO WHERE ID_CLIENTE=@ID_CLIENTE
PRINT 'CLIENTE MODIFICADO'

--ELIMINAR CLIENTE
GO
CREATE PROCEDURE SP_ELIMINAR_CLIENTE
@ID_CLIENTE INT
AS
UPDATE CLIENTES SET BORRADO =1 WHERE ID_CLIENTE=@ID_CLIENTE
PRINT 'CLIENTE BORRADO'

--PROCEDMIENTO INSERTAR RESERVA
GO
CREATE PROCEDURE SP_INSERTAR_RESERVA
@VEHICULO INT,
@CLIENTE INT,
@FECHA_INICIO DATE,
@FECHA_FIN DATE,
@BORRADO BIT = 0
AS
IF NOT EXISTS (SELECT VEHICULO FROM RESERVAS WHERE VEHICULO=@VEHICULO AND @FECHA_INICIO BETWEEN FECHA_INICIO AND FECHA_FIN OR VEHICULO=@VEHICULO AND @FECHA_FIN BETWEEN FECHA_INICIO AND FECHA_FIN)
BEGIN
INSERT INTO RESERVAS VALUES (@VEHICULO,@CLIENTE,@FECHA_INICIO,@FECHA_FIN,@BORRADO)
PRINT 'RESERVACION DEL VEHICULO REALIZADA'
END
ELSE
PRINT 'EL VEHICULO NO SE PUEDE RESERVAR PORQUE YA ESTA RESERVADO EN ESTA FECHA'

--ELIMINAR CLIENTE
GO
CREATE PROCEDURE SP_ELIMINAR_CLIENTE
@ID_CLIENTE INT
AS
UPDATE CLIENTES SET BORRADO =1 WHERE ID_CLIENTE=@ID_CLIENTE
PRINT 'CLIENTE BORRADO'

--PROCEDMIENTO INSERTAR FACTURA
GO
CREATE PROCEDURE SP_INSERTAR_FACTURA
@RESERVA INT,
@MONTO_A_PAGAR MONEY
AS
INSERT INTO FACTURAS VALUES (@RESERVA,@MONTO_A_PAGAR,@MONTO_A_PAGAR) 
PRINT 'FACTURA CREADA'

--PROCEDIMIENTO PAGO DE FACTURA
GO
CREATE PROCEDURE SP_PAGAR_FACTURA
@ID_FACTURA INT,
@MONTO_A_PAGAR MONEY
AS
UPDATE FACTURAS SET PENDIENTE_DE_PAGO = PENDIENTE_DE_PAGO-@MONTO_A_PAGAR WHERE ID_FACTURA = @ID_FACTURA
PRINT 'PAGO DE FACTURA REALIZADO'

--EJECUTAR PROCEDIMIENTOS ALMACENADOS
EXEC SP_INSERTAR_VEHICULO 'HIYUNDAI','SONATA',1977,'AMRILLO',1283,'CAMIONETA',55478,4,'4655312','56451351','56465453','521531321','51512312',1
EXEC SP_MODIFICAR_VEHICULOS 1,'TOYOTA','COROLA',1977,'AMRILLO',1283,'CAMIONETA',55478,4,'4655312','56451351','56465453','521531321','51512312',0
EXEC SP_ELIMINAR_VEHICULOS 1
EXEC SP_INSERTAR_CLIENTES '40225359641','LUIS ALFREDO','PASCUAL POLANCO','LUISALFREDO.LAPP.LAPP@GMAIL.COM','SI','DOMINICANO','B+','6451368','6545456',1
EXEC SP_MODIFICAR_CLIENTES 1,'40225359641','LUIS ALFREDO','PASCUAL POLANCO','LUISALFREDO.LAPP.LAPP@GMAIL.COM','SI','DOMINICANO','B+','6451368','6545456',0
EXEC SP_INSERTAR_RESERVA 1,1,'2021-08-10','2021-09-10'
EXEC SP_INSERTAR_FACTURA 1,5048
EXEC SP_PAGAR_FACTURA 1, 2000

--ELIMINAR PROCEDIMIENTOS ALMACENADOS
DROP PROCEDURE SP_INSERTAR_VEHICULO
DROP PROCEDURE SP_MODIFICAR_VEHICULOS
DROP PROCEDURE SP_INSERTAR_CLIENTES
DROP PROCEDURE SP_MODIFICAR_CLIENTES
DROP PROCEDURE SP_INSERTAR_RESERVA
DROP PROCEDURE SP_INSERTAR_FACTURA
DROP PROCEDURE SP_PAGAR_FACTURA

