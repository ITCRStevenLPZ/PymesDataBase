CREATE TABLE Categoria( --Fuerte
	Nombre varchar(80) not null unique, --Nombre de la categoria
	Descripcion varchar(150) default 'No se especifico', --Descripcion OPCIONAL de la categoria
	PRIMARY KEY (Nombre)
);
CREATE TABLE Cliente ( --Fuerte
	Cedula           int not null unique, --Cedula OBLIGATORIA
    Nombre           varchar(80) not null, -- Nombre OBLIGATORIO
	Telefono_1       int not null check (Telefono_1 between 10000000 and 99999999), -- 1 numero de telefono OBLIGATORIO 
	Telefono_2   	 int check (Telefono_1 between 10000000 and 99999999), --Telefono 2 OPCIONAL
	Direccion 		 varchar(150) --Direccion del cliente OPCIONAL
);
CREATE TABLE Persona(
    Apellido_1       varchar(80) not null, -- Apellido 1 OBLIGATORIO
    Apellido_2       varchar(80) not null,-- Apellido 2 OBLIGATORIO
	PRIMARY KEY (Cedula)
)INHERITS(Cliente);
CREATE TABLE Empresa(
	Descripcion 	varchar(150),
	PRIMARY KEY (Cedula)
)INHERITS(Cliente);

CREATE TABLE Marca(
	Categoria varchar(80) not null, --Cataegoria a la cual pertenece
	Nombre varchar(80) not null, --Nombre de la marca
	Descripcion varchar(150) default 'No se especifico', --Muestra una breve descripcion de la Marca
	CONSTRAINT MarcaPrimary PRIMARY KEY (Categoria, Nombre),
	CONSTRAINT FK_MarcaCategoria FOREIGN KEY (Categoria)
    REFERENCES Categoria(Nombre)
);
CREATE TABLE Producto (
	Cantidad   int not null default 0, --Cantidad de unidades que hay de un producto
	Marca	   varchar(80) not null, -- Marca del producto OBLIGATORIO
	Categoria  varchar(80) not null, -- Categoria del producto OBLIGATORIO
	Modelo 	   varchar(100) not null, -- Marca del producto OBLIGATORIO
    Descripcion varchar(150) default 'No se especifico', -- Tipo de producto dentro de categoria 2 OPCIONAL
    Nombre     varchar(100) not null, -- Nombre de Producto 2 OBLIGATORIO
	Precio_Colones  float not null , -- Precio en colones sin I.V.A
	CONSTRAINT FK_ProductoMarca FOREIGN KEY (Marca,Categoria)
    REFERENCES Marca(Nombre,Categoria),
	PRIMARY KEY (Modelo)
);
CREATE TABLE Producto_Unidad (
	Apartado boolean default false, --booleano que indica si esta apartado o no
	Vendido   boolean default false, --booleano que indica si se vendio o no
	N_Serial   int not null, --numero de serial del producto
    Fecha_Ingreso    date,-- Fecha en la cual se ingreso el producto OPCIONAL
    Modelo_Producto varchar(100) not null,
	CONSTRAINT FK_ProductoUnidad FOREIGN KEY(Modelo_Producto)
    REFERENCES Producto(Modelo),
	PRIMARY KEY (N_Serial)
);
CREATE TABLE Factura (
	Fecha_Compra DATE not null, --fecha en la cual se realizao la compra del o los productos
	Hora_Compra TIME not null, --tiempo en la cual se realizo la compra
	Cedula_Cliente int not null, --cedula de la empresa o de la persona
	IVA float not null default 13.0, --impuestos de ventas
	Descuento_Colones float not null default 0.0, --descuento que se le hace al cliente en colones
	Total_Cobrado float not null, --este valor es calculado con la venta, el IVA y el descuento
	N_Factura int not null, --este valor es el id de la factura
	CONSTRAINT FK_FacturaCliente FOREIGN KEY (Cedula_Cliente)
    REFERENCES Cliente(Cedula),
	PRIMARY KEY (N_Factura)
);
CREATE TABLE Venta (
	Numero_Factura int not null,
	Serial_Producto int not null,
	CONSTRAINT FK_VentaFactura FOREIGN KEY (Numero_Factura)
    REFERENCES Factura(N_Factura),
    CONSTRAINT FK_VentaProductoUnidad FOREIGN KEY (Serial_Producto)
    REFERENCES Producto_Unidad(N_Serial)
);

