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
                        success: function () {
                            window.location.href = "/";
                        },
                        error: function (xhr, status, error) {
                            alertas.error(`Error setting cookies: ${error}`);
                        }
                    });
                } else {
                    alertas.error("Login failed. Please try again.");
                }
            },
            error: function (xhr, status, error) {
                alertas.error(`An unexpected error occurred: ${error}`);
                console.error("Status:", status);
                console.error("Error:", error);
                console.error("Response Text:", xhr.responseText);
            },
        });
    });

    $("#signUpForm").on('submit',function (e) {
        e.preventDefault();
        try {
            if (!$("#apellidoIngresado").val()) throw new Error("Apellido not set");
            if (!$("#nombreIngresado").val()) throw new Error("Nombre not set");
            if (!$("#emailIngresado").val()) throw new Error("Email not set");
            if (!$("#passwordIngresado").val()) throw new Error("Contraseña not set");

            let seguridad = verificarSeguridadContrasena($("#passwordIngresado").val());
            const mensajesError = {
                1: "Mínimo 8 caracteres",
                2: "Debe contener 1 número",
                3: "Debe contener 1 mayúscula",
                4: "Debe contener 1 minúscula",
                5: "Debe contener 1 carácter especial"
            };
            if (typeof seguridad === 'number') {
                alertas.error(mensajesError[seguridad] || "Contraseña no segura.");
                throw new Error("La contraseña no es segura");
            }

            if (!$("#gridCheck").is(":checked")) {
                alertas.error("Debes aceptar los términos y condiciones.");
                throw new Error("Debes aceptar los términos y condiciones");
            }


            if ($("#emailIngresado").val()) {
                if ($("#emailIngresado").val().includes('@')) {
                    console.log(true);
                } else {
                    throw new Error("Email incorrecto");
                }
            } else {
                throw new Error("Email es requerido");
                
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
                    if (response.status === "error") {
                        alertas.error(response.message);
                    } else {
                        alertas.success("Cuenta creada con éxito!");
                        setTimeout(() => {
                            window.location.href = "/view/tienda/signIn.html";
                        }, 1000);
                    }
                },
                error: function (xhr, status, error) {
                    alertas.error(`Error al crear la cuenta: ${error}`);
                },
            });
        } catch (error) {
            alertas.error(error.message || "Error desconocido");
        }
    });

    function verificarSeguridadContrasena(contrasena) {
        const longitudMinima = 8;
        const tieneNumero = /[0-9]/.test(contrasena);
        const tieneMayuscula = /[A-Z]/.test(contrasena);
        const tieneMinuscula = /[a-z]/.test(contrasena);
        const tieneCaracterEspecial = /[!@#$%^&*(),.?":{}|<>]/.test(contrasena);

        if (contrasena.length < longitudMinima) return 1;
        if (!tieneNumero) return 2;
        if (!tieneMayuscula) return 3;
        if (!tieneMinuscula) return 4;
        if (!tieneCaracterEspecial) return 5;

        return true;
    }

    function actualizarBarraProgreso(seguridad) {
        const progressBar = $('#progress-bar');
        let porcentaje = 0;
        let mensaje = "Contraseña débil";

        switch (seguridad) {
            case 1:
                porcentaje = 20;
                mensaje = "Mínimo 8 caracteres";
                break;
            case 2:
                porcentaje = 40;
                mensaje = "Debe contener 1 número";
                break;
            case 3:
                porcentaje = 60;
                mensaje = "Debe contener 1 mayúscula";
                break;
            case 4:
                porcentaje = 80;
                mensaje = "Debe contener 1 minúscula";
                break;
            case 5:
                porcentaje = 90;
                mensaje = "Debe contener 1 carácter especial";
                break;
            default:
                porcentaje = 100;
                mensaje = "Contraseña fuerte";
                break;
        }

        progressBar.css('width', porcentaje + '%').text(mensaje);

        progressBar.removeClass('danger warning success').addClass(
            porcentaje < 50 ? 'danger' :
            porcentaje < 75 ? 'warning' : 'success'
        );
    }

    $('#passwordIngresado').on('input', function () {
        const contrasena = $(this).val();
        const seguridad = verificarSeguridadContrasena(contrasena);
        actualizarBarraProgreso(seguridad);
    });

    $('#showPasswordCheckbox').on('change', function () {
        const passwordInput = $('#passwordIngresado');
        const passwordInput2 = $("#passwordIS");
        passwordInput.attr('type', this.checked ? 'text' : 'password');
        passwordInput2.attr('type', this.checked ? 'text' : 'password');
    });



});