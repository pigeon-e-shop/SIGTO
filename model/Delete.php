<?php

require_once '../Config/Database.php';
require_once '../model/Read.php';

class Delete
{
    private $conn;
    private $read;

    public function __construct()
    {
        $this->read = new Read();
        $this->conn = $this->read->getConn();
    }

    public function delete($tabla, $id)
    {

        $columna = $this->read->getPrimaryKeyColumn($tabla);

        $query = "DELETE FROM `$tabla` WHERE `$columna` = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function delete2($tabla, $id, $primaryColumn)
    {

        $query = "DELETE FROM `$tabla` WHERE `$primaryColumn` = :id";

        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(':id',$id);

        return $stmt->execute();
    }


    public function banVendedor($id)
    {
        $sql = "DELETE FROM pertenece p WHERE p.id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_STR);
        return $stmt->execute();
    }

    public function sacarDelCarrito($idArticulo, $idCarrito)
    {
        $sql = "DELETE FROM compone WHERE idArticulo = ? AND idCarrito = ?;";
        $stmt = $this->conn->prepare($sql);

        if ($stmt->execute([$idArticulo, $idCarrito])) {
            return true;
        } else {
            throw new Exception("Error al eliminar el artículo del carrito.");
        }
    }
}
