<?php

class Connection
{
    private $servername = "localhost";
    private $username = "pigeon";
    private $password = "pigeon";
    private $dbname = "pigeon";
    private $port = "3306";
    private $charset = "utf8mb4";

    public function connection()
    {
        try {
            $conn = new PDO(
                "mysql:host=" . $this->servername . ";port=" . $this->port . ";dbname=" . $this->dbname . ";charset=" . $this->charset,
                $this->username,
                $this->password
            );
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn;
        } catch (PDOException $e) {
            echo "Connection failed: " . $e->getMessage();
            return null;
        }
    }
}