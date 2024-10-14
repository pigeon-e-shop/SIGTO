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
                $data = ($update->cambiarVisibilidad($_POST['visibilidad'],$_POST['idArticulo']));
                if ($data) {
                    echo 'ok';
                } else {
                    echo 'bad';
                }
            }
        } catch (Exception $e) {
            echo json_encode($e);
        }
        break;

    case 'getInfoArticulo':
        try {
            if (!(isset($_POST['idArticulo']))) {
                throw new Exception("Error",1);
            } else {
                echo json_encode($read->readArticuloById($_POST['idArticulo']));
            }
        } catch (Exception $e) {
            throw $e;
        }
        break;

    case 'getInfoEmpresa':
        try {
            if (!(isset($_POST['email']))) {
                throw new Exception("Error Processing Request", 1);
            } else {
                echo json_encode($read->readDetalleEmpresa($_POST['email']));
            }
        } catch (Exception $e) {
            throw $e;
        }
        break;

    case 'getComments':
        try {
            // check ID
            if (!(isset($_POST['id']))) {
                throw new Exception("Error Processing Request", 1);
            } else {
                echo json_encode($read->getCommentsByArticulo($_POST['id']));
            }
        } catch (Exception $e) {
            throw $e;
        }
        break;
    default:
        throw new Exception("Error",1);
}