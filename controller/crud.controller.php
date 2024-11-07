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

            case 'articulos:':
                $data = [];
                parse_str($_POST['data'],$data);
                $result = $update->updateArticulo(
                    $data['id'] ?? null,
                    $data['nombre'] ?? null,
                    $data['precio'] ?? null,
                    $data['descripcion'] ?? null,
                    $data['rutaImagen'] ?? null,
                    $data['categoria'] ?? null,
                    $data['descuento'] ?? null,
                    $data['empresa'] ?? null,
                    $data['stock'] ?? null
                );
                break;

            case 'empresa':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateEmpresa(
                    $data['idEmpresa'] ?? null,
                    $data['email'] ?? null,
                    $data['nombre'] ?? null,
                    $data['categoria'] ?? null,
                    $data['RUT'] ?? null,
                    $data['telefono'] ?? null
                );
                break;

            case 'factura':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateFactura(
                    $data['idFactura'] ?? null,
                    $data['horaEmitida'] ?? null,
                    $data['contenido'] ?? null
                );
                break;

            case 'vendedor':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateVendedor(
                    $data['id'] ?? null,
                    $data['admin'] ?? null
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

            case 'consulta':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateConsulta(
                    $data['idArticulo'] ?? null,
                    $data['id'] ?? null,
                    $data['fecha'] ?? null
                );
                break;

            case 'calificacion':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCalificacion(
                    $data['id_articulo'] ?? null,
                    $data['id_usuario'] ?? null,
                    $data['puntuacion'] ?? null,
                    $data['comentario'] ?? null,
                    $data['fecha_calificacion'] ?? null
                );
                break;

            case 'envios':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateEnvios(
                    $data['idEnvios'] ?? null,
                    $data['metodoEnvio'] ?? null,
                    $data['fechaSalida'] ?? null,
                    $data['fechaLlegada'] ?? null,
                    $data['idUsuario'] ?? null,
                    $data['direccion'] ?? null,
                    $data['npuerta'] ?? null
                );
                break;

            case 'compra':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateCompra(
                    $data['idCompra'] ?? null,
                    $data['idCarrito'] ?? null,
                    $data['metodoPago'] ?? null,
                    $data['fechaCompra'] ?? null
                );
                break;

            case 'historial':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateHistorial(
                    $data['idCompra'] ?? null,
                    $data['idUsuario'] ?? null,
                    $data['estado'] ?? null
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

            case 'generan':
                $data = [];
                parse_str($_POST['data'], $data);
                $result = $update->updateGeneran(
                    $data['idFactura'] ?? null,
                    $data['idArticulo'] ?? null
                );
                break;

            // Agregar más casos según sea necesario para las demás tablas

            default:
                $data = ['error' => 'Tabla no encontrada'];
                break;
        }

        if (isset($result) && $result) {
            $data = [];
        } else {
            $data = ['error' => 'No se pudo actualizar'];
        }
        break;

        case 'createData':
            $dataPost = isset($_POST['data']) ? $_POST['data'] : [];
            $table = isset($_POST['table']) ? $_POST['table'] : '';
            if (empty($table) || empty($dataPost)) {
                $data = ['error' => 'Datos incompletos'];
                break;
            }
    
            switch ($table) {
                case 'usuarios':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearUsuario(
                        $data['apellido'] ?? null,
                        $data['nombre'] ?? null,
                        $data['calle'] ?? null,
                        $data['email'] ?? null,
                        $data['contrasena'] ?? null,
                        $data['Npuerta'] ?? null,
                        $data['telefono'] ?? null
                    );
                    break;
    
                case 'empresa':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearEmpresa(
                        $data['email'] ?? null,
                        $data['nombre'] ?? null,
                        $data['categoria'] ?? null,
                        $data['RUT'] ?? null,
                        $data['telefono'] ?? null
                    );
                    break;
    
                case 'factura':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearFactura(
                        $data['horaEmitida'] ?? null,
                        $data['contenido'] ?? null
                    );
                    break;
    
                case 'vendedor':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearVendedor(
                        $data['id'] ?? null,
                        $data['admin'] ?? null
                    );
                    break;
    
                case 'cliente':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearCliente(
                        $data['id'] ?? null
                    );
                    break;
    
                case 'consulta':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearConsulta(
                        $data['idArticulo'] ?? null,
                        $data['id'] ?? null,
                        $data['fecha'] ?? null
                    );
                    break;
    
                case 'calificacion':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearCalificacion(
                        $data['id_articulo'] ?? null,
                        $data['id_usuario'] ?? null,
                        $data['puntuacion'] ?? null,
                        $data['comentario'] ?? null,
                        $data['fecha_calificacion'] ?? null
                    );
                    break;
    
                case 'envios':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearEnvios(
                        $data['metodoEnvio'] ?? null,
                        $data['fechaSalida'] ?? null,
                        $data['fechaLlegada'] ?? null,
                        $data['idUsuario'] ?? null,
                        $data['direccion'] ?? null,
                        $data['npuerta'] ?? null
                    );
                    break;
    
                case 'compra':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearCompra(
                        $data['idCarrito'] ?? null,
                        $data['metodoPago'] ?? null,
                        $data['fechaCompra'] ?? null
                    );
                    break;
    
                case 'historial':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearHistorial(
                        $data['idCompra'] ?? null,
                        $data['idUsuario'] ?? null,
                        $data['estado'] ?? null
                    );
                    break;
    
                case 'pertenece':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearPertenece(
                        $data['id'] ?? null,
                        $data['idEmpresa'] ?? null
                    );
                    break;
    
                case 'generan':
                    $data = [];
                    parse_str($_POST['data'], $data);
                    $result = $create->crearGeneran(
                        $data['idFactura'] ?? null,
                        $data['idArticulo'] ?? null
                    );
                    break;
    
                // Agregar más casos de creación según otras tablas
    
                default:
                    $data = ['error' => 'Tabla no encontrada'];
                    break;
            }
    
            if (isset($result) && $result) {
                $data = [];
            } else {
                $data = ['error' => 'No se pudo crear el registro'];
            }
            break;
    
        case 'deleteData':
            $table = isset($_POST['table']) ? $_POST['table'] : '';
            $id = isset($_POST['id']) ? $_POST['id'] : '';
            if (empty($table) || empty($id)) {
                $data = ['error' => 'Datos incompletos'];
                break;
            }
    
            switch ($table) {
                case 'usuarios':
                    $result = $delete->deleteUsuario($id);
                    break;
    
                case 'empresa':
                    $result = $delete->deleteEmpresa($id);
                    break;
    
                case 'factura':
                    $result = $delete->deleteFactura($id);
                    break;
    
                case 'vendedor':
                    $result = $delete->deleteVendedor($id);
                    break;
    
                case 'cliente':
                    $result = $delete->deleteCliente($id);
                    break;
    
                case 'consulta':
                    $result = $delete->deleteConsulta($id);
                    break;
    
                case 'calificacion':
                    $result = $delete->deleteCalificacion($id);
                    break;
    
                case 'envios':
                    $result = $delete->deleteEnvios($id);
                    break;
    
                case 'compra':
                    $result = $delete->deleteCompra($id);
                    break;
    
                case 'historial':
                    $result = $delete->deleteHistorial($id);
                    break;
    
                case 'pertenece':
                    $result = $delete->deletePertenece($id);
                    break;
    
                case 'generan':
                    $result = $delete->deleteGeneran($id);
                    break;
    
                // Agregar más casos de eliminación según otras tablas
    
                default:
                    $data = ['error' => 'Tabla no encontrada'];
                    break;
            }
    
            if (isset($result) && $result) {
                $data = [];
            } else {
                $data = ['error' => 'No se pudo eliminar el registro'];
            }
            break;

}

echo json_encode($data);

