<?php
require_once 'connection.php'; // Ajusta la ruta según la ubicación de tu archivo Connection.php

use SIGTO\Model\Connection;

$connect = new Connection();

// Obtener el ID del producto de la cadena de consulta
$idArticulo = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Obtener detalles del producto
$product = $connect->fetchProductDetails($idArticulo);

header('Content-Type: application/json'); // Establecer el encabezado de respuesta como JSON

if (!$product) {
    echo json_encode(['error' => 'Product not found.']);
} else {
    echo json_encode($product);

}