<?php
require_once '../Config/Database.php';
require_once '../model/Read.php';

$read = new Read();
$modo = $_POST['mode'];

header('Content-Type: application/json');

switch ($modo) {
    case 'logIn':
        try {
            $result = $read->checkLogIn($_POST['email'], $_POST['password']);
            if ($result) {
                // Inicia una sesión y establece una cookie de sesión segura
                session_start();
                $_SESSION['user_id'] = $result;
                echo json_encode(['status' => 'OK']);
            } else {
                echo json_encode(['error' => 'Usuario o contraseña incorrectos']);
            }
        } catch (Exception $e) {
            echo json_encode(['error' => 'Se produjo un error en el servidor']);
        }
        break;

    case 'setCookies':
        // NO almacenes contraseñas en cookies
        $cookieName = 'session';
        $cookieData = json_encode(['username' => $_POST['username']]);
        $expiryTime = time() + (30 * 24 * 60 * 60);
        setcookie($cookieName, $cookieData, $expiryTime, '/', '', true, true); // Atributos de seguridad
        echo json_encode(['status' => 'Cookie establecida']);
        break;

    case 'readCookies':
        if (isset($_COOKIE['session'])) {
            echo json_encode(['cookieData' => $_COOKIE['session']]);
        } else {
            echo json_encode(['error' => 'Cookie no encontrada']);
        }
        break;

    case 'deleteCookies':
        setcookie('session', '', time() - 3600, '/', '', true, true); // Atributos de seguridad
        echo json_encode(['status' => 'Cookie eliminada']);
        break;

    case 'updateCookies':
        $cookieName = 'session';
        $cookieData = json_encode(['username' => $_POST['username']]);
        $expiryTime = time() + (30 * 24 * 60 * 60);
        setcookie($cookieName, $cookieData, $expiryTime, '/', '', true, true); // Atributos de seguridad
        echo json_encode(['status' => 'Cookie actualizada']);
        break;

    default:
        echo json_encode(['error' => 'Modo no especificado']);
        break;
}
