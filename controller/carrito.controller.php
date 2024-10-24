<?php


require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$read = new Read();
$create = new Create();
$update = new Update();
$delete = new Delete();

$mode = $_POST['mode'];

try {
    switch ($mode) {
        case 'agregar':
            // agregar al carrito
            $create->agregarCarrito($_POST['idCarrito'], $_POST['idArticulo'], $_POST['cantidad']);
            break;

        case 'eliminar':
            // sacar del carrito
            $delete->sacarDelCarrito($_POST['idArticulo'], $_POST['idCarrito']);
            break;

        case 'actualizar':
            // tomar idCarrito
            $data = $read->getIdCarritoByUser($_POST['idUser']);
            echo json_encode($data);
            // cambiar cantidad
            // echo json_encode($update->editCantidadArticulosEnCarrito($_POST['cantidad'], $_POST['idCarrito'], $_POST['idArticulo']));
            break;

        case 'leer':
            try {
                $data = $read->getCarrito($_POST['idUsuario']);
            
                if (empty($data)) {
                    echo json_encode(['status' => 'error', 'message' => 'El carrito está vacío.']);
                } else {
                    echo json_encode(['status' => 'success', 'data' => $data]);
                }
            } catch (Exception $e) {
                echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
            }


        default:
            throw new Exception("Error Processing Request", 1);
    }
} catch (Exception $e) {
    return json_encode($e);
}
