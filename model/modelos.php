<?php

namespace SIGTO\Model;

require_once('connection.php');

function getConnection(){
    $connection = new Connection();  // Crea una instancia de la clase Connection
    $conn = $connection->connection();  // Llama al método connection() de la instancia
    return $conn;  // Devuelve la conexión
}


class Create {

    private $conn = getConnection();

    private function __construct($conn) {
        $this->conn = $conn;
    }
    public function crearUsuario($apellido, $nombre, $calle, $email, $contraseña, $Npuerta, $telefono) {
        $sql = "INSERT INTO usuarios (apellido, nombre, calle, email, contraseña, Npuerta, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$apellido, $nombre, $calle, $email, $contraseña, $Npuerta, $telefono]);
    }

    public function crearArticulo($nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra) {
        $sql = "INSERT INTO articulo (nombre, precio, descripcion, rutaImagen, categoria, descuento, empresa, stock, codigoBarra) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra]);
    }

    public function crearEmpresa($email, $nombre, $categoria, $RUT, $telefono) {
        $sql = "INSERT INTO empresa (email, nombre, categoria, RUT, telefono) VALUES (?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$email, $nombre, $categoria, $RUT, $telefono]);
    }

    public function crearCliente($id, $cedula) {
        $sql = "INSERT INTO cliente (id, cedula) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id, $cedula]);
    }

    public function crearAdministrador($id, $cedula, $claveSecreta) {
        $sql = "INSERT INTO administrador (id, cedula, claveSecreta) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id, $cedula, $claveSecreta]);
    }

    public function crearVendedor($id, $cedula) {
        $sql = "INSERT INTO vendedor (id, cedula) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id, $cedula]);
    }

    public function crearCarrito($Estado, $fecha, $id, $monto) {
        $sql = "INSERT INTO carrito (Estado, fecha, id, monto) VALUES (?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$Estado, $fecha, $id, $monto]);
    }

    public function crearCompra($fechaCompra, $idCarrito) {
        $sql = "INSERT INTO compra (fechaCompra, idCarrito) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$fechaCompra, $idCarrito]);
    }

    public function crearEnvios($metodoEnvio, $fechaSalida, $fechaLlegada) {
        $sql = "INSERT INTO envios (metodoEnvio, fechaSalida, fechaLlegada) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$metodoEnvio, $fechaSalida, $fechaLlegada]);
    }

    public function crearFactura($horaEmitida) {
        $sql = "INSERT INTO factura (horaEmitida) VALUES (?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$horaEmitida]);
    }

    public function crearAgregan($id, $idArticulo) {
        $sql = "INSERT INTO agregan (id, idArticulo) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id, $idArticulo]);
    }

    public function crearCompone($idArticulo, $idCompra) {
        $sql = "INSERT INTO compone (idArticulo, idCompra) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$idArticulo, $idCompra]);
    }

    public function crearConsulta($fecha, $idArticulo, $id) {
        $sql = "INSERT INTO consulta (fecha, idArticulo, id) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$fecha, $idArticulo, $id]);
    }

    public function crearPertenece($id, $idEmpresa) {
        $sql = "INSERT INTO pertenece (id, idEmpresa) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id, $idEmpresa]);
    }

    public function crearCrea($idArticulo, $idEmpresa) {
        $sql = "INSERT INTO crea (idArticulo, idEmpresa) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$idArticulo, $idEmpresa]);
    }

    public function crearGeneran($idFactura, $idCompra) {
        $sql = "INSERT INTO generan (idFactura, idCompra) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$idFactura, $idCompra]);
    }

    public function crearRecibe($idEnvios, $idCompra) {
        $sql = "INSERT INTO recibe (idEnvios, idCompra) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$idEnvios, $idCompra]);
    }
}

class Read {
    private $conn = getConnection();
    private $tabla = $_POST['tabla'] ?? 'articulo';
    private function __construct($tabla) {
        $this->tabla = $tabla;
    }

    // esta funcion retorna toda la informacion de la tabla articulos.
    function read_articulo() {}

    // esta funcion retorna la info de la tabla articulos para imprimir nombre, precio, descripcion e imagen.
    function read_articulo_detalle() {}
 
