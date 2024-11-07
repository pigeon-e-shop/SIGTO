import Alertas from "./Alertas.js";
const alertas = new Alertas("#alert-container");
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

    $(document).keypress(function (e) {
        var key = e.which;
        if (key == 13) {
            // get info
            let calle = $("#form-calle").val();
            let npuerta = $("#form-npuerta").val();
            // ajax request
            $.ajax({
                type: "POST",
                url: "/controller/usuario.controller.php",
                data: {
                    mode: "updateDireccion",
                    id: idUser,
                    calle: calle,
                    npuerta: npuerta,
                },
                success: function (response) {
                    alertas.success("HOLA");
                    getUserInfo(idUser);
                },
                error: function (xhr, status, error) {
                    console.error(xhr, status, error);
                },
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
                            <td>${compra.idEnvio}</td>
                            <td>${compra.metodoEnvio}</td>
                            <td>${new Date(compra.fechaSalida).toLocaleString()}</td>
                            <td>${compra.fechaLlegada ? new Date(compra.fechaLlegada).toLocaleString() : "No disponible"}</td>
                            <td>${compra.calle}</td>
                            <td>${compra.Npuerta}</td>
                            <td>${!isNaN(precio) ? precio.toFixed(2) : "No disponible"}</td>
                            <td><button class="btn btn-info" data-id="${compra.idCompra}">Detalles</button></td>
                        </tr>
                    `);
                });
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud AJAX:", error);
                alertas.warning("Ocurrió un error al cargar los datos.");
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
        const alertas = new Alertas("#alert-container");
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
                        case "password_updated":
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
    // interfaz pagina
    // 0 = informacion de usuario: mis ordenes e info
    // 1 = editar usuario: info editable
    // 2 = Seguimiento de envios: mis ordenes y seguimiento de envios
    // 3 = historial: historial: historial de articulos vistos
    const urlParams = new URLSearchParams(window.location.search);
    let filter = urlParams.get("mode");
    try {
        filter = parseInt(filter);
    } catch (Error) {
        console.error(Error);
    }
    let title = $("title");
    switch (filter) {
        case 1:
            title.text("Editar usuario");
            break;
        case 2:
            title.text("Seguimiento de envios");
            // borrar info usuario
            // infoCuenta
            let container = $("#infoCuenta");
            container.empty("");
            container.html("<div class='container mt-5'><h2>Seguimiento de envios</h2></div>");
            container.append("<ul id='seguimiento'>");
            for (let index = 0; index < 5; index++) {
                $("#seguimiento").append(`<li>${index}</li>`);
            }
            break;
        case 3:
            title.text("Historial");
            let mainDiv = $("#content-main");
            mainDiv.empty(); // Limpiar el contenedor antes de agregar nuevo contenido
            mainDiv.html("<h1>Historial</h1>");
            mainDiv.append(`<ul class="row w-100" id="listaHistorial"></ul>`);

            // Verifica que la cookie de sesión sea válida
            $.ajax({
                type: "POST",
                url: "/controller/login.controller.php",
                data: { mode: "readCookies" },
                dataType: "JSON",
                success: function (redcookies) {
                    console.log("Cookies read response:", redcookies);
                    if (redcookies.error === "Cookie no encontrada") {
                        window.location.href = "/"; // Redirige al login si no se encuentran las cookies
                    } else {
                        const idUser = redcookies.usuario; // Obtener el ID del usuario desde las cookies
                        // Ahora solicitamos el historial de artículos vistos
                        $.ajax({
                            type: "POST",
                            url: "/controller/usuario.controller.php",
                            data: {
                                mode: 'getHistorial',
                                idUser: idUser
                            },
                            dataType: 'json',
                            success: function (response) {
                                console.log(response);
                                if (response.length === 0) {
                                    $("#listaHistorial").append("<li>No hay historial de artículos vistos.</li>");
                                } else {
                                    response.forEach(element => {
                                        let content = `
                                                <div class="col col-12 col-md-2 card m-5">
                                                    <img src="${element.rutaImagen}" class="card-img-top" alt="${element.nombre}">
                                                    <div class="card-body">
                                                      <h5 class="card-title">${element.nombre}</h5>
                                                      <p class="card-text">${element.precio}</p>
                                                      <a href="/view/tienda/detalle_producto.html?id=${element.idArticulo}&modo=exclusivo2" class="btn btn-primary">Ver pagina</a>
                                                    </div>
                                                </div>
                                            `;
                                        $("#listaHistorial").append(content);
                                    });
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error("Error al cargar historial:", error);
                                $("#listaHistorial").append("<li>Error al cargar historial. Intenta nuevamente.</li>");
                            }
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error al leer cookies:", error);
                }
            });
            break;

        case 0:
            title.text("Informacion de usuario");
            break;
        default:
            window.location.href = "/view/tienda/usuario.html?mode=0";
            break;
    }
});