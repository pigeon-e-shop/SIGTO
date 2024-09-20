<?php

require_once '../model/Read.php';

$read = new Read();

try {
    switch ($_GET['mode']) {
        case 'readDetalle':
            echo json_encode($read->read_articulo_detalle());
            break;

        case 'exclusivo2':
            $articulo = $read->read_articulo_detalle_exclusivo($_GET['id']);
            $descuento = $read->getDiscount($_GET['id']);
            $stock = $read->getStock($_GET['id']);
            $data = [
                'articulo' => $articulo,
                'descuento' => $descuento,
                'stock' => $stock
            ];
            echo json_encode($data);
            break;

        case 'listaArticulos':
            echo json_encode($read->read_articulo_detalle());
            $descuento = $read->getDiscount($_POST['id']);
            break;

        default:
            echo json_encode(["error" => "Invalid mode"]);
            break;
    }
} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
