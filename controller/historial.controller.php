<?php
require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$read = new Read();
$update = new Update();
$create = new Create();
$delete = new Delete();

try {

    switch ($_POST['modo'] ?? 'getCookie') {
        case 'agregar':
            $create->crearConsulta($_POST['idArticulo'], $_POST['id']);
            echo json_encode(['OK']);
            break;

        case 'getCookie':
            $cookieValue = $read->getCookie('usuario', 'usuario');
            echo json_encode(["valor" => $cookieValue]);
            break;

        default:
            throw new Exception("Error", 1);
            break;
    }
} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
