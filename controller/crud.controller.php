<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

// Determina la acción a realizar
$action = $_GET['action'] ?? $_POST['action'] ?? '';
$readAction = $_GET['readAction'] ?? $_POST['readAction'] ?? ''; // Usado para acciones específicas de lectura

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
function handleCreateData($create) {
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
                $attributes['apellido'], $attributes['nombre'], $attributes['calle'],
                $attributes['email'], $attributes['contrasena'], $attributes['Npuerta'], $attributes['telefono']
            );
            break;
        case 'articulo':
            $result = $create->crearArticulo(
                $attributes['nombre'], $attributes['precio'], $attributes['descripcion'],
                $attributes['rutaImagen'], $attributes['categoria'], $attributes['descuento'],
                $attributes['empresa'], $attributes['stock']
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
function handleReadData($read, $readAction) {
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
function handleUpdateData($update) {
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
                $id, $attributes['apellido'], $attributes['nombre'], $attributes['calle'],
                $attributes['email'], $attributes['contrasena'], $attributes['Npuerta'], $attributes['telefono']
            );
            break;
        case 'articulo':
            $result = $update->updateArticulo(
                $id, $attributes['nombre'], $attributes['precio'], $attributes['descripcion'],
                $attributes['rutaImagen'], $attributes['categoria'], $attributes['descuento'],
                $attributes['empresa'], $attributes['stock']
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
function handleDeleteData($delete) {
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);

    if (json_last_error() !== JSON_ERROR_NONE || empty($data['table']) || empty($data['id'])) {
        echo json_encode(["error" => "Invalid input"]);
        return;
    }

    $table = $data['table'];
    $id = $data['id'];

    $result = $delete->delete($table, $id);

    echo json_encode($result ? ["success" => "Record deleted"] : ["error" => "Delete failed"]);
}
