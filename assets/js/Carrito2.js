import Alertas from './Alertas.js';

$(document).ready(function () {
    const alertas = new Alertas("#alert-container");
    let carritoId; // Declarar la variable carritoId

    // Función para inicializar eventos
    function initEvents() {
        $(document).on("click", ".agregarArt", agregarArticulo);
        $(document).on('change', '.articulo-cantidad', actualizarCantidad);
    }

    // Función para agregar un artículo al carrito
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
                idCarrito: carritoId // Pasar el idCarrito
            },
            success: function (response) {
                if (response.status === "ok") {
                    alertas.success("Artículo agregado correctamente");
                    getItems(checklogin()); // Actualizar el carrito después de agregar
                } else {
                    alertas.error("Error al agregar el artículo.");
                }
            },
            error: function () {
                alertas.error("Error en la conexión.");
            },
        });
    }

    // Función para verificar si el usuario está logueado
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

    // Función para obtener los artículos del carrito
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
                    alertas.success("Carrito cargado!");
                    carritoId = response.data[1].CarritoId; // Guardar el idCarrito
                    renderizarArticulos(response.data);
                    actualizarResumenCompra(); // Llamar aquí
                }
            },
            error: function (xhr, status, message) {
                console.error(xhr, status, message);
            },
        });
    }

    // Función para renderizar artículos en el carrito
    function renderizarArticulos(data) {
        let precioTotal = 0;

        // Limpiar contenido previo
        $("#resumen-lista").empty();
        $("#main-content").empty();

        data.forEach((articulo) => {
            const htmlContent = crearHtmlArticulo(articulo);
            const listaContent = crearHtmlResumen(articulo);

            $("#resumen-lista").append(listaContent);
            $("#main-content").append(htmlContent);
            precioTotal += articulo.precio * articulo.cantidad;

            // Establecer el valor seleccionado en el select
            $(`#cantidad-${articulo.id}`).val(articulo.cantidad);
        });

        // Actualizar el total del carrito
        $("#cartTotal").text(precioTotal.toFixed(2)); // Asegurarse de mostrar 2 decimales
    }

    // Función para crear el HTML de un artículo
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
            <button class="btn btn-danger btn-remove">Eliminar</button>
        </li>`;
    }

    // Función para crear el HTML del resumen de artículos
    function crearHtmlResumen(articulo) {
        return `
        <li class="d-flex justify-content-between w-100" data-id="${articulo.id}">
            <span>${articulo.cantidad} x ${articulo.nombre}</span>
            <span>US$${(articulo.precio * articulo.cantidad).toFixed(2)}</span>
        </li>`;
    }

    // Función para actualizar la cantidad de un artículo
    function actualizarCantidad() {
        const articuloId = $(this).attr('id').split('-')[1];
        const cantidadSeleccionada = parseInt($(this).val());

        const $articulo = $(`#precio-final-${articuloId}`).closest('.cart-item');
        const precioUnitario = parseFloat($articulo.find('.articulo-precio').text().replace('$', ''));
        const descuento = parseFloat($articulo.find('.articulo-descuento strong').text().replace('%', '')) / 100;

        // Calcular el nuevo precio final
        const precioFinal = (precioUnitario * (1 - descuento) * cantidadSeleccionada).toFixed(2);
        $articulo.find(`#precio-final-${articuloId}`).text(precioFinal); // Actualizar el precio final del artículo actual

        // Actualizar la cantidad en la base de datos
        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: 'actualizar',
                cantidad: cantidadSeleccionada,
                idArticulo: articuloId,
                idCarrito: carritoId
            },
            success: function (response) {
                alertas.success("Cantidad actualizada correctamente.");
                actualizarTotalCarrito(); // Actualizar total del carrito
                actualizarResumen(); // Actualizar resumen del carrito
                actualizarResumenCompra(); // Llamar aquí también
            },
            error: function (xhr, status, message) {
                alertas.error("Error al actualizar la cantidad.");
                console.error(xhr, status, message);
            }
        });
    }

    // Función para actualizar el resumen de la compra
function actualizarResumenCompra() {
    let subtotal = 0;
    let totalDescuento = 0; // Variable para el total de descuentos
    let totalConDescuento = 0; // Variable para el total después de aplicar descuentos

    $('.cart-item').each(function () {
        const $articulo = $(this);
        const cantidad = parseInt($articulo.find('.articulo-cantidad').val());
        const precioUnitario = parseFloat($articulo.find('.articulo-precio').text().replace('$', ''));
        const descuento = parseFloat($articulo.find('.articulo-descuento strong').text().replace('%', '')) / 100;

        // Calcular subtotal y descuentos
        const subtotalArticulo = precioUnitario * cantidad;
        const descuentoArticulo = subtotalArticulo * descuento;
        
        subtotal += subtotalArticulo;
        totalDescuento += descuentoArticulo; // Acumular descuentos
        totalConDescuento += (subtotalArticulo - descuentoArticulo); // Calcular total con descuento
    });

    // Actualizar los elementos del DOM
    $("#subtotalResumen").text(`US$${subtotal.toFixed(2)}`); // Solo el precio
    $("#descuentoResumen").text(`US$${totalDescuento.toFixed(2)}`); // Solo el precio
    $("#totalResumen").text(`US$${totalConDescuento.toFixed(2)}`); // Solo el precio
    
    alertas.success("Resumen de compra actualizado correctamente.");
}

// Asegúrate de llamar a esta función en las siguientes partes del código:
// 1. Al finalizar la función `renderizarArticulos`.
// 2. Después de `actualizarTotalCarrito` y `actualizarResumen` en `actualizarCantidad`.


    // Función para actualizar el total del carrito
    function actualizarTotalCarrito() {
        let precioTotal = 0;
        $('.cart-item').each(function () {
            const $articulo = $(this);
            const precioFinal = parseFloat($articulo.find('.articulo-precio-final span').text());
            const cantidad = parseInt($articulo.find('.articulo-cantidad').val());
            precioTotal += precioFinal;
        });
        $("#cartTotal").text(precioTotal.toFixed(2)); // Asegurarse de mostrar 2 decimales
        alertas.success("Total del carrito actualizado correctamente.");
    }

    // Función para actualizar el resumen de artículos
    function actualizarResumen() {
        let resumenHtml = "";
        let precioTotalResumen = 0;

        $('.cart-item').each(function () {
            const $articulo = $(this);
            const nombre = $articulo.find('.articulo-nombre').text();
            const cantidad = parseInt($articulo.find('.articulo-cantidad').val());
            const precioUnitario = parseFloat($articulo.find('.articulo-precio').text().replace('$', ''));
            const subtotal = (precioUnitario * cantidad).toFixed(2);
            precioTotalResumen += parseFloat(subtotal);

            resumenHtml += `
            <li class="d-flex justify-content-between w-100">
                <span>${cantidad} x ${nombre}</span>
                <span>US$${subtotal}</span>
            </li>`;
        });

        // Actualizar el resumen en el DOM
        $("#resumen-lista").html(resumenHtml);
        $("#precioTotalResumen").text(precioTotalResumen.toFixed(2)); // Asegurarse de mostrar 2 decimales
        alertas.success("Resumen actualizado correctamente.");
    }

    // Verificar si el usuario está logueado y cargar el carrito
    checklogin(getItems);
    initEvents();
});
