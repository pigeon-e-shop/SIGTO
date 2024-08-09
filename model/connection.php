<?php

class Connection
{
    private $servername = "localhost";
    private $username = "root";
    private $password = "";
    private $dbname = "mibd";

    function connection()
    {
        try {
            $conn = new PDO("mysql:host=" . $this->servername . ";dbname=" . $this->dbname, $this->username, $this->password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn; 
        } catch (PDOException $e) {
            echo "Connection failed: " . $e->getMessage();
            return false;
        }
    }

    function select($tablaNombre, $columnaNombre)
    {
        $conn = $this->connection();

        if ($conn) {
            $sql = "SELECT * FROM $tablaNombre";
            $statement = $conn->query($sql);
            $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
            foreach ($rows as $row) {
                echo $row[$columnaNombre] . '<br>';
            }
        } else {
            echo "Error al conectar con la base de datos.";
        }
    }
}

$connect = new Connection();
if ($connect->connection()) {
    $connect->select("persona","id");
}
