<?php

require_once '../model/Read.php';

$read = new Read();

try {
    switch ($_GET['mode']) {
        case 'readDetalle':
            echo json_encode($read->read_articulo_detalle());
            break;

        default:
            echo json_encode(["error" => "Invalid mode"]);
            break;
    }
} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
