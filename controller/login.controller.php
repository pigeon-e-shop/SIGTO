<?php
require_once '../Config/Database.php';
require_once '../model/Read.php';

$read = new Read();
$modo = $_POST['mode'] ?? '';

header('Content-Type: application/json');

switch ($modo) {
    case 'logIn':
        if (empty($_POST['email']) || empty($_POST['password'])) {
            echo json_encode(['status' => 'Email y contraseña son requeridos']);
            break;
        }

        try {
            $result = $read->checkLogIn($_POST['email'], $_POST['password']);
            if ($result) {
                session_start();
                $_SESSION['user_id'] = $result;
                echo json_encode(['status' => 'OK']);
            } else {
                echo json_encode(['status' => 'Usuario o contraseña incorrectos']);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'Se produjo un error en el servidor', 'error' => $e->getMessage()]);
        }
        break;

    case 'setCookies':
        if (empty($_POST['username'])) {
            echo json_encode(['status' => 'El nombre de usuario es requerido']);
            break;
        }

        try {
            $userId = $read->getIdByEmail($_POST['username']);
            if ($userId) {
                $cookieName = 'usuario';
                $cookieData = json_encode(['usuario' => $userId, 'email' => $_POST['username']]);
                $expiryTime = time() + (30 * 24 * 60 * 60);
                setcookie($cookieName, $cookieData, $expiryTime, '/', '', true, true);
                echo json_encode(['status' => 'Cookie establecida']);
            } else {
                echo json_encode(['status' => 'Usuario no encontrado']);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'Error al establecer la cookie', 'error' => $e->getMessage()]);
        }
        break;


    case 'readCookies':
        if (isset($_COOKIE['usuario'])) {
            echo ($_COOKIE['usuario']);
        } else {
            echo json_encode(['error' => 'Cookie no encontrada']);
        }
        break;

    case 'deleteCookies':
        setcookie('usuario', '', time() - 3600, '/', '', true, true);
        echo json_encode(['status' => 'Cookie eliminada']);
        break;

    case 'updateCookies':
        if (empty($_POST['username'])) {
            echo json_encode(['status' => 'El nombre de usuario es requerido']);
            break;
        }

        try {
            $cookieName = 'usuario';
            $userId = $read->getIdByEmail($_POST['username']);
            if ($userId) {
                $cookieData = json_encode(['usuario' => $userId, 'email' => $_POST['username']]);
                $expiryTime = time() + (30 * 24 * 60 * 60);
                setcookie($cookieName, $cookieData, $expiryTime, '/', '', true, true);
                echo json_encode(['status' => 'Cookie actualizada']);
            } else {
                echo json_encode(['status' => 'Usuario no encontrado']);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'Error al actualizar la cookie', 'error' => $e->getMessage()]);
        }
        break;

    case 'logInAdmin':
        if (empty($_POST['email']) || empty($_POST['password'])) {
            echo json_encode(['status' => 'Email y contraseña son requeridos']);
            break;
        }

        try {
            $result = $read->checkLogIn($_POST['email'], $_POST['password']);
            if ($result) {
                session_start();
                $_SESSION['user_id'] = $result;
                echo json_encode(['status' => 'OK']);
            } else {
                echo json_encode(['status' => 'Usuario o contraseña incorrectos']);
            }
        } catch (Exception $e) {
            echo json_encode(['status' => 'Se produjo un error en el servidor', 'error' => $e->getMessage()]);
        }
        break;

    default:
        echo json_encode(['error' => 'Modo no especificado']);
        break;
}
