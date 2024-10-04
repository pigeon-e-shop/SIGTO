<?php

require_once('../Config/Database.php');
require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$read = new Read();

switch ($_POST['mode']) {
    case 'getInfo':
        echo json_encode($read->readInfoUser($_POST['id']));
        break;

    case 'getOrdenes':
        echo json_encode($read->readGetOrdenes($_POST['id']));
        break;
    
    default:
        echo json_encode(["error"]);
        break;
}