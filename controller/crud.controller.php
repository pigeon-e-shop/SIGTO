<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

// si get esta vacio toma los datos de post; si post esta vacio lo deja vacio.
$action = isset($_GET['action']) ? $_GET['action'] : (isset($_POST['action']) ? $_POST['action'] : '');

// Si no se encontró en GET o POST, buscar en el JSON
if (empty($action)) {
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);
    
    if (json_last_error() === JSON_ERROR_NONE) {
        $action = isset($data['action']) ? $data['action'] : '';
    } else {
        echo json_encode(["error" => "Error al decodificar JSON: " . json_last_error_msg()]);
        exit;
    }
} 
// crear instancias de los modelos
$read = new Read();
$update = new Update();
$create = new Create();
$delete = new Delete();

$data = [];

switch ($action) {
    case 'getTables':
        $data = $read->getTables();
        break;

    case 'getColumns':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        if ($table) {
            $data = $read->getColumns($table);
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'getData':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $column = isset($_GET['column']) ? $_GET['column'] : (isset($_POST['column']) ? $_POST['column'] : '');
        if ($table) {
            $data = $read->getData($table, $column);
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'getDataWithPagination':
        header('Content-Type: application/json');
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        $limit = isset($_POST['limit']) ? intval($_POST['limit']) : 5;
        $page = isset($_POST['page']) ? intval($_POST['page']) : 1;
        $response = $read->getDataWithPagination($table, $limit, $page);
        echo json_encode($response);
        exit;

    case 'getDataFilter':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $column = isset($_GET['column']) ? $_GET['column'] : (isset($_POST['column']) ? $_POST['column'] : '');
        $filter = isset($_GET['filter']) ? $_GET['filter'] : (isset($_POST['filter']) ? $_POST['filter'] : '');
        if ($table) {
            $data = $read->getDataFilter($table, $column, $filter);
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'updateData':
        $dataPost = isset($_POST['data']) ? $_POST['data'] : [];
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        $id = isset($_POST['id']) ? $_POST['id'] : (isset($data['id']) ? $data['id'] : []);
        if (empty($table) || empty($id) || empty($dataPost)) {
            $data = ['error' => 'Datos incompletos'];
            break;
        }

        switch ($table) {
            case 'usuarios':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateUsuario(
                    $data['id'] ?? null,
                    $data['apellido'] ?? null,
                    $data['nombre'] ?? null,
                    $data['calle'] ?? null,
                    $data['email'] ?? null,
                    $data['contrasena'] ?? null,
                    $data['Npuerta'] ?? null,
                    $data['telefono'] ?? null
                );
                break;

            case 'articulo':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateArticulo(
                    $data['id'] ?? null,
                    $data['nombre'] ?? null,
                    $data['precio'] ?? null,
                    $data['descripcion'] ?? null,
                    $data['rutaImagen'] ?? null,
                    $data['categoria'] ?? null,
                    $data['descuento'] ?? null,
                    $data['empresa'] ?? null,
                    $data['stock'] ?? null,
                    $data['codigoBarra'] ?? null
                );
                break;

            case 'empresa':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateEmpresa(
                    $data['id'] ?? null,
                    $data['email'] ?? null,
                    $data['nombre'] ?? null,
                    $data['categoria'] ?? null,
                    $data['RUT'] ?? null,
                    $data['telefono'] ?? null
                );
                break;

            case 'cliente':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCliente(
                    $data['id'] ?? null,
                    $data['cedula'] ?? null
                );
                break;

            case 'administrador':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateAdministrador(
                    $data['id'] ?? null,
                    $data['cedula'] ?? null,
                    $data['claveSecreta'] ?? null
                );
                break;

            case 'vendedor':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateVendedor(
                    $data['id'] ?? null,
                    $data['cedula'] ?? null
                );
                break;

            case 'carrito':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCarrito(
                    $data['id'] ?? null,
                    $data['Estado'] ?? null,
                    $data['fecha'] ?? null,
                    $data['monto'] ?? null
                );
                break;

            case 'compra':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCompra(
                    $data['id'] ?? null,
                    $data['fechaCompra'] ?? null,
                    $data['idCarrito'] ?? null
                );
                break;

            case 'envios':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateEnvios(
                    $data['id'] ?? null,
                    $data['metodoEnvio'] ?? null,
                    $data['fechaSalida'] ?? null,
                    $data['fechaLlegada'] ?? null
                );
                break;

            case 'factura':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateFactura(
                    $data['id'] ?? null,
                    $data['horaEmitida'] ?? null
                );
                break;

            case 'agregan':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateAgregan(
                    $data['id'] ?? null,
                    $data['idArticulo'] ?? null
                );
                break;

            case 'compone':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCompone(
                    $data['idArticulo'] ?? null,
                    $data['idCompra'] ?? null
                );
                break;

            case 'consulta':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateConsulta(
                    $data['id'] ?? null,
                    $data['fecha'] ?? null,
                    $data['idArticulo'] ?? null
                );
                break;

            case 'pertenece':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updatePertenece(
                    $data['id'] ?? null,
                    $data['idEmpresa'] ?? null
                );
                break;

            case 'crea':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCrea(
                    $data['idEnvios'] ?? null,
                    $data['idCompra'] ?? null,
                    $data['idArticulo'] ?? null
                );
                break;

            case 'generan':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateGeneran(
                    $data['idFactura'] ?? null,
                    $data['idArticulo'] ?? null
                );
                break;

            case 'recibe':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateRecibe(
                    $data['idFactura'] ?? null,
                    $data['id'] ?? null
                );
                break;
        }

        if (isset($result) && $result) {
            $data = [];
        } else {
            $data = ['error' => 'No se pudo actualizar'];
        }
        break;

    case 'deleteData':
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        $id = isset($_POST['id']) ? $_POST['id'] : '';
        if ($table && $id) {
            $delete->delete($table, $id);
            $data = [];
        } else {
            $data = ['error' => 'Datos incompletos'];
        }
        break;

    case 'getColumnsWithTypes':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        if ($table) {
            $data = $read->getColumnsWithTypes($table);
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'createData':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        if (empty($table)) {
            $json = file_get_contents('php://input');
            $data = json_decode($json, true);
            $table = isset($data['table']) ? $data['table'] : '';
        }        switch ($table) {
            case 'articulo':
                if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                    // Obtener el cuerpo de la solicitud
                    $json = file_get_contents('php://input');
                
                    // Decodificar el JSON
                    $data = json_decode($json, true);
                
                    // Verificar si la decodificación fue exitosa
                    if (json_last_error() !== JSON_ERROR_NONE) {
                        echo json_encode(["error" => "Error al decodificar JSON: " . json_last_error_msg()]);
                        exit;
                    }
                
                    // Obtener datos del artículo
                    $nombre = $data['data']['nombre'];
                    $precio = $data['data']['precio'];
                    $descripcion = $data['data']['descripcion'];
                    $imagen = $data['data']['rutaImagen'];
                    $categoria = $data['data']['categoria'];
                    $descuento = $data['data']['descuento'];
                    $empresa = $data['data']['empresa'];
                    $stock = $data['data']['stock'];
                
                    // Validaciones
                    $errores = [];
                    if (trim($nombre) === '') {
                        $errores[] = "El nombre es obligatorio.";
                    }
                    if (!is_numeric($precio) || $precio < 0) {
                        $errores[] = "El precio debe ser un número mayor o igual a 0.";
                    }
                    if (trim($descripcion) === '') {
                        $errores[] = "La descripción es obligatoria.";
                    }
                    if (trim($categoria) === '') {
                        $errores[] = "La categoría es obligatoria.";
                    }
                    if (!is_numeric($descuento) || $descuento < 0) {
                        $errores[] = "El descuento debe ser un número mayor o igual a 0.";
                    }
                    if (trim($empresa) === '') {
                        $errores[] = "La empresa es obligatoria.";
                    }
                    if (!is_numeric($stock) || $stock < 0) {
                        $errores[] = "El stock debe ser un número mayor o igual a 0.";
                    }
                    error_log("Categoría: $categoria");
                    if (empty($errores)) {
                        try {
                            $create->crearArticulo($nombre, $precio, $descripcion,$imagen, $categoria, $descuento, $empresa, $stock);
                            $response = ["success" => "Artículo creado con éxito."];
                        } catch (Exception $e) {
                            $response = ["error" => "Error: " . $e->getMessage()];
                        }
                    } else {
                        $response = ["error" => implode(", ", $errores)];
                    }
                
                    // Devolver respuesta en formato JSON
                    echo json_encode($response);
                }
                
                
                break;

            case 'usuarios':
                $data = [];
                $dataArray = $_POST['data'];
                parse_str($dataArray, $data);
                $create->crearUsuario(
                    $data['apellido'],
                    $data['nombre'],
                    $data['calle'],
                    $data['email'],
                    $data['contrasena'],
                    $data['Npuerta'],
                    $data['telefono']
                );
            default:
                $data = ['error' => 'Acción no válida'];
                break;
        }
        break;

    default:
        $data = ['error' => 'Acción no válida'];
        break;
}

echo json_encode($data);
