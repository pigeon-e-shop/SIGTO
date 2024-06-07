<?php

include("./connection.php");

if (!conexionExitosa()) {
    
    die;

}

// prepare and bind
$stmt = $conn->prepare("INSERT INTO usuarios (email, username, contrasena, direccion, direccion2, departamento, localidad, cod_pos, aceptaTyC, recibeMail) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("ssssssssii", $email, $username, $hashedPassword, $address, $address2, $departamento, $ciudad, $zip, $termsAccepted, $offersAccepted);

$email = $_POST['emailSignUp'];
$password = $_POST['passwordSignUp'];
$hashedPassword = password_hash($password, PASSWORD_DEFAULT); // Hash
$address = $_POST['address'];
$address2 = $_POST['address2'];
$departamento = $_POST['departamento'];
$ciudad = $_POST['ciudad'];
$zip = $_POST['zip'];
$termsAccepted = isset($_POST['termsAccepted']) ? 1 : 0;
$offersAccepted = isset($_POST['offersAccepted']) ? 1 : 0;
$username = usernameGen($email,$zip);

$stmt->execute();
$stmt->close();
$conn->close();

echo "Agregado";

function usernameGen($email, $zip) {
    $emailParts = explode('@', $email);
    $emailPrefix = $emailParts[0];
    $username = $emailPrefix . $zip;
    return $username;
}
