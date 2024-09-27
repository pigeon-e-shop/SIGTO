<?php

require_once('../model/Create.php');
require_once('../model/Read.php');
require_once('../model/Update.php');
require_once('../model/Delete.php');

header('Content-Type: application/json');

$read = new Read();
$create = new Create();
$update = new Update();

try {
    switch ($_POST['mode']) {
        case 'getComments':
            $comments = $read->getCommentsByArticulo($_GET['id']);
            if (empty($comments)) {
                echo json_encode(['message' => 'No hay comentarios para este artículo.']);
            } else {
                echo json_encode($comments);
            }
            break;
        
        case 'createComment':
            $create->crearCalificacion($_POST['idArticulo'],$_POST['idUsuario'],$_POST['calificacion'],$_POST['comentario']);
            $update->promediarCalificacion($_POST['idArticulo']);
            echo json_encode(['OK']);
            break;
        
        default:
            throw new Exception("Error Processing Request", 1);
            break;
    }
} catch (Exception $e) {
    echo $e->getMessage();
}
