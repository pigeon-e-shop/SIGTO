<?php

namespace SIGTO\Model;

use PDO;
use PDOException;

class Connection
{
    private $servername = "192.168.1.14";
    private $username = "root";
    private $password = "pigeon888";
    private $dbname = "pigeonDB";
    private $port = "3306";

    function connection()
    {
        try {
            $conn = new PDO("mysql:host=" . $this->servername . ";port=" . $this->port .";dbname=" . $this->dbname, $this->username, $this->password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn; 
        } catch (PDOException $e) {
            echo "Connection failed: " . $e->getMessage();
            return false;
        }
    }

    function select($tablaNombre)
    {
        $conn = $this->connection();

        if ($conn) {
            $sql = "SELECT * FROM $tablaNombre";
            $statement = $conn->query($sql);
            $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($rows);
        } else {
            echo json_encode(["error" => "Error al conectar con la base de datos."]);
        }
    }

    function create($tablaNombre, $email,$username,$celular,$password)
    {
        $conn = $this->connection();

        if ($conn) {
            $sql = "INSERT INTO $tablaNombre (email,username,celular,contrasena)VALUES ($email,$username,$celular,$password)";
            if ($conn->exec($sql)) {
                echo json_encode(["success" => "Registro insertado exitosamente."]);
                header("Location: http://localhost/SIGTO/");
            } else {
                echo json_encode(["error" => "Error al insertar el registro."]);
            }
        } else {
            echo json_encode(["error" => "Error al conectar con la base de datos."]);
        }
    }

    function update($tablaNombre, $datos, $id)
    {
        $conn = $this->connection();

        if ($conn) {
            $set = "";
            foreach ($datos as $key => $value) {
                $set .= "$key = " . $conn->quote($value) . ", ";
            }
            $set = rtrim($set, ", ");

            $sql = "UPDATE $tablaNombre SET $set WHERE id = " . $conn->quote($id);
            if ($conn->exec($sql)) {
                echo json_encode(["success" => "Registro actualizado exitosamente."]);
                header("Location: http://localhost/SIGTO/");
            } else {
                echo json_encode(["error" => "Error al actualizar el registro."]);
            }
        } else {
            echo json_encode(["error" => "Error al conectar con la base de datos."]);
        }
    }

    function delete($tablaNombre, $id)
    {
        $conn = $this->connection();

        if ($conn) {
            $sql = "DELETE FROM $tablaNombre WHERE id = " . $conn->quote($id);
            if ($conn->exec($sql)) {
                echo json_encode(["success" => "Registro eliminado exitosamente."]);
                header("Location: http://localhost/SIGTO/");
            } else {
                echo json_encode(["error" => "Error al eliminar el registro."]);
            }
        } else {
            echo json_encode(["error" => "Error al conectar con la base de datos."]);
        }
    }
}


if (isset($_GET['modo'])) {
    $modo = $_GET['modo'] ?? 'read';
    $tabla = $_GET['tabla'] ?? 'usuario';
    $connect = new Connection();

    if ($connect->connection()) {
        switch ($modo) {
            case 'create':
                $datos = $_POST;
                $connect->create($tabla, $datos["emailInput"], $datos["usernameInput"],$datos["numeroInput"],$datos["passwordInput"]);
                break;

            case 'read':
                $connect->select($tabla);
                break;

            case 'update':
                $id = $_GET['id'];
                $datos = $_POST;
                $connect->update($tabla, $datos, $id);
                break;

            case 'delete':
                $id = $_POST['idInputDelete'];
                $connect->delete($tabla, $id);
                break;

            default:
                echo json_encode(["error" => "Modo no valido."]);
                break;
        }
    } else {
        echo json_encode(["error" => "Error al conectar con la base de datos."]);
    }
} else {
    echo json_encode(["error" => "No se especifico ningun modo."]);
}