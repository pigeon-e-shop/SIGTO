import Alertas from './Alertas.js';

$(document).ready(function () {
    const alertas = new Alertas("#alertContainer");
    $("#signInBtn").click(function (e) {
        e.preventDefault();
        let url = "../../controller/login.controller.php";
        let mode = "logIn";

        $.ajax({
            type: "POST",
            url: url,
            data: {
                mode: mode,
                username: $("#emailIS").val(),
                password: $("#passwordIS").val(),
            },
            dataType: "JSON",
            success: function (response) {
                if (response.status == "success") {
                    alertas.success(response.message || "Login successful!");

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: {
                            mode: "setCookies",
                            username: $("#emailIS").val(),
                        },
                        dataType: "JSON",
                        success: function (response) {
                            window.location.href = "/";
                        },
                        error: function (xhr, status, error) {
                        }
                    });
                } else if (response.status == "error") {
                    alertas.error("Login failed. Please try again.");
                } else {
                    alertas.error("Login failed. Please try again.");
                }
            },
            error: function (xhr, status, error) {
                alertas.error(`An unexpected error occurred: ${error}`);
                console.error("Status: " + status);
                console.error("Error: " + error);
                console.error("Response Text: " + xhr.responseText);
            },
        });
    });
    $("#signUpBtn").click(function (e) {
        e.preventDefault();
        try {
            if (!$("#apellidoIngresado").val()) {
                throw new Error("Apellido not set");
            }
            if (!$("#nombreIngresado").val()) {
                throw new Error("Nombre not set");
            }
            if (!$("#emailIngresado").val()) {
                throw new Error("Email not set");
            }
            if (!$("#passwordIngresado").val()) {
                throw new Error("Contrasena not set");
            }
            // verificar contrasena
            // valor de la contrasena
            let seguridad = verificarSeguridadContrasena($("#passwordIngresado").val());
            // objeto mensajes
            const mensajesError = {
                1: "Mínimo 8 caracteres",
                2: "Debe contener 1 número",
                3: "Debe contener 1 mayúscula",
                4: "Debe contener 1 minúscula",
                5: "Debe contener 1 carácter especial"
            };
            // si seguridad es un numero es porque hay un error.
            if (typeof seguridad === 'number') {
                // se usa la variable seguridad como clave para el objeto de mensajes
                alertas.error(mensajesError[seguridad] || "Contraseña no segura.");
                // tira error para no hacer la peticion AJAX
                throw new Error("La contraseña no es segura");
            }

            if (!($("#gridCheck").is(":checked"))) {
                alert.error("Debes aceptar los terminos y condiciones.")
                throw new Error("Debes aceptar los terminos y condiciones");

            }

            $.ajax({
                type: "POST",
                url: "/controller/login.controller.php",
                data: {
                    mode: "registrar",
                    apellido: $("#apellidoIngresado").val(),
                    nombre: $("#nombreIngresado").val(),
                    email: $("#emailIngresado").val(),
                    contrasena: $("#passwordIngresado").val(),
                },
                success: function (response) {
                    if (response.status == "error") {
                        throw new Error(response.message);
                    } else {
                        alertas.success("Cuenta creada con exito!");
                        setTimeout(() => {
                            window.location.href = "/view/tienda/signIn.html";
                        }, 1000);
                    }
                },
                error: function (xhr, status, error) {
                    throw new Error("ERROR" + xhr, status, error);
                },
            });
        } catch (error) {
            let alertMessage;

            switch (error.message) {
                case "Apellido not set":
                    alertMessage = "Error: Apellido is required.";
                    break;
                case "Nombre not set":
                    alertMessage = "Error: Nombre is required.";
                    break;
                case "Email not set":
                    alertMessage = "Error: Email is required.";
                    break;
                case "Contraseña not set":
                    alertMessage = "Error: Contraseña is required.";
                    break;
                default:
                    alertMessage = error.message;
                    break;
            }




            alertas.error(alertMessage);
        }
    });
    $("#showPasswordCheckbox").click(function () {
        var passwordField = $("#passwordIS");
        if (this.checked) {
            passwordField.attr("type", "text");
        } else {
            passwordField.attr("type", "password");
        }
    });
    $("#modalTr").click(function (e) {
        e.preventDefault();
    });
    function verificarSeguridadContrasena(contrasena) {
        const longitudMinima = 8;
        const tieneNumero = /[0-9]/.test(contrasena);
        const tieneMayuscula = /[A-Z]/.test(contrasena);
        const tieneMinuscula = /[a-z]/.test(contrasena);
        const tieneCaracterEspecial = /[!@#$%^&*(),.?":{}|<>]/.test(contrasena);

        if (contrasena.length < longitudMinima) {
            return 1;
        }

        if (!tieneNumero) {
            return 2;
        }

        if (!tieneMayuscula) {
            return 3;
        }

        if (!tieneMinuscula) {
            return 4;
        }

        if (!tieneCaracterEspecial) {
            return 5;
        }

        return true;
    }

    const passwordInput = $('#passwordIngresado').get(0);

    function verificarSeguridadContrasena(contrasena) {
        const longitudMinima = 8;
        const tieneNumero = /[0-9]/.test(contrasena);
        const tieneMayuscula = /[A-Z]/.test(contrasena);
        const tieneMinuscula = /[a-z]/.test(contrasena);
        const tieneCaracterEspecial = /[!@#$%^&*(),.?":{}|<>]/.test(contrasena);

        let puntos = 0;

        if (contrasena.length >= longitudMinima) puntos++;
        if (tieneNumero) puntos++;
        if (tieneMayuscula) puntos++;
        if (tieneMinuscula) puntos++;
        if (tieneCaracterEspecial) puntos++;
        console.log(tieneCaracterEspecial);
        
        return puntos;
    }


    function actualizarBarraProgreso(porcentaje) {
        const progressBar = $('#progress-bar');
        progressBar.css('width', porcentaje + '%');

        if (porcentaje < 50) {
            progressBar.removeClass('success warning info').addClass('danger');
            progressBar.text('Contraseña débil');
        } else if (porcentaje < 75) {
            progressBar.removeClass('success danger info').addClass('warning');
            progressBar.text('Contraseña media');
        } else {
            progressBar.removeClass('danger warning').addClass('success');
            progressBar.text('Contraseña fuerte');
        }
    }

    $('#passwordIngresado').on('input', function () {
        const contrasena = $(this).val();
        const seguridad = verificarSeguridadContrasena(contrasena);

        if (typeof seguridad === 'number') {
            actualizarBarraProgreso(seguridad * 20);
        } else {
            actualizarBarraProgreso(100);
        }
    });

    const observer = new MutationObserver(() => {
        const contrasena = passwordInput.value;
        const seguridad = verificarSeguridadContrasena(contrasena);

        if (typeof seguridad === 'number') {
            actualizarBarraProgreso(seguridad * 20);
        } else {
            actualizarBarraProgreso(100);
        }
    });

    observer.observe(passwordInput, {
        attributes: true,
        attributeFilter: ['value'],
    });

    // Evento para mostrar/ocultar contraseña
    $('#showPasswordCheckbox').on('change', function () {
        const passwordInput = $('#passwordIngresado');
        if (this.checked) {
            passwordInput.attr('type', 'text');
        } else {
            passwordInput.attr('type', 'password');
        }
    });




});
