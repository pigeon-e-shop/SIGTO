-- pigeon.compra definition

CREATE TABLE `compra` (
  `fechaCompra` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCompra` int unsigned NOT NULL AUTO_INCREMENT,
  `idCarrito` int unsigned NOT NULL,
  `metodoPago` enum('paypal','efectivo','mercado Pago') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idCompra`),
  UNIQUE KEY `compra_unique` (`idCarrito`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.empresa definition

CREATE TABLE `empresa` (
  `idEmpresa` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts') COLLATE utf8mb4_general_ci NOT NULL,
  `RUT` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idEmpresa`),
  UNIQUE KEY `empresa_unique` (`email`),
  UNIQUE KEY `empresa_unique_1` (`nombre`),
  UNIQUE KEY `empresa_unique_2` (`RUT`),
  UNIQUE KEY `empresa_unique_3` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.envios definition

CREATE TABLE `envios` (
  `idEnvios` int unsigned NOT NULL AUTO_INCREMENT,
  `metodoEnvio` enum('RETIRO','EXPRESS','NORMAL') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'RETIRO',
  `fechaSalida` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaLlegada` datetime DEFAULT NULL,
  PRIMARY KEY (`idEnvios`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.factura definition

CREATE TABLE `factura` (
  `horaEmitida` datetime NOT NULL,
  `idFactura` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idFactura`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.usuarios definition

CREATE TABLE `usuarios` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `apellido` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `calle` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Npuerta` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Usuarios_unique` (`email`),
  UNIQUE KEY `Usuarios_unique_1` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Los usuarios del sistema';


-- pigeon.administrador definition

CREATE TABLE `administrador` (
  `id` int unsigned NOT NULL,
  `cedula` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  `claveSecreta` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Administrador_unique` (`cedula`),
  CONSTRAINT `Administrador_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.articulo definition

CREATE TABLE `articulo` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `descuento` int DEFAULT '0',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stock` int unsigned NOT NULL,
  `empresa` int unsigned NOT NULL,
  `codigoBarra` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `rutaImagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '../../assets/img/productos/error.png',
  `fechaAgregado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Articulo_unique` (`codigoBarra`),
  KEY `articulo_empresa_FK` (`empresa`),
  CONSTRAINT `articulo_empresa_FK` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.cliente definition

CREATE TABLE `cliente` (
  `id` int unsigned NOT NULL,
  `cedula` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cliente_unique` (`cedula`),
  CONSTRAINT `Cliente_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.compone definition

CREATE TABLE `compone` (
  `idArticulo` int unsigned NOT NULL,
  `idCompra` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idArticulo`),
  UNIQUE KEY `Compone_unique` (`idCompra`),
  CONSTRAINT `Compone_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.consulta definition

CREATE TABLE `consulta` (
  `fecha` datetime NOT NULL,
  `idArticulo` int unsigned NOT NULL,
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`fecha`,`idArticulo`,`id`),
  KEY `idArticulo` (`idArticulo`),
  KEY `id` (`id`),
  CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.crea definition

CREATE TABLE `crea` (
  `idCompra` int unsigned NOT NULL,
  `idArticulo` int unsigned NOT NULL,
  `idEnvios` int unsigned NOT NULL,
  PRIMARY KEY (`idEnvios`),
  UNIQUE KEY `Crea_unique` (`idEnvios`),
  KEY `Crea_Compra_FK` (`idCompra`),
  KEY `Crea_Compone_FK` (`idArticulo`),
  CONSTRAINT `Crea_Compone_FK` FOREIGN KEY (`idArticulo`) REFERENCES `compone` (`idArticulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Crea_Compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Crea_Envios_FK` FOREIGN KEY (`idEnvios`) REFERENCES `envios` (`idEnvios`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.generan definition

CREATE TABLE `generan` (
  `idArticulo` int unsigned NOT NULL,
  `idFactura` int unsigned NOT NULL,
  PRIMARY KEY (`idFactura`),
  UNIQUE KEY `generan_unique` (`idArticulo`),
  CONSTRAINT `generan_articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `generan_factura_FK` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Una factura se genera con un id de articulo';


-- pigeon.pertenece definition

CREATE TABLE `pertenece` (
  `id` int unsigned NOT NULL,
  `idEmpresa` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pertenece_empresa_FK` (`idEmpresa`),
  CONSTRAINT `pertenece_empresa_FK` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pertenece_usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='El vendedor pertenece a una empresa';


-- pigeon.recibe definition

CREATE TABLE `recibe` (
  `idFactura` int unsigned NOT NULL,
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`idFactura`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `recibe_ibfk_1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recibe_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Las facturas que recibe el cliente';


-- pigeon.vendedor definition

CREATE TABLE `vendedor` (
  `id` int unsigned NOT NULL,
  `cedula` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Vendedor_unique` (`cedula`),
  CONSTRAINT `Vendedor_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Vendedores representantes de las empresas';


-- pigeon.agregan definition

CREATE TABLE `agregan` (
  `id` int unsigned NOT NULL,
  `idArticulo` int unsigned NOT NULL,
  UNIQUE KEY `Agregan_unique_1` (`idArticulo`),
  KEY `Agregan_Usuarios_FK` (`id`),
  CONSTRAINT `Agregan_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Agregan_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.carrito definition

CREATE TABLE `carrito` (
  `IdCarrito` int unsigned NOT NULL AUTO_INCREMENT,
  `Estado` enum('PAGO','NO PAGO') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO PAGO',
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int unsigned NOT NULL,
  `monto` decimal(12,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`IdCarrito`),
  UNIQUE KEY `Carrito_unique` (`id`),
  CONSTRAINT `Carrito_Cliente_FK` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO usuarios (id, apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES(2, 'Pérez', 'María Jose', 'Avenida Siempre Viva ', 'maria.perez@example.com', '$2y$10$n4fBVnKDwKFPOu3H/Mw/z.1f7M3wyI3Ewgc3FSjLAWSD52PVa84Ue', '34B', '300765432');
INSERT INTO usuarios (id, apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES(3, 'López', 'Carlos', 'Boulevard de los Sueños', 'carlos.lopez@example.com', '$2y$10$bKZBqYtb7/duOugcL31ikeMzOMckge2qJo860XitkBX.N5qsaU/oy', '56C', '300112233');
INSERT INTO usuarios (id, apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES(4, 'Tilla', 'Aitor', 'Octava Avenida', 'aitor@example.com', '$2y$10$Y351vm7y7UrDcNLDRzmsm.S7KS65.nUNF6cemi2SwUMmADhMxMKkG', '8455', '300445566');
INSERT INTO usuarios (id, apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES(10, 'Vazquez', 'Santiago', 'Dr. Jose Maria Penco', 'santi.vazquez.rubio@gmail.com', '$2y$10$OsQB4yEicwkcDVTAzNDDv.5r6w0IOMY9wO6CmSMccr/5aYkZeO.lu', '3089', '099099098');
INSERT INTO usuarios (id, apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES(11, 'Vazquez', 'Niro', 'Bulevar Artigas', 'nirovazquez@gmail.com', '$2y$10$jH6erQmrxxsFcZ3PEiWGtOJyxaEOoaBL7T9KMhcZHuIUidf7.lx4G', '9884', '099445566');
INSERT INTO usuarios (id, apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES(12, 'Zanini', 'Giovanni', 'Lucas Obes', 'giovazanini@gmail.com', '$2y$10$1Gktbg8eTDdCNPe78yyfKefGm2IzHFw7Qf3COFl5uw.xr3dG5rFSW', '5482', '094578154');

INSERT INTO empresa (idEmpresa, email, nombre, categoria, RUT, telefono) VALUES(8, 'empresa1@example.com', 'Empresa Uno', 'Teléfonos móviles', 'RUT12345678', '123456789');
INSERT INTO empresa (idEmpresa, email, nombre, categoria, RUT, telefono) VALUES(9, 'empresa2@example.com', 'Empresa Dos', 'Computadoras y Laptops', 'RUT23456789', '987654321');
INSERT INTO empresa (idEmpresa, email, nombre, categoria, RUT, telefono) VALUES(10, 'empresa3@example.com', 'Empresa Tres', 'Ropa de Hombre', 'RUT34567890', '456123789');
INSERT INTO empresa (idEmpresa, email, nombre, categoria, RUT, telefono) VALUES(11, 'empresa4@example.com', 'Empresa Cuatro', 'Videojuegos y Consolas', 'RUT45678901', '321654987');
INSERT INTO empresa (idEmpresa, email, nombre, categoria, RUT, telefono) VALUES(12, 'empresa5@example.com', 'Empresa Cinco', 'Muebles', 'RUT56789012', '789123456');

INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(200, 'iPhone 14', 799.99, 'Teléfonos móviles', 30, 'Smartphone con pantalla de 6.1 pulgadas y cámara dual.', 50, 8, '1234567890123', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(201, 'Dell XPS 13', 1299.00, 'Computadoras y Laptops', 5, 'Laptop ultradelgada con procesador Intel i7 y pantalla 4K.', 30, 8, '1234567890124', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(202, 'Nike T-Shirt', 29.99, 'Ropa de Hombre', 0, 'Camiseta de algodón 100% con logo de Nike.', 100, 9, '1234567890125', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(203, 'PlayStation 5', 499.99, 'Videojuegos y Consolas', 15, 'Consola de videojuegos de última generación con 825 GB de almacenamiento.', 20, 10, '1234567890126', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(204, 'IKEA Kallax', 89.99, 'Muebles', 20, 'Estantería modular de madera, ideal para cualquier habitación.', 15, 11, '1234567890127', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(205, 'Samsung Galaxy S21', 799.99, 'Teléfonos móviles', 0, 'Smartphone con pantalla AMOLED y triple cámara.', 60, 8, '1234567890128', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(206, 'HP Spectre x360', 1499.00, 'Computadoras y Laptops', 5, 'Convertible 2 en 1 con pantalla táctil y diseño elegante.', 25, 8, '1234567890129', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(207, 'Levi’s 501 Jeans', 59.99, 'Ropa de Hombre', 10, 'Jeans clásicos de corte recto, cómodos y duraderos.', 75, 9, '1234567890130', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(208, 'Xbox Series X', 499.00, 'Videojuegos y Consolas', 5, 'Consola de videojuegos con potencia para 4K y HDR.', 18, 10, '1234567890131', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(209, 'Sofa de 3 Plazas', 399.99, 'Muebles', 15, 'Cómodo sofá en tela suave, ideal para salas de estar.', 10, 11, '1234567890132', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(210, 'OnePlus 9', 729.00, 'Teléfonos móviles', 0, 'Smartphone con carga rápida y cámara Hasselblad.', 45, 8, '1234567890133', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(211, 'Lenovo ThinkPad X1', 1399.00, 'Computadoras y Laptops', 0, 'Laptop empresarial con gran duración de batería.', 20, 8, '1234567890134', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(212, 'Adidas Sweatpants', 49.99, 'Ropa de Hombre', 5, 'Pantalones deportivos de algodón, cómodos y elegantes.', 50, 9, '1234567890135', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(213, 'Nintendo Switch', 299.99, 'Videojuegos y Consolas', 10, 'Consola portátil que se puede jugar en casa o en movimiento.', 30, 10, '1234567890136', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(214, 'Mesa de Comedor', 299.00, 'Muebles', 10, 'Mesa de madera maciza, perfecta para reuniones familiares.', 12, 11, '1234567890137', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(215, 'Google Pixel 6', 599.00, 'Teléfonos móviles', 5, 'Smartphone con cámara de 50 MP y software inteligente.', 40, 8, '1234567890138', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(216, 'Asus ZenBook 14', 1199.00, 'Computadoras y Laptops', 0, 'Laptop ligera con pantalla NanoEdge y gran rendimiento.', 18, 8, '1234567890139', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(217, 'Puma Sports Jacket', 69.99, 'Ropa de Hombre', 15, 'Chaqueta deportiva resistente al agua y transpirable.', 25, 9, '1234567890140', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(218, 'Razer Gaming Mouse', 79.99, 'Videojuegos y Consolas', 5, 'Mouse gaming con alta precisión y retroiluminación RGB.', 15, 10, '1234567890141', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(219, 'Cama King Size', 499.99, 'Muebles', 20, 'Cama de gran tamaño con colchón viscoelástico.', 0, 11, '1234567890142', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(220, 'Xiaomi Mi 11', 749.00, 'Teléfonos móviles', 0, 'Smartphone con pantalla AMOLED y carga rápida de 55W.', 55, 8, '1234567890143', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(221, 'Acer Swift 3', 899.00, 'Computadoras y Laptops', 5, 'Laptop delgada y ligera con buen rendimiento para estudiantes.', 35, 8, '1234567890144', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(222, 'H&M Casual Shirt', 34.99, 'Ropa de Hombre', 0, 'Camisa casual de manga larga en algodón suave.', 80, 9, '1234567890145', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(223, 'Steam Deck', 399.00, 'Videojuegos y Consolas', 10, 'PC portátil para jugar tus juegos de Steam en cualquier lugar.', 25, 10, '1234567890146', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(224, 'Estantería Modular', 199.99, 'Muebles', 15, 'Estantería ajustable en altura, ideal para libros y decoración.', 10, 11, '1234567890147', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(225, 'Sony Xperia 1 III', 1299.99, 'Teléfonos móviles', 99, 'Smartphone con pantalla 4K y cámara triple.', 20, 8, '1234567890148', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(226, 'Microsoft Surface Laptop 4', 1399.00, 'Computadoras y Laptops', 0, 'Laptop elegante con pantalla táctil y buena duración de batería.', 12, 8, '1234567890149', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(227, 'Tommy Hilfiger Hoodie', 59.99, 'Ropa de Hombre', 10, 'Sudadera con capucha de la marca Tommy Hilfiger.', 40, 9, '1234567890150', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(228, 'Oculus Quest 2', 299.99, 'Videojuegos y Consolas', 15, 'Gafas de realidad virtual todo en uno, sin cables.', 22, 10, '1234567890151', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(229, 'Mesa de Noche', 149.99, 'Muebles', 20, 'Mesa de noche con cajón, ideal para dormitorio.', 25, 11, '1234567890152', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(230, 'Huawei P40 Pro', 899.00, 'Teléfonos móviles', 0, 'Smartphone con cámara cuádruple y potente batería.', 35, 8, '1234567890153', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(231, 'LG Gram 17', 1699.00, 'Computadoras y Laptops', 0, 'Laptop ligera de 17 pulgadas, ideal para portabilidad.', 10, 8, '1234567890154', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(232, 'Gap Chinos', 49.99, 'Ropa de Hombre', 5, 'Pantalones chinos en variedad de colores, cómodos y elegantes.', 50, 9, '1234567890155', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(233, 'Razer Blade 15', 1999.99, 'Videojuegos y Consolas', 5, 'Laptop gaming con gráficos NVIDIA GeForce RTX.', 5, 10, '1234567890156', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(234, 'Silla Ergonomica', 249.99, 'Muebles', 10, 'Silla de oficina con soporte lumbar y ajuste de altura.', 15, 11, '1234567890157', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(235, 'Realme GT', 499.99, 'Teléfonos móviles', 0, 'Smartphone con carga rápida y pantalla AMOLED.', 40, 8, '1234567890158', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(236, 'Toshiba Satellite', 799.00, 'Computadoras y Laptops', 0, 'Laptop confiable para uso diario y trabajo.', 20, 8, '1234567890159', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(237, 'American Eagle Shorts', 29.99, 'Ropa de Hombre', 10, 'Shorts cómodos y ligeros, perfectos para el verano.', 100, 9, '1234567890160', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(238, 'Gaming Headset', 89.99, 'Videojuegos y Consolas', 5, 'Auriculares con micrófono y sonido envolvente.', 25, 10, '1234567890161', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(239, 'Escritorio de Oficina', 299.00, 'Muebles', 15, 'Escritorio amplio con espacio para computadora y documentos.', 10, 11, '1234567890162', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(240, 'Nokia G50', 299.99, 'Teléfonos móviles', 0, 'Smartphone 5G con batería de larga duración.', 45, 8, '1234567890163', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(241, 'Razer Stealth', 1599.99, 'Computadoras y Laptops', 0, 'Laptop gamer compacta con diseño atractivo y gran rendimiento.', 15, 8, '1234567890164', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(242, 'Under Armour Compression Shirt', 39.99, 'Ropa de Hombre', 0, 'Camiseta compresora ideal para hacer deporte.', 80, 9, '1234567890165', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(243, 'Guitar Hero Live', 49.99, 'Videojuegos y Consolas', 5, 'Juego de música para PlayStation, Wii y Xbox.', 15, 10, '1234567890166', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(244, 'Comoda de Madera', 199.99, 'Muebles', 20, 'Cómoda espaciosa de madera con varios cajones.', 10, 11, '1234567890167', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(245, 'Oppo Find X3', 899.00, 'Teléfonos móviles', 0, 'Smartphone con pantalla curva y cámara de 50 MP.', 40, 8, '1234567890168', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(246, 'Lenovo Yoga 9i', 1399.99, 'Computadoras y Laptops', 0, 'Laptop convertible con buena duración de batería.', 10, 8, '1234567890169', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(247, 'Puma Sneakers', 79.99, 'Ropa de Hombre', 0, 'Zapatillas deportivas cómodas y ligeras.', 60, 9, '1234567890170', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(248, 'Razer Gamepad', 49.99, 'Videojuegos y Consolas', 5, 'Controlador de juegos compatible con múltiples plataformas.', 25, 10, '1234567890171', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(249, 'Mesa de Centro', 199.99, 'Muebles', 15, 'Mesa de centro moderna, ideal para el salón.', 10, 11, '1234567890172', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(250, 'Apple Watch Series 6', 399.99, 'Accesorios tecnológicos', 0, 'Reloj inteligente con monitoreo de salud.', 20, 12, '1234567890173', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(251, 'Samsung Galaxy Buds', 149.99, 'Accesorios tecnológicos', 0, 'Auriculares inalámbricos con cancelación de ruido.', 30, 12, '1234567890174', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');
INSERT INTO articulo (id, nombre, precio, categoria, descuento, descripcion, stock, empresa, codigoBarra, rutaImagen, fechaAgregado) VALUES(252, 'Xiaomi Mi Band 6', 49.99, 'Accesorios tecnológicos', 0, 'Pulsera inteligente para monitoreo de actividad.', 100, 12, '1234567890175', '../../assets/img/productos/error.png', '2024-09-19 19:55:40');

-- views

-- pigeon.listar_articulos source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `listar_articulos` AS
select
    `a`.`id` AS `id`,
    `a`.`nombre` AS `nombre`,
    `a`.`descripcion` AS `descripcion`,
    `a`.`rutaImagen` AS `rutaImagen`,
    `a`.`descuento` AS `descuento`,
    `a`.`precio` AS `precio`
from
    `articulo` `a`
where
    (`a`.`VISIBLE` = 1);


-- pigeon.listar_articulos_lista source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `listar_articulos_lista` AS
select
    `a`.`id` AS `id`,
    `a`.`nombre` AS `nombre`,
    `a`.`precio` AS `precio`,
    `a`.`categoria` AS `categoria`,
    `a`.`descuento` AS `descuento`,
    `a`.`descripcion` AS `descripcion`,
    `a`.`stock` AS `stock`,
    `a`.`rutaImagen` AS `rutaImagen`,
    `a`.`calificacion` AS `calificacion`,
    `a`.`VISIBLE` AS `VISIBLE`
from
    `articulo` `a`
where
    (`a`.`VISIBLE` = 1);


-- pigeon.tomar_calificacion source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `tomar_calificacion` AS
select
    `u`.`nombre` AS `nombre_usuario`,
    `c`.`puntuacion` AS `calificacion`,
    `c`.`comentario` AS `comentario`,
    `c`.`fecha_calificacion` AS `fecha_calificacion`,
    `c`.`id_articulo` AS `id_articulo`
from
    ((`calificacion` `c`
join `usuarios` `u` on
    ((`c`.`id_usuario` = `u`.`id`)))
join `articulo` `a` on
    ((`c`.`id_articulo` = `a`.`id`)));