<?php
require_once '../Config/Database.php';

class Update
{
	private $conn;

	public function __construct()
	{
		$connection = new Connection();
		$this->conn = $connection->connection();
	}

	public function updateUsuario($id, $apellido, $nombre, $calle, $email, $contrasena, $Npuerta, $telefono)
	{
		$query = "UPDATE usuarios SET apellido=?, nombre=?, calle=?, email=?, contrasena=?, Npuerta=?, telefono=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		$hashedPassword = password_hash($contrasena, PASSWORD_DEFAULT);
		return $stmt->execute([$apellido, $nombre, $calle, $email, $hashedPassword, $Npuerta, $telefono, $id]);
	}

	public function updateArticulo($id, $nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra)
	{
		$stmt = $this->conn->prepare("UPDATE articulo SET nombre=?, precio=?, descripcion=?, rutaImagen=?, categoria=?, descuento=?, empresa=?, stock=?, codigoBarra=? WHERE id=?");
		return $stmt->execute([$nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $codigoBarra, $id]);
	}

	public function updateEmpresa($id, $email, $nombre, $categoria, $RUT, $telefono)
	{
		$query = "UPDATE empresa SET email=?, nombre=?, categoria=?, RUT=?, telefono=? WHERE idEmpresa=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$email, $nombre, $categoria, $RUT, $telefono, $id]);
	}

	public function updateCliente($id, $cedula)
	{
		$query = "UPDATE cliente SET cedula=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$cedula, $id]);
	}

	public function updateAdministrador($id, $cedula, $claveSecreta)
	{
		$query = "UPDATE administrador SET cedula=?, claveSecreta=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		$hashedPassword = password_hash($claveSecreta, PASSWORD_DEFAULT);
		return $stmt->execute([$cedula, $hashedPassword, $id]);
	}

	public function updateVendedor($id, $cedula)
	{
		$query = "UPDATE vendedor SET cedula=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$cedula, $id]);
	}

	public function updateCarrito($id, $Estado, $fecha, $monto)
	{
		$query = "UPDATE carrito SET Estado=?, fecha=?, monto=? WHERE IdCarrito=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$Estado, $fecha, $monto, $id]);
	}

	public function updateCompra($id, $fechaCompra, $idCarrito)
	{
		$query = "UPDATE compra SET fechaCompra=?, idCarrito=? WHERE idCompra=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$fechaCompra, $idCarrito, $id]);
	}

	public function updateEnvios($id, $metodoEnvio, $fechaSalida, $fechaLlegada)
	{
		$query = "UPDATE envios SET metodoEnvio=?, fechaSalida=?, fechaLlegada=? WHERE idEnvios=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$metodoEnvio, $fechaSalida, $fechaLlegada, $id]);
	}

	public function updateFactura($id, $horaEmitida)
	{
		$query = "UPDATE factura SET horaEmitida=? WHERE idFactura=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$horaEmitida, $id]);
	}

	public function updateAgregan($id, $idArticulo)
	{
		$query = "UPDATE agregan SET idArticulo=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$idArticulo, $id]);
	}

	public function updateCompone($idArticulo, $idCompra)
	{
		$query = "UPDATE compone SET idCompra=? WHERE idArticulo=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$idCompra, $idArticulo]);
	}

	public function updateConsulta($id, $fecha, $idArticulo)
	{
		$query = "UPDATE consulta SET fecha=?, idArticulo=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$fecha, $idArticulo, $id]);
	}

	public function updatePertenece($id, $idEmpresa)
	{
		$query = "UPDATE pertenece SET idEmpresa=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$idEmpresa, $id]);
	}

	public function updateCrea($idEnvios, $idCompra, $idArticulo)
	{
		$query = "UPDATE crea SET idCompra=?, idArticulo=? WHERE idEnvios=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$idCompra, $idArticulo, $idEnvios]);
	}

	public function updateGeneran($idFactura, $idArticulo)
	{
		$query = "UPDATE generan SET idFactura=? WHERE idArticulo=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$idFactura, $idArticulo]);
	}

	public function updateRecibe($idFactura, $id)
	{
		$query = "UPDATE recibe SET idFactura=? WHERE id=?";
		$stmt = $this->conn->prepare($query);
		return $stmt->execute([$idFactura, $id]);
	}

	public function promediarCalificacion($id) {
		$query = "UPDATE articulo a
				  SET a.calificacion = (
					  SELECT AVG(c.puntuacion)
					  FROM calificacion c
					  WHERE c.id_articulo = a.id
				  )
				  WHERE a.id = ?";
		
		$stmt = $this->conn->prepare($query);
		$stmt->execute([$id]);
	}
	
}