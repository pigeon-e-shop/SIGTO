<?php

require_once '../Config/Database.php';
require_once '../model/Read.php';

class Delete {
    private $conn;
    private $read;

    public function __construct() {
        $this->read = new Read();
        $this->conn = $this->read->getConn();
    }

    public function delete($tabla, $id) {
    
		$columna = $this->read->getPrimaryKeyColumn($tabla);

		$query = "DELETE FROM `$tabla` WHERE `$columna` = :id";
            $stmt = $this->conn->prepare($query);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $result = $stmt->execute();
	
	}

    public function sacarDelCarrito($idArticulo, $idCarrito) {
        $sql = "DELETE FROM compone WHERE idArticulo = ? AND idCarrito = ?;";
        $stmt = $this->conn->prepare($sql);
        
        if ($stmt->execute([$idArticulo, $idCarrito])) {
            return true;
        } else {
            throw new Exception("Error al eliminar el artículo del carrito.");
        }
    }
}