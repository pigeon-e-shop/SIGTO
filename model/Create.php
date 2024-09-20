<?php 
require_once '../Config/Database.php';

class Create {
	private $conn;
	public function __construct() {
		$connection = new Connection ();
		$this->conn = $connection->connection ();
	}
	public function crearUsuario(string $apellido='', string $nombre='', string $calle='', string $email='', string $contraseña='', string $Npuerta='', string $telefono='') {
		$sql = "INSERT INTO usuarios (apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$contraseña = password_hash($contraseña, PASSWORD_DEFAULT);
		$stmt->execute ( [
				$apellido,
				$nombre,
				$calle,
				$email,
				$contraseña,
				$Npuerta,
				$telefono
		] );
	}
	public function crearArticulo($nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra) {
		$sql = "INSERT INTO articulo (nombre, precio, descripcion, rutaImagen, categoria, descuento, empresa, stock, codigoBarra) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$nombre,
				$precio,
				$descripcion,
				$rutaImagen,
				$categoria,
				$descuento,
				$empresa,
				$stock,
				$codigoBarra
		] );
	}
	public function crearEmpresa($email, $nombre, $categoria, $RUT, $telefono) {
		$sql = "INSERT INTO empresa (email, nombre, categoria, RUT, telefono) VALUES (?, ?, ?, ?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$email,
				$nombre,
				$categoria,
				$RUT,
				$telefono
		] );
	}
	public function crearCliente($id, $cedula) {
		$sql = "INSERT INTO cliente (id, cedula) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$id,
				$cedula
		] );
	}
	public function crearAdministrador($id, $cedula, $claveSecreta) {
		$sql = "INSERT INTO administrador (id, cedula, claveSecreta) VALUES (?, ?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$id,
				$cedula,
				$claveSecreta
		] );
	}
	public function crearVendedor($id, $cedula) {
		$sql = "INSERT INTO vendedor (id, cedula) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$id,
				$cedula
		] );
	}
	public function crearCarrito($Estado, $fecha, $id, $monto) {
		$sql = "INSERT INTO carrito (Estado, fecha, id, monto) VALUES (?, ?, ?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$Estado,
				$fecha,
				$id,
				$monto
		] );
	}
	public function crearCompra($fechaCompra, $idCarrito) {
		$sql = "INSERT INTO compra (fechaCompra, idCarrito) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$fechaCompra,
				$idCarrito
		] );
	}
	public function crearEnvios($metodoEnvio, $fechaSalida, $fechaLlegada) {
		$sql = "INSERT INTO envios (metodoEnvio, fechaSalida, fechaLlegada) VALUES (?, ?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$metodoEnvio,
				$fechaSalida,
				$fechaLlegada
		] );
	}
	public function crearFactura($horaEmitida) {
		$sql = "INSERT INTO factura (horaEmitida) VALUES (?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$horaEmitida
		] );
	}
	public function crearAgregan($id, $idArticulo) {
		$sql = "INSERT INTO agregan (id, idArticulo) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$id,
				$idArticulo
		] );
	}
	public function crearCompone($idArticulo, $idCompra) {
		$sql = "INSERT INTO compone (idArticulo, idCompra) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$idArticulo,
				$idCompra
		] );
	}
	public function crearConsulta($idArticulo, $id) {
		$sql = "INSERT INTO consulta (idArticulo, id) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$idArticulo,
				$id
		] );
	}
	public function crearPertenece($id, $idEmpresa) {
		$sql = "INSERT INTO pertenece (id, idEmpresa) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$id,
				$idEmpresa
		] );
	}
	public function crearCrea($idArticulo, $idEmpresa) {
		$sql = "INSERT INTO crea (idArticulo, idEmpresa) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$idArticulo,
				$idEmpresa
		] );
	}
	public function crearGeneran($idFactura, $idCompra) {
		$sql = "INSERT INTO generan (idFactura, idCompra) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$idFactura,
				$idCompra
		] );
	}
	public function crearRecibe($idEnvios, $idCompra) {
		$sql = "INSERT INTO recibe (idEnvios, idCompra) VALUES (?, ?)";
		$stmt = $this->conn->prepare ( $sql );
		$stmt->execute ( [
				$idEnvios,
				$idCompra
		] );
	}

}