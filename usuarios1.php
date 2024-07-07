<?php

session_start();

$users = array(

    array(
        "user" => "SANTIAGOVAZQUEZ0",
        "email" => "santiagovazquez@pigeon.pt",
        "password" => "santiPigeonAdmin"
    )

);

function crearUsuario()
{

    global $users;

    $userN = array(
        "user" => [$_SESSION["user"]],
        "email" => [$_SESSION["email"]],
        "password" => [$_SESSION["password"]]
    );

    array_push($users, $userN);

}

function verUsuario()
{

    global $users;

    foreach ($users as $key => $value) {

        echo "<table><tr><td>".$key."</td><td>".$value."</td></tr></table>";

    }

}

function editarUsuario()
{

}

function eliminarUsuario()
{

}