USE PROYECTO_SQL;

-- Tabla que contiene información sobre la empresa
CREATE TABLE Empresa (
    IDEMPRESA INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(255) NOT NULL,
    DIRECCION VARCHAR(255),
    TELEFONO VARCHAR(20),
    INDEX nombreindex (NOMBRE)
    )ENGINE=InnoDB;

-- Tabla que almacena los datos básicos de los proveedores
CREATE TABLE Proveedores (
    IDPROVEEDOR INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(255) NOT NULL,
    DIRECCION VARCHAR(255),
    TELEFONO VARCHAR(20),
    INDEX nombre_index (NOMBRE)
)ENGINE=InnoDB;


-- Tabla que contiene información básica sobre los productos
CREATE TABLE Productos (
    IDPRODUCTO INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(255) NOT NULL,
    MARCA VARCHAR(255),
    PRECIO DECIMAL(10, 2) NOT NULL, 
    FECHAVENCIMIENTO DATE,
    DESCRIPCION TEXT,
    INDEX nombreindex (NOMBRE),
    INDEX marcaindex (MARCA)
)ENGINE=InnoDB;

-- Tabla que registra los detalles de los pedidos realizados a los proveedores
CREATE TABLE Pedidos (
    IDPEDIDO INT PRIMARY KEY AUTO_INCREMENT,
    IDPROVEEDOR INT,
    IDPRODUCTO INT,
    CANTIDAD INT,
    PRECIO DECIMAL(10, 2),
    FECHAPEDIDO DATE,
    FECHADESPACHO DATE,
    FOREIGN KEY (IDPROVEEDOR) REFERENCES Proveedores(IDPROVEEDOR)ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IDPRODUCTO) REFERENCES Productos(IDPRODUCTO)  ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX proveedorproductoindex (IDPROVEEDOR, IDPRODUCTO)
)ENGINE=InnoDB;


-- Tabla que contiene información sobre las ventas realizadas por la empresa
CREATE TABLE Ventas (
    IDVENTA INT PRIMARY KEY AUTO_INCREMENT,
    COMPRADOR VARCHAR(255) NOT NULL,
    FECHACOMPRA DATE NOT NULL,
    CANTIDADPRODUCTOS INT NOT NULL,
    PRECIOVENTA DECIMAL(10, 2) NOT NULL,
    NFACTURA VARCHAR(20) NOT NULL,
    INDEX compradorindex (COMPRADOR),
    INDEX fechaindex (FECHACOMPRA)
)ENGINE=InnoDB;


-- Datos de la tabla empresa
INSERT INTO Empresa (NOMBRE, DIRECCION, TELEFONO) VALUES ('Gran Sabana', 'Bolivar 411 Pilar Centro', '1157263000');

-- Datos de la tabla proveedores

INSERT INTO Proveedores (NOMBRE, TELEFONO) VALUES ('Tovareño', '1125321247');
INSERT INTO Proveedores (NOMBRE, TELEFONO) VALUES ('VeneBatos', '1138148895');

-- Datos de la tabla productos

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Hairna Morixe', 'Morixe', 2999.00, '2025-01-12', 'Harina de maiz precida para arepas');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Harina Presto', 'Arcor', 2999.00, '2024-12-01', 'Harina de maiz precida para arepas');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Suero', 'Caroreño', 3200.00, '2024-04-20', 'Producto hecho de la leche de vaca');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Queso duro', 'Tovareño', 7050.00, '2024-07-05', 'Queso de vaca duro y salado');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Queso semiduro', 'Tovareño', 6900.00, '2024-05-15', 'Queso de vaca con poca sal y suave');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Malta', 'Polar', 1300.00, '2024-11-30', 'Gaseo de malta');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Rekolita', 'REKO', 980.00, '2024-10-29', 'Gaseosa con sabor a cereza');

INSERT INTO Productos (NOMBRE, MARCA, PRECIO, FECHAVENCIMIENTO, DESCRIPCION) 
VALUES ('Salsa de soja', 'La Parmesana', 1200.00, '202-02-10', 'Salsa hecha en base a la soja');

select * from productos

-- Datos de la tabla pedidos

INSERT INTO Pedidos (IDPROVEEDOR, IDPRODUCTO, CANTIDAD, PRECIO, FECHAPEDIDO, FECHADESPACHO) 
VALUES 
(1, 1, 50, 2500.00, '2024-03-22', '2024-03-27'),
(1, 4, 30, 6500.00, '2024-03-22', '2024-03-27'),
(1, 5, 30, 6300.00, '2024-03-22', '2024-03-27'),
(1, 3, 12, 2700.00, '2024-03-22', '2024-03-27'),
(1, 8, 24, 600.00, '2024-03-22', '2024-03-27');

