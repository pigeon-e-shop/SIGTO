<?php
require_once '../Config/Database.php';
require_once '../model/Read.php';
require_once '../model/Create.php';

$read = new Read();
$create = new Create();
$modo = $_POST['mode'] ?? '';

header('Content-Type: application/json');

switch ($modo) {
    case 'logIn':
        try {
            if (empty($_POST['username']) || empty($_POST['password'])) {
                throw new Exception('Email y contraseña son requeridos.');
            }
    
            $email = filter_var(trim($_POST['username']), FILTER_SANITIZE_EMAIL);
            $password = trim($_POST['password']);
    
            $result = $read->checkLogIn($email, $password);
            $result = json_decode($result,true);
            if ($result["status"] == "success") {
                session_start();
                $_SESSION['user_id'] = $result;
                echo json_encode(['status' => 'success']);
            } else if($result["status"] == "error") {
                throw new Exception($result["message"]);
            } else {
                throw new Exception($result["message"]);
            }
        } catch (Exception $e) {
            echo json_encode([
                'status' => 'error', 
                'message' => $e->getMessage()
            ]);
        }
        break;
    

        case 'registrar':
            try {
                if (!empty($_POST)) {
                    $nombre = $_POST['nombre'] ?? throw new Exception("El campo 'nombre' no está establecido", 1);
                    if (empty($nombre)) throw new Exception("El campo 'nombre' no puede estar vacío", 1);
        
                    $apellido = $_POST['apellido'] ?? throw new Exception("El campo 'apellido' no está establecido", 1);
                    if (empty($apellido)) throw new Exception("El campo 'apellido' no puede estar vacío", 1);
        
                    $email = $_POST['email'] ?? throw new Exception("El campo 'email' no está establecido", 1);
                    if (empty($email)) throw new Exception("El campo 'email' no puede estar vacío", 1);
                    
                    $contrasena = $_POST['contrasena'] ?? throw new Exception("El campo 'contrasena' no está establecido", 1);
                    if (empty($contrasena)) throw new Exception("El campo 'contrasena' no puede estar vacío", 1);
                    
                    $calle = $_POST['calle'] ?? '';
                    $Npuerta = $_POST['Npuerta'] ?? '';
                    $telefono = $_POST['telefono'] ?? '';
        
                    $create->crearUsuario($apellido, $nombre, $calle, $email, $contrasena, $Npuerta, $telefono);
                    sleep(1);
                    $id = $read->getIdByEmail($email);
                    $create->crearCliente($id);
                    $create->crearCarrito($id);
                    
                    echo json_encode(["status" => "success", "message" => "Usuario registrado con éxito."]);
                } else {
                    throw new Exception("No se recibió información POST", 1);
                }
            } catch (Exception $e) {
                echo json_encode(["status" => "error", "message" => $e->getMessage()]);
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