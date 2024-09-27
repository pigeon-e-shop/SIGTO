<?php
$id = $_GET ['id'];

require_once '../model/Read.php';

$read = new Read ();
echo json_encode ( $read->read_articulo_by_nombre($id));