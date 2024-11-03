<?php


require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');
require_once('../Config/Database.php');

header('Content-Type: application/json');

$read = new Read();
$create = new Create();
$update = new Update();
$delete = new Delete();
$connection = new Connection();
$conn = $connection->connection();

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

        case 'pagar':
            try {
                $conn->beginTransaction();
                $idUsuario = $_POST['idUsuario'] ?? null;
                $metodoEnvio = $_POST['metodoEnvio'] ?? null;
                $calle = $_POST['calle'] ?? null;
                $nPuerta = $_POST['nPuerta'] ?? null;
                $post = array($idUsuario,$metodoEnvio,$calle,$nPuerta);
                for ($i=0; $i < count($post); $i++) { 
                    if ($post[$i] == null) {
                        throw new Exception("Faltan variables POST",   $i+1);
                    }
                }
                $envios = ['RETIRO', 'EXPRESS', 'NORMAL'];
                if (!in_array($metodoEnvio,$envios)) {
                    throw new Exception('Envio INCORRECTO', 1);
                }
                $data = $read->getIdCarritoByUser($_POST['idUsuario']);
                $idCarrito = $data[0]['IdCarrito'] ?? null;
                if (is_null($idCarrito)) {
                    throw new Exception("idCarrito can't be null", 2);
                }
                if (!$create->crearCompra($idCarrito)) {
                    throw new Exception("Error en crearCompra", 3);
                }
                if (!$create->crearCarrito($_POST['idUsuario'])) {
                    throw new Exception("Error en crearCarrito", 4);
                }
                $data = $read->getIdCarritoByUser($_POST['idUsuario']);
                $idCarrito = $data[0]['IdCarrito'] ?? null;
                if (is_null($idCarrito)) {
                    throw new Exception("idCarrito can't be null", 5);
                }
                $data = $read->getIdCompra($idCarrito);
                $idCompra = ($data[0]['idCompra']) ?? null;
                if (is_null($idCompra)) {
                    throw new Exception("idCompra can't be null", 6);
                }
                if (!$create->crearHistorial($_POST['idUsuario'],$idCompra)) {
                    throw new Exception("Error en crearHistorial", 7);
                }
                if (!$create->crearEnvios($_POST['metodoEnvio'],$_POST['idUsuario'],$_POST['calle'],$_POST['nPuerta'])) {
                    throw new Exception("Error en crearEnvio", 8);
                }
                sleep(1);
                $data = $read->getIdEnvio($_POST['idUsuario']);
                $idEnvio = $data[0]['idEnvios'] ?? null;
                if (is_null($idEnvio)) {
                    throw new Exception("idEnvio can't be null", 9);
                }
                if (!$create->crearEnvioCompra($idEnvio,$idCompra)) {
                    throw new Exception("Error en crearEnvioCompra", 10);
                }
                $conn->commit();
                echo json_encode(value: ['status' => 'success', 'message' => 'exito']);
            } catch (PDOException $e) {
                $conn->rollBack();
                echo json_encode(['status' => $e->getCode(), 'message' => $e->getMessage()]);
            } catch (Exception $e) {
                $conn->rollBack();
                echo json_encode(['status' => 'error', 'message' => $e->getMessage(), 'code'=>$e->getCode()]);
            } 
        break;

        default:
            throw new Exception("Error DEFAULT", 1);
    }
} catch (Exception $e) {
    echo json_encode(value: ['status' => 'error', 'message' => $e->getMessage()]);
}
