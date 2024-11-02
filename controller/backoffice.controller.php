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

switch ($_POST['mode']) {
    case 'getArticulos':
        echo json_encode($read->read_articulo_detalleByEmpresa($_COOKIE['idEmpresa']));
        break;

    case 'cambiarVisibilidad':
        try {
            if (!(isset($_POST['visibilidad']) && isset($_POST['idArticulo']))) {
                throw new Exception("Error Processing Request", 1);
            } else {
                $data = $update->cambiarVisibilidad($_POST['visibilidad'], $_POST['idArticulo']);
                if ($data) {
                    echo json_encode(['status' => 'success']);
                } else {
                    echo json_encode(['status' => 'error', 'message' => 'Failed to change visibility']);
                }
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
        break;

    case 'getInfoArticulo':
        try {
            if (!(isset($_POST['idArticulo']))) {
                throw new Exception("Error: Articulo ID is required", 1);
            } else {
                echo json_encode($read->readArticuloById($_POST['idArticulo']));
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
        break;


    case 'getInfoEmpresa':
        try {
            if (!(isset($_COOKIE['email']))) {
                throw new Exception("Error Processing Request: Email is required", 1);
            } else {
                $data = $read->getEmpresaByVendedor($_COOKIE['email']);

                $data = json_encode($read->readDetalleEmpresa($read->getEmpresaByVendedor($_COOKIE['email'])[0]['email'])[0]);
                $data = json_decode($data, 1);
                setcookie('idEmpresa', $data['idEmpresa']);
                echo json_encode($read->readDetalleEmpresa($read->getEmpresaByVendedor($_COOKIE['email'])[0]['email'])[0]);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
        break;


    case 'getComments':
        try {
            if (!(isset($_POST['id']))) {
                throw new Exception("Error Processing Request: Article ID is required", 1);
            } else {
                echo json_encode($read->getCommentsByArticulo($_POST['id']));
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
        break;


    case 'getViewsXMes':
        try {
            if (!(isset($_POST['idArticulo']))) {
                throw new Exception("Error Processing Request: Article ID is required", 1);
            } else {
                echo json_encode($read->getvistasXMes($_POST['idArticulo']));
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        }
        break;

    case 'getArticulo':
        echo json_encode($read->readArticuloById($_POST['id'])[0]);
        break;

    case 'updateArticulo':
        $nombre = $_POST['nombre'] ?? '';
        $descripcion = $_POST['descripcion'] ?? '';
        $precio = $_POST['precio'] ?? '';
        $categorias = $_POST['categorias'] ?? '';
        $descuento = $_POST['descuento'] ?? '';
        $stock = $_POST['stock'] ?? '';
        $id = $_POST['id'] ?? '';

        $rutaImagen = null;

        if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === UPLOAD_ERR_OK) {
            $file = $_FILES['imagen'];
            $uploadDir = rtrim($_SERVER['DOCUMENT_ROOT'], '/') . '/assets/img/productos/';
            $uploadFile = $uploadDir . basename($file['name']);
            error_log("Intentando mover a: " . $uploadFile);

            if (!is_dir($uploadDir)) {
                echo json_encode(['status' => 'error', 'message' => 'El directorio de destino no existe.']);
                break;
            }

            if (move_uploaded_file($file['tmp_name'], $uploadFile)) {
                $rutaImagen = '/assets/img/productos/' . basename($file['name']);
                error_log($rutaImagen);

                $updateResult = $update->updateArticulo2($id, $nombre, $precio, $descripcion, $rutaImagen, $categorias, $descuento, $stock);

                if ($updateResult) {
                    echo json_encode(['status' => 'success', 'message' => 'Artículo actualizado con éxito.']);
                } else {
                    echo json_encode(['status' => 'error', 'message' => 'Error al actualizar el artículo.']);
                }
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Error al mover el archivo.', 'php_error' => $lastError]);
            }
        }
        break;

        case 'createArticulo':
            $nombre = $_POST['nombre'] ?? '';
            $descripcion = $_POST['descripcion'] ?? '';
            $precio = $_POST['precio'] ?? 0.00;
            $categorias = $_POST['categorias'] ?? '';
            $descuento = $_POST['descuento'] ?? 0;
            $stock = $_POST['stock'] ?? 0;
        
            if (isset($_FILES['imagen'])) {
                $file = $_FILES['imagen'];
                if ($file['error'] === UPLOAD_ERR_OK) {
                    $uploadDir = $_SERVER['DOCUMENT_ROOT'] . '/assets/img/productos/';
                    $uploadFile = $uploadDir . basename($file['name']);
        
                    if (!is_dir($uploadDir)) {
                        mkdir($uploadDir, 0777, true);
                    }
        
                    if (move_uploaded_file($file['tmp_name'], $uploadFile)) {
                        $rutaImagen = '/assets/img/productos/' . basename($file['name']);
                        error_log($categorias);
                        $insertResult = $create->crearArticulo($nombre, $precio, $descripcion, $rutaImagen, $categorias, $descuento,$_COOKIE['idEmpresa'], $stock);
        
                        if ($insertResult) {
                            echo json_encode(['status' => 'success', 'message' => 'Artículo creado con éxito.']);
                        } else {
                            echo json_encode(['status' => 'error', 'message' => 'Error al insertar el artículo.']);
                        }
                    } else {
                        echo json_encode(['status' => 'error', 'message' => 'Error al mover el archivo.']);
                    }
                } else {
                    echo json_encode(['status' => 'error', 'message' => 'Error al subir la imagen.']);
                }
            } else {
                echo json_encode(['status' => 'error', 'message' => 'No se proporcionó una imagen.']);
            }
            break;
        


    default:
        echo json_encode(['status' => 'error', 'message' => 'default']);
        break;
}
