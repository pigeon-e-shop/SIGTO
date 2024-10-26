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
            if (!isset($_POST['idUser'])) {
                throw new Exception("Debes loguearte primero", 1);
            }

            $data = $read->getIdCarritoByUser(id_usuario: $_POST['idUser']);

            if (!empty($data) && isset($data[0]['IdCarrito'])) {
                $idCarrito = $data[0]['IdCarrito'];

                $articuloExistente = $read->verificarArticuloEnCarrito($idCarrito, $_POST['idArticulo']);

                if ($articuloExistente) {
                    $nuevaCantidad = $articuloExistente['cantidad'] + 1;
                    $updateStatus = $update->editCantidadArticulosEnCarrito(idCarrito: $idCarrito, idArticulo: $_POST['idArticulo'], cantidad: $nuevaCantidad);

                    if ($updateStatus) {
                        $response = ['status' => 'ok', 'message' => 'Cantidad actualizada correctamente'];
                    } else {
                        $response = ['status' => 'error', 'message' => 'No se pudo actualizar la cantidad'];
                    }
                } else {
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
            try {
                $idUser = filter_var($_POST['idUser'], FILTER_SANITIZE_NUMBER_INT);
                $idArticulo = filter_var($_POST['idArticulo'], FILTER_SANITIZE_NUMBER_INT);

                $data = $read->getIdCarritoByUser($idUser);
                $idCarrito = $data[0]['IdCarrito'] ?? null;

                if ($idCarrito) {
                    $delete->sacarDelCarrito($idArticulo, $idCarrito);
                    echo json_encode(['status' => 'success', 'message' => 'Artículo eliminado del carrito.']);
                } else {
                    throw new Exception("No se encontró el carrito asociado al usuario.");
                }
            } catch (PDOException $e) {
                echo json_encode(['status' => 'error', 'message' => 'Error en la base de datos: ' . $e->getMessage()]);
            } catch (Exception $e) {
                echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
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
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
