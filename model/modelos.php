<?php

require_once('../Config/Database.php');

class Read
{
    private $conn;

    public function __construct()
    {
        $connection = new Connection();
        $this->conn = $connection->connection();
    }

    public function getTables()
    {
        if ($this->conn) {
            $stmt = $this->conn->query("SHOW TABLES");
            return $stmt->fetchAll(PDO::FETCH_COLUMN);
        } else {
            return [];
        }
    }

    public function getColumns($table)
    {
        $stmt = $this->conn->prepare("SHOW COLUMNS FROM `{$table}`");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_COLUMN, 0);
    }

    public function getData($table, $column)
    {
        $stmt = $this->conn->prepare("SELECT * FROM `{$table}`");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getDataFilter($table, $column, $filter)
    {
        $sql = "SELECT * FROM `{$table}` WHERE `{$column}` LIKE :filter";
        $stmt = $this->conn->prepare($sql);

        $stmt->bindValue(':filter', "%{$filter}%", PDO::PARAM_STR);

        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getEnumValues($table, $column)
    {
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

}

class Create
{
    private $conn;

    public function __construct()
    {
        $connection = new Connection();
        $this->conn = $connection->connection();
    }

    public function insertData($table, $data) {
        // Generar la consulta SQL para insertar los datos
        $columns = implode(',', array_keys($data));
        $placeholders = implode(',', array_fill(0, count($data), '?'));
        
        $sql = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        $stmt = $this->conn->prepare($sql);
    
        return $stmt->execute(array_values($data));
    }
    
}

class Update
{
    private $conn;

    public function __construct()
    {
        $connection = new Connection();
        $this->conn = $connection->connection();
    }

    function updateDataArticulos($datos, $tabla, $id)
    {
        if (!isset($datos['idArticulo'])) {
            throw new Exception("ID Artículo no proporcionado");
        }

        $data = [
            'nombre' => $datos['nombre'],
            'precio' => $datos['precio'],
            'descripcion' => $datos['descripcion'],
            'rutaImagen' => $datos['rutaImagen'],
            'categoria' => $datos['categoria'],
            'descuento' => $datos['descuento'],
            'empresa' => $datos['empresa'],
            'stock' => $datos['stock'],
            'codigoBarra' => $datos['codigoBarra'],
            'idArticulo' => $id
        ];

        $sql = "UPDATE $tabla 
                SET nombre=:nombre, 
                    precio=:precio, 
                    descripcion=:descripcion, 
                    rutaImagen=:rutaImagen, 
                    categoria=:categoria, 
                    descuento=:descuento, 
                    empresa=:empresa, 
                    stock=:stock, 
                    codigoBarra=:codigoBarra 
                WHERE idArticulo=:idArticulo";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute($data);
    }
}

class Delete
{
    private $conn;

    public function __construct()
    {
        $connection = new Connection();
        $this->conn = $connection->connection();
    }
}
