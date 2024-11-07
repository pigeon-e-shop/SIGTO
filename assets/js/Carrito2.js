import Alertas from "./Alertas.js";

$(document).ready(function () {
    const alertas = new Alertas("#alert-container");
    let carritoId; 

    function initEvents() {
        $(document).on("click", ".agregarArt", agregarArticulo);
        $(document).on("change", ".articulo-cantidad", actualizarCantidad);
        $(document).on("click",".btn-remove", eliminarArticulo);
    }

    function agregarArticulo(e) {
        e.preventDefault();
        const idArticulo = $(this).data("id");

        if (!carritoId) {
            alertas.error("Carrito no encontrado. Intenta cargar los artículos primero.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: "agregar",
                idUser: checklogin(),
                idArticulo: idArticulo,
                idCarrito: carritoId, 
            },
            success: function (response) {
                if (response.status === "ok") {
                    alertas.success("Artículo agregado correctamente");
                    getItems(checklogin()); 
                } else {
                    alertas.error("Error al agregar el artículo.");
                }
            },
            error: function () {
                alertas.error("Error en la conexión.");
            },
        });
    }

    function eliminarArticulo() {
        const articuloId = $(this).data("id");
    
        if (!carritoId) {
            alertas.error("Carrito no encontrado. No se puede eliminar el artículo.");
            return;
        }
    
        checklogin((idUsuario) => {
            $.ajax({
                type: "POST",
                url: "/controller/carrito.controller.php",
                data: {
                    mode: 'eliminar',
                    idArticulo: articuloId,
                    idUser: idUsuario,
                },
                success: function (response) {
                    if (response.status == "success") {
                        alertas.success("Artículo eliminado correctamente.");
                        checklogin(getItems);
                    } else {
                        alertas.error("Error al eliminar el artículo: " + response.message);
                    }
                },
                error: function (xhr,status,message) {
                    console.error(xhr,status,message);
                    alertas.error("Error en la conexión al eliminar el artículo.");
                },
            });
        });
    }
    
    

    function checklogin(callback) {
        $.ajax({
            type: "POST",
            url: "/controller/login.controller.php",
            data: { mode: "readCookies" },
            dataType: "JSON",
            success: function (redcookies) {
                callback(redcookies.usuario);
            },
            error: function (error) {
                console.error("Error:", error);
                callback(null);
            },
        });
    }

    function getItems(idUsuario) {
        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: "leer",
                idUsuario: idUsuario,
            },
            success: function (response) {
                if (response.status === "success") {
                    if (response.message == "El carrito está vacío.") {
                        mostrarCarritoVacio();
                    } else {
                        alertas.success("Carrito cargado!");
                        carritoId = response.data[0].CarritoId; 
                        renderizarArticulos(response.data);
                        actualizarResumenCompra(); 
                    }
                } else {
                    mostrarCarritoVacio();
                }
            },
            error: function (xhr, status, message) {
                console.error(xhr, status, message);
            },
        });
    }
    
    function mostrarCarritoVacio() {
        $("#main-content").empty().append(`
            <div class="alert alert-info">
                <p>Parece que tu carrito está vacío! Vamos a comprar algo!</p>
                <a href="/" class="btn btn-primary">Ir a comprar</a>
            </div>
        `);
        $("#resumen-lista").empty();
        $("#cartTotal").text("US$0.00");
        $("#pagar").attr('disabled', true)
    }
    

    function renderizarArticulos(data) {
        let precioTotal = 0;

        $("#resumen-lista").empty();
        $("#main-content").empty();

        data.forEach((articulo) => {
            const htmlContent = crearHtmlArticulo(articulo);
            const listaContent = crearHtmlResumen(articulo);

            $("#resumen-lista").append(listaContent);
            $("#main-content").append(htmlContent);
            precioTotal += articulo.precio * articulo.cantidad;

            $(`#cantidad-${articulo.id}`).val(articulo.cantidad);
        });

        $("#cartTotal").text(precioTotal.toFixed(2));
    }

    function crearHtmlArticulo(articulo) {
        return `
        <li class="list-group-item d-flex justify-content-between align-items-center cart-item">
            <img src="${articulo.rutaImagen}" alt="${articulo.nombre}" class="articulo-imagen rounded" width="100">
            <div class="articulo-detalles flex-grow-1 ms-3">
                <span class="articulo-nombre fw-bold">${articulo.nombre}</span>
                <span class="articulo-precio text-muted">$${parseInt(articulo.precio).toFixed(2)}</span>
                <div class="row">
                    <div class="col col-1">
                        <label for="cantidad-${articulo.id}" class="mt-2">Cantidad:</label>
                    </div>
                    <div class="col col-1">
                        <select id="cantidad-${articulo.id}" class="form-select articulo-cantidad" aria-label="Seleccionar cantidad">
                            ${Array.from({ length: Math.min(articulo.stock, 12) }, (_, i) => `<option value="${i + 1}">${i + 1}</option>`).join("")}
                        </select>    
                    </div>
                </div>    
                <span class="articulo-descuento">Descuento: <strong>${articulo.descuento}%</strong></span>
                <span class="articulo-precio-final">Precio Final: <strong>$<span id="precio-final-${articulo.id}">${(articulo.precio * (1 - articulo.descuento / 100)).toFixed(2)}</span></strong></span>
            </div>
            <button class="btn btn-danger btn-remove" data-id="${articulo.id}">Eliminar</button>
        </li>`;
    }

    function crearHtmlResumen(articulo) {
        return `
        <li class="d-flex justify-content-between w-100" data-id="${articulo.id}">
            <span>${articulo.cantidad} x ${articulo.nombre}</span>
            <span>US$${(articulo.precio * articulo.cantidad).toFixed(2)}</span>
        </li>`;
    }

    function actualizarCantidad() {
        const articuloId = $(this).attr("id").split("-")[1];
        const cantidadSeleccionada = parseInt($(this).val());

        const $articulo = $(`#precio-final-${articuloId}`).closest(".cart-item");
        const precioUnitario = parseFloat($articulo.find(".articulo-precio").text().replace("$", ""));
        const descuento = parseFloat($articulo.find(".articulo-descuento strong").text().replace("%", "")) / 100;

        const precioFinal = (precioUnitario * (1 - descuento) * cantidadSeleccionada).toFixed(2);
        $articulo.find(`#precio-final-${articuloId}`).text(precioFinal);

        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: "actualizar",
                cantidad: cantidadSeleccionada,
                idArticulo: articuloId,
                idCarrito: carritoId,
                idUser: checklogin()
            },
            success: function (response) {
                alertas.success("Cantidad actualizada correctamente.");
                actualizarTotalCarrito(); 
                actualizarResumen(); 
                actualizarResumenCompra(); 
            },
            error: function (xhr, status, message) {
                alertas.error("Error al actualizar la cantidad.");
                console.error(xhr, status, message);
            },
        });
    }

    function actualizarResumenCompra() {
        let subtotal = 0;
        let totalDescuento = 0;
        let totalConDescuento = 0; 

        $(".cart-item").each(function () {
            const $articulo = $(this);
            const cantidad = parseInt($articulo.find(".articulo-cantidad").val());
            const precioUnitario = parseFloat($articulo.find(".articulo-precio").text().replace("$", ""));
            const descuento = parseFloat($articulo.find(".articulo-descuento strong").text().replace("%", "")) / 100;

            // Calcular subtotal y descuentos
            const subtotalArticulo = precioUnitario * cantidad;
            const descuentoArticulo = subtotalArticulo * descuento;

            subtotal += subtotalArticulo;
            totalDescuento += descuentoArticulo;
            totalConDescuento += subtotalArticulo - descuentoArticulo;
        });

        $("#subtotalResumen").text(`US$${subtotal.toFixed(2)}`); 
        $("#descuentoResumen").text(`US$${totalDescuento.toFixed(2)}`); 
        $("#totalResumen").text(`US$${totalConDescuento.toFixed(2)}`); 

        alertas.success("Resumen de compra actualizado correctamente.");
    }

    function actualizarTotalCarrito() {
        let precioTotal = 0;
        $(".cart-item").each(function () {
            const $articulo = $(this);
            const precioFinal = parseFloat($articulo.find(".articulo-precio-final span").text());
            const cantidad = parseInt($articulo.find(".articulo-cantidad").val());
            precioTotal += precioFinal;
        });
        $("#cartTotal").text(precioTotal.toFixed(2)); 
        alertas.success("Total del carrito actualizado correctamente.");
    }

    function actualizarResumen() {
        let resumenHtml = "";
        let precioTotalResumen = 0;

        $(".cart-item").each(function () {
            const $articulo = $(this);
            const nombre = $articulo.find(".articulo-nombre").text();
            const cantidad = parseInt($articulo.find(".articulo-cantidad").val());
            const precioUnitario = parseFloat($articulo.find(".articulo-precio").text().replace("$", ""));
            const subtotal = (precioUnitario * cantidad).toFixed(2);
            precioTotalResumen += parseFloat(subtotal);

            resumenHtml += `
            <li class="d-flex justify-content-between w-100">
                <span>${cantidad} x ${nombre}</span>
                <span>US$${subtotal}</span>
            </li>`;
        });

        $("#resumen-lista").html(resumenHtml);
        $("#precioTotalResumen").text(precioTotalResumen.toFixed(2));
        alertas.success("Resumen actualizado correctamente.");
    }

    $("#pagar").on('click', function () {
        window.location.href = "/view/tienda/pago.html"
    });

    checklogin(getItems);
    initEvents();
});
