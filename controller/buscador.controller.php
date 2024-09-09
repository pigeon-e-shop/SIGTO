<?php
$id = $_GET ['id'];

require_once '../model/Read.php';

$read = new Read ();
return json_encode ( $read->read_articulo_detalle_exclusivo ( $id ) );
