$(document).ready(function () {
    let idUser;

    $.ajax({
        type: "POST",
        url: "/controller/login.controller.php",
        data: { mode: "readCookies" },
        dataType: "JSON",
        success: function (redcookies) {
            console.log("Cookies read response:", redcookies);
            if (redcookies.error === "Cookie no encontrada") {
                window.location.href = "/";
            } else {
                idUser = redcookies.usuario;
                getUserInfo(idUser);
                getUserOrders(idUser);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al leer cookies:", error);
        },
    });

    $(document).keypress(function (e) {
        var key = e.which;
        if(key == 13)
         {
           // get info
           let calle = $("#form-calle").val();
           let npuerta = $("#form-npuerta").val();
           // ajax request
           $.ajax({
            type: "POST",
            url: "/controller/usuario.controller.php",
            data: {
                mode: 'updateDireccion',
                id: idUser,
                calle: calle,
                npuerta: npuerta
            },
            success: function (response) {
                getUserInfo(idUser);
            }
           });
         }
       });  
    


    function getUserInfo(idUser) {
        $.ajax({
            type: "POST",
            url: "/controller/usuario.controller.php",
            data: { mode: "getInfo", id: idUser },
            success: function (response) {
                const urlParams = new URLSearchParams(window.location.search);
                const filter = urlParams.get("mode");
                const userInfo = response[0][0];

                $("#nombre").html(userInfo.nombre);
                $("#apellido").html(userInfo.apellido);
                $("#email").html(userInfo.email);

                if (filter == 1) {
                    if (userInfo.calle !== "null") {

                        $("#calle").html(`<input type="street" id="form-calle" class="form-control" value="${userInfo.calle}" readonly="readonly">`);
                        $("#numeroPuerta").html(`<input type="number" id="form-npuerta" class="form-control" value="${userInfo.nPuerta}" readonly="readonly">`);
                        $("#contrasena").html(`<button class="btn btn-primary" id="btnEditPassword">Editar contraseña</button>`);
                        $("#form-calle").attr("readonly", "readonly");
                        $("#form-npuerta").attr("readonly", "readonly");

                        $("#form-calle, #form-npuerta").on("dblclick", function () {
                            $(this).css("box-shadow", "1px 1px 1px 1px black");
                            $(this).removeAttr("readonly");
                        });


                    } else {
                        $("#calle").html(`<input type="text" name="direccion" class="form-control" value="${userInfo.calle}" placeholder="Calle">`);
                        $("#numeroPuerta").html(`<input type="text" name="direccion" class="form-control" value="${userInfo.nPuerta}" placeholder="No de puerta">`);
                        $("#contrasena").html(`<button class="btn btn-primary" id="btnEditPassword">Editar contraseña</button>`);
                    }
                } else {
                    $("#calle").html(userInfo.calle);
                    $("#numeroPuerta").html(userInfo.nPuerta);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error al obtener información del usuario:", error);
            },
        });
    }

    function getUserOrders(idUser) {
        $.ajax({
            type: "POST",
            url: "/controller/usuario.controller.php",
            data: { mode: "getOrdenes", id: idUser },
            success: function (response) {
                $("#tablaOrdenes tbody").empty();
                $.each(response, function (index, compra) {
                    const precio = parseFloat(compra.precio);
                    $("#tablaOrdenes tbody").append(`
                        <tr>
                            <td>${compra.idCompra}</td>
                            <td>${compra.idEnvios}</td>
                            <td>${compra.metodoEnvio}</td>
                            <td>${new Date(compra.fechaSalida).toLocaleString()}</td>
                            <td>${compra.fechaLlegada ? new Date(compra.fechaLlegada).toLocaleString() : "No disponible"}</td>
                            <td>${compra.calle}</td>
                            <td>${compra.Npuerta}</td>
                            <td>${!isNaN(precio) ? precio.toFixed(2) : "No disponible"}</td>
                            <td><button class="btn btn-info">Detalles</button></td>
                        </tr>
                    `);
                });
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud AJAX:", error);
                alert("Ocurrió un error al cargar los datos.");
            },
        });
    }

    $(document).on("click", "#btnEditPassword", function (e) {
        e.preventDefault();
        $("#contrasena").html(`
            <div class="w-100">
                <div id="alert-container"></div>
                <hr>
                <label for="oldPassword">Antigua contraseña</label>
                <input class="form-control" type="password" name="oldPassword" id="oldPassword" required>
                <hr>
                <label for="newPassword">Nueva contraseña</label>
                <input class="form-control" type="password" name="newPassword" id="newPassword" required>
                <div class="my-3">
                    <label for="showPassword">Mostrar contraseña</label>
                    <input type="checkbox" name="showPassword" id="showPassword">
                </div>
                <br>
                <button class="btn btn-primary" id="submitNewPassword">Confirmar</button>
                <button class="btn btn-secondary" id="btnCancel">Cancelar</button>
            </div>
        `);
    });

    $(document).on("click", "#btnCancel", function (e) {
        e.preventDefault();
        $("#contrasena").html(`<button class="btn btn-primary" id="btnEditPassword">Editar contraseña</button>`);
    });

    $(document).on("click", "#submitNewPassword", function (e) {
        e.preventDefault();
        let oldPassword = $("#oldPassword").val();
        let newPassword = $("#newPassword").val();
        validateAndSubmitPassword(oldPassword, newPassword);
    });

    $(document).on("change", "#showPassword", function (e) {
        e.preventDefault();
        if ($(this).is(":checked")) {
            $("#newPassword").attr("type", "text");
        } else {
            $("#newPassword").attr("type", "password");
        }
    });

    function validateAndSubmitPassword(oldPassword, newPassword) {
        const alertas = new Alertas('#alert-container');
        if (oldPassword === newPassword) {
            alertas.warning("Las contraseñas no pueden ser iguales");
        } else if (oldPassword === "" || newPassword === "") {
            alertas.warning("Los campos no pueden estar vacíos");
        } else if (!isValidPassword(newPassword)) {
            alertas.warning("La nueva contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y caracteres especiales.");
        } else {
            $.ajax({
                type: "POST",
                url: "/controller/usuario.controller.php",
                data: {
                    mode: "editPassword",
                    old: oldPassword,
                    new: newPassword,
                    id: idUser,
                },
                success: function (response) {
                    switch (response.status) {
                        case "old=new":
                            alertas.warning("La antigua contraseña no puede ser igual a la nueva");
                            break;
                        case "ok":
                            alertas.success("Contraseña cambiada con éxito");
                            $("#contrasena").html(`<button class="btn btn-primary" id="btnEditPassword">Editar contraseña</button>`);
                            break;
                        case "old!=old":
                            alertas.error("La antigua contrasena no es la correcta");
                            break;
                        default:
                            alertas.error("Error inesperado, intenta de nuevo.");
                            break;
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error al cambiar la contraseña:", error);
                },
            });
        }
    }

    function isValidPassword(password) {
        const minLength = 8;
        const hasUpperCase = /[A-Z]/.test(password);
        const hasLowerCase = /[a-z]/.test(password);
        const hasNumbers = /\d/.test(password);
        const hasSpecialChars = /[!@#$%^&*(),.?":{}|<>]/.test(password);
        return password.length >= minLength && hasUpperCase && hasLowerCase && hasNumbers && hasSpecialChars;
    }
});

class Alertas {
    constructor(contenedor) {
        this.contenedor = contenedor;
    }

    success(texto) {
        this.showAlert('success', texto);
    }

    error(texto) {
        this.showAlert('danger', texto);
    }

    warning(texto) {
        this.showAlert('warning', texto);
    }

    showAlert(tipo, texto) {
        const alertElement = $(`
            <div class="alert alert-${tipo} alert-dismissible fade show" role="alert">
                ${texto}
                <button type="button" class="btn close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        `);

        $(this.contenedor).append(alertElement);

        setTimeout(() => {
            alertElement.alert('close');
        }, 3000);
    }
}
