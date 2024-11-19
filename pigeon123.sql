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
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  KEY `Carrito_Cliente_FK` (`id`),
  CONSTRAINT `Carrito_Cliente_FK` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `direccion` varchar(256) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `npuerta` smallint NOT NULL,
  PRIMARY KEY (`idEnvios`),
  KEY `envios_usuarios_FK` (`idUsuario`),
  CONSTRAINT `envios_usuarios_FK` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `horaEmitida` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idFactura` int unsigned NOT NULL AUTO_INCREMENT,
  `contenido` text COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idFactura`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
 1 AS `UsuarioId`,
 1 AS `fechaCarrito`*/;
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
-- Table structure for table `historial`
--

DROP TABLE IF EXISTS `historial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial` (
  `idCompra` int unsigned NOT NULL,
  `idUsuario` int unsigned NOT NULL,
  `estado` enum('entregado','no entregado') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`idCompra`,`idUsuario`),
  KEY `historial_usuarios_FK` (`idUsuario`),
  CONSTRAINT `historial_compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `historial_usuarios_FK` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  CONSTRAINT `pertenece_usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='El vendedor pertenece a una empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `contrasena` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Npuerta` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Usuarios_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Los usuarios del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `id` int unsigned NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `Vendedor_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Vendedores representantes de las empresas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `verhistorial`
--

DROP TABLE IF EXISTS `verhistorial`;
/*!50001 DROP VIEW IF EXISTS `verhistorial`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `verhistorial` AS SELECT 
 1 AS `nombre`,
 1 AS `fecha`,
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `getarticuloscarrito`
--

/*!50001 DROP VIEW IF EXISTS `getarticuloscarrito`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getarticuloscarrito` AS select `a`.`id` AS `id`,`a`.`nombre` AS `nombre`,`a`.`precio` AS `precio`,`a`.`categoria` AS `categoria`,`a`.`descuento` AS `descuento`,`a`.`descripcion` AS `descripcion`,`a`.`stock` AS `stock`,`a`.`rutaImagen` AS `rutaImagen`,`a`.`calificacion` AS `calificacion`,`c`.`IdCarrito` AS `CarritoId`,`c2`.`idCarrito` AS `ComponenteCarritoId`,`c2`.`cantidad` AS `cantidad`,`u`.`id` AS `UsuarioId`,`c`.`fecha` AS `fechaCarrito` from (((`carrito` `c` join `compone` `c2` on((`c`.`IdCarrito` = `c2`.`idCarrito`))) join `articulo` `a` on((`a`.`id` = `c2`.`idArticulo`))) join `usuarios` `u` on((`u`.`id` = `c`.`id`))) order by `c`.`fecha` */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getordenes` AS select `c`.`idEnvio` AS `idEnvio`,`c`.`idCompra` AS `idCompra`,`e`.`metodoEnvio` AS `metodoEnvio`,`e`.`fechaSalida` AS `fechaSalida`,`e`.`fechaLlegada` AS `fechaLlegada`,`e`.`direccion` AS `calle`,`e`.`npuerta` AS `Npuerta`,`u`.`id` AS `userId` from ((((`crea` `c` join `compra` `c2` on((`c2`.`idCompra` = `c`.`idCompra`))) join `envios` `e` on((`e`.`idEnvios` = `c`.`idEnvio`))) join `carrito` `c3` on((`c3`.`IdCarrito` = `c2`.`idCarrito`))) join `usuarios` `u` on((`u`.`id` = `c3`.`id`))) */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
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
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `verhistorial` AS select `a`.`nombre` AS `nombre`,`c`.`fecha` AS `fecha`,`u`.`id` AS `id` from ((`consulta` `c` join `articulo` `a` on((`a`.`id` = `c`.`idArticulo`))) join `usuarios` `u` on((`u`.`id` = `c`.`id`))) */;
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

-- Dump completed on 2024-11-07  1:32:08
