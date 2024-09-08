<?php

require_once('../Config/Database.php');
require_once('../model/modelos.php');

header('Content-Type: application/json');

$action = isset($_GET['action']) ? $_GET['action'] : '';

$read = new Read(); // Crear una instancia de Read
$update = new Update();
$create = new Create();

switch ($action) {
    case 'getTables':
        $tables = $read->getTables();
        echo json_encode($tables); // Solo el array de tablas
        break;

    case 'getColumns':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $columns = $read->getColumns($table);
        echo json_encode($columns); // Solo el array de columnas
        break;

    case 'getData':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $column = isset($_GET['column']) ? $_GET['column'] : '';
        $data = $read->getData($table, $column);
        echo json_encode($data); // Solo el array de datos
        break;

    case 'getDataFilter':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $column = isset($_GET['column']) ? $_GET['column'] : '';
        $filter = isset($_GET['filter']) ? $_GET['filter'] : '';
        $data = $read->getDataFilter($table, $column, $filter);
        echo json_encode($data);
        break;

    case 'updateDataArticulos':
        $datos = isset($_GET['data']) ? $_GET['data'] : [];
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $id = isset($datos['idArticulo']) ? $datos['idArticulo'] : '';

        if ($table && !empty($datos) && $id) {
            $update->updateDataArticulos($datos, $table, $id);
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Datos incompletos']);
        }
        break;

    case 'getEnumValues':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $column = isset($_GET['column']) ? $_GET['column'] : '';
        $values = $read->getEnumValues($table, $column);
        echo json_encode($values);
        break;

    case 'insertData':
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        parse_str($_POST['data'], $data); // Convertir los datos del formulario en un array asociativo
        $result = $create->insertData($table, $data); // Usa el método correcto en el modelo
        echo json_encode(['success' => $result]);
        break;

    case 'getTableFields':
        // Obtener los campos de una tabla, incluyendo si son autoincrementales
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $fields = $read->getTableFields($table); // Usa la variable correcta
        echo json_encode($fields);
        break;

    default:
        echo json_encode(['error' => 'Acción no válida']);
        break;
}
