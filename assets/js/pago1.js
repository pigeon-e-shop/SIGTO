$(document).ready(function () {
    async function cargarResumen() {
        let idUser = await obtenerIdUsuario();
        let infoDireccion = await getDireccion(idUser);
        $("#direccion").html(`${infoDireccion[0].calle} ${infoDireccion[0].npuerta}`)
        getItems(idUser);
    }

    cargarResumen();

    async function obtenerIdUsuario() {
        try {
            let response = await $.ajax({
                type: "POST",
                url: "/controller/login.controller.php",
                data: { mode: "readCookies" },
                dataType: "JSON",
            });
            return response.usuario;
        } catch (error) {
            window.location.href = "/view/tienda/signIn.html";
            return 0;
        }
    }

    function getItems(idUser) {
        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: "leer",
                idUsuario: idUser,
            },
            dataType: "JSON",
            success: function (response) {
                if (response.status === "success") {
                    renderizarArticulos(response.data);
                }
            },
            error: function (xhr, status, message) {
                console.error("Error al obtener los artículos:", message);
            },
        });
    }

    let pagar = async () => {
        let idUser = await obtenerIdUsuario();
        const metodoEnvio = $('input[name="envio"]:checked').data("tipo");
        const calle = $("#direccion").text().split(" ")[0];
        const npuerta = $("#direccion").text().split(" ")[1];
        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: 'pagar',
                idUsuario: idUser,
                metodoEnvio: '',
                calle: '',
                npuerta: '' 
            },
            dataType: "JSON",
            success: function (response) {
                alert('EXITO');
            },
            error: function (xhr,status,message) {
                console.error(xhr,status,message);
                
            }
        });
    }

    function renderizarArticulos(data) {
        let precioTotal = 0;

        $("#resumen-lista").empty();

        data.forEach((articulo) => {
            const listaContent = crearHtmlResumen(articulo);
            $("#resumen-lista").append(listaContent);
            precioTotal += articulo.precio * articulo.cantidad;
        });

        $("#subtotalResumen").text(`US$${precioTotal.toFixed(2)}`);
        actualizarResumen(precioTotal);
    }

    function crearHtmlResumen(articulo) {
        return `
        <li class="d-flex justify-content-between w-100">
            <span>${articulo.cantidad} x ${articulo.nombre}</span>
            <span>US$${(articulo.precio * articulo.cantidad).toFixed(2)}</span>
        </li>`;
    }

    function actualizarResumen() {
        let subtotal = 0;
        let descuento = 0;
        let envio = parseFloat($("#envioResumen").text()) || 0;

        $("#resumen-lista li").each(function () {
            const cantidadTexto = $(this).find("span").first().text().split(" x ")[0];
            const precioTexto = $(this).find("span").last().text().replace("US$", "");
            const cantidad = parseInt(cantidadTexto);
            const precioUnitario = parseFloat(precioTexto);

            subtotal += precioUnitario * cantidad;
        });

        let total = subtotal - descuento + envio;

        $("#subtotalResumen").text(`US$${subtotal.toFixed(2)}`);
        $("#descuentoResumen").text(`US$${descuento.toFixed(2)}`);
        $("#totalResumen").text(`US$${total.toFixed(2)}`);
    }

    $('input[name="envio"]').on("change", function () {
        var precio = parseFloat($(this).val());
        $("#precio").text(`El costo adicional del envio es $${precio.toFixed(2)}`);
        $("#envioResumen").text(`$${precio.toFixed(2)}`);
        actualizarTotal(precio);
    });
    

    function actualizarTotal(precioEnvio) {
        const subtotal = parseFloat($("#subtotalResumen").text().replace("US$", "")) || 0;
        const descuentos = parseFloat($("#descuentoResumen").text().replace("US$", "")) || 0;
        const total = subtotal - descuentos + precioEnvio;

        $("#totalResumen").text(`US$${total.toFixed(2)}`);
    }

    let getDireccion = async (idUser) => {
        try {
            let response = await $.ajax({
                type: "POST",
                url: "/controller/usuario.controller.php",
                data: { mode: "getDireccion", idUsuario: idUser },
                dataType: "JSON",
            });
            return response;
        } catch (error) {
            console.error("Error al obtener la dirección:", error);
            return null;
        }
    };
    
});
