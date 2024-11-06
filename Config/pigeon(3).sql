-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2024 at 01:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

CREATE DATABASE pigeon;
USE pigeon;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pigeon`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrador`
--

CREATE TABLE `administrador` (
  `id` int(10) UNSIGNED NOT NULL,
  `claveSecreta` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `agregan`
--

CREATE TABLE `agregan` (
  `id` int(10) UNSIGNED NOT NULL,
  `idArticulo` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `articulo`
--

CREATE TABLE `articulo` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts') NOT NULL,
  `descuento` int(11) DEFAULT 0,
  `descripcion` text NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `empresa` int(10) UNSIGNED NOT NULL,
  `rutaImagen` varchar(255) NOT NULL DEFAULT '../../assets/img/productos/error.png',
  `fechaAgregado` datetime NOT NULL DEFAULT current_timestamp(),
  `calificacion` decimal(3,2) NOT NULL DEFAULT 0.00,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `articulo`
--

INSERT INTO `articulo` (`id`, `nombre`, `precio`, `categoria`, `descuento`, `descripcion`, `stock`, `empresa`, `rutaImagen`, `fechaAgregado`, `calificacion`, `VISIBLE`) VALUES
(268, 'Teléfono Móvil XYZ', 299.99, 'Teléfonos móviles', 0, 'Teléfono móvil con pantalla de 6.5 pulgadas.', 50, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 5.00, 1),
(269, 'Laptop ABC', 899.99, 'Computadoras y Laptops', 15, 'Laptop de alto rendimiento con procesador i7.', 30, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 5.00, 1),
(270, 'Televisor LED 55\"', 499.99, 'Televisores y Audio', 0, 'Televisor 4K con HDR y Smart TV.', 20, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(271, 'Auriculares Inalámbricos', 89.99, 'Accesorios tecnológicos', 0, 'Auriculares Bluetooth con cancelación de ruido.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(272, 'Camisa de Hombre', 39.99, 'Ropa de Hombre', 0, 'Camisa de algodón, disponible en varias tallas.', 200, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(273, 'Vestido de Mujer', 49.99, 'Ropa de Mujer', 0, 'Vestido elegante, ideal para ocasiones especiales.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(274, 'Zapatillas Deportivas', 59.99, 'Ropa Deportiva', 0, 'Zapatillas cómodas para correr.', 75, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(275, 'Juguete Educativo', 19.99, 'Juguetes para Niños', 0, 'Juguete que estimula la creatividad de los niños.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(276, 'Silla de Oficina', 149.99, 'Muebles', 0, 'Silla ergonómica para largas horas de trabajo.', 40, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(277, 'Cafetera Automática', 79.99, 'Herramientas y Mejoras para el Hogar', 0, 'Cafetera de fácil uso para preparar café.', 60, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(278, 'Set de Jardinería', 29.99, 'Jardinería', 0, 'Set completo de herramientas para el jardín.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(279, 'Crema Hidratante', 24.99, 'Productos para el Cuidado de la Piel', 0, 'Crema que proporciona hidratación profunda.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(280, 'Paleta de Maquillaje', 34.99, 'Maquillaje', 0, 'Paleta con colores vibrantes para todo tipo de piel.', 90, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(281, 'Shampoo Nutritivo', 12.99, 'Productos para el Cuidado del Cabello', 0, 'Shampoo enriquecido con vitaminas.', 200, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(282, 'Proteína en Polvo', 39.99, 'Suplementos y Vitaminas', 0, 'Suplemento de proteína para deportistas.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(283, 'Bicicleta de Montaña', 299.99, 'Bicicletas y Patinetes', 0, 'Bicicleta robusta para todo tipo de terrenos.', 20, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(284, 'Tienda de Camping', 199.99, 'Camping y Senderismo', 0, 'Tienda liviana y fácil de montar.', 15, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(285, 'Juego de Mesa Clásico', 24.99, 'Juegos de Mesa', 0, 'Juego de mesa que reúne a la familia.', 120, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(286, 'Consola de Videojuegos', 399.99, 'Videojuegos y Consolas', 0, 'Consola de última generación.', 25, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(287, 'Puzzles de 1000 Piezas', 19.99, 'Puzzles y Rompecabezas', 0, 'Puzzle desafiante para amantes de los rompecabezas.', 50, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(288, 'Accesorio para Auto', 39.99, 'Accesorios para Automóviles', 0, 'Accesorio práctico para mejorar la comodidad en el auto.', 75, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(289, 'Accesorio para Moto', 49.99, 'Accesorios para Motocicletas', 0, 'Accesorio que aumenta la seguridad al conducir.', 40, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(290, 'Set de Herramientas', 59.99, 'Herramientas y Equipos', 0, 'Set de herramientas para cualquier tipo de trabajo.', 60, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(291, 'Neumático de Coche', 79.99, 'Neumáticos y Llantas', 0, 'Neumático duradero y seguro para tu coche.', 30, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(292, 'Gourmet Snack', 9.99, 'Comida Gourmet', 0, 'Snack delicioso y saludable.', 200, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(293, 'Vino Tinto', 29.99, 'Bebidas Alcohólicas', 0, 'Vino tinto de la mejor calidad.', 50, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(294, 'Almendras Orgánicas', 14.99, 'Alimentos Orgánicos', 0, 'Almendras orgánicas, un snack saludable.', 120, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(295, 'Barra de Chocolate', 2.99, 'Snacks y Dulces', 0, 'Barra de chocolate oscuro.', 250, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(296, 'Smartwatch', 199.99, 'Accesorios tecnológicos', 0, 'Reloj inteligente con múltiples funciones.', 35, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(297, 'Cámara Digital', 499.99, 'Accesorios tecnológicos', 0, 'Cámara de alta definición para fotografía.', 20, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(298, 'Cargador Solar', 49.99, 'Accesorios tecnológicos', 0, 'Cargador portátil que funciona con energía solar.', 70, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(299, 'Mesa de Comedor', 299.99, 'Muebles', 0, 'Mesa de comedor de madera para 6 personas.', 15, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(300, 'Sofá Cama', 399.99, 'Muebles', 0, 'Sofá que se convierte en cama, ideal para visitas.', 10, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(301, 'Pantalón de Hombre', 49.99, 'Ropa de Hombre', 0, 'Pantalón de tela cómoda, ideal para el trabajo.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(302, 'Chaqueta de Mujer', 79.99, 'Ropa de Mujer', 0, 'Chaqueta abrigadora para climas fríos.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(303, 'Botas de Trabajo', 99.99, 'Zapatos y Accesorios', 0, 'Botas resistentes y cómodas para el trabajo.', 60, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(304, 'Mochila Escolar', 34.99, 'Ropa para Niños', 0, 'Mochila con diseños divertidos para niños.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(305, 'Juego de Construcción', 29.99, 'Juguetes para Niños', 0, 'Juego de bloques para desarrollar habilidades motoras.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(306, 'Gafas de Sol', 24.99, 'Accesorios para Automóviles', 0, 'Gafas de sol con protección UV.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(307, 'Manta de Picnic', 19.99, 'Camping y Senderismo', 0, 'Manta ideal para salir de picnic.', 50, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(308, 'Reloj de Pared', 34.99, 'Decoración', 0, 'Reloj de pared moderno para el hogar.', 30, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(309, 'Portavelas', 12.99, 'Decoración', 0, 'Portavelas decorativo para iluminar espacios.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(310, 'Espejo Decorativo', 49.99, 'Decoración', 0, 'Espejo con marco elegante para cualquier habitación.', 25, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(311, 'Lámpara LED', 19.99, 'Decoración', 0, 'Lámpara LED eficiente y de bajo consumo.', 60, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(312, 'Almohada Ergonomica', 29.99, 'Muebles', 0, 'Almohada que brinda soporte para el cuello.', 70, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(313, 'Colchón Doble', 399.99, 'Muebles', 0, 'Colchón de alta calidad para mayor comodidad.', 15, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(314, 'Botella de Agua', 9.99, 'Accesorios tecnológicos', 0, 'Botella reutilizable para mantenerte hidratado.', 200, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(315, 'Taza de Cerámica', 14.99, '', 0, 'Taza de cerámica con diseño único.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(316, 'Set de Cuchillos', 49.99, 'Herramientas y Mejoras para el Hogar', 0, 'Set de cuchillos de cocina de acero inoxidable.', 40, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(317, 'Funda para Laptop', 29.99, 'Accesorios tecnológicos', 0, 'Funda acolchada para proteger tu laptop.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(318, 'Mochila de Senderismo', 89.99, 'Camping y Senderismo', 0, 'Mochila resistente para largas caminatas.', 30, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(319, 'Chaqueta Impermeable', 59.99, 'Ropa Deportiva', 0, 'Chaqueta que protege de la lluvia.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(320, 'Camiseta Deportiva', 24.99, 'Ropa Deportiva', 0, 'Camiseta cómoda y transpirable para hacer ejercicio.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(321, 'Botiquín de Primeros Auxilios', 39.99, 'Herramientas y Mejoras para el Hogar', 0, 'Kit completo para emergencias.', 40, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(322, 'Luz LED para Bicicleta', 19.99, 'Bicicletas y Patinetes', 0, 'Luz que aumenta la seguridad al montar.', 60, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(323, 'Ropa de Cama', 49.99, 'Muebles', 0, 'Juego de sábanas de algodón suave.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(324, 'Tarjetero de Cuero', 19.99, '', 0, 'Tarjetero elegante y duradero.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(325, 'Portátil de Videojuegos', 299.99, 'Videojuegos y Consolas', 0, 'Dispositivo portátil para jugar en cualquier lugar.', 25, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(326, 'Altavoz Bluetooth', 79.99, 'Accesorios tecnológicos', 0, 'Altavoz inalámbrico con gran calidad de sonido.', 50, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(327, 'Conector HDMI', 9.99, 'Accesorios tecnológicos', 0, 'Cable HDMI de alta velocidad.', 200, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(328, 'Juego de Sartenes', 59.99, 'Herramientas y Mejoras para el Hogar', 0, 'Juego de sartenes antiadherentes.', 30, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(329, 'Paraguas', 14.99, '', 0, 'Paraguas resistente y liviano.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(330, 'Cojín Decorativo', 19.99, 'Decoración', 0, 'Cojín suave para dar color a tu hogar.', 75, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(331, 'Set de Baño', 39.99, '', 0, 'Set de toallas de baño de alta calidad.', 60, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(332, 'Bolsa de Deporte', 34.99, 'Ropa Deportiva', 0, 'Bolsa para llevar tus cosas al gimnasio.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(333, 'Ropa de Entrenamiento', 49.99, 'Ropa Deportiva', 0, 'Conjunto cómodo para entrenar.', 80, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(334, 'Termo de Acero', 29.99, 'Accesorios tecnológicos', 0, 'Termo que mantiene la temperatura de las bebidas.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(335, 'Cámara de Seguridad', 99.99, 'Herramientas y Mejoras para el Hogar', 0, 'Cámara para vigilancia con conexión Wi-Fi.', 40, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(336, 'Estantería de Madera', 149.99, 'Muebles', 0, 'Estantería elegante y funcional.', 25, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(337, 'Bandeja Organizadora', 19.99, '', 0, 'Bandeja para mantener ordenados los objetos.', 100, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(338, 'Cuaderno de Notas', 6.99, '', 0, 'Cuaderno con hojas recicladas.', 200, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1),
(339, 'Bolígrafo de Lujo', 14.99, '', 0, 'Bolígrafo elegante para escribir.', 150, 8, '../../assets/img/productos/error.png', '2024-10-18 07:31:18', 0.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `calificacion`
--

CREATE TABLE `calificacion` (
  `id_articulo` int(10) UNSIGNED NOT NULL,
  `id_usuario` int(10) UNSIGNED NOT NULL,
  `puntuacion` decimal(3,2) NOT NULL,
  `comentario` varchar(250) DEFAULT NULL,
  `fecha_calificacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `calificacion`
--

INSERT INTO `calificacion` (`id_articulo`, `id_usuario`, `puntuacion`, `comentario`, `fecha_calificacion`) VALUES
(269, 15, 5.00, 'Genial!', '2024-10-21 11:13:30'),
(268, 22, 5.00, 'Genial!', '2024-10-31 12:15:54');

-- --------------------------------------------------------

--
-- Table structure for table `carrito`
--

CREATE TABLE `carrito` (
  `IdCarrito` int(10) UNSIGNED NOT NULL,
  `Estado` enum('PROCESO DE PAGO','NO PAGO') NOT NULL DEFAULT 'NO PAGO',
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carrito`
--

INSERT INTO `carrito` (`IdCarrito`, `Estado`, `fecha`, `id`) VALUES
(16, 'NO PAGO', '2024-10-30 14:44:08', 22),
(17, 'NO PAGO', '2024-10-30 14:52:06', 22),
(18, 'NO PAGO', '2024-10-30 15:04:33', 22),
(19, 'NO PAGO', '2024-10-30 15:04:56', 22),
(20, 'NO PAGO', '2024-10-30 15:21:09', 22),
(21, 'NO PAGO', '2024-10-30 15:38:59', 22),
(22, 'NO PAGO', '2024-10-30 16:12:09', 22),
(23, 'NO PAGO', '2024-10-30 16:28:20', 22),
(24, 'NO PAGO', '2024-10-30 16:31:37', 22),
(25, 'NO PAGO', '2024-10-30 16:33:03', 22),
(26, 'NO PAGO', '2024-10-30 16:37:59', 22);

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`id`) VALUES
(15),
(22);

-- --------------------------------------------------------

--
-- Table structure for table `compone`
--

CREATE TABLE `compone` (
  `idCarrito` int(10) UNSIGNED NOT NULL,
  `idArticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `compone`
--

INSERT INTO `compone` (`idCarrito`, `idArticulo`, `cantidad`) VALUES
(16, 268, 1),
(16, 269, 1);

-- --------------------------------------------------------

--
-- Table structure for table `compra`
--

CREATE TABLE `compra` (
  `fechaCompra` datetime NOT NULL DEFAULT current_timestamp(),
  `idCompra` int(10) UNSIGNED NOT NULL,
  `idCarrito` int(10) UNSIGNED NOT NULL,
  `metodoPago` enum('paypal','mercado Pago') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `compra`
--

INSERT INTO `compra` (`fechaCompra`, `idCompra`, `idCarrito`, `metodoPago`) VALUES
('2024-10-30 16:37:59', 38, 16, 'paypal');

-- --------------------------------------------------------

--
-- Table structure for table `consulta`
--

CREATE TABLE `consulta` (
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `idArticulo` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consulta`
--

INSERT INTO `consulta` (`fecha`, `idArticulo`, `id`) VALUES
('2024-10-21 11:36:00', 268, 15),
('2024-10-21 11:36:48', 268, 15),
('2024-10-21 11:38:09', 268, 15),
('2024-10-21 13:07:10', 271, 15),
('2024-10-21 13:07:14', 268, 15),
('2024-10-21 13:09:20', 268, 15),
('2024-10-21 13:09:51', 268, 15),
('2024-10-21 13:09:54', 268, 15),
('2024-10-21 13:09:55', 268, 15),
('2024-10-22 20:10:21', 339, 22),
('2024-10-22 20:18:35', 337, 22),
('2024-10-22 20:18:47', 339, 22),
('2024-10-22 20:31:52', 279, 22),
('2024-10-22 21:53:22', 268, 22),
('2024-10-22 22:39:20', 268, 22),
('2024-10-24 13:20:48', 310, 22),
('2024-10-24 14:58:22', 338, 22),
('2024-10-25 12:06:52', 338, 22),
('2024-10-25 12:43:08', 271, 22),
('2024-10-25 14:16:06', 269, 22),
('2024-10-25 14:23:05', 269, 22),
('2024-10-25 14:24:33', 269, 22),
('2024-10-25 14:32:08', 269, 22),
('2024-10-25 14:53:51', 269, 22),
('2024-10-25 14:54:05', 269, 22),
('2024-10-25 14:54:20', 269, 22),
('2024-10-25 14:54:34', 320, 22),
('2024-10-25 14:54:55', 276, 22),
('2024-10-30 11:45:51', 269, 22),
('2024-10-31 12:14:54', 268, 22),
('2024-10-31 12:15:55', 268, 22);

-- --------------------------------------------------------

--
-- Table structure for table `crea`
--

CREATE TABLE `crea` (
  `idEnvio` int(10) UNSIGNED NOT NULL,
  `idCompra` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crea`
--

INSERT INTO `crea` (`idEnvio`, `idCompra`) VALUES
(11, 38);

-- --------------------------------------------------------

--
-- Table structure for table `empresa`
--

CREATE TABLE `empresa` (
  `idEmpresa` int(10) UNSIGNED NOT NULL,
  `email` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts') NOT NULL,
  `RUT` bigint(20) UNSIGNED NOT NULL,
  `telefono` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `empresa`
--

INSERT INTO `empresa` (`idEmpresa`, `email`, `nombre`, `categoria`, `RUT`, `telefono`) VALUES
(8, 'empresa1@example.com', 'Empresa Uno', 'Teléfonos móviles', 12345678, '123456789'),
(9, 'empresa2@example.com', 'Empresa Dos', 'Computadoras y Laptops', 23456789, '987654321'),
(10, 'empresa3@example.com', 'Empresa Tres', 'Ropa de Hombre', 34567890, '456123789'),
(11, 'empresa4@example.com', 'Empresa Cuatro', 'Videojuegos y Consolas', 45678901, '321654987'),
(12, 'empresa5@example.com', 'Empresa Cinco', 'Muebles', 56789012, '789123456');

-- --------------------------------------------------------

--
-- Table structure for table `envios`
--

CREATE TABLE `envios` (
  `idEnvios` int(10) UNSIGNED NOT NULL,
  `metodoEnvio` enum('RETIRO','EXPRESS','NORMAL') NOT NULL DEFAULT 'RETIRO',
  `fechaSalida` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaLlegada` datetime DEFAULT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `direccion` varchar(256) NOT NULL DEFAULT '',
  `npuerta` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `envios`
--

INSERT INTO `envios` (`idEnvios`, `metodoEnvio`, `fechaSalida`, `fechaLlegada`, `idUsuario`, `direccion`, `npuerta`) VALUES
(11, 'EXPRESS', '2024-10-30 16:37:59', NULL, 22, 'penco', 3089);

-- --------------------------------------------------------

--
-- Table structure for table `factura`
--

CREATE TABLE `factura` (
  `horaEmitida` datetime NOT NULL DEFAULT current_timestamp(),
  `idFactura` int(10) UNSIGNED NOT NULL,
  `contenido` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `generan`
--

CREATE TABLE `generan` (
  `idArticulo` int(10) UNSIGNED NOT NULL,
  `idFactura` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Una factura se genera con un id de articulo';

-- --------------------------------------------------------

--
-- Stand-in structure for view `getarticuloscarrito`
-- (See below for the actual view)
--
CREATE TABLE `getarticuloscarrito` (
`id` int(10) unsigned
,`nombre` varchar(30)
,`precio` decimal(10,2)
,`categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts')
,`descuento` int(11)
,`descripcion` text
,`stock` int(10) unsigned
,`rutaImagen` varchar(255)
,`calificacion` decimal(3,2)
,`CarritoId` int(10) unsigned
,`ComponenteCarritoId` int(10) unsigned
,`cantidad` int(10) unsigned
,`UsuarioId` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `getordenes`
-- (See below for the actual view)
--
CREATE TABLE `getordenes` (
`idEnvio` int(10) unsigned
,`idCompra` int(10) unsigned
,`metodoEnvio` enum('RETIRO','EXPRESS','NORMAL')
,`fechaSalida` datetime
,`fechaLlegada` datetime
,`calle` varchar(50)
,`Npuerta` varchar(10)
,`userId` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `historial`
--

CREATE TABLE `historial` (
  `idCompra` int(10) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `estado` enum('entregado','no entregado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `historial`
--

INSERT INTO `historial` (`idCompra`, `idUsuario`, `estado`) VALUES
(38, 22, 'no entregado');

-- --------------------------------------------------------

--
-- Stand-in structure for view `infousuario`
-- (See below for the actual view)
--
CREATE TABLE `infousuario` (
`id` int(10) unsigned
,`nombre` varchar(30)
,`apellido` varchar(40)
,`email` varchar(100)
,`telefono` varchar(9)
,`calle` varchar(50)
,`nPuerta` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `listar_articulos`
-- (See below for the actual view)
--
CREATE TABLE `listar_articulos` (
`id` int(10) unsigned
,`nombre` varchar(30)
,`descripcion` text
,`rutaImagen` varchar(255)
,`descuento` int(11)
,`precio` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `listar_articulos_lista`
-- (See below for the actual view)
--
CREATE TABLE `listar_articulos_lista` (
`id` int(10) unsigned
,`nombre` varchar(30)
,`precio` decimal(10,2)
,`categoria` enum('Teléfonos móviles','Computadoras y Laptops','Televisores y Audio','Accesorios tecnológicos','Ropa de Hombre','Ropa de Mujer','Zapatos y Accesorios','Ropa para Niños','Muebles','Decoración','Herramientas y Mejoras para el Hogar','Jardinería','Productos para el Cuidado de la Piel','Maquillaje','Productos para el Cuidado del Cabello','Suplementos y Vitaminas','Equipamiento Deportivo','Ropa Deportiva','Bicicletas y Patinetes','Camping y Senderismo','Juguetes para Niños','Juegos de Mesa','Videojuegos y Consolas','Puzzles y Rompecabezas','Accesorios para Automóviles','Accesorios para Motocicletas','Herramientas y Equipos','Neumáticos y Llantas','Comida Gourmet','Bebidas Alcohólicas','Alimentos Orgánicos','Snacks y Dulces','Ropa de Bebé','Juguetes para Bebés','Productos para la Alimentación del Bebé','Mobiliario Infantil','Libros Físicos y E-Books','Música y CDs','Instrumentos Musicales','Audiolibros y Podcasts')
,`descuento` int(11)
,`descripcion` text
,`stock` int(10) unsigned
,`rutaImagen` varchar(255)
,`calificacion` decimal(3,2)
,`VISIBLE` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `loginadmin`
-- (See below for the actual view)
--
CREATE TABLE `loginadmin` (
`email` varchar(100)
,`contrasena` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `pertenece`
--

CREATE TABLE `pertenece` (
  `id` int(10) UNSIGNED NOT NULL,
  `idEmpresa` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='El vendedor pertenece a una empresa';

-- --------------------------------------------------------

--
-- Table structure for table `recibe`
--

CREATE TABLE `recibe` (
  `idFactura` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Las facturas que recibe el cliente';

-- --------------------------------------------------------

--
-- Stand-in structure for view `tomar_calificacion`
-- (See below for the actual view)
--
CREATE TABLE `tomar_calificacion` (
`nombre_usuario` varchar(30)
,`calificacion` decimal(3,2)
,`comentario` varchar(250)
,`fecha_calificacion` timestamp
,`id_articulo` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(10) UNSIGNED NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `calle` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `Npuerta` varchar(10) DEFAULT NULL,
  `telefono` varchar(9) NOT NULL,
  `VISIBLE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Los usuarios del sistema';

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `apellido`, `nombre`, `calle`, `email`, `contrasena`, `Npuerta`, `telefono`, `VISIBLE`) VALUES
(2, 'Pérez', 'María Jose', 'Avenida Siempre Viva ', 'maria.perez@example.com', '$2y$10$n4fBVnKDwKFPOu3H/Mw/z.1f7M3wyI3Ewgc3FSjLAWSD52PVa84Ue', '34B', '300765432', 1),
(3, 'López', 'Carlos', 'Boulevard de los Sueños', 'carlos.lopez@example.com', '$2y$10$bKZBqYtb7/duOugcL31ikeMzOMckge2qJo860XitkBX.N5qsaU/oy', '56C', '300112233', 1),
(4, 'Tilla', 'Aitor', 'Octava Avenida', 'aitor@example.com', '$2y$10$Y351vm7y7UrDcNLDRzmsm.S7KS65.nUNF6cemi2SwUMmADhMxMKkG', '8455', '300445566', 1),
(10, 'Vazquez', 'Santiago', 'Dr. Jose Maria Penco', 'santi.vazquez.rubio@gmail.com', '$2y$10$OsQB4yEicwkcDVTAzNDDv.5r6w0IOMY9wO6CmSMccr/5aYkZeO.lu', '3089', '099099098', 1),
(11, 'Vazquez', 'Niro', 'Bulevar Artigas', 'nirovazquez@gmail.com', '$2y$10$jH6erQmrxxsFcZ3PEiWGtOJyxaEOoaBL7T9KMhcZHuIUidf7.lx4G', '9884', '099445566', 1),
(12, 'Zanini', 'Giovanni', 'Lucas Obes', 'giovazanini@gmail.com', '$2y$10$1Gktbg8eTDdCNPe78yyfKefGm2IzHFw7Qf3COFl5uw.xr3dG5rFSW', '5482', '094578154', 1),
(15, 'Riela', 'Mauro', 'Dr. Jose', 'mauro@gmail.com', '$2y$10$IxrupXwrN7nNb22Fjm3qGOgpjBx73sd9fe.diLkWYsqVRgV7hV6AC', '1512', '', 1),
(22, 'Blanco', 'Rodrigo', 'calle 1', 'rodri@gmail.com', '$2y$10$5tcYJrfOA0XsXx37jmMpe.iLog0qzvx47Rd/XuFqoO8HVM.bDrT32', '5683', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vendedor`
--

CREATE TABLE `vendedor` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Vendedores representantes de las empresas';

-- --------------------------------------------------------

--
-- Stand-in structure for view `verhistorial`
-- (See below for the actual view)
--
CREATE TABLE `verhistorial` (
`nombre` varchar(30)
,`fecha` timestamp
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Structure for view `getarticuloscarrito`
--
DROP TABLE IF EXISTS `getarticuloscarrito`;

CREATE VIEW `getarticuloscarrito`  AS SELECT `a`.`id` AS `id`, `a`.`nombre` AS `nombre`, `a`.`precio` AS `precio`, `a`.`categoria` AS `categoria`, `a`.`descuento` AS `descuento`, `a`.`descripcion` AS `descripcion`, `a`.`stock` AS `stock`, `a`.`rutaImagen` AS `rutaImagen`, `a`.`calificacion` AS `calificacion`, `c`.`IdCarrito` AS `CarritoId`, `c2`.`idCarrito` AS `ComponenteCarritoId`, `c2`.`cantidad` AS `cantidad`, `u`.`id` AS `UsuarioId` FROM (((`carrito` `c` join `compone` `c2` on(`c`.`IdCarrito` = `c2`.`idCarrito`)) join `articulo` `a` on(`a`.`id` = `c2`.`idArticulo`)) join `usuarios` `u` on(`u`.`id` = `c`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `getordenes`
--
DROP TABLE IF EXISTS `getordenes`;

CREATE VIEW `getordenes`  AS SELECT `c`.`idEnvio` AS `idEnvio`, `c`.`idCompra` AS `idCompra`, `e`.`metodoEnvio` AS `metodoEnvio`, `e`.`fechaSalida` AS `fechaSalida`, `e`.`fechaLlegada` AS `fechaLlegada`, `u`.`calle` AS `calle`, `u`.`Npuerta` AS `Npuerta`, `u`.`id` AS `userId` FROM ((((`crea` `c` join `compra` `c2` on(`c2`.`idCompra` = `c`.`idCompra`)) join `envios` `e` on(`e`.`idEnvios` = `c`.`idEnvio`)) join `carrito` `c3` on(`c3`.`IdCarrito` = `c2`.`idCarrito`)) join `usuarios` `u` on(`u`.`id` = `c3`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `infousuario`
--
DROP TABLE IF EXISTS `infousuario`;

CREATE VIEW `infousuario`  AS SELECT `u`.`id` AS `id`, `u`.`nombre` AS `nombre`, `u`.`apellido` AS `apellido`, `u`.`email` AS `email`, `u`.`telefono` AS `telefono`, `u`.`calle` AS `calle`, `u`.`Npuerta` AS `nPuerta` FROM `usuarios` AS `u` ;

-- --------------------------------------------------------

--
-- Structure for view `listar_articulos`
--
DROP TABLE IF EXISTS `listar_articulos`;

CREATE VIEW `listar_articulos`  AS SELECT `a`.`id` AS `id`, `a`.`nombre` AS `nombre`, `a`.`descripcion` AS `descripcion`, `a`.`rutaImagen` AS `rutaImagen`, `a`.`descuento` AS `descuento`, `a`.`precio` AS `precio` FROM `articulo` AS `a` WHERE `a`.`VISIBLE` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `listar_articulos_lista`
--
DROP TABLE IF EXISTS `listar_articulos_lista`;

CREATE VIEW `listar_articulos_lista`  AS SELECT `a`.`id` AS `id`, `a`.`nombre` AS `nombre`, `a`.`precio` AS `precio`, `a`.`categoria` AS `categoria`, `a`.`descuento` AS `descuento`, `a`.`descripcion` AS `descripcion`, `a`.`stock` AS `stock`, `a`.`rutaImagen` AS `rutaImagen`, `a`.`calificacion` AS `calificacion`, `a`.`VISIBLE` AS `VISIBLE` FROM `articulo` AS `a` WHERE `a`.`VISIBLE` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `loginadmin`
--
DROP TABLE IF EXISTS `loginadmin`;

CREATE VIEW `loginadmin`  AS SELECT `u`.`email` AS `email`, `u`.`contrasena` AS `contrasena` FROM (`usuarios` `u` join `administrador` `a` on(`a`.`id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `tomar_calificacion`
--
DROP TABLE IF EXISTS `tomar_calificacion`;

CREATE VIEW `tomar_calificacion`  AS SELECT `u`.`nombre` AS `nombre_usuario`, `c`.`puntuacion` AS `calificacion`, `c`.`comentario` AS `comentario`, `c`.`fecha_calificacion` AS `fecha_calificacion`, `c`.`id_articulo` AS `id_articulo` FROM ((`calificacion` `c` join `usuarios` `u` on(`c`.`id_usuario` = `u`.`id`)) join `articulo` `a` on(`c`.`id_articulo` = `a`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `verhistorial`
--
DROP TABLE IF EXISTS `verhistorial`;

CREATE VIEW `verhistorial`  AS SELECT `a`.`nombre` AS `nombre`, `c`.`fecha` AS `fecha`, `u`.`id` AS `id` FROM ((`consulta` `c` join `articulo` `a` on(`a`.`id` = `c`.`idArticulo`)) join `usuarios` `u` on(`u`.`id` = `c`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `administrador_unique` (`claveSecreta`);

--
-- Indexes for table `agregan`
--
ALTER TABLE `agregan`
  ADD UNIQUE KEY `Agregan_unique_1` (`idArticulo`),
  ADD KEY `Agregan_Usuarios_FK` (`id`);

--
-- Indexes for table `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `articulo_empresa_FK` (`empresa`);

--
-- Indexes for table `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_usuario`,`id_articulo`),
  ADD KEY `calificacion_articulo_FK` (`id_articulo`),
  ADD KEY `calificacion_usuarios_FK` (`id_usuario`);

--
-- Indexes for table `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`IdCarrito`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `compone`
--
ALTER TABLE `compone`
  ADD PRIMARY KEY (`idArticulo`,`idCarrito`),
  ADD KEY `compone_carrito_FK` (`idCarrito`);

--
-- Indexes for table `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`idCompra`),
  ADD UNIQUE KEY `compra_unique` (`idCarrito`);

--
-- Indexes for table `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`fecha`,`idArticulo`,`id`),
  ADD KEY `idArticulo` (`idArticulo`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `crea`
--
ALTER TABLE `crea`
  ADD PRIMARY KEY (`idEnvio`),
  ADD UNIQUE KEY `crea_unique` (`idCompra`);

--
-- Indexes for table `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`idEmpresa`),
  ADD UNIQUE KEY `empresa_unique` (`email`),
  ADD UNIQUE KEY `empresa_unique_1` (`nombre`),
  ADD UNIQUE KEY `empresa_unique_2` (`RUT`),
  ADD UNIQUE KEY `empresa_unique_3` (`telefono`);

--
-- Indexes for table `envios`
--
ALTER TABLE `envios`
  ADD PRIMARY KEY (`idEnvios`),
  ADD KEY `envios_usuarios_FK` (`idUsuario`);

--
-- Indexes for table `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idFactura`);

--
-- Indexes for table `generan`
--
ALTER TABLE `generan`
  ADD PRIMARY KEY (`idFactura`),
  ADD UNIQUE KEY `generan_unique` (`idArticulo`);

--
-- Indexes for table `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`idCompra`,`idUsuario`),
  ADD KEY `historial_usuarios_FK` (`idUsuario`);

--
-- Indexes for table `pertenece`
--
ALTER TABLE `pertenece`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pertenece_empresa_FK` (`idEmpresa`);

--
-- Indexes for table `recibe`
--
ALTER TABLE `recibe`
  ADD PRIMARY KEY (`idFactura`,`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Usuarios_unique` (`email`);

--
-- Indexes for table `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulo`
--
ALTER TABLE `articulo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=340;

--
-- AUTO_INCREMENT for table `carrito`
--
ALTER TABLE `carrito`
  MODIFY `IdCarrito` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `compra`
--
ALTER TABLE `compra`
  MODIFY `idCompra` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `empresa`
--
ALTER TABLE `empresa`
  MODIFY `idEmpresa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `envios`
--
ALTER TABLE `envios`
  MODIFY `idEnvios` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `factura`
--
ALTER TABLE `factura`
  MODIFY `idFactura` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `Administrador_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `agregan`
--
ALTER TABLE `agregan`
  ADD CONSTRAINT `Agregan_Articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Agregan_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `articulo_empresa_FK` FOREIGN KEY (`empresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `calificacion_articulo_FK` FOREIGN KEY (`id_articulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificacion_usuarios_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `Carrito_Cliente_FK` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `Cliente_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `compone`
--
ALTER TABLE `compone`
  ADD CONSTRAINT `compone_articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `compone_carrito_FK` FOREIGN KEY (`idCarrito`) REFERENCES `carrito` (`IdCarrito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_carrito_FK` FOREIGN KEY (`idCarrito`) REFERENCES `carrito` (`IdCarrito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `crea`
--
ALTER TABLE `crea`
  ADD CONSTRAINT `crea_compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `crea_envios_FK` FOREIGN KEY (`idEnvio`) REFERENCES `envios` (`idEnvios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `envios`
--
ALTER TABLE `envios`
  ADD CONSTRAINT `envios_usuarios_FK` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `generan`
--
ALTER TABLE `generan`
  ADD CONSTRAINT `generan_articulo_FK` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `generan_factura_FK` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial_compra_FK` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `historial_usuarios_FK` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pertenece`
--
ALTER TABLE `pertenece`
  ADD CONSTRAINT `pertenece_empresa_FK` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pertenece_usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `recibe`
--
ALTER TABLE `recibe`
  ADD CONSTRAINT `recibe_ibfk_1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recibe_ibfk_2` FOREIGN KEY (`id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vendedor`
--
ALTER TABLE `vendedor`
  ADD CONSTRAINT `Vendedor_Usuarios_FK` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
