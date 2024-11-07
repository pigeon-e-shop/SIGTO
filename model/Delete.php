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

    // Método genérico para eliminar por tabla y id
    public function delete($tabla, $id)
    {
        $columna = $this->read->getPrimaryKeyColumn($tabla);

        $query = "DELETE FROM `$tabla` WHERE `$columna` = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Método para eliminar utilizando un nombre de columna primaria personalizado
    public function delete2($tabla, $id, $primaryColumn)
    {
        $query = "DELETE FROM `$tabla` WHERE `$primaryColumn` = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id);
        return $stmt->execute();
    }

    // Eliminar un vendedor
    public function deleteVendedor($id)
    {
        $sql = "DELETE FROM vendedor WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar un cliente
    public function deleteCliente($id)
    {
        $sql = "DELETE FROM cliente WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar una empresa
    public function deleteEmpresa($id)
    {
        $sql = "DELETE FROM empresa WHERE idEmpresa = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar una factura
    public function deleteFactura($id)
    {
        $sql = "DELETE FROM factura WHERE idFactura = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar una calificación
    public function deleteCalificacion($id)
    {
        $sql = "DELETE FROM calificacion WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar una consulta
    public function deleteConsulta($id)
    {
        $sql = "DELETE FROM consulta WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar un envío
    public function deleteEnvios($id)
    {
        $sql = "DELETE FROM envios WHERE idEnvios = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar una compra
    public function deleteCompra($id)
    {
        $sql = "DELETE FROM compra WHERE idCompra = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar un historial de compra
    public function deleteHistorial($id)
    {
        $sql = "DELETE FROM historial WHERE idCompra = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar la relación entre un usuario y una empresa (pertenece)
    public function deletePertenece($id)
    {
        $sql = "DELETE FROM pertenece WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar un artículo de una factura (generan)
    public function deleteGeneran($id)
    {
        $sql = "DELETE FROM generan WHERE idFactura = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    // Eliminar un artículo de un carrito (compone)
    public function deleteArticuloDeCarrito($idArticulo, $idCarrito)
    {
        $sql = "DELETE FROM compone WHERE idArticulo = :idArticulo AND idCarrito = :idCarrito";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':idArticulo', $idArticulo, PDO::PARAM_INT);
        $stmt->bindParam(':idCarrito', $idCarrito, PDO::PARAM_INT);
        return $stmt->execute();
    }
    public function deleteUsuario($id)
    {
        $sql = "DELETE FROM usuarios WHERE idUsuario = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        return $stmt->execute();
    }

    public function banVendedor($id) {
        $sql = "DELETE FROM pertenece p WHERE p.id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id',$id,PDO::PARAM_STR);
        return $stmt->execute();
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
