$(document).ready(function () {
    let user = prompt("CORREO: ");
    let pass = prompt("CONTRASENA: ");
    $.ajax({
        type: "POST",
        url: "/controller/login.controller.php",
        data: {
            mode: "logInAdmin",
            email: user,
            password: pass,
        },
        dataType: "JSON",
        success: function (response) {
            console.log(response);
            if (response.status === "OK") {
                document.cookie = "authToken=true; path=/;";
                window.location.replace("/view/admin/crud.html");
            }
        },
        error: function (xhr, status, error) {
            console.error(xhr, status, error);
        }
    });
    $("#title").html("<p>Si no pudiste iniciar sesion refresca la pagina. Si tienes prblemas para iniciar sesion comunicate con el servicio al cliente o con tu empresa.</p>");
});