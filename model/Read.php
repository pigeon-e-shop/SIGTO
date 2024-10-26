<?php

require_once '../Config/Database.php';

class Read
{
    private $conn;

    public function __construct()
    {
        $connection = new Connection();
        $this->conn = $connection->connection();
    }

    public function getConn()
    {
        return $this->conn;
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

    public function getTableFields($table)
    {
        $table = preg_replace('/[^a-zA-Z0-9_]/', '', $table);
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

    public function getPrimaryKeyColumn($table)
    {
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

    public function read_articulo_detalle()
    {
        $query = "SELECT * FROM listar_articulos;";
        $result = $this->conn->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function read_articulo_detalle_exclusivo($id)
    {
        $query = "SELECT id, nombre, precio, descripcion, rutaImagen FROM articulo WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function read_articulo_by_nombre($nombre)
    {
        $query = "SELECT id, nombre, precio, descripcion FROM articulo WHERE nombre LIKE :nombre LIMIT 5";
        $stmt = $this->conn->prepare($query);
        $nombre = "%$nombre%";
        $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }


    public function readAll($tabla = 'articulo')
    {
        $query = "SELECT * FROM $tabla";
        $result = $this->conn->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    public function readOne($id, $tabla = 'articulo')
    {
        $primaryKey = $this->getPrimaryKeyColumn($tabla);
        if (!$primaryKey) {
            throw new InvalidArgumentException("No se encontró la clave primaria para la tabla {$tabla}");
        }

        $query = "SELECT * FROM $tabla WHERE $primaryKey = ? LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getForeignKeys($table)
    {
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

    public function checkLogIn($username, $password)
    {
        try {
            $stmt = $this->conn->prepare("SELECT id, contrasena FROM usuarios WHERE email = :username");
            $stmt->bindParam(':username', $username, PDO::PARAM_STR);
            $stmt->execute();

            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user && password_verify($password, $user['contrasena'])) {
                return json_encode(['status' => 'success', 'id' => $user['id'], 'message' => 'Inicio de sesión exitoso']);
            } else {
                return json_encode(['status' => 'error', 'message' => 'Credenciales incorrectas']);
            }
        } catch (PDOException $e) {
            error_log("Error en la consulta: " . $e->getMessage());
            return json_encode(['status' => 'error', 'message' => 'Error interno del servidor']);
        } catch (Exception $e) {
            return json_encode(['status' => 'error', 'message' => 'Error interno del servidor']);
        }
    }



    public function checkLogInAdmin($username, $password)
    {
        try {
            $stmt = $this->conn->prepare("SELECT * FROM loginadmin WHERE email = :username AND contraseña = :pass");
            $stmt->bindParam(':username', $username, PDO::PARAM_STR);
            if (password_verify($password, PASSWORD_DEFAULT)) {
                $stmt->bindParam(':pass', $password, PDO::PARAM_STR);
                $stmt->execute();
            } else {
                return json_encode(['?']);
            }
            return json_encode($stmt->fetch(PDO::FETCH_ASSOC));
        } catch (PDOException $e) {
            error_log("Error en la consulta: " . $e->getMessage());
            return false;
        }
    }


    public function getColumnsWithTypes($table)
    {
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

            if (preg_match("/^enum\((.*)\)$/", $type, $matches)) {
                $enumValues = str_getcsv($matches[1], ',', "'");
                $columnType['enum_values'] = $enumValues;
            }

            $result[] = $columnType;
        }
        return $result;
    }

    public function getStock($id)
    {
        $sql = "SELECT stock FROM articulo WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getDiscount($id)
    {
        $sql = "SELECT descuento FROM articulo WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getIdByEmail($email)
    {
        $sql = "SELECT id FROM usuarios WHERE email = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$email]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result ? $result['id'] : null;
    }


    public function getCookie($cookieName, $key)
    {
        if (isset($_COOKIE[$cookieName])) {
            $cookieData = json_decode($_COOKIE[$cookieName], true);
            if (array_key_exists($key, $cookieData)) {
                return $cookieData[$key];
            } else {
                throw new Exception("La clave '{$key}' no se encuentra en la cookie '{$cookieName}'.");
            }
        } else {
            throw new Exception("La cookie '{$cookieName}' no está definida.");
        }
    }

    public function getComment($id)
    {
        $sql = "SELECT * FROM calificacion WHERE id=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getCommentsByUser($id_usuario)
    {
        $sql = "SELECT * FROM calificacion WHERE id_usuario=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_usuario]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getCommentsByArticulo($id_articulo)
    {
        $sql = "SELECT * FROM tomar_calificacion WHERE id_articulo=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_articulo]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getStars($id_articulo)
    {
        $sql = "SELECT calificacion FROM articulo WHERE id=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_articulo]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function readDetalleLista()
    {
        $sql = "SELECT id, nombre, precio, categoria, descuento, descripcion, stock, rutaImagen, calificacion, VISIBLE FROM pigeon.listar_articulos_lista";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function readDetalleLista2($nombre)
    {
        $sql = "SELECT id, nombre, precio, categoria, descuento, descripcion, stock, rutaImagen, calificacion, VISIBLE FROM pigeon.listar_articulos_lista WHERE nombre LIKE ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(['%' . $nombre . '%']);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getDataWithPagination($table, $limit = 5, $page = 1)
    {
        $offset = ($page - 1) * $limit;
        $stmt = $this->conn->prepare("SELECT COUNT(*) FROM $table");
        $stmt->execute();
        $totalRows = $stmt->fetchColumn();
        $totalPages = ceil($totalRows / $limit);

        $stmt = $this->conn->prepare("SELECT * FROM $table LIMIT :limit OFFSET :offset");
        $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
        $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
        $stmt->execute();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return array('articles' => $data, 'totalPages' => $totalPages);
    }

    public function readInfoUser($id)
    {
        $sql = "SELECT * FROM infousuario WHERE id=?";
        $sql = $this->conn->prepare($sql);
        $sql->execute([$id]);
        $data = $sql->fetchAll(PDO::FETCH_ASSOC);
        return array($data);
    }

    public function readGetOrdenes($id)
    {
        $sql = "SELECT * FROM getordenes WHERE userId = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id]);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $data;
    }


    public function verifyPassword($inputPassword, $userId)
    {
        $sql = "SELECT id, contrasena FROM usuarios WHERE id = ?";
        $sql = $this->conn->prepare($sql);
        $sql->execute([$userId]);
        $data = $sql->fetch(PDO::FETCH_ASSOC);

        if (!$data) {
            return false;
        }

        return password_verify($inputPassword, $data['contrasena']);
    }

    public function getCarrito($id_usuario)
    {
        try {
            $sql = "SELECT * FROM getarticuloscarrito WHERE UsuarioId = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$id_usuario]);

            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($data === false) {
                throw new Exception("Error al recuperar datos.");
            }

            return $data;
        } catch (PDOException $e) {
            throw new Exception("Error en la base de datos: " . $e->getMessage());
        } catch (Exception $e) {
            throw new Exception("Error: " . $e->getMessage());
        }
    }
    
    public function getIdCarritoByUser($id_usuario) {
        try {
            $sql = "SELECT IdCarrito FROM carrito WHERE id = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$id_usuario]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);

        } catch (Exception $e) {
            return ['status'=>'error'];
        }
    }

    public function verificarArticuloEnCarrito($idCarrito, $idArticulo) {
        try {
            $sql = "SELECT cantidad FROM compone WHERE idCarrito = ? AND idArticulo = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$idCarrito, $idArticulo]);
            return $stmt->fetch(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }
    

    public function getHistorialUser($id_usuario) {
        $sql = "SELECT * FROM verhistorial WHERE idUsuario = ? ORDER BY fecha ASC";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_usuario]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);

    }
}
