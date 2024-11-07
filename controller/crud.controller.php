<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$action = $_GET['action'] ?? $_POST['action'] ?? '';

$readAction = $_GET['readAction'] ?? $_POST['readAction'] ?? '';

$json = file_get_contents('php://input');
$data = json_decode($json, true);

if (!empty($data['action'])) {
    $action = $data['action'];
}

if (!empty($data['readAction'])) {
    $readAction = $data['readAction'];
}

// Crea instancias de las clases CRUD
$create = new Create();
$read = new Read();
$update = new Update();
$delete = new Delete();

// Procesa las acciones
switch ($action) {
    case 'createData':
        handleCreateData($create);
        break;

    case 'readData':
        handleReadData($read, $readAction);
        break;

    case 'updateData':
        handleUpdateData($update);
        break;

    case 'deleteData':
        handleDeleteData($delete);
        break;

    default:
        echo json_encode(["error" => "Invalid action"]);
        break;
}

/**
 * Maneja la creación de datos en una tabla
 */
function handleCreateData($create)
{
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);

    if (json_last_error() !== JSON_ERROR_NONE || empty($data['table']) || empty($data['data'])) {
        echo json_encode(["error" => "Invalid input"]);
        return;
    }

    $table = $data['table'];
    $attributes = $data['data'];

    $result = false;
    switch ($table) {
        case 'usuarios':
            $result = $create->crearUsuario(
                $attributes['apellido'],
                $attributes['nombre'],
                $attributes['calle'],
                $attributes['email'],
                $attributes['contrasena'],
                $attributes['Npuerta'],
                $attributes['telefono']
            );
            break;
        case 'articulo':
            $result = $create->crearArticulo(
                $attributes['nombre'],
                $attributes['precio'],
                $attributes['descripcion'],
                $attributes['rutaImagen'],
                $attributes['categoria'],
                $attributes['descuento'],
                $attributes['empresa'],
                $attributes['stock']
            );
            break;
            // Agrega casos para otras tablas según sea necesario
        default:
            echo json_encode(["error" => "Table not supported"]);
            return;
    }

    echo json_encode($result ? ["success" => "Record created"] : ["error" => "Create failed"]);
}

/**
 * Maneja la lectura de datos, tablas y columnas
 */
function handleReadData($read, $readAction)
{
    $table = $_GET['table'] ?? $_POST['table'] ?? '';
    $filter = $_GET['filter'] ?? $_POST['filter'] ?? '';

    switch ($readAction) {
        case 'readTables':
            $data = $read->getTables();
            break;

        case 'readColumns':
            if (empty($table)) {
                echo json_encode(["error" => "Table name missing"]);
                return;
            }
            $data = $read->getColumns($table);
            break;

        default: // Caso de lectura de datos con o sin filtro
            if (empty($table)) {
                echo json_encode(["error" => "Table name missing"]);
                return;
            }
            $data = $filter ? $read->getDataFilter($table, $filter) : $read->readAll($table);
            break;
    }

    echo json_encode($data);
}

/**
 * Maneja la actualización de datos en una tabla
 */
function handleUpdateData($update)
{
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);

    if (json_last_error() !== JSON_ERROR_NONE || empty($data['table']) || empty($data['id']) || empty($data['data'])) {
        echo json_encode(["error" => "Invalid input"]);
        return;
    }

    $table = $data['table'];
    $id = $data['id'];
    $attributes = $data['data'];

    $result = false;
    switch ($table) {
        case 'usuarios':
            $result = $update->updateUsuario(
                $id,
                $attributes['apellido'],
                $attributes['nombre'],
                $attributes['calle'],
                $attributes['email'],
                $attributes['contrasena'],
                $attributes['Npuerta'],
                $attributes['telefono']
            );
            break;
        case 'articulo':
            $result = $update->updateArticulo(
                $id,
                $attributes['nombre'],
                $attributes['precio'],
                $attributes['descripcion'],
                $attributes['rutaImagen'],
                $attributes['categoria'],
                $attributes['descuento'],
                $attributes['empresa'],
                $attributes['stock']
            );
            break;
            // Agrega casos para otras tablas según sea necesario
        default:
            echo json_encode(["error" => "Table not supported"]);
            return;
    }

    echo json_encode($result ? ["success" => "Record updated"] : ["error" => "Update failed"]);
}

/**
 * Maneja la eliminación de datos en una tabla
 */
function handleDeleteData($delete)
{
    // Obtener los datos JSON de la solicitud
    $json = file_get_contents('php://input');
    error_log("Datos recibidos: " . $json);  // Agregar un log para ver los datos recibidos

    // Decodificar el JSON a un array asociativo
    $data = json_decode($json, true);

    $table = $data['table'];
    $id = $data['id'];

    // Llamada a la función de eliminación
    switch ($table) {
        case 'consulta':
            try {
                $result = $delete->delete2($table, $id, "id");

                // Si la eliminación fue exitosa
                if ($result) {
                    echo json_encode(["success" => "Record deleted successfully"]);
                } else {
                    error_log("Fallo al eliminar el registro con ID: " . $id);
                    http_response_code(500);
                    echo json_encode(["error" => "Failed to delete the record"]);
                }
            } catch (Exception $e) {
                // Capturar errores internos (como problemas con la base de datos)
                error_log("Error interno: " . $e->getMessage());
                http_response_code(500);
                echo json_encode([
                    "error" => "Internal server error",
                    "details" => $e->getMessage()
                ]);
            }
            break;
        default:
            try {
                $result = $delete->delete($table, $id);

                // Si la eliminación fue exitosa
                if ($result) {
                    echo json_encode(["success" => "Record deleted successfully"]);
                } else {
                    error_log("Fallo al eliminar el registro con ID: " . $id);
                    http_response_code(500);
                    echo json_encode(["error" => "Failed to delete the record"]);
                }
            } catch (Exception $e) {
                // Capturar errores internos (como problemas con la base de datos)
                error_log("Error interno: " . $e->getMessage());
                http_response_code(500);
                echo json_encode([
                    "error" => "Internal server error",
                    "details" => $e->getMessage()
                ]);
            }
            break;
    }
}
