-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: pigeon
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `id` int unsigned NOT NULL,
  `claveSecreta` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `administrador_unique` (`claveSecreta`),
  CONSTRAINT `Administrador_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agregan`
--

DROP TABLE IF EXISTS `agregan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agregan` (
  `id` int unsigned NOT NULL,
  `idArticulo` int unsigned NOT NULL,
  UNIQUE KEY `Agregan_unique_1` (`idArticulo`),
  KEY `Agregan_Usuarios_FK` (`id`),
  CONSTRAINT `Agregan_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Agregan_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agregan`
--

LOCK TABLES `agregan` WRITE;
/*!40000 ALTER TABLE `agregan` DISABLE KEYS */;
/*!40000 ALTER TABLE `agregan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulo` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts') COLLATE utf8mb4_general_ci NOT NULL,
  `descuento` int DEFAULT '0',
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `stock` int unsigned NOT NULL DEFAULT '0',
  `empresa` int unsigned NOT NULL,
  `rutaImagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '../../assets/img/productos/error.png',
  `fechaAgregado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `calificacion` decimal(3,2) NOT NULL DEFAULT '0.00',
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `articulo_empresa_FK` (`empresa`),
  CONSTRAINT `articulo_empresa_FK` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (268,'Teléfono Móvil XYZ',299.99,'Teléfonos móviles',0,'Teléfono móvil con pantalla de 6.5 pulgadas.',50,8,'/assets/img/productos/pngtree-the-new-xyz-smartphone-design-and-innovation-png-image_13165364.png','2024-10-18 07:31:18',0.00,1),(269,'Laptop ABC',899.99,'Computadoras y Laptops',0,'Laptop de alto rendimiento con procesador i7.',30,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',5.00,1),(270,'Televisor LED 55\"',499.99,'Televisores y Audio',10,'Televisor 4K con HDR y Smart TV.',20,8,'/assets/img/productos/1-106.png','2024-10-18 07:31:18',0.00,1),(271,'Auriculares Inalámbricos',89.99,'Accesorios tecnológicos',0,'Auriculares Bluetooth con cancelación de ruido.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(272,'Camisa de Hombre',39.99,'Ropa de Hombre',0,'Camisa de algodón, disponible en varias tallas.',200,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(273,'Vestido de Mujer',49.99,'Ropa de Mujer',0,'Vestido elegante, ideal para ocasiones especiales.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(274,'Zapatillas Deportivas',59.99,'Ropa Deportiva',0,'Zapatillas cómodas para correr.',75,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(275,'Juguete Educativo',19.99,'Juguetes para Niños',0,'Juguete que estimula la creatividad de los niños.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(276,'Silla de Oficina',149.99,'Muebles',0,'Silla ergonómica para largas horas de trabajo.',40,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(277,'Cafetera Automática',79.99,'Herramientas y Mejoras para el Hogar',0,'Cafetera de fácil uso para preparar café.',60,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(278,'Set de Jardinería',29.99,'Jardinería',0,'Set completo de herramientas para el jardín.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(279,'Crema Hidratante',24.99,'Productos para el Cuidado de la Piel',0,'Crema que proporciona hidratación profunda.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(280,'Paleta de Maquillaje',34.99,'Maquillaje',0,'Paleta con colores vibrantes para todo tipo de piel.',90,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(281,'Shampoo Nutritivo',12.99,'Productos para el Cuidado del Cabello',0,'Shampoo enriquecido con vitaminas.',200,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(282,'Proteína en Polvo',39.99,'Suplementos y Vitaminas',0,'Suplemento de proteína para deportistas.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(283,'Bicicleta de Montaña',299.99,'Bicicletas y Patinetes',0,'Bicicleta robusta para todo tipo de terrenos.',20,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(284,'Tienda de Camping',199.99,'Camping y Senderismo',0,'Tienda liviana y fácil de montar.',15,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(285,'Juego de Mesa Clásico',24.99,'Juegos de Mesa',0,'Juego de mesa que reúne a la familia.',120,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(286,'Consola de Videojuegos',399.99,'Videojuegos y Consolas',0,'Consola de última generación.',25,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(287,'Puzzles de 1000 Piezas',19.99,'Puzzles y Rompecabezas',0,'Puzzle desafiante para amantes de los rompecabezas.',50,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(288,'Accesorio para Auto',39.99,'Accesorios para Automóviles',0,'Accesorio práctico para mejorar la comodidad en el auto.',75,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(289,'Accesorio para Moto',49.99,'Accesorios para Motocicletas',0,'Accesorio que aumenta la seguridad al conducir.',40,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(290,'Set de Herramientas',59.99,'Herramientas y Equipos',0,'Set de herramientas para cualquier tipo de trabajo.',60,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(291,'Neumático de Coche',79.99,'Neumáticos y Llantas',0,'Neumático duradero y seguro para tu coche.',30,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(292,'Gourmet Snack',9.99,'Comida Gourmet',0,'Snack delicioso y saludable.',200,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(293,'Vino Tinto',29.99,'Bebidas Alcohólicas',0,'Vino tinto de la mejor calidad.',50,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(294,'Almendras Orgánicas',14.99,'Alimentos Orgánicos',0,'Almendras orgánicas, un snack saludable.',120,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(295,'Barra de Chocolate',2.99,'Snacks y Dulces',0,'Barra de chocolate oscuro.',250,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(296,'Smartwatch',199.99,'Accesorios tecnológicos',0,'Reloj inteligente con múltiples funciones.',35,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(297,'Cámara Digital',499.99,'Accesorios tecnológicos',0,'Cámara de alta definición para fotografía.',20,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(298,'Cargador Solar',49.99,'Accesorios tecnológicos',0,'Cargador portátil que funciona con energía solar.',70,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(299,'Mesa de Comedor',299.99,'Muebles',0,'Mesa de comedor de madera para 6 personas.',15,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(300,'Sofá Cama',399.99,'Muebles',0,'Sofá que se convierte en cama, ideal para visitas.',10,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(301,'Pantalón de Hombre',49.99,'Ropa de Hombre',0,'Pantalón de tela cómoda, ideal para el trabajo.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(302,'Chaqueta de Mujer',79.99,'Ropa de Mujer',0,'Chaqueta abrigadora para climas fríos.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(303,'Botas de Trabajo',99.99,'Zapatos y Accesorios',0,'Botas resistentes y cómodas para el trabajo.',60,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(304,'Mochila Escolar',34.99,'Ropa para Niños',0,'Mochila con diseños divertidos para niños.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(305,'Juego de Construcción',29.99,'Juguetes para Niños',0,'Juego de bloques para desarrollar habilidades motoras.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(306,'Gafas de Sol',24.99,'Accesorios para Automóviles',0,'Gafas de sol con protección UV.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(307,'Manta de Picnic',19.99,'Camping y Senderismo',0,'Manta ideal para salir de picnic.',50,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(308,'Reloj de Pared',34.99,'Decoración',0,'Reloj de pared moderno para el hogar.',30,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(309,'Portavelas',12.99,'Decoración',0,'Portavelas decorativo para iluminar espacios.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(310,'Espejo Decorativo',49.99,'Decoración',0,'Espejo con marco elegante para cualquier habitación.',25,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(311,'Lámpara LED',19.99,'Decoración',0,'Lámpara LED eficiente y de bajo consumo.',60,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(312,'Almohada Ergonomica',29.99,'Muebles',0,'Almohada que brinda soporte para el cuello.',70,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(313,'Colchón Doble',399.99,'Muebles',0,'Colchón de alta calidad para mayor comodidad.',15,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(314,'Botella de Agua',9.99,'Accesorios tecnológicos',0,'Botella reutilizable para mantenerte hidratado.',200,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(315,'Taza de Cerámica',14.99,'',0,'Taza de cerámica con diseño único.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(316,'Set de Cuchillos',49.99,'Herramientas y Mejoras para el Hogar',0,'Set de cuchillos de cocina de acero inoxidable.',40,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(317,'Funda para Laptop',29.99,'Accesorios tecnológicos',0,'Funda acolchada para proteger tu laptop.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(318,'Mochila de Senderismo',89.99,'Camping y Senderismo',0,'Mochila resistente para largas caminatas.',30,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(319,'Chaqueta Impermeable',59.99,'Ropa Deportiva',0,'Chaqueta que protege de la lluvia.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(320,'Camiseta Deportiva',24.99,'Ropa Deportiva',0,'Camiseta cómoda y transpirable para hacer ejercicio.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(321,'Botiquín de Primeros Auxilios',39.99,'Herramientas y Mejoras para el Hogar',0,'Kit completo para emergencias.',40,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(322,'Luz LED para Bicicleta',19.99,'Bicicletas y Patinetes',0,'Luz que aumenta la seguridad al montar.',60,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(323,'Ropa de Cama',49.99,'Muebles',0,'Juego de sábanas de algodón suave.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(324,'Tarjetero de Cuero',19.99,'',0,'Tarjetero elegante y duradero.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(325,'Portátil de Videojuegos',299.99,'Videojuegos y Consolas',0,'Dispositivo portátil para jugar en cualquier lugar.',25,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(326,'Altavoz Bluetooth',79.99,'Accesorios tecnológicos',0,'Altavoz inalámbrico con gran calidad de sonido.',50,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(327,'Conector HDMI',9.99,'Accesorios tecnológicos',0,'Cable HDMI de alta velocidad.',200,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(328,'Juego de Sartenes',59.99,'Herramientas y Mejoras para el Hogar',0,'Juego de sartenes antiadherentes.',30,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(329,'Paraguas',14.99,'',0,'Paraguas resistente y liviano.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(330,'Cojín Decorativo',19.99,'Decoración',0,'Cojín suave para dar color a tu hogar.',75,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(331,'Set de Baño',39.99,'',0,'Set de toallas de baño de alta calidad.',60,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(332,'Bolsa de Deporte',34.99,'Ropa Deportiva',0,'Bolsa para llevar tus cosas al gimnasio.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(333,'Ropa de Entrenamiento',49.99,'Ropa Deportiva',0,'Conjunto cómodo para entrenar.',80,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(334,'Termo de Acero',29.99,'Accesorios tecnológicos',0,'Termo que mantiene la temperatura de las bebidas.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(335,'Cámara de Seguridad',99.99,'Herramientas y Mejoras para el Hogar',0,'Cámara para vigilancia con conexión Wi-Fi.',40,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(336,'Estantería de Madera',149.99,'Muebles',0,'Estantería elegante y funcional.',25,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(337,'Bandeja Organizadora',19.99,'',0,'Bandeja para mantener ordenados los objetos.',100,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(338,'Cuaderno de Notas',6.99,'',0,'Cuaderno con hojas recicladas.',200,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(339,'Bolígrafo de Lujo',14.99,'',0,'Bolígrafo elegante para escribir.',150,8,'../../assets/img/productos/error.png','2024-10-18 07:31:18',0.00,1),(340,'Frecuencia Cafre - Los Cafres',14.99,'Música y CDs',0,'ALBUM ORIGINAL - LOS CAFRES - FRECUENCIA CAFRE',50,8,'/assets/img/productos/600x600bf-60.jpg','2024-11-01 22:00:29',0.00,1),(341,'cerveza michelob',1.99,'Bebidas Alcohólicas',0,'cerveza de arroz, ligth y deliciosa, la cerveza de los campeones',1400,8,'/assets/img/productos/images.jpeg','2024-11-01 22:28:42',0.00,1);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificacion` (
  `id_articulo` int unsigned NOT NULL,
  `id_usuario` int unsigned NOT NULL,
  `puntuacion` decimal(3,2) NOT NULL,
  `comentario` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_calificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`,`id_articulo`),
  KEY `calificacion_articulo_FK` (`id_articulo`),
  KEY `calificacion_usuarios_FK` (`id_usuario`),
  CONSTRAINT `calificacion_articulo_FK` FOREIGN KEY (`id_articulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calificacion_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
INSERT INTO `calificacion` VALUES (269,15,5.00,'Genial!','2024-10-21 11:13:30');
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `IdCarrito` int unsigned NOT NULL AUTO_INCREMENT,
  `Estado` enum('PROCESO DE PAGO','NO PAGO') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO PAGO',
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`IdCarrito`),
  UNIQUE KEY `Carrito_unique` (`id`),
  CONSTRAINT `Carrito_Cliente_FK` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (7,'PROCESO DE PAGO','2024-10-22 10:44:23',15),(11,'PROCESO DE PAGO','2024-10-22 12:25:19',22),(12,'NO PAGO','2024-10-24 20:39:42',23),(13,'NO PAGO','2024-10-26 09:54:52',24);
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Cliente_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (15),(22),(23),(24);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compone`
--

DROP TABLE IF EXISTS `compone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compone` (
  `idCarrito` int unsigned NOT NULL,
  `idArticulo` int unsigned NOT NULL,
  `cantidad` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idArticulo`,`idCarrito`),
  KEY `compone_carrito_FK` (`idCarrito`),
  CONSTRAINT `compone_articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compone_carrito_FK` FOREIGN KEY (`idCarrito`) REFERENCES `carrito` (`IdCarrito`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compone`
--

LOCK TABLES `compone` WRITE;
/*!40000 ALTER TABLE `compone` DISABLE KEYS */;
INSERT INTO `compone` VALUES (13,269,1),(13,271,1),(12,284,1),(11,293,10);
/*!40000 ALTER TABLE `compone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `fechaCompra` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCompra` int unsigned NOT NULL AUTO_INCREMENT,
  `idCarrito` int unsigned NOT NULL,
  `metodoPago` enum('paypal','mercado Pago') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idCompra`),
  UNIQUE KEY `compra_unique` (`idCarrito`),
  CONSTRAINT `compra_carrito_FK` FOREIGN KEY (`idCarrito`) REFERENCES `carrito` (`IdCarrito`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES ('2024-10-22 10:45:04',6,7,'paypal'),('2024-10-22 12:25:19',8,11,'paypal');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
INSERT INTO `consulta` VALUES ('2024-09-21 11:36:00',268,15),('2024-10-21 11:36:00',268,15),('2024-10-21 11:36:48',268,15),('2024-10-21 11:38:09',268,15),('2024-10-21 13:07:14',268,15),('2024-10-21 13:09:20',268,15),('2024-10-21 13:09:51',268,15),('2024-10-21 13:09:54',268,15),('2024-10-21 13:09:55',268,15),('2024-10-22 21:53:22',268,22),('2024-10-22 22:39:20',268,22),('2024-10-25 18:48:00',268,23),('2024-10-26 01:44:03',268,23),('2024-10-26 01:48:36',268,23),('2024-11-01 20:11:18',268,15),('2024-11-01 20:11:38',268,15),('2024-10-26 01:40:56',269,23),('2024-10-26 01:44:08',269,23),('2024-10-26 01:45:25',269,23),('2024-10-26 01:45:28',269,23),('2024-10-26 01:45:31',269,23),('2024-10-26 12:23:03',269,23),('2024-10-26 12:58:09',269,24),('2024-10-21 13:07:10',271,15),('2024-10-26 12:57:14',271,24),('2024-10-22 20:31:52',279,22),('2024-10-26 02:00:58',284,23),('2024-10-26 02:01:13',284,23),('2024-10-22 20:18:35',337,22),('2024-10-22 20:10:21',339,22),('2024-10-22 20:18:47',339,22),('2024-11-02 01:29:21',339,15),('2024-11-02 01:01:54',340,15),('2024-11-02 01:29:18',340,15),('2024-11-02 01:29:09',341,15);
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crea`
--

DROP TABLE IF EXISTS `crea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crea` (
  `idEnvio` int unsigned NOT NULL,
  `idCompra` int unsigned NOT NULL,
  PRIMARY KEY (`idEnvio`),
  UNIQUE KEY `crea_unique` (`idCompra`),
  CONSTRAINT `crea_compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `crea_envios_FK` FOREIGN KEY (`idEnvio`) REFERENCES `envios` (`idEnvios`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crea`
--

LOCK TABLES `crea` WRITE;
/*!40000 ALTER TABLE `crea` DISABLE KEYS */;
INSERT INTO `crea` VALUES (6,6),(7,8);
/*!40000 ALTER TABLE `crea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `idEmpresa` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts') COLLATE utf8mb4_general_ci NOT NULL,
  `RUT` bigint unsigned NOT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idEmpresa`),
  UNIQUE KEY `empresa_unique` (`email`),
  UNIQUE KEY `empresa_unique_1` (`nombre`),
  UNIQUE KEY `empresa_unique_2` (`RUT`),
  UNIQUE KEY `empresa_unique_3` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (8,'empresa1@example.com','Empresa Uno','Teléfonos móviles',12345678,'123456789'),(9,'empresa2@example.com','Empresa Dos','Computadoras y Laptops',23456789,'987654321'),(10,'empresa3@example.com','Empresa Tres','Ropa de Hombre',34567890,'456123789'),(11,'empresa4@example.com','Empresa Cuatro','Videojuegos y Consolas',45678901,'321654987'),(12,'empresa5@example.com','Empresa Cinco','Muebles',56789012,'789123456');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envios` (
  `idEnvios` int unsigned NOT NULL AUTO_INCREMENT,
  `metodoEnvio` enum('RETIRO','EXPRESS','NORMAL') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'RETIRO',
  `fechaSalida` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaLlegada` datetime DEFAULT NULL,
  `idUsuario` int unsigned NOT NULL,
  PRIMARY KEY (`idEnvios`),
  KEY `envios_usuarios_FK` (`idUsuario`),
  CONSTRAINT `envios_usuarios_FK` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envios`
--

LOCK TABLES `envios` WRITE;
/*!40000 ALTER TABLE `envios` DISABLE KEYS */;
INSERT INTO `envios` VALUES (5,'EXPRESS','2024-10-22 10:45:43',NULL,15),(6,'EXPRESS','2024-10-22 11:15:59',NULL,22),(7,'EXPRESS','2024-10-22 12:27:08',NULL,22);
/*!40000 ALTER TABLE `envios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generan`
--

DROP TABLE IF EXISTS `generan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generan` (
  `idArticulo` int unsigned NOT NULL,
  `idFactura` int unsigned NOT NULL,
  PRIMARY KEY (`idFactura`),
  UNIQUE KEY `generan_unique` (`idArticulo`),
  CONSTRAINT `generan_articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `generan_factura_FK` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Una factura se genera con un id de articulo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generan`
--

LOCK TABLES `generan` WRITE;
/*!40000 ALTER TABLE `generan` DISABLE KEYS */;
/*!40000 ALTER TABLE `generan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `getarticuloscarrito`
--

DROP TABLE IF EXISTS `getarticuloscarrito`;
/*!50001 DROP VIEW IF EXISTS `getarticuloscarrito`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `getarticuloscarrito` AS SELECT 
 1 AS `id`,
 1 AS `nombre`,
 1 AS `precio`,
 1 AS `categoria`,
 1 AS `descuento`,
 1 AS `descripcion`,
 1 AS `stock`,
 1 AS `rutaImagen`,
 1 AS `calificacion`,
 1 AS `CarritoId`,
 1 AS `ComponenteCarritoId`,
 1 AS `cantidad`,
 1 AS `UsuarioId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `getordenes`
--

DROP TABLE IF EXISTS `getordenes`;
/*!50001 DROP VIEW IF EXISTS `getordenes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `getordenes` AS SELECT 
 1 AS `idEnvio`,
 1 AS `idCompra`,
 1 AS `metodoEnvio`,
 1 AS `fechaSalida`,
 1 AS `fechaLlegada`,
 1 AS `calle`,
 1 AS `Npuerta`,
 1 AS `userId`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `infousuario`
--

DROP TABLE IF EXISTS `infousuario`;
/*!50001 DROP VIEW IF EXISTS `infousuario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `infousuario` AS SELECT 
 1 AS `id`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `email`,
 1 AS `telefono`,
 1 AS `calle`,
 1 AS `nPuerta`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `listar_articulos`
--

DROP TABLE IF EXISTS `listar_articulos`;
/*!50001 DROP VIEW IF EXISTS `listar_articulos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `listar_articulos` AS SELECT 
 1 AS `id`,
 1 AS `nombre`,
 1 AS `descripcion`,
 1 AS `rutaImagen`,
 1 AS `descuento`,
 1 AS `precio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `listar_articulos_lista`
--

DROP TABLE IF EXISTS `listar_articulos_lista`;
/*!50001 DROP VIEW IF EXISTS `listar_articulos_lista`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `listar_articulos_lista` AS SELECT 
 1 AS `id`,
 1 AS `nombre`,
 1 AS `precio`,
 1 AS `categoria`,
 1 AS `descuento`,
 1 AS `descripcion`,
 1 AS `stock`,
 1 AS `rutaImagen`,
 1 AS `calificacion`,
 1 AS `VISIBLE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `loginadmin`
--

DROP TABLE IF EXISTS `loginadmin`;
/*!50001 DROP VIEW IF EXISTS `loginadmin`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `loginadmin` AS SELECT 
 1 AS `email`,
 1 AS `contrasena`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pertenece`
--

DROP TABLE IF EXISTS `pertenece`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pertenece` (
  `id` int unsigned NOT NULL,
  `idEmpresa` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pertenece_empresa_FK` (`idEmpresa`),
  CONSTRAINT `pertenece_empresa_FK` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pertenece_vendedor_FK` FOREIGN KEY (`id`) REFERENCES `vendedor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='El vendedor pertenece a una empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pertenece`
--

LOCK TABLES `pertenece` WRITE;
/*!40000 ALTER TABLE `pertenece` DISABLE KEYS */;
INSERT INTO `pertenece` VALUES (10,8),(15,8);
/*!40000 ALTER TABLE `pertenece` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recibe`
--

DROP TABLE IF EXISTS `recibe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recibe` (
  `idFactura` int unsigned NOT NULL,
  `id` int unsigned NOT NULL,
  PRIMARY KEY (`idFactura`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `recibe_ibfk_1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recibe_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Las facturas que recibe el cliente';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recibe`
--

LOCK TABLES `recibe` WRITE;
/*!40000 ALTER TABLE `recibe` DISABLE KEYS */;
INSERT INTO `recibe` VALUES (1,3),(3,3),(2,4);
/*!40000 ALTER TABLE `recibe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `tomar_calificacion`
--

DROP TABLE IF EXISTS `tomar_calificacion`;
/*!50001 DROP VIEW IF EXISTS `tomar_calificacion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tomar_calificacion` AS SELECT 
 1 AS `nombre_usuario`,
 1 AS `calificacion`,
 1 AS `comentario`,
 1 AS `fecha_calificacion`,
 1 AS `id_articulo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  UNIQUE KEY `Usuarios_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Los usuarios del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (2,'Pérez','María Jose','Avenida Siempre Viva ','maria.perez@example.com','$2y$10$n4fBVnKDwKFPOu3H/Mw/z.1f7M3wyI3Ewgc3FSjLAWSD52PVa84Ue','34B','300765432',1),(3,'López','Carlos','Boulevard de los Sueños','carlos.lopez@example.com','$2y$10$bKZBqYtb7/duOugcL31ikeMzOMckge2qJo860XitkBX.N5qsaU/oy','56C','300112233',1),(4,'Tilla','Aitor','Octava Avenida','aitor@example.com','$2y$10$Y351vm7y7UrDcNLDRzmsm.S7KS65.nUNF6cemi2SwUMmADhMxMKkG','8455','300445566',1),(10,'Vazquez','Santiago','Dr. Jose Maria Penco','santi.vazquez.rubio@gmail.com','$2y$10$OsQB4yEicwkcDVTAzNDDv.5r6w0IOMY9wO6CmSMccr/5aYkZeO.lu','3089','099099098',1),(11,'Vazquez','Niro','Bulevar Artigas','nirovazquez@gmail.com','$2y$10$jH6erQmrxxsFcZ3PEiWGtOJyxaEOoaBL7T9KMhcZHuIUidf7.lx4G','9884','099445566',1),(12,'Zanini','Giovanni','Lucas Obes','giovazanini@gmail.com','$2y$10$1Gktbg8eTDdCNPe78yyfKefGm2IzHFw7Qf3COFl5uw.xr3dG5rFSW','5482','094578154',1),(13,'menta','aitor','null','aitormenta@example.com','$2y$10$R5L1zIdD/K3Nr.4nXfEkhuLqsMMsRWVP6KXXM6MXotuZ3LmuGzVp2','','098459875',1),(14,'ELA','DMIN','calle','pigeontompkins.industries@gmail.com','HOLA','300','095095095',1),(15,'Blanco','Rodrigo','','rodri@gmail.com','$2y$10$9V7370E2Ng3VlfpP3V2IauCjh5Xv72LCYuaNo3HFZnCtT1Uhx3V/G','','',1),(23,'Vazquez','Luis','','luis@gmail.com','$2y$10$DQbmncQQYFkGP5VTlnKdhOCiKKeN8PEKIdJpW3uGxvAe0eJQdtuCa','','',1),(24,'rubio','veronica','jose maria penco','vrubio@montevideo.com.uy','$2y$10$f10eR.W1MoWfIQ/XKLq5EuAjxTkqv2z3827VYgyRBtNNzLzQ3tEd.','3089','',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `id` int unsigned NOT NULL,
  `admin` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `Vendedor_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Vendedores representantes de las empresas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (4,0),(10,1),(15,0);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `verhistorial`
--

DROP TABLE IF EXISTS `verhistorial`;
/*!50001 DROP VIEW IF EXISTS `verhistorial`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `verhistorial` AS SELECT 
 1 AS `fecha`,
 1 AS `idArticulo`,
 1 AS `idUsuario`,
 1 AS `nombre`,
 1 AS `precio`,
 1 AS `rutaImagen`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_articulos_por_mes`
--

DROP TABLE IF EXISTS `vista_articulos_por_mes`;
/*!50001 DROP VIEW IF EXISTS `vista_articulos_por_mes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_articulos_por_mes` AS SELECT 
 1 AS `año`,
 1 AS `mes`,
 1 AS `nombreMes`,
 1 AS `idArticulo`,
 1 AS `total_articulos`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'pigeon'
--

--
-- Final view structure for view `getarticuloscarrito`
--

/*!50001 DROP VIEW IF EXISTS `getarticuloscarrito`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getarticuloscarrito` AS select `a`.`id` AS `id`,`a`.`nombre` AS `nombre`,`a`.`precio` AS `precio`,`a`.`categoria` AS `categoria`,`a`.`descuento` AS `descuento`,`a`.`descripcion` AS `descripcion`,`a`.`stock` AS `stock`,`a`.`rutaImagen` AS `rutaImagen`,`a`.`calificacion` AS `calificacion`,`c`.`IdCarrito` AS `CarritoId`,`c2`.`idCarrito` AS `ComponenteCarritoId`,`c2`.`cantidad` AS `cantidad`,`u`.`id` AS `UsuarioId` from (((`carrito` `c` join `compone` `c2` on((`c`.`IdCarrito` = `c2`.`idCarrito`))) join `articulo` `a` on((`a`.`id` = `c2`.`idArticulo`))) join `usuarios` `u` on((`u`.`id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `getordenes`
--

/*!50001 DROP VIEW IF EXISTS `getordenes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getordenes` AS select `c`.`idEnvio` AS `idEnvio`,`c`.`idCompra` AS `idCompra`,`e`.`metodoEnvio` AS `metodoEnvio`,`e`.`fechaSalida` AS `fechaSalida`,`e`.`fechaLlegada` AS `fechaLlegada`,`u`.`calle` AS `calle`,`u`.`Npuerta` AS `Npuerta`,`u`.`id` AS `userId` from ((((`crea` `c` join `compra` `c2` on((`c2`.`idCompra` = `c`.`idCompra`))) join `envios` `e` on((`e`.`idEnvios` = `c`.`idEnvio`))) join `carrito` `c3` on((`c3`.`IdCarrito` = `c2`.`idCarrito`))) join `usuarios` `u` on((`u`.`id` = `c3`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `infousuario`
--

/*!50001 DROP VIEW IF EXISTS `infousuario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `infousuario` AS select `u`.`id` AS `id`,`u`.`nombre` AS `nombre`,`u`.`apellido` AS `apellido`,`u`.`email` AS `email`,`u`.`telefono` AS `telefono`,`u`.`calle` AS `calle`,`u`.`Npuerta` AS `nPuerta` from `usuarios` `u` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `listar_articulos`
--

/*!50001 DROP VIEW IF EXISTS `listar_articulos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `listar_articulos` AS select `a`.`id` AS `id`,`a`.`nombre` AS `nombre`,`a`.`descripcion` AS `descripcion`,`a`.`rutaImagen` AS `rutaImagen`,`a`.`descuento` AS `descuento`,`a`.`precio` AS `precio` from `articulo` `a` where (`a`.`VISIBLE` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `listar_articulos_lista`
--

/*!50001 DROP VIEW IF EXISTS `listar_articulos_lista`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `listar_articulos_lista` AS select `a`.`id` AS `id`,`a`.`nombre` AS `nombre`,`a`.`precio` AS `precio`,`a`.`categoria` AS `categoria`,`a`.`descuento` AS `descuento`,`a`.`descripcion` AS `descripcion`,`a`.`stock` AS `stock`,`a`.`rutaImagen` AS `rutaImagen`,`a`.`calificacion` AS `calificacion`,`a`.`VISIBLE` AS `VISIBLE` from `articulo` `a` where (`a`.`VISIBLE` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `loginadmin`
--

/*!50001 DROP VIEW IF EXISTS `loginadmin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `loginadmin` AS select `u`.`email` AS `email`,`u`.`contrasena` AS `contrasena` from (`usuarios` `u` join `administrador` `a` on((`a`.`id` = `u`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tomar_calificacion`
--

/*!50001 DROP VIEW IF EXISTS `tomar_calificacion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tomar_calificacion` AS select `u`.`nombre` AS `nombre_usuario`,`c`.`puntuacion` AS `calificacion`,`c`.`comentario` AS `comentario`,`c`.`fecha_calificacion` AS `fecha_calificacion`,`c`.`id_articulo` AS `id_articulo` from ((`calificacion` `c` join `usuarios` `u` on((`c`.`id_usuario` = `u`.`id`))) join `articulo` `a` on((`c`.`id_articulo` = `a`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `verhistorial`
--

/*!50001 DROP VIEW IF EXISTS `verhistorial`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `verhistorial` AS select `c`.`fecha` AS `fecha`,`a`.`id` AS `idArticulo`,`u`.`id` AS `idUsuario`,`a`.`nombre` AS `nombre`,`a`.`precio` AS `precio`,`a`.`rutaImagen` AS `rutaImagen` from ((`consulta` `c` join `articulo` `a` on((`a`.`id` = `c`.`idArticulo`))) join `usuarios` `u` on((`u`.`id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_articulos_por_mes`
--

/*!50001 DROP VIEW IF EXISTS `vista_articulos_por_mes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_articulos_por_mes` AS select year(`consulta`.`fecha`) AS `año`,month(`consulta`.`fecha`) AS `mes`,monthname(`consulta`.`fecha`) AS `nombreMes`,`consulta`.`idArticulo` AS `idArticulo`,count(0) AS `total_articulos` from `consulta` group by year(`consulta`.`fecha`),month(`consulta`.`fecha`),monthname(`consulta`.`fecha`),`consulta`.`idArticulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-03  1:55:15