-- INSERTIONS DE PRUEBA --
INSERT INTO Persona(Nombre, Apellido_1, Apellido_2, Cedula, Telefono_1, Telefono_2, Direccion)
VALUES('Ronald','Fran','Lopez',208020900,86314653,24436213,'Canoas, Alajuela, Costa Rica');
INSERT INTO Persona(Nombre, Apellido_1, Apellido_2, Cedula, Telefono_1, Telefono_2, Direccion)
VALUES('Ronald','Esquivel','Jimenez',204350795,87429055,24436213,'Canoas, Alajuela, Costa Rica');
INSERT INTO Persona(Nombre, Apellido_1, Apellido_2, Cedula, Telefono_1, Telefono_2, Direccion)
VALUES('Damaris','Lopez','Chacon',205640789,83849392,24436213,'Canoas, Alajuela, Costa Rica');

Select * from Persona;

INSERT INTO Categoria(Nombre, Descripcion)
VALUES('Radios','Aparatos electronicos de radio AM Y FM, con caracteristicas como Bluethooth');
INSERT INTO Categoria(Nombre, Descripcion)
VALUES('Parlantes','Equipos de sonido como sobwoofers, equipos de sonido y demas');
INSERT INTO Categoria(Nombre, Descripcion)
VALUES('Alogenos','Luces de carro, antifog, y demas');

Select * from Categoria;

INSERT INTO Marca(Categoria, Nombre, Descripcion)
VALUES('Radios','Pionner','Marca popular de radios y aparatos de sonido');
INSERT INTO Marca(Categoria, Nombre, Descripcion)
VALUES('Parlantes','Pionner','Marca popular de radios y aparatos de sonido');
INSERT INTO Marca(Categoria, Nombre)
VALUES('Alogenos','Yukida');

Select * from Marca;

INSERT INTO Producto(Cantidad, Marca, Categoria, Modelo, Descripcion, Nombre, Precio_Colones)
VALUES(10,'Pionner','Radios','NF45','Radio Bluethooth de baja gama','Shivava',20000.45);
INSERT INTO Producto(Cantidad, Marca, Categoria, Modelo, Descripcion, Nombre, Precio_Colones)
VALUES(10,'Pionner','Parlantes','RJ1020','Parlante de gama alta','Bazuco',139000.52);
INSERT INTO Producto(Cantidad, Marca, Categoria, Modelo, Descripcion, Nombre, Precio_Colones)
VALUES(3,'Yukida','Alogenos','XCV4567','Alogenos antifog gama baja','Shivava',20000.45);

Select * from Producto;

INSERT INTO Producto_Unidad(N_Serial, Fecha_Ingreso, Modelo_Producto)
VALUES(12345698,'2020-06-15','RJ1020');
INSERT INTO Producto_Unidad(N_Serial, Fecha_Ingreso, Modelo_Producto)
VALUES(15614869,'2020-06-15','RJ1020');
INSERT INTO Producto_Unidad(N_Serial, Fecha_Ingreso, Modelo_Producto)
VALUES(15215264,'2020-06-15','RJ1020');


Select * from Producto_Unidad;
-- DROPS --
Drop TABLE Venta;
Drop TABLE Factura;
Drop TABLE Producto_Unidad;
Drop TABLE Producto;
Drop TABLE Marca;
Drop TABLE Empresa;
Drop TABLE Persona;
Drop TABLE Cliente;
Drop TABLE Categoria;
