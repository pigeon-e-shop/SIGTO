<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$read = new Read();
$update = new Update();

switch ($_POST['mode']) {
    case 'getInfo':
        echo json_encode($read->readInfoUser($_POST['id']));
        break;

    case 'getOrdenes':
        echo json_encode($read->readGetOrdenes($_POST['id']));
        break;

        case 'editPassword':
            $old = $_POST['old'];
            $new = $_POST['new'];
            $userId = $_POST['id'];
        
            if (empty($old) || empty($new) || empty($userId)) {
                echo json_encode(array('status' => 'invalid_input'));
                break;
            }
        
            if ($old === $new) {
                echo json_encode(array('status' => 'old=new'));
            } else {
                if ($read->verifyPassword($old, $userId)) {
                    if (strlen($new) < 8) {
                        echo json_encode(array('status' => 'weak_password'));
                    } else {
                        $hashedNewPassword = password_hash($new, PASSWORD_DEFAULT);
                        if ($update->updatePassword($userId, $hashedNewPassword)) {
                            echo json_encode(array('status' => 'password_updated'));
                        } else {
                            echo json_encode(array('status' => 'update_failed'));
                        }
                    }
                } else {
                    echo json_encode(array('status' => 'old!=old'));
                }
            }
        
            break;

    case 'updateDireccion':
        $data = null;
        try {
            $id = $_POST['id'];
            $calle = $_POST['calle'];
            $nPuerta = $_POST['npuerta'];
            echo $update->updateDatosEnvio($id,$calle,$nPuerta);
        } catch (Exception $e) {
            echo json_encode(array('status' => FALSE));
        }

    default:
        echo json_encode(["error"]);
        break;
}
