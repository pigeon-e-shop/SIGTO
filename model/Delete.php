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
		if (!$this->isValidTable($tabla)) {
			throw new InvalidArgumentException("Nombre de tabla inválido");
		}
	
		if (!is_numeric($id)) {
			throw new InvalidArgumentException("ID inválido");
		}
	
		// Primero, elimina las referencias en las tablas secundarias
		$this->removeReferences($tabla, $id);
	
		$primaryKey = $this->read->getPrimaryKeyColumn($tabla);
		if (!$primaryKey) {
			throw new RuntimeException("No se encontró la clave primaria para la tabla {$tabla}");
		}
	
		$query = "DELETE FROM `$tabla` WHERE `$primaryKey` = :id";
		$stmt = $this->conn->prepare($query);
	
		if (!$stmt) {
			throw new RuntimeException("Error al preparar la consulta: " . $this->conn->errorInfo()[2]);
		}
	
		$stmt->bindParam(':id', $id, PDO::PARAM_INT);
		$result = $stmt->execute();
	
		if (!$result) {
			throw new RuntimeException("Error al ejecutar la consulta: " . $stmt->errorInfo()[2]);
		}
	
		return $result;
	}
	
	private function removeReferences($tabla, $id) {
		// Ejemplo:
		if ($tabla === 'articulo') {
			$query = "DELETE FROM `agregan` WHERE `idArticulo` = :id";
			$stmt = $this->conn->prepare($query);
			$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			$stmt->execute();
		}
	}
	
}
?>