INSERT INTO Pedidos (IDPROVEEDOR, IDPRODUCTO, CANTIDAD, PRECIO, FECHAPEDIDO, FECHADESPACHO) 
VALUES 
(2, 9, 12, 800.00, '2024-03-25', '2024-03-26'),
(2, 6, 40, 700.00, '2024-03-25', '2024-03-26'),
(2, 2, 40, 2500.00, '2024-03-25', '2024-03-26'),
(2, 3, 12, 2700.00, '2024-03-25', '2024-03-26'),
(2, 8, 24, 600.00, '2024-03-25', '2024-03-26');

-- Datos de la tabla ventas

INSERT INTO Ventas (COMPRADOR, FECHACOMPRA, CANTIDADPRODUCTOS, PRECIOVENTA, NFACTURA)
VALUES
('Juan Perez', '2024-03-22', 10, 25000.00, '254'),
('Carolina Fernandez', '2024-03-22', 5, 6000.00, '255'),
('Carlos Sanchez', '2024-03-22',14, 52500.00, '256');


-- Funciones 

-- Esta función devolverá la dirección de un proveedor dado su ID de proveedor.
DELIMITER //

CREATE FUNCTION ObtenerDireccionProveedor(idProveedor INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE direccionProveedor VARCHAR(255);
    SELECT DIRECCION INTO direccionProveedor
    FROM Proveedores
    WHERE IDPROVEEDOR = idProveedor
    LIMIT 1; 
    RETURN direccionProveedor;
END //

DELIMITER ;

-- Esta función devuelve el nombre de un producto dado su ID.
DELIMITER //

CREATE FUNCTION ObtenerNombreProducto(idProducto INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE nombreProducto VARCHAR(255);
    SELECT NOMBRE INTO nombreProducto
    FROM Productos
    WHERE IDPRODUCTO = idProducto
    LIMIT 1; 
    RETURN nombreProducto;
END //

DELIMITER ;

-- Vistas

-- Vista de Productos con Precio Mayor a 5000
CREATE VIEW Productos_Precio_Mayor_5000 AS
SELECT *
FROM Productos
WHERE PRECIO > 5000;

-- Vista de Pedidos con Precio Mayor a 3000
CREATE VIEW Pedidos_Precio_Mayor_3000 AS
SELECT *
FROM Pedidos
WHERE PRECIO > 3000;

-- Vista de Proveedores con Pedidos Realizados
CREATE VIEW Proveedores_Con_Pedidos AS
SELECT pr.NOMBRE AS Proveedor, COUNT(*) AS Total_Pedidos
FROM Pedidos ped
JOIN Proveedores pr ON ped.IDPROVEEDOR = pr.IDPROVEEDOR
GROUP BY pr.NOMBRE;

-- Vista de Ventas por Comprador
CREATE VIEW Ventas_Por_Comprador AS
SELECT COMPRADOR, COUNT(*) AS Total_Ventas, SUM(PRECIOVENTA) AS Total_Vendido
FROM Ventas
GROUP BY COMPRADOR;
 
 -- Esta vista muestra la cantidad total de productos comprados por cada comprador
CREATE VIEW Cantidad_Productos_Por_Comprador AS
SELECT COMPRADOR, SUM(CANTIDADPRODUCTOS) AS Total_Productos_Comprados
FROM Ventas
GROUP BY COMPRADOR;

-- Stored Procedures

-- ActualizarPrecioProducto
DELIMITER //

CREATE PROCEDURE ActualizarPrecioProducto(
    IN idProducto INT,
    IN nuevoPrecio DECIMAL(10, 2)
)
BEGIN
    UPDATE Productos
    SET PRECIO = nuevoPrecio
    WHERE IDPRODUCTO = idProducto;
END //

DELIMITER ;


-- Stored Procedure para agregar un nuevo proveedor
DELIMITER //
CREATE PROCEDURE AgregarProveedor(
    IN nombreProveedor VARCHAR(255),
    IN direccionProveedor VARCHAR(255),
    IN telefonoProveedor VARCHAR(20)
)
BEGIN
    INSERT INTO Proveedores (NOMBRE, DIRECCION, TELEFONO)
    VALUES (nombreProveedor, direccionProveedor, telefonoProveedor);
END //
DELIMITER ;

-- Stored Procedure para realizar una venta
DELIMITER //
CREATE PROCEDURE RealizarVenta(
    IN comprador VARCHAR(255),
    IN fechaCompra DATE,
    IN cantidadProductos INT,
    IN precioVenta DECIMAL(10, 2),
    IN nFactura VARCHAR(20)
)
BEGIN
    INSERT INTO Ventas (COMPRADOR, FECHACOMPRA, CANTIDADPRODUCTOS, PRECIOVENTA, NFACTURA)
    VALUES (comprador, fechaCompra, cantidadProductos, precioVenta, nFactura);
END //
DELIMITER ;

