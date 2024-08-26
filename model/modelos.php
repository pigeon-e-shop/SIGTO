<?php

namespace SIGTO\Model;

require_once('connection.php');

function getConnection(){
    $connection = new Connection();  // Crea una instancia de la clase Connection
    $conn = $connection->connection();  // Llama al método connection() de la instancia
    return $conn;  // Devuelve la conexión
}


class Create {

    private $conn = getConnection();

    private function __construct($conn) {
        $this->conn = $conn;
    }
}

class Read {
    private $conn = getConnection();
    private $tabla = $_POST['tabla'] ?? 'articulo';
    private function __construct($tabla) {
        $this->tabla = $tabla;
    }

    // esta funcion retorna toda la informacion de la tabla articulos.
    function read_articulo() {}

    // esta funcion retorna la info de la tabla articulos para imprimir nombre, precio, descripcion e imagen.
    function read_articulo_detalle() {}
 
}

class Update {
    private $conn = getConnection();

    private function __construct($conn) {
        $this->conn = $conn;
    }
}

class Delete {
    private $conn = getConnection();

    private function __construct($conn) {
        $this->conn = $conn;
    }
}
