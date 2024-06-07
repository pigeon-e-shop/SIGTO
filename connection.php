<?php

$servername = "localhost";
$username = "root";
$password = "";
$database = "pigeon-e-shop";
$port = 3306;

$conn = mysqli_connect($servername, $username, $password, $database, $port);

// Check connection
if (!$conn) {
  die("Hubo un error en la conexion");
}
echo "La conexion fue exitosa";


function conexionExitosa() {

  $servername = "localhost";
$username = "root";
$password = "";
$database = "pigeon-e-shop";
$port = 3306;

$conn = mysqli_connect($servername, $username, $password, $database, $port);

// Check connection
if (!$conn) {
  return false;
} else {

  return true;

}


}
