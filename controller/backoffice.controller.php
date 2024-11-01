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
        echo json_encode($read->read_articulo_detalleByEmpresa(8));
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
                //1
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

    default:
        echo json_encode(['status' => 'error', 'message' => 'default']);
        break;
}
