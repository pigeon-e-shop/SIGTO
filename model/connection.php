<?php

namespace SIGTO\Model;

use Exception;
use PDO;
use PDOException;

class Connection
{
    private $servername = "localhost";
    private $username = "root";
    private $password = "";
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
            return false;
        }
    }


    function select($tablaNombre = 'articulo')
    {
        $conn = $this->connection();

        if ($conn) {
            $rows = [];
            $sql = "SELECT * FROM $tablaNombre";
            $statement = $conn->query($sql);
            $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
            if ($rows) {
                header('Content-Type: application/json; charset=utf-8');
                echo json_encode($rows, JSON_UNESCAPED_UNICODE);
            } else {
                echo json_encode(["error" => "No se encontraron resultados."]);
            }
        } else {
            echo json_encode(["error" => "Error al conectar con la base de datos."]);
        }
    }

    function selectExclusivo($tablaNombre = 'articulo', $item)
    {
        try {
            $conn = $this->connection();
            $sql = "SELECT * FROM " . $tablaNombre . " WHERE nombre LIKE :pattern";
            $stmt = $conn->prepare($sql);
            $pattern = '%' . $item . '%';
            $stmt->bindParam(':pattern', $pattern);
            $stmt->execute();
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode($results);
        } catch (PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }

    function selectExclusivo2($tablaNombre = 'articulo', $item)
    {
        try {
            $conn = $this->connection();
            $sql = "SELECT * FROM " . $tablaNombre . " WHERE nombre LIKE :pattern";
            $stmt = $conn->prepare($sql);
            $pattern = '%' . $item . '%';
            $stmt->bindParam(':pattern', $pattern);
            $stmt->execute();
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
            header('Content-Type: application/json; charset=utf-8');
            // echo json_encode($results);
            // si esta linea no esta, a la hora de mostrar en detalle producto, todo anda bien.
        } catch (PDOException $e) {
            echo 'Error: ' . $e->getMessage();
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }


    function create($tablaNombre, $email, $username, $celular, $password)
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
    function readArticulos()
    {
        $conn = $this->connection();

        if (!$conn) {
            echo json_encode(["error" => "Error al conectar con la base de datos."]);
            return;
        }

        $sql = "SELECT idArticulo, empresa, categoria, CAST(precio AS CHAR) AS precio, codigoBarra, descuento, fechaAgregado, stock, nombreArticulo, descripcionArticulo FROM Articulo;";

        try {
            $statement = $conn->query($sql);

            if ($statement === false) {
                echo json_encode(["error" => "Error al ejecutar la consulta: " . implode(" ", $conn->errorInfo())]);
                return;
            }

            $rows = $statement->fetchAll(PDO::FETCH_ASSOC);

            if ($rows === false) {
                echo json_encode(["error" => "Error al obtener los resultados: " . implode(" ", $conn->errorInfo())]);
            } else {
                if (empty($rows)) {
                    echo json_encode(["message" => "No se encontraron resultados en Articulos."]);
                } else {
                    echo json_encode($rows);
                }
            }
        } catch (PDOException $e) {
            echo json_encode(["error" => "Error en la consulta: " . $e->getMessage()]);
        }
    }
    public function fetchProductDetails($idArticulo)
{
    $conn = $this->connection();

    if (!$conn) {
        echo json_encode(["error" => "Error al conectar con la base de datos."]);
        return;
    }

    $sql = "SELECT * FROM articulo WHERE idArticulo = :idArticulo";
    try {
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':idArticulo', $idArticulo, PDO::PARAM_INT);
        $stmt->execute();
        $product = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($product) {
            return $product;
        } else {
            echo json_encode(["error" => "Producto no encontrado."]);
        }
    } catch (PDOException $e) {
        echo json_encode(["error" => "Error en la consulta: " . $e->getMessage()]);
    }
}

}


if (isset($_GET['modo'])) {
    $modo = $_GET['modo'] ?? 'read';
    $tabla = $_GET['tabla'] ?? 'Articulo';
    $connect = new Connection();

    if ($connect->connection()) {
        switch ($modo) {
            case 'create':
                $datos = $_POST;
                $connect->create($tabla, $datos["emailInput"], $datos["usernameInput"], $datos["numeroInput"], $datos["passwordInput"]);
                break;

            case 'read':
                if ($tabla === 'Articulo') {
                    $connect->select($tabla);
                } else {
                    $connect->select($tabla);
                }
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

            case 'exclusivo':
                $item = $_GET['id'];
                $connect->selectExclusivo($nombreTabla = 'articulo', $item);
                break;
                
                case 'exclusivo2':
                    $item = $_GET['id'];
                    $connect->selectExclusivo2($nombreTabla = 'articulo', $item);
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
