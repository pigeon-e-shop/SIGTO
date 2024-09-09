<?php 

require_once '../Config/Database.php';

class Read {
    private $conn;

    public function __construct() {
        $connection = new Connection();
        $this->conn = $connection->connection();
    }

    public function getConn() {
        return $this->conn;
    }

    public function getTables() {
        if ($this->conn) {
            $stmt = $this->conn->query("SHOW TABLES");
            return $stmt->fetchAll(PDO::FETCH_COLUMN);
        } else {
            return [];
        }
    }

    public function getColumns($table) {
        $stmt = $this->conn->prepare("SHOW COLUMNS FROM `{$table}`");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_COLUMN, 0);
    }

    public function getData($table, $column) {
        $stmt = $this->conn->prepare("SELECT * FROM `{$table}`");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getDataFilter($table, $column, $filter) {
        $sql = "SELECT * FROM `{$table}` WHERE `{$column}` LIKE :filter";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':filter', "%{$filter}%", PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getEnumValues($table, $column) {
        $stmt = $this->conn->prepare("SHOW COLUMNS FROM `{$table}` LIKE '{$column}'");
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($result) {
            $type = $result['Type'];
            preg_match_all("/'([^']*)'/", $type, $matches);
            return $matches[1];
        }
        return [];
    }

    public function getTableFields($table) {
        // Escapar el nombre de la tabla correctamente
        $table = preg_replace('/[^a-zA-Z0-9_]/', '', $table); // Asegúrate de que solo contenga caracteres válidos
        $sql = "DESCRIBE " . $table;
        $stmt = $this->conn->query($sql);
        $fields = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return array_map(function ($field) {
            return [
                'name' => $field['Field'],
                'auto_increment' => isset($field['Extra']) && $field['Extra'] === 'auto_increment',
                'data_type' => $field['Type']
            ];
        }, $fields);
    }

    public function getPrimaryKeyColumn($table) {
        $stmt = $this->conn->prepare(
            "SELECT COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = :table AND COLUMN_KEY = 'PRI'"
        );
        $stmt->bindParam(':table', $table, PDO::PARAM_STR);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result ? $result['COLUMN_NAME'] : null;
    }

    public function read_articulo_detalle() {
        $query = "SELECT idArticulo, nombre, precio, descripcion, rutaImagen FROM articulo;";
        $result = $this->conn->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function read_articulo_detalle_exclusivo($id) {
        $query = "SELECT idArticulo, nombre, precio, descripcion, rutaImagen FROM articulo WHERE idArticulo = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function readAll($tabla = 'articulo') {
        $query = "SELECT * FROM $tabla";
        $result = $this->conn->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function readOne($id, $tabla = 'articulo') {
        // Utiliza la columna de clave primaria dinámica
        $primaryKey = $this->getPrimaryKeyColumn($tabla);
        if (!$primaryKey) {
            throw new InvalidArgumentException("No se encontró la clave primaria para la tabla {$tabla}");
        }

        $query = "SELECT * FROM $tabla WHERE $primaryKey = ? LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>
