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

	public function updateArticulo($id, $nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock)
	{
		$stmt = $this->conn->prepare("UPDATE articulo SET nombre=?, precio=?, descripcion=?, rutaImagen=?, categoria=?, descuento=?, empresa=?, stock=? WHERE id=?");
		return $stmt->execute([$nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $empresa, $stock, $id]);
	}

	public function updateArticulo2($id, $nombre, $precio, $descripcion, $rutaImagen, $categoria, $descuento, $stock)
	{
		$stmt = $this->conn->prepare("UPDATE articulo SET nombre = :nombre, precio = :precio, descripcion = :descripcion, rutaImagen = :rutaImagen, categoria = :categoria, descuento = :descuento, stock = :stock WHERE id = :id");

		$stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
		$stmt->bindParam(':precio', $precio, PDO::PARAM_STR);
		$stmt->bindParam(':descripcion', $descripcion, PDO::PARAM_STR);
		$stmt->bindParam(':rutaImagen', $rutaImagen, PDO::PARAM_STR);
		$stmt->bindParam(':categoria', $categoria, PDO::PARAM_STR);
		$stmt->bindParam(':descuento', $descuento, PDO::PARAM_STR);
		$stmt->bindParam(':stock', $stock, PDO::PARAM_INT);
		$stmt->bindParam(':id', $id, PDO::PARAM_INT);

		return $stmt->execute();
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

	public function promediarCalificacion($id)
	{
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

	public function updatePassword($userId, $newPassword)
	{
		$sql = "UPDATE usuarios SET contrasena = ? WHERE id = ?";
		$stmt = $this->conn->prepare($sql);
		return $stmt->execute([$newPassword, $userId]);
	}
	public function cambiarVisibilidad($visible, $idArticulo)
	{
		try {
			$sql = "UPDATE articulo a SET a.VISIBLE=? WHERE a.id=?";
			$stmt = $this->conn->prepare($sql);
			return $stmt->execute([$visible, $idArticulo]);
		} catch (Exception $e) {
			throw $e;
		}
	}
	public function updateDatosEnvio($userId, $calle, $Npuerta)
	{
		try {
			$sql = "UPDATE usuarios SET calle = :calle, Npuerta = :npuerta WHERE id = :id;";
			$sql = $this->conn->prepare($sql);
			$sql->bindParam(':calle', $calle, PDO::PARAM_STR);
			$sql->bindParam(':npuerta', $Npuerta, PDO::PARAM_STR);
			$sql->bindParam(':id', $userId, PDO::PARAM_INT);
			return $sql->execute();
		} catch (Exception $e) {
			return false;
		}
	}

	public function updateTelefono($userId, $telefono)
	{
		try {
			$sql = "UPDATE usuarios SET telefono = :telefono WHERE id = :id;";
			$sql = $this->conn->prepare($sql);
			$sql->bindParam(':telefono', $telefono, PDO::PARAM_STR);
			$sql->bindParam(':id', $userId, PDO::PARAM_INT);
			$data =  $sql->execute();
			if ($data) {
				return $data;
			} else {
				throw new Exception("Error Processing Request", 1);
			}
		} catch (Exception $e) {
			throw $e;
		}
	}

	public function editCantidadArticulosEnCarrito($cantidad,$idCarrito,$idArticulo) {
		try {
			$sql = "UPDATE compone SET cantidad = :cantidad WHERE idCarrito = :idCarrito AND idArticulo = :idArticulo;";
			$sql = $this->conn->prepare($sql);
			$sql->bindParam(':cantidad',$cantidad,PDO::PARAM_STR);
			$sql->bindParam(':idCarrito',$idCarrito,PDO::PARAM_STR);
			$sql->bindParam(':idArticulo',$idArticulo,PDO::PARAM_STR);
			$sql->execute();
			return ['status'=>'success','message'=>'actualizado correctamente'];
		} catch (Exception $e) {
			return ['status' => 'error','message'=>$e];
		}
		
	}

	public function updateStock($id_articulo,$stock) {
		try {
			$sql = "UPDATE articulo SET stock = :stock WHERE id = :id";
			$sql = $this->conn->prepare($sql);
			$sql->bindParam(':stock',$stock,PDO::PARAM_STR);
			$sql->bindParam(':id',$id_articulo,PDO::PARAM_STR);
			$sql->execute();
			return ['status'=>'success','message'=>'actualizado correctamente'];
		} catch (Exception $e) {
			return ['status' => 'error','message'=>$e];
		}
	}
}