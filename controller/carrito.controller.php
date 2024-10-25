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
            // Verificar si el usuario está autenticado
            if (!isset($_POST['idUser'])) {
                throw new Exception("Debes loguearte primero", 1);
            }
        
            // Obtener el idCarrito del usuario
            $data = $read->getIdCarritoByUser(id_usuario: $_POST['idUser']);
            
            if (!empty($data) && isset($data[0]['IdCarrito'])) {
                $idCarrito = $data[0]['IdCarrito'];
                
                // Verificar si el artículo ya está en el carrito
                $articuloExistente = $read->verificarArticuloEnCarrito($idCarrito, $_POST['idArticulo']);
                
                if ($articuloExistente) {
                    // Si ya existe, incrementa la cantidad
                    $nuevaCantidad = $articuloExistente['cantidad'] + 1;
                    $updateStatus = $update->editCantidadArticulosEnCarrito(idCarrito:$idCarrito, idArticulo:$_POST['idArticulo'], cantidad:$nuevaCantidad);
                    
                    if ($updateStatus) {
                        $response = ['status' => 'ok', 'message' => 'Cantidad actualizada correctamente'];
                    } else {
                        $response = ['status' => 'error', 'message' => 'No se pudo actualizar la cantidad'];
                    }
                } else {
                    // Si no existe, agregar el artículo con cantidad inicial de 1
                    $insertStatus = $create->agregarCarrito($idCarrito, $_POST['idArticulo'], 1);
                    
                    if ($insertStatus) {
                        $response = ['status' => 'ok', 'message' => 'Artículo agregado al carrito'];
                    } else {
                        $response = ['status' => 'error', 'message' => 'No se pudo agregar el artículo'];
                    }
                }
            } else {
                $response = ["status" => "error", "message" => "No se encontró el carrito para este usuario"];
            }
        
            echo json_encode($response);
            break;

        case 'eliminar':
            // sacar del carrito
            try {
                $data = $read->getIdCarritoByUser(id_usuario: $_POST['idUser']);
                $idCarrito = $data[0]['IdCarrito'];
                $delete->sacarDelCarrito($_POST['idArticulo'], $idCarrito);
            } catch (Exception $e) {
                echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
            } finally {
                echo json_encode(['status'=>'ok','message',"eliminado"]);
            }
            break;

        case 'actualizar':
            // tomar idCarrito
            // $data = $read->getIdCarritoByUser(id_usuario: $_POST['idUser']);
            // echo json_encode($data);
            // cambiar cantidad
            echo json_encode($update->editCantidadArticulosEnCarrito($_POST['cantidad'], $_POST['idCarrito'], $_POST['idArticulo']));
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
            break;  


        default:
            throw new Exception("Error Processing Request", 1);
    }
} catch (Exception $e) {
    echo json_encode(['status'=>'error','message'=>$e->getMessage()]);   
}
