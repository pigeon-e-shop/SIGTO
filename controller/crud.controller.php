<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

// si get esta vacio toma los datos de post; si post esta vacio lo deja vacio.
$action = isset($_GET['action']) ? $_GET['action'] : (isset($_POST['action']) ? $_POST['action'] : '');

// crear instancias de los modelos
$read = new Read();
$update = new Update();
$create = new Create();
$delete = new Delete();

// Initialize data array
$data = [];

switch ($action) {
    case 'getTables':
        $data = $read->getTables(); // Assuming this returns an array
        break;

    case 'getColumns':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        if ($table) {
            $data = $read->getColumns($table); // Assuming this returns an array
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'getData':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $column = isset($_GET['column']) ? $_GET['column'] : (isset($_POST['column']) ? $_POST['column'] : '');
        if ($table) {
            $data = $read->getData($table, $column); // Assuming this returns an array
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'getDataFilter':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $column = isset($_GET['column']) ? $_GET['column'] : (isset($_POST['column']) ? $_POST['column'] : '');
        $filter = isset($_GET['filter']) ? $_GET['filter'] : (isset($_POST['filter']) ? $_POST['filter'] : '');
        if ($table) {
            $data = $read->getDataFilter($table, $column, $filter); // Assuming this returns an array
        } else {
            $data = ['error' => 'Nombre de tabla no proporcionado'];
        }
        break;

    case 'updateData':
        $dataPost = isset($_POST['data']) ? $_POST['data'] : [];
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        $id = isset($_POST['id']) ? $_POST['id'] : '';

        if (empty($table) || empty($id) || empty($dataPost)) {
            $data = ['error' => 'Datos incompletos'];
            break;
        }

        switch ($table) {
            case 'usuarios':
                $result = $update->updateUsuario(
                    $id,
                    $dataPost['apellido'] ?? null,
                    $dataPost['nombre'] ?? null,
                    $dataPost['calle'] ?? null,
                    $dataPost['email'] ?? null,
                    $dataPost['contraseña'] ?? null,
                    $dataPost['Npuerta'] ?? null,
                    $dataPost['telefono'] ?? null
                );
                break;

            case 'articulo':
                if (empty($dataPost['nombre'])) {
                    $data = ['error' => 'El nombre es requerido'];
                    break;
                }
                $result = $update->updateArticulo(
                    $id,
                    $dataPost['nombre'],
                    $dataPost['precio'] ?? null,
                    $dataPost['descripcion'] ?? null,
                    $dataPost['rutaImagen'] ?? null,
                    $dataPost['categoria'] ?? null,
                    $dataPost['descuento'] ?? null,
                    $dataPost['empresa'] ?? null,
                    $dataPost['stock'] ?? null,
                    $dataPost['codigoBarra'] ?? null
                );
                break;

            case 'empresa':
                $result = $update->updateEmpresa(
                    $id,
                    $dataPost['email'] ?? null,
                    $dataPost['nombre'] ?? null,
                    $dataPost['categoria'] ?? null,
                    $dataPost['RUT'] ?? null,
                    $dataPost['telefono'] ?? null
                );
                break;

            default:
                $data = ['error' => 'Acción no válida'];
                break;
        }

        if (isset($result) && $result) {
            $data = [];
        } else {
            $data = ['error' => 'No se pudo actualizar'];
        }
        break;

    case 'insertData':
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        parse_str($_POST['data'], $dataPost);
        switch ($table) {
            case 'value':
                # code...
                break;
            
            default:
                # code...
                break;
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

    default:
        $data = ['error' => 'Acción no válida'];
        break;
}

echo json_encode($data);
