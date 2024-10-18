-- pigeon.compra definition
create database pigeon;
use pigeon;

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


-- pigeon.factura definition

CREATE TABLE `factura` (
  `horaEmitida` datetime NOT NULL,
  `idFactura` int unsigned NOT NULL AUTO_INCREMENT,
  `contenido` text COLLATE utf8mb4_general_ci NOT NULL,
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
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Usuarios_unique` (`email`),
  UNIQUE KEY `Usuarios_unique_1` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Los usuarios del sistema';


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
  `stock` int unsigned NOT NULL DEFAULT '0',
  `empresa` int unsigned NOT NULL,
  `rutaImagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '../../assets/img/productos/error.png',
  `fechaAgregado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `calificacion` decimal(3,2) NOT NULL DEFAULT '0.00',
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `articulo_empresa_FK` (`empresa`),
  CONSTRAINT `articulo_empresa_FK` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.calificacion definition

CREATE TABLE `calificacion` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_articulo` int unsigned NOT NULL,
  `id_usuario` int unsigned NOT NULL,
  `puntuacion` decimal(3,2) NOT NULL,
  `comentario` varchar(250) DEFAULT NULL,
  `fecha_calificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `calificacion_articulo_FK` (`id_articulo`),
  KEY `calificacion_usuarios_FK` (`id_usuario`),
  CONSTRAINT `calificacion_articulo_FK` FOREIGN KEY (`id_articulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calificacion_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- pigeon.cliente definition

CREATE TABLE `cliente` (
  `id` int unsigned NOT NULL,
  `cedula` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cliente_unique` (`cedula`),
  CONSTRAINT `Cliente_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.consulta definition

CREATE TABLE `consulta` (
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idArticulo` int unsigned NOT NULL,
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`fecha`,`idArticulo`,`id`),
  KEY `idArticulo` (`idArticulo`),
  KEY `id` (`id`),
  CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.envios definition

CREATE TABLE `envios` (
  `idEnvios` int unsigned NOT NULL AUTO_INCREMENT,
  `metodoEnvio` enum('RETIRO','EXPRESS','NORMAL') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'RETIRO',
  `fechaSalida` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaLlegada` datetime DEFAULT NULL,
  `idUsuario` int unsigned NOT NULL,
  PRIMARY KEY (`idEnvios`),
  KEY `envios_usuarios_FK` (`idUsuario`),
  CONSTRAINT `envios_usuarios_FK` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


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


-- pigeon.carrito definition

CREATE TABLE `carrito` (
  `IdCarrito` int unsigned NOT NULL AUTO_INCREMENT,
  `Estado` enum('PAGO','NO PAGO') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO PAGO',
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`IdCarrito`),
  UNIQUE KEY `Carrito_unique` (`id`),
  CONSTRAINT `Carrito_Cliente_FK` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.compra definition

CREATE TABLE `compra` (
  `fechaCompra` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCompra` int unsigned NOT NULL AUTO_INCREMENT,
  `idCarrito` int unsigned NOT NULL,
  `metodoPago` enum('paypal','efectivo','mercado Pago') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idCompra`),
  UNIQUE KEY `compra_unique` (`idCarrito`),
  CONSTRAINT `compra_carrito_FK` FOREIGN KEY (`idCarrito`) REFERENCES `carrito` (`IdCarrito`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.crea definition

CREATE TABLE `crea` (
  `idCompra` int unsigned NOT NULL,
  `idEnvios` int unsigned NOT NULL,
  PRIMARY KEY (`idEnvios`),
  UNIQUE KEY `Crea_unique` (`idEnvios`),
  KEY `Crea_Compra_FK` (`idCompra`),
  CONSTRAINT `Crea_Compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Crea_Envios_FK` FOREIGN KEY (`idEnvios`) REFERENCES `envios` (`idEnvios`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.agregan definition

CREATE TABLE `agregan` (
  `id` int unsigned NOT NULL,
  `idArticulo` int unsigned NOT NULL,
  `idCarrito` int unsigned DEFAULT NULL,
  UNIQUE KEY `Agregan_unique_1` (`idArticulo`),
  KEY `Agregan_Usuarios_FK` (`id`),
  KEY `agregan_carrito_FK` (`idCarrito`),
  CONSTRAINT `Agregan_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `agregan_carrito_FK` FOREIGN KEY (`idCarrito`) REFERENCES `carrito` (`IdCarrito`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Agregan_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- pigeon.compone definition

CREATE TABLE `compone` (
  `idArticulo` int unsigned NOT NULL,
  `idCompra` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idArticulo`),
  UNIQUE KEY `Compone_unique` (`idCompra`),
  CONSTRAINT `Compone_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compone_compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

INSERT INTO `articulo` (`nombre`, `precio`, `categoria`, `descripcion`, `stock`, `empresa`) VALUES
('Teléfono Móvil XYZ', 299.99, 'Teléfonos móviles', 'Teléfono móvil con pantalla de 6.5 pulgadas.', 50, 8),
('Laptop ABC', 899.99, 'Computadoras y Laptops', 'Laptop de alto rendimiento con procesador i7.', 30, 8),
('Televisor LED 55"', 499.99, 'Televisores y Audio', 'Televisor 4K con HDR y Smart TV.', 20, 8),
('Auriculares Inalámbricos', 89.99, 'Accesorios tecnológicos', 'Auriculares Bluetooth con cancelación de ruido.', 100, 8),
('Camisa de Hombre', 39.99, 'Ropa de Hombre', 'Camisa de algodón, disponible en varias tallas.', 200, 8),
('Vestido de Mujer', 49.99, 'Ropa de Mujer', 'Vestido elegante, ideal para ocasiones especiales.', 150, 8),
('Zapatillas Deportivas', 59.99, 'Ropa Deportiva', 'Zapatillas cómodas para correr.', 75, 8),
('Juguete Educativo', 19.99, 'Juguetes para Niños', 'Juguete que estimula la creatividad de los niños.', 100, 8),
('Silla de Oficina', 149.99, 'Muebles', 'Silla ergonómica para largas horas de trabajo.', 40, 8),
('Cafetera Automática', 79.99, 'Herramientas y Mejoras para el Hogar', 'Cafetera de fácil uso para preparar café.', 60, 8),
('Set de Jardinería', 29.99, 'Jardinería', 'Set completo de herramientas para el jardín.', 80, 8),
('Crema Hidratante', 24.99, 'Productos para el Cuidado de la Piel', 'Crema que proporciona hidratación profunda.', 150, 8),
('Paleta de Maquillaje', 34.99, 'Maquillaje', 'Paleta con colores vibrantes para todo tipo de piel.', 90, 8),
('Shampoo Nutritivo', 12.99, 'Productos para el Cuidado del Cabello', 'Shampoo enriquecido con vitaminas.', 200, 8),
('Proteína en Polvo', 39.99, 'Suplementos y Vitaminas', 'Suplemento de proteína para deportistas.', 100, 8),
('Bicicleta de Montaña', 299.99, 'Bicicletas y Patinetes', 'Bicicleta robusta para todo tipo de terrenos.', 20, 8),
('Tienda de Camping', 199.99, 'Camping y Senderismo', 'Tienda liviana y fácil de montar.', 15, 8),
('Juego de Mesa Clásico', 24.99, 'Juegos de Mesa', 'Juego de mesa que reúne a la familia.', 120, 8),
('Consola de Videojuegos', 399.99, 'Videojuegos y Consolas', 'Consola de última generación.', 25, 8),
('Puzzles de 1000 Piezas', 19.99, 'Puzzles y Rompecabezas', 'Puzzle desafiante para amantes de los rompecabezas.', 50, 8),
('Accesorio para Auto', 39.99, 'Accesorios para Automóviles', 'Accesorio práctico para mejorar la comodidad en el auto.', 75, 8),
('Accesorio para Moto', 49.99, 'Accesorios para Motocicletas', 'Accesorio que aumenta la seguridad al conducir.', 40, 8),
('Set de Herramientas', 59.99, 'Herramientas y Equipos', 'Set de herramientas para cualquier tipo de trabajo.', 60, 8),
('Neumático de Coche', 79.99, 'Neumáticos y Llantas', 'Neumático duradero y seguro para tu coche.', 30, 8),
('Gourmet Snack', 9.99, 'Comida Gourmet', 'Snack delicioso y saludable.', 200, 8),
('Vino Tinto', 29.99, 'Bebidas Alcohólicas', 'Vino tinto de la mejor calidad.', 50, 8),
('Almendras Orgánicas', 14.99, 'Alimentos Orgánicos', 'Almendras orgánicas, un snack saludable.', 120, 8),
('Barra de Chocolate', 2.99, 'Snacks y Dulces', 'Barra de chocolate oscuro.', 250, 8),
('Smartwatch', 199.99, 'Accesorios tecnológicos', 'Reloj inteligente con múltiples funciones.', 35, 8),
('Cámara Digital', 499.99, 'Accesorios tecnológicos', 'Cámara de alta definición para fotografía.', 20, 8),
('Cargador Solar', 49.99, 'Accesorios tecnológicos', 'Cargador portátil que funciona con energía solar.', 70, 8),
('Mesa de Comedor', 299.99, 'Muebles', 'Mesa de comedor de madera para 6 personas.', 15, 8),
('Sofá Cama', 399.99, 'Muebles', 'Sofá que se convierte en cama, ideal para visitas.', 10, 8),
('Pantalón de Hombre', 49.99, 'Ropa de Hombre', 'Pantalón de tela cómoda, ideal para el trabajo.', 150, 8),
('Chaqueta de Mujer', 79.99, 'Ropa de Mujer', 'Chaqueta abrigadora para climas fríos.', 80, 8),
('Botas de Trabajo', 99.99, 'Zapatos y Accesorios', 'Botas resistentes y cómodas para el trabajo.', 60, 8),
('Mochila Escolar', 34.99, 'Ropa para Niños', 'Mochila con diseños divertidos para niños.', 100, 8),
('Juego de Construcción', 29.99, 'Juguetes para Niños', 'Juego de bloques para desarrollar habilidades motoras.', 80, 8),
('Gafas de Sol', 24.99, 'Accesorios para Automóviles', 'Gafas de sol con protección UV.', 150, 8),
('Manta de Picnic', 19.99, 'Camping y Senderismo', 'Manta ideal para salir de picnic.', 50, 8),
('Reloj de Pared', 34.99, 'Decoración', 'Reloj de pared moderno para el hogar.', 30, 8),
('Portavelas', 12.99, 'Decoración', 'Portavelas decorativo para iluminar espacios.', 80, 8),
('Espejo Decorativo', 49.99, 'Decoración', 'Espejo con marco elegante para cualquier habitación.', 25, 8),
('Lámpara LED', 19.99, 'Decoración', 'Lámpara LED eficiente y de bajo consumo.', 60, 8),
('Almohada Ergonomica', 29.99, 'Muebles', 'Almohada que brinda soporte para el cuello.', 70, 8),
('Colchón Doble', 399.99, 'Muebles', 'Colchón de alta calidad para mayor comodidad.', 15, 8),
('Botella de Agua', 9.99, 'Accesorios tecnológicos', 'Botella reutilizable para mantenerte hidratado.', 200, 8),
('Taza de Cerámica', 14.99, 'Accesorios para el Hogar', 'Taza de cerámica con diseño único.', 150, 8),
('Set de Cuchillos', 49.99, 'Herramientas y Mejoras para el Hogar', 'Set de cuchillos de cocina de acero inoxidable.', 40, 8),
('Funda para Laptop', 29.99, 'Accesorios tecnológicos', 'Funda acolchada para proteger tu laptop.', 80, 8),
('Mochila de Senderismo', 89.99, 'Camping y Senderismo', 'Mochila resistente para largas caminatas.', 30, 8),
('Chaqueta Impermeable', 59.99, 'Ropa Deportiva', 'Chaqueta que protege de la lluvia.', 100, 8),
('Camiseta Deportiva', 24.99, 'Ropa Deportiva', 'Camiseta cómoda y transpirable para hacer ejercicio.', 150, 8),
('Botiquín de Primeros Auxilios', 39.99, 'Herramientas y Mejoras para el Hogar', 'Kit completo para emergencias.', 40, 8),
('Luz LED para Bicicleta', 19.99, 'Bicicletas y Patinetes', 'Luz que aumenta la seguridad al montar.', 60, 8),
('Ropa de Cama', 49.99, 'Muebles', 'Juego de sábanas de algodón suave.', 80, 8),
('Tarjetero de Cuero', 19.99, 'Accesorios para el Hogar', 'Tarjetero elegante y duradero.', 100, 8),
('Portátil de Videojuegos', 299.99, 'Videojuegos y Consolas', 'Dispositivo portátil para jugar en cualquier lugar.', 25, 8),
('Altavoz Bluetooth', 79.99, 'Accesorios tecnológicos', 'Altavoz inalámbrico con gran calidad de sonido.', 50, 8),
('Conector HDMI', 9.99, 'Accesorios tecnológicos', 'Cable HDMI de alta velocidad.', 200, 8),
('Juego de Sartenes', 59.99, 'Herramientas y Mejoras para el Hogar', 'Juego de sartenes antiadherentes.', 30, 8),
('Paraguas', 14.99, 'Accesorios para el Hogar', 'Paraguas resistente y liviano.', 100, 8),
('Cojín Decorativo', 19.99, 'Decoración', 'Cojín suave para dar color a tu hogar.', 75, 8),
('Set de Baño', 39.99, 'Accesorios para el Hogar', 'Set de toallas de baño de alta calidad.', 60, 8),
('Bolsa de Deporte', 34.99, 'Ropa Deportiva', 'Bolsa para llevar tus cosas al gimnasio.', 100, 8),
('Ropa de Entrenamiento', 49.99, 'Ropa Deportiva', 'Conjunto cómodo para entrenar.', 80, 8),
('Termo de Acero', 29.99, 'Accesorios tecnológicos', 'Termo que mantiene la temperatura de las bebidas.', 150, 8),
('Cámara de Seguridad', 99.99, 'Herramientas y Mejoras para el Hogar', 'Cámara para vigilancia con conexión Wi-Fi.', 40, 8),
('Estantería de Madera', 149.99, 'Muebles', 'Estantería elegante y funcional.', 25, 8),
('Bandeja Organizadora', 19.99, 'Accesorios para el Hogar', 'Bandeja para mantener ordenados los objetos.', 100, 8),
('Cuaderno de Notas', 6.99, 'Accesorios para el Hogar', 'Cuaderno con hojas recicladas.', 200, 8),
('Bolígrafo de Lujo', 14.99, 'Accesorios para el Hogar', 'Bolígrafo elegante para escribir.', 150, 8);


-- views

-- pigeon.getOrdenes source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `getOrdenes` AS
select
    `u`.`id` AS `id`,
    `u`.`calle` AS `calle`,
    `u`.`Npuerta` AS `Npuerta`,
    `c`.`idCompra` AS `idCompra`,
    `e`.`idEnvios` AS `idEnvios`,
    `e`.`metodoEnvio` AS `metodoEnvio`,
    `e`.`fechaSalida` AS `fechaSalida`,
    `e`.`fechaLlegada` AS `fechaLlegada`,
    sum(`a2`.`precio`) AS `precio`,
    sum(`a2`.`descuento`) AS `descuento`
from
    ((((((`envios` `e`
join `usuarios` `u` on
    ((`e`.`idUsuario` = `u`.`id`)))
join `crea` `c` on
    ((`c`.`idEnvios` = `e`.`idEnvios`)))
join `compra` `c2` on
    ((`c`.`idCompra` = `c2`.`idCompra`)))
join `carrito` `c3` on
    ((`c3`.`id` = `u`.`id`)))
join `agregan` `a` on
    ((`a`.`id` = `u`.`id`)))
join `articulo` `a2` on
    ((`a`.`idArticulo` = `a2`.`id`)))
group by
    `u`.`id`,
    `c`.`idCompra`,
    `e`.`idEnvios`;


-- pigeon.infoUsuario source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `infoUsuario` AS
select
    `u`.`id` AS `id`,
    `u`.`nombre` AS `nombre`,
    `u`.`apellido` AS `apellido`,
    `u`.`email` AS `email`,
    `u`.`telefono` AS `telefono`,
    `u`.`calle` AS `calle`,
    `u`.`Npuerta` AS `nPuerta`
from
    `usuarios` `u`;


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


-- pigeon.loginAdmin source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `loginAdmin` AS
select
    `u`.`email` AS `email`,
    `u`.`contrasena` AS `contrasena`
from
    (`usuarios` `u`
join `administrador` `a` on
    ((`a`.`id` = `u`.`id`)));


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


-- pigeon.verHistorial source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `verHistorial` AS
select
    `a`.`nombre` AS `nombre`,
    `c`.`fecha` AS `fecha`,
    `u`.`id` AS `id`
from
    ((`consulta` `c`
join `articulo` `a` on
    ((`a`.`id` = `c`.`idArticulo`)))
join `usuarios` `u` on
    ((`u`.`id` = `c`.`id`)));

-- Crear el usuario
CREATE USER 'pigeon'@'localhost' IDENTIFIED BY 'pigeon';
GRANT ALL PRIVILEGES ON *.* TO 'pigeon'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;