    public function readAll() {
        $query = "SELECT * FROM usuarios";
        $result = $this->conn->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }

    
    public function readOne($id) {
        $query = "SELECT * FROM usuarios WHERE id = ? LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}

class Update {
    private $conn = getConnection();

    private function __construct($conn) {
        $this->conn = $conn;
    }

    public function updateUsuario($id, $apellido, $nombre, $calle, $email, $contraseña, $Npuerta, $telefono) {
        $query = "UPDATE usuarios SET apellido=?, nombre=?, calle=?, email=?, contraseña=?, Npuerta=?, telefono=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        $hashedPassword = password_hash($contraseña, PASSWORD_DEFAULT);
        return $stmt->execute([$apellido, $nombre, $calle, $email, $hashedPassword, $Npuerta, $telefono, $id]);
    }
    
    public function updateArticulo($id, $nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra) {
        $query = "UPDATE articulo SET nombre=?, precio=?, descripcion=?, rutaImagen=?, categoria=?, descuento=?, empresa=?, stock=?, codigoBarra=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra, $id]);
    }
    
    public function updateEmpresa($id, $email, $nombre, $categoria, $RUT, $telefono) {
        $query = "UPDATE empresa SET email=?, nombre=?, categoria=?, RUT=?, telefono=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$email, $nombre, $categoria, $RUT, $telefono, $id]);
    }
    
    public function updateCliente($id, $cedula) {
        $query = "UPDATE cliente SET cedula=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$cedula, $id]);
    }
    
    public function updateAdministrador($id, $cedula, $claveSecreta) {
        $query = "UPDATE administrador SET cedula=?, claveSecreta=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        $hashedPassword = password_hash($claveSecreta, PASSWORD_DEFAULT);
        return $stmt->execute([$cedula, $hashedPassword, $id]);
    }
    
    public function updateVendedor($id, $cedula) {
        $query = "UPDATE vendedor SET cedula=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$cedula, $id]);
    }
    
    public function updateCarrito($id, $Estado, $fecha, $monto) {
        $query = "UPDATE carrito SET Estado=?, fecha=?, monto=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$Estado, $fecha, $monto, $id]);
    }
    
    public function updateCompra($id, $fechaCompra, $idCarrito) {
        $query = "UPDATE compra SET fechaCompra=?, idCarrito=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$fechaCompra, $idCarrito, $id]);
    }
    
    public function updateEnvios($id, $metodoEnvio, $fechaSalida, $fechaLlegada) {
        $query = "UPDATE envios SET metodoEnvio=?, fechaSalida=?, fechaLlegada=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$metodoEnvio, $fechaSalida, $fechaLlegada, $id]);
    }
    
    public function updateFactura($id, $horaEmitida) {
        $query = "UPDATE factura SET horaEmitida=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$horaEmitida, $id]);
    }
    
    public function updateAgregan($id, $idArticulo) {
        $query = "UPDATE agregan SET idArticulo=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$idArticulo, $id]);
    }
    
    public function updateCompone($id, $idArticulo, $idCompra) {
        $query = "UPDATE compone SET idArticulo=?, idCompra=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$idArticulo, $idCompra, $id]);
    }
    
    public function updateConsulta($id, $fecha, $idArticulo) {
        $query = "UPDATE consulta SET fecha=?, idArticulo=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$fecha, $idArticulo, $id]);
    }
    
    public function updatePertenece($id, $idEmpresa) {
        $query = "UPDATE pertenece SET idEmpresa=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$idEmpresa, $id]);
    }
    
    public function updateCrea($id, $idArticulo, $idEmpresa) {
        $query = "UPDATE crea SET idArticulo=?, idEmpresa=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$idArticulo, $idEmpresa, $id]);
    }
    
    public function updateGeneran($id, $idFactura, $idCompra) {
        $query = "UPDATE generan SET idFactura=?, idCompra=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$idFactura, $idCompra, $id]);
    }
    
    public function updateRecibe($id, $idEnvios, $idCompra) {
        $query = "UPDATE recibe SET idEnvios=?, idCompra=? WHERE id=?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$idEnvios, $idCompra, $id]);
    }
}

class Delete {
    private $conn = getConnection();

    private function __construct($conn) {
        $this->conn = $conn;
    }

    public function delete($tabla, $id) {
        $query = "DELETE FROM $tabla WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([$id]);
    }
}
