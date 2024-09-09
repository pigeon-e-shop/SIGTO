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

switch ($action) {
    case 'getTables':
        $tables = $read->getTables();
        echo json_encode($tables);
        break;

    case 'getColumns':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $columns = $read->getColumns($table);
        echo json_encode($columns);
        break;

    case 'getData':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $column = isset($_GET['column']) ? $_GET['column'] : (isset($_POST['column']) ? $_POST['column'] : '');
        $data = $read->getData($table, $column);
        echo json_encode($data);
        break;

    case 'getDataFilter':
        $table = isset($_GET['table']) ? $_GET['table'] : (isset($_POST['table']) ? $_POST['table'] : '');
        $column = isset($_GET['column']) ? $_GET['column'] : (isset($_POST['column']) ? $_POST['column'] : '');
        $filter = isset($_GET['filter']) ? $_GET['filter'] : (isset($_POST['filter']) ? $_POST['filter'] : '');
        $data = $read->getDataFilter($table, $column, $filter);
        echo json_encode($data);
        break;

        case 'updateData':
            $data = isset($_POST['data']) ? json_decode($_POST['data'], true) : [];
            $table = isset($_POST['table']) ? $_POST['table'] : '';
            $id = isset($_POST['id']) ? $_POST['id'] : '';
            $columns = isset($_POST['columns']) ? $_POST['columns'] : [];

            switch ($table) {
                case 'usuarios':
                    $result = $update->updateUsuario(
                        $id,
                        $data['apellido'],
                        $data['nombre'],
                        $data['calle'],
                        $data['email'],
                        $data['contraseña'],
                        $data['Npuerta'],
                        $data['telefono']
                    );
                    break;
        
                case 'articulo':
                    $result = $update->updateArticulo(
                        $id,
                        $data['nombre'],
                        $data['precio'],
                        $data['descripcion'],
                        $data['rutaImagen'],
                        $data['categoria'],
                        $data['descuento'],
                        $data['empresa'],
                        $data['stock'],
                        $data['codigoBarra']
                    );
                    break;
        
                case 'empresa':
                    $result = $update->updateEmpresa(
                        $id,
                        $data['email'],
                        $data['nombre'],
                        $data['categoria'],
                        $data['RUT'],
                        $data['telefono']
                    );
                    break;
                
                default:
                    $result = false;
                    break;
            }
        
            if ($result) {
                echo json_encode(['success' => true]);
            } else {
                echo json_encode(['success' => false, 'error' => 'No se pudo actualizar']);
            }
            break;
        

    case 'insertData':
        $table = isset($_POST['table']) ? $_POST['table'] : '';
        parse_str($_POST['data'], $data);
        //$result = $create->insertData($table, $data);
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