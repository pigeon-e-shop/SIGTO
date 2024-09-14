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

	public function getForeignKeys($table) {
        $stmt = $this->conn->prepare("
            SELECT 
                TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME 
            FROM 
                INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
            WHERE 
                REFERENCED_TABLE_NAME = :table
        ");
        $stmt->bindParam(':table', $table);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function checkLogIn($username, $password) {
        $stmt = $this->conn->prepare("SELECT id, contraseña FROM usuarios WHERE email=:username");
        $stmt->bindParam(':username', $username, PDO::PARAM_STR);
        $stmt->execute();
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($user && password_verify($password, $user['contraseña'])) {
            return $user['id'];
        } else {
            return false;
        }
    }
    public function getColumnsWithTypes($table) {
        $sql = "SHOW COLUMNS FROM $table";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        $columns = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $result = [];
        foreach ($columns as $column) {
            $field = $column['Field'];
            $type = $column['Type'];
            $null = $column['Null'];
            $key = $column['Key'];
            $default = $column['Default'];
            $extra = $column['Extra'];

            $columnType = [
                'field' => $field,
                'type' => $type,
                'null' => $null,
                'key' => $key,
                'default' => $default,
                'extra' => $extra
            ];

            // Detecta si es un ENUM y obtiene los valores
            if (preg_match("/^enum\((.*)\)$/", $type, $matches)) {
                $enumValues = str_getcsv($matches[1], ',', "'");
                $columnType['enum_values'] = $enumValues;
            }

            $result[] = $columnType;
        }
        return $result;
    }
}
?>
