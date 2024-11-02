import Alertas from "./Alertas.js"
$(document).ready(function () {
    const alertas = new Alertas("#alert-container");
    $("#form").on('submit', function (e) {
        e.preventDefault();
        login($("#email").val(),$("#password").val());
    });

    function login(email, password) {
        if (!validarEmail(email)) {
            alert("Email no valido");
        } else {
            $.ajax({
                type: "POST",
                url: "/controller/login.controller.php",
                data: {
                    mode: "loginVendedor",
                    email: email,
                    password: password,
                },
                dataType: "JSON",
                success: function (response) {
                    if (response.status == "error") {
                        switch (response.message) {
                            case 'respuesta vacia':
                                alertas.error("Credenciales incorrectas.");
                                break;

                            default:
                                alertas.error("Credenciales incorrectas.");
                                break;
                        }
                    } else {
                        $.ajax({
                            type: "POST",
                            url: "/controller/login.controller.php",
                            data: {
                                mode: 'startSessionVendedor',
                                email: $("#email").val()
                            },
                            dataType: "JSON",
                            success: function (response) {
                                alertas.success("Ingreso exitoso!")
                                setTimeout(() => {
                                    window.location.href = "/view/backoffice";
                                }, 2000);
                            }
                        });
                    }
                },
                error: function (xhr, status, message) { },
            });
        }
    }

    function validarEmail(email) {
        if (validator.isEmail(email)) {
            return true;
        } else {
            return false;
        }
    }

});