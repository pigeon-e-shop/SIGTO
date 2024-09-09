<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$action = isset($_GET['action']) ? $_GET['action'] : '';

$read = new Read();
$update = new Update();
$create = new Create();
$delete = new Delete();

switch ($action) {
    case 'getTables':
        $tables = $read->getTables();
        echo json_encode($tables);
        break;

    case 'getColumns':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $columns = $read->getColumns($table);
        echo json_encode($columns);
        break;

    case 'getData':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $column = isset($_GET['column']) ? $_GET['column'] : '';
        $data = $read->getData($table, $column);
        echo json_encode($data);
        break;

    case 'getDataFilter':
        $table = isset($_GET['table']) ? $_GET['table'] : '';
        $column = isset($_GET['column']) ? $_GET['column'] : '';
        $filter = isset($_GET['filter']) ? $_GET['filter'] : '';
        $data = $read->getDataFilter($table, $column, $filter);
        echo json_encode($data);
        break;

    case 'updateData':
        $data = isset($_POST['data']) ? $_POST['data'] : [];
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        $id = isset($data['id']) ? $data['id'] : '';

        if ($table && !empty($data) && $id) {
            $update->updateDataArticulos($data, $table, $id);
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Datos incompletos']);
        }
        break;

    case 'insertData':
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        parse_str($_POST['data'], $data);
        $result = $create->insertData($table, $data);
        echo json_encode(['success' => $result]);
        break;

    case 'deleteData':
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        $id = isset($_POST['id']) ? $_POST['id'] : '';
        if ($table && $id) {
            $delete->delete($table, $id);
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Datos incompletos']);
        }
        break;

    default:
        echo json_encode(['error' => 'Acción no válida']);
        break;
}