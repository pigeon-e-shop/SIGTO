$(document).ready(function () {
    let idUser;
    let content1 = `<div id="contentUser" class="col-11 container-flex">
                <section id="misOrdenes" class="p-3">
                    <h3 class="text-center mb-4">Mis Órdenes</h3>
                    <div class="container-flex table-responsive">
                        <table id="tablaOrdenes" class="table table-striped table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID Compra</th>
                                    <th>ID Envío</th>
                                    <th>Método de Envío</th>
                                    <th>Fecha de Salida</th>
                                    <th>Fecha de Llegada</th>
                                    <th>Calle</th>
                                    <th>Número de Puerta</th>
                                    <th>Total de la Orden</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </section>
                <hr class="container">
                <section id="infoCuenta" class="">
                    <h3 class="text-center mt-4">Info Cuenta</h3>
                    <div class="row">
                        <div class="col-md-auto">
                            <p id="nombre" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="apellido" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="email" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="calle" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="numeroPuerta" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="contrasena" class="font-weight-bold"></p>
                        </div>
                    </div>
                </section>
            </div>`;
    let content2 = `<section id="infoCuenta" class="">
                    <h3 class="text-center mt-4">Info Cuenta</h3>
                    <div class="row">
                        <div class="col-md-auto">
                            <p id="nombre" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="apellido" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="email" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="calle" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="numeroPuerta" class="font-weight-bold"></p>
                        </div>
                        <div class="col-md-auto">
                            <p id="contrasena" class="font-weight-bold"></p>
                        </div>
                    </div>
                </section>`;

    let content3 = `<section id="misOrdenes" class="p-3">
                    <h3 class="text-center mb-4">Mis Órdenes</h3>
                    <div class="container-flex table-responsive">
                        <table id="tablaOrdenes" class="table table-striped table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID Compra</th>
                                    <th>ID Envío</th>
                                    <th>Método de Envío</th>
                                    <th>Fecha de Salida</th>
                                    <th>Fecha de Llegada</th>
                                    <th>Calle</th>
                                    <th>Número de Puerta</th>
                                    <th>Total de la Orden</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </section>`;
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
                    $("#usuarioMain").html(content3);
                    /*
                    $("#calle").html(`<input type="text" value="${userInfo.calle}">`);
                    $("#numeroPuerta").html(`<input type="text" value="${userInfo.nPuerta}">`);
                    $("#contrasena").html(`<button class="btn btn-primary" id="btnEditPassword">Editar contraseña</button>`);
                    */
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
            <div>
                <hr>
                <label for="oldPassword">Antigua contraseña</label>
                <input type="password" name="oldPassword" id="oldPassword" required>
                <hr>
                <label for="newPassword">Nueva contraseña</label>
                <input type="password" name="newPassword" id="newPassword" required>
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
        if (oldPassword === newPassword) {
            alert("Las contraseñas no pueden ser iguales");
        } else if (oldPassword === "" || newPassword === "") {
            alert("Los campos no pueden estar vacíos");
        } else if (!isValidPassword(newPassword)) {
            alert("La nueva contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y caracteres especiales.");
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
                            alert("La antigua contraseña no puede ser igual a la nueva");
                            break;
                        case "ok":
                            alert("Contraseña cambiada con éxito");
                            $("#contrasena").html(`<button class="btn btn-primary" id="btnEditPassword">Editar contraseña</button>`);
                            break;
                        case "old!=old":
                            alert("La antigua contrasena no es la correcta");
                            break;
                        default:
                            alert("Error inesperado, intenta de nuevo.");
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