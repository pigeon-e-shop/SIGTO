<?php

require_once '../model/Read.php';

$read = new Read();
header('Content-Type: application/json');

try {
    switch ($_GET['mode'] ?? $_POST['mode']) {
        case 'readDetalle':
            echo json_encode($read->read_articulo_detalle());
            break;

        case 'exclusivo2':
            $articulo = $read->read_articulo_detalle_exclusivo($_GET['id']);
            $descuento = $read->getDiscount($_GET['id']);
            $stock = $read->getStock($_GET['id']);
            $stars = $read->getStars($_GET['id']);
            $data = [
                'articulo' => $articulo,
                'descuento' => $descuento,
                'stock' => $stock,
                'calificacion' => $stars
            ];
            echo json_encode($data);
            break;

        case 'listaArticulos':
            echo json_encode($read->read_articulo_detalle());
            $descuento = $read->getDiscount($_GET['id']);
            break;

        case 'readDetalleLista':
            echo json_encode($read->readDetalleLista());
            break;

        case 'getDiscount':
            echo json_encode($read->getDiscount($_POST['id']));
            break;

        case 'filtrarListaNombre':
            echo json_encode($read->readDetalleLista2($_POST['content']));
            break;

        default:
            echo json_encode(["error" => "Invalid mode"]);
            break;
    }
} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
