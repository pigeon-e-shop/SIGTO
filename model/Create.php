<?php
require_once '../Config/Database.php';

class Create
{
	private $conn;
	public function __construct()
	{
		$connection = new Connection();
		$this->conn = $connection->connection();
	}
	public function crearUsuario(string $apellido = '', string $nombre = '', string $calle = '', string $email = '', string $contraseña = '', string $Npuerta = '', string $telefono = '')
	{
		$sql = "INSERT INTO usuarios (apellido, nombre, calle, email, contrasena, Npuerta, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";
		$stmt = $this->conn->prepare($sql);
		$contraseña = password_hash($contraseña, PASSWORD_DEFAULT);
		$stmt->execute([
			$apellido,
			$nombre,
			$calle,
			$email,
			$contraseña,
			$Npuerta,
			$telefono
		]);
	}
	public function crearArticulo($nombre, $precio, $descripcion, $imagen, $categoria, $descuento, $empresa, $stock)
	{
		$sql = "INSERT INTO articulo (nombre, precio, descripcion, rutaImagen, categoria, descuento, empresa, stock) 
		VALUES (:nombre, :precio, :descripcion, :imagen, :categoria, :descuento, :empresa, :stock)";
		$stmt = $this->conn->prepare($sql);

		$stmt->bindParam(':nombre', $nombre);
		$stmt->bindParam(':precio', $precio);
		$stmt->bindParam(':descripcion', $descripcion);
		$stmt->bindParam(':imagen', $imagen);
		$stmt->bindParam(':categoria', $categoria);
		$stmt->bindParam(':descuento', $descuento);
		$stmt->bindParam(':empresa', $empresa);
		$stmt->bindParam(':stock', $stock);

		return $stmt->execute();
	}

	public function crearEmpresa($email, $nombre, $categoria, $RUT, $telefono)
	{
		$sql = "INSERT INTO empresa (email, nombre, categoria, RUT, telefono) VALUES (?, ?, ?, ?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$email,
			$nombre,
			$categoria,
			$RUT,
			$telefono
		]);
	}
	public function crearCliente($id)
	{
		$sql = "INSERT INTO cliente (id) VALUES (?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$id
		]);
	}
	public function crearAdministrador($id, $cedula, $claveSecreta)
	{
		$sql = "INSERT INTO administrador (id, cedula, claveSecreta) VALUES (?, ?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$id,
			$cedula,
			$claveSecreta
		]);
	}
	public function crearVendedor($id, $cedula)
	{
		$sql = "INSERT INTO vendedor (id, cedula) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$id,
			$cedula
		]);
	}

	public function crearCompra($idCarrito)
	{
		try {
			$sql = "INSERT INTO compra (idCarrito, metodoPago) VALUES (?, 'paypal')";
			$stmt = $this->conn->prepare($sql);
			$stmt->execute([$idCarrito]);
			return true;
		} catch (Exception $e) {
			return false;
		}
	}

	public function crearEnvios($metodoEnvio,$idUsuario,$calle,$nPuerta)
	{
		try {
			$sql = "INSERT INTO envios (metodoEnvio,idUsuario,direccion,npuerta) VALUES (?,?,?,?)";
			$stmt = $this->conn->prepare($sql);
			$stmt->execute([$metodoEnvio,$idUsuario,$calle,$nPuerta]);
			return true;
		} catch (Exception $e) {
			error_log($e);
			return false;
		}
	}
	public function crearFactura($horaEmitida)
	{
		$sql = "INSERT INTO factura (horaEmitida) VALUES (?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$horaEmitida
		]);
	}
	public function crearAgregan($id, $idArticulo)
	{
		$sql = "INSERT INTO agregan (id, idArticulo) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$id,
			$idArticulo
		]);
	}
	public function crearCompone($idArticulo, $idCompra)
	{
		$sql = "INSERT INTO compone (idArticulo, idCompra) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$idArticulo,
			$idCompra
		]);
	}

	public function crearConsulta($idArticulo, $id)
	{
		$sql = "INSERT INTO consulta (idArticulo, id) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		try {
			$data = $stmt->execute([$idArticulo, $id]);
		} catch (PDOException $e) {
			error_log("Error en crearConsulta: " . $e->getMessage());
			return false;
		} catch (Exception $e) {
			return false;
		}

		return $data;
	}

	public function crearPertenece($id, $idEmpresa)
	{
		$sql = "INSERT INTO pertenece (id, idEmpresa) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$id,
			$idEmpresa
		]);
	}
	public function crearCrea($idArticulo, $idEmpresa)
	{
		$sql = "INSERT INTO crea (idArticulo, idEmpresa) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$idArticulo,
			$idEmpresa
		]);
	}
	public function crearGeneran($idFactura, $idCompra)
	{
		$sql = "INSERT INTO generan (idFactura, idCompra) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$idFactura,
			$idCompra
		]);
	}
	public function crearRecibe($idEnvios, $idCompra)
	{
		$sql = "INSERT INTO recibe (idEnvios, idCompra) VALUES (?, ?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([
			$idEnvios,
			$idCompra
		]);
	}

	public function crearCalificacion($id_articulo, $id_usuario, $puntuacion, $comentario)
	{
		$sql = "INSERT INTO calificacion (id_articulo, id_usuario, puntuacion, comentario) VALUES (?,?,?,?)";
		$stmt = $this->conn->prepare($sql);
		$stmt->execute([$id_articulo, $id_usuario, $puntuacion, $comentario]);
	}

	public function crearCarrito($id_usuario)
	{
		// idCarrito - autoincrement.
		// estado - default
		// fecha - default
		// id - argumento
		try {
			$sql = "INSERT INTO carrito(id) VALUES (?)";
			$stmt = $this->conn->prepare($sql);
			$stmt->execute([$id_usuario]);
			return true;
		} catch (Exception $e) {
			return false;	
		}
	}
	public function agregarCarrito($id_carrito, $id_articulo, $cantidad)
	{
		try {
			$sql = "INSERT INTO compone(idCarrito, idArticulo, cantidad) VALUES (?,?,?)";
			$stmt = $this->conn->prepare($sql);
			$stmt->execute([$id_carrito, $id_articulo, $cantidad]);
			return true;
		} catch (Exception $e) {
			return false;
		}
	}

	public function crearHistorial($id_usuario,$id_compra) {
		// idUsuario
		// idCompra
		// estado: no entregado.
		try {
			$sql = "INSERT INTO historial (idCompra,idUsuario,estado) VALUES (?,?,'no entregado')";
			$stmt = $this->conn->prepare($sql);
			return $stmt->execute([$id_compra,$id_usuario]);
		} catch (Exception $e) {
			error_log($e->getMessage());
			return false;
		}
	}

	public function crearEnvioCompra($id_envio,$id_compra) {
		try {
			$sql = "INSERT INTO crea (idEnvio,idCompra) VALUES (?,?)";
			$stmt = $this->conn->prepare($sql);
			return $stmt->execute([$id_envio,$id_compra]);
		} catch (Exception $e) {
			error_log($e->getMessage());
			return false;
		}
	}

	public function agregarVendedor($id,$idEmpresa) {
		$sql = "INSERT INTO pertenece VALUES (?,?)";
		$stmt = $this->conn->prepare($sql);
		return $stmt->execute([$id,$idEmpresa]);
	}
}
