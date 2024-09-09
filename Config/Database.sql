CREATE DATABASE IF NOT EXISTS pigeon;

USE pigeon;

-- pigeon.articulo definition
CREATE TABLE `articulo` (
  `nombre` VARCHAR(30) NOT NULL,
  `categoria` VARCHAR(100) NOT NULL,
  `descuento` INT(2) DEFAULT 0,
  `precio` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `empresa` VARCHAR(100) NOT NULL,
  `stock` INT(10) UNSIGNED NOT NULL,
  `idArticulo` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fechaAgregado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `codigoBarra` VARCHAR(255) NOT NULL,
  `rutaImagen` VARCHAR(255) NOT NULL DEFAULT '../../assets/img/productos/error.png',
  `descripcion` TEXT NOT NULL,
  PRIMARY KEY (`idArticulo`),
  UNIQUE KEY `Articulo_unique` (`codigoBarra`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.compra definition
CREATE TABLE `compra` (
  `fechaCompra` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCompra` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCarrito` INT(10) UNSIGNED NOT NULL,
  `metodoPago` ENUM('paypal', 'efectivo', 'mercado Pago') NOT NULL,
  PRIMARY KEY (`idCompra`),
  UNIQUE KEY `compra_unique` (`idCarrito`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.empresa definition
CREATE TABLE `empresa` (
  `idEmpresa` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `categoria` ENUM('Teléfonos móviles', 'Computadoras y Laptops', 'Televisores y Audio', 'Accesorios tecnológicos', 'Ropa de Hombre', 'Ropa de Mujer', 'Zapatos y Accesorios', 'Ropa para Niños', 'Muebles', 'Decoración', 'Herramientas y Mejoras para el Hogar', 'Jardinería', 'Productos para el Cuidado de la Piel', 'Maquillaje', 'Productos para el Cuidado del Cabello', 'Suplementos y Vitaminas', 'Equipamiento Deportivo', 'Ropa Deportiva', 'Bicicletas y Patinetes', 'Camping y Senderismo', 'Juguetes para Niños', 'Juegos de Mesa', 'Videojuegos y Consolas', 'Puzzles y Rompecabezas', 'Accesorios para Automóviles', 'Accesorios para Motocicletas', 'Herramientas y Equipos', 'Neumáticos y Llantas', 'Comida Gourmet', 'Bebidas Alcohólicas', 'Alimentos Orgánicos', 'Snacks y Dulces', 'Ropa de Bebé', 'Juguetes para Bebés', 'Productos para la Alimentación del Bebé', 'Mobiliario Infantil', 'Libros Físicos y E-Books', 'Música y CDs', 'Instrumentos Musicales', 'Audiolibros y Podcasts') NOT NULL,
  `RUT` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idEmpresa`),
  UNIQUE KEY `empresa_unique` (`email`),
  UNIQUE KEY `empresa_unique_1` (`nombre`),
  UNIQUE KEY `empresa_unique_2` (`RUT`),
  UNIQUE KEY `empresa_unique_3` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.envios definition
CREATE TABLE `envios` (
  `idEnvios` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `metodoEnvio` ENUM('RETIRO', 'EXPRESS', 'NORMAL') NOT NULL DEFAULT 'RETIRO',
  `fechaSalida` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaLlegada` DATETIME DEFAULT NULL,
  PRIMARY KEY (`idEnvios`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.factura definition
CREATE TABLE `factura` (
  `horaEmitida` DATETIME NOT NULL,
  `idFactura` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFactura`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.usuarios definition
CREATE TABLE `usuarios` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(40) NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `calle` VARCHAR(50) DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(40) NOT NULL,
  `Npuerta` VARCHAR(10) DEFAULT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Usuarios_unique` (`email`),
  UNIQUE KEY `Usuarios_unique_1` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Los usuarios del sistema';

-- pigeon.administrador definition
CREATE TABLE `administrador` (
  `id` INT(10) UNSIGNED NOT NULL,
  `cedula` VARCHAR(9) NOT NULL,
  `claveSecreta` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Administrador_unique` (`cedula`),
  CONSTRAINT `Administrador_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.agregan definition
CREATE TABLE `agregan` (
  `id` INT(10) UNSIGNED NOT NULL,
  `idArticulo` INT(10) UNSIGNED NOT NULL,
  UNIQUE KEY `Agregan_unique_1` (`idArticulo`),
  KEY `Agregan_Usuarios_FK` (`id`),
  CONSTRAINT `Agregan_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`),
  CONSTRAINT `Agregan_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.cliente definition
CREATE TABLE `cliente` (
  `id` INT(10) UNSIGNED NOT NULL,
  `cedula` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cliente_unique` (`cedula`),
  CONSTRAINT `Cliente_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.compone definition
CREATE TABLE `compone` (
  `idArticulo` INT(10) UNSIGNED NOT NULL,
  `idCompra` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idArticulo`),
  UNIQUE KEY `Compone_unique` (`idCompra`),
  CONSTRAINT `Compone_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.consulta definition
CREATE TABLE `consulta` (
  `fecha` DATETIME NOT NULL,
  `idArticulo` INT(10) UNSIGNED NOT NULL,
  `id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`fecha`, `idArticulo`, `id`),
  KEY `idArticulo` (`idArticulo`),
  KEY `id` (`id`),
  CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`),
  CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.crea definition
CREATE TABLE `crea` (
  `idCompra` INT(10) UNSIGNED NOT NULL,
  `idArticulo` INT(10) UNSIGNED NOT NULL,
  `idEnvios` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idEnvios`),
  UNIQUE KEY `Crea_unique` (`idEnvios`),
  KEY `Crea_Compra_FK` (`idCompra`),
  KEY `Crea_Compone_FK` (`idArticulo`),
  CONSTRAINT `Crea_Compone_FK` FOREIGN KEY (`idArticulo`) REFERENCES `compone` (`idArticulo`),
  CONSTRAINT `Crea_Compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`),
  CONSTRAINT `Crea_Envios_FK` FOREIGN KEY (`idEnvios`) REFERENCES `envios` (`idEnvios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.generan definition
CREATE TABLE `generan` (
  `idArticulo` INT(10) UNSIGNED NOT NULL,
  `idFactura` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idFactura`),
  UNIQUE KEY `generan_unique` (`idArticulo`),
  CONSTRAINT `generan_articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`),
  CONSTRAINT `generan_factura_FK` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.pertenece definition
CREATE TABLE `pertenece` (
  `id` INT(10) UNSIGNED NOT NULL,
  `idEmpresa` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pertenece_empresa_FK` (`idEmpresa`),
  CONSTRAINT `pertenece_empresa_FK` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`),
  CONSTRAINT `pertenece_usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.recibe definition
CREATE TABLE `recibe` (
  `idFactura` INT(10) UNSIGNED NOT NULL,
  `id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idFactura`, `id`),
  KEY `id` (`id`),
  CONSTRAINT `recibe_ibfk_1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`),
  CONSTRAINT `recibe_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.vendedor definition
CREATE TABLE `vendedor` (
  `id` INT(10) UNSIGNED NOT NULL,
  `cedula` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Vendedor_unique` (`cedula`),
  CONSTRAINT `Vendedor_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- pigeon.carrito definition
CREATE TABLE `carrito` (
  `IdCarrito` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Estado` ENUM('PAGO', 'NO PAGO') NOT NULL DEFAULT 'NO PAGO',
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` INT(10) UNSIGNED NOT NULL,
  `monto` DECIMAL(12,2) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`IdCarrito`),
  UNIQUE KEY `Carrito_unique` (`id`),
  CONSTRAINT `Carrito_Cliente_FK` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos en la tabla `usuarios`
INSERT INTO `usuarios` (`id`, `apellido`, `nombre`, `calle`, `email`, `contraseña`, `Npuerta`, `telefono`) VALUES
(1, 'García', 'Juan', 'Calle Falsa 123', 'juan.garcia@example.com', 'hashed_password1', '12A', '3001234567'),
(2, 'Pérez', 'María', 'Avenida Siempre Viva 456', 'maria.perez@example.com', 'hashed_password2', '34B', '3007654321'),
(3, 'López', 'Carlos', 'Boulevard de los Sueños 789', 'carlos.lopez@example.com', 'hashed_password3', '56C', '3001122334'),
(4, 'Rodríguez', 'Ana', 'Calle 10', 'ana.rodriguez@example.com', 'hashed_password4', '78D', '3004455667'),
(5, 'Martínez', 'José', 'Avenida Principal', 'jose.martinez@example.com', 'hashed_password5', '90E', '3007788990');

-- Insertar datos en la tabla `administrador` (heredan el id de usuarios)
INSERT INTO `administrador` (`id`, `cedula`, `claveSecreta`) VALUES
(1, 'V12345678', 'claveSecretaAdmin1'),
(2, 'V87654321', 'claveSecretaAdmin2');

-- Insertar datos en la tabla `cliente` (heredan el id de usuarios)
INSERT INTO `cliente` (`id`, `cedula`) VALUES
(3, 'C12345678'),
(4, 'C87654321');

-- Insertar datos en la tabla `vendedor` (heredan el id de usuarios)
INSERT INTO `vendedor` (`id`, `cedula`) VALUES
(4, 'V11223344'),
(5, 'V22334455');

-- Insertar datos en la tabla `empresa`
INSERT INTO `empresa` (`idEmpresa`, `email`, `nombre`, `categoria`, `RUT`, `telefono`) VALUES
(1, 'contacto@tecnologiaejemplo.com', 'TecnoEjemplo S.A.', 'Computadoras y Laptops', 'RUT12345678', '301234567'),
(2, 'ventas@ropaejemplo.com', 'RopaEjemplo Ltda.', 'Ropa de Mujer', 'RUT87654321', '309876543');

-- Insertar datos en la tabla `pertenece` (vendedores que pertenecen a empresas)
INSERT INTO `pertenece` (`id`, `idEmpresa`) VALUES
(4, 1),
(5, 2);

-- Insertar datos en la tabla `articulo`
INSERT INTO `articulo` (`idArticulo`, `nombre`, `precio`, `descripcion`, `rutaImagen`, `categoria`, `descuento`, `empresa`, `stock`, `fechaAgregado`, `codigoBarra`) VALUES
(1, 'Laptop Modelo X', 1500.00, 'Laptop de alto rendimiento con 16GB RAM y 512GB SSD.', '../../assets/img/productos/laptop_x.png', 'Computadoras y Laptops', 10, 1, 50, NOW(), 'ABC1234567890'),
(2, 'Vestido de Verano', 75.50, 'Vestido ligero perfecto para el verano.', '../../assets/img/productos/vestido_verano.png', 'Ropa de Mujer', 15, 2, 200, NOW(), 'DEF0987654321'),
(3, 'Smartphone Modelo Y', 800.00, 'Smartphone con cámara de 12MP y batería de larga duración.', '../../assets/img/productos/smartphone_y.png', 'Celulares y Smartphones', 5, 1, 100, NOW(), 'GHI1122334455');

