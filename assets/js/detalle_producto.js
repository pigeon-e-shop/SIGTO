$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get("id");
    const mode = urlParams.get("modo");
    if (productId) {
        $.ajax({
            url: "../../controller/index.controller.php",
            method: "GET",
            data: { id: productId, mode: mode },
            dataType: "json",
            success: function (data) {
                if (data.error) {
                    $("#nombreArticulo").text("Producto no encontrado");
                    $("#descripcionArticulo").text("");
                    $("#precioProducto").text("");
                    $("#precioProducto1").text("");
                    $("#imagenArticulo").attr("src", "");
                } else {
                    let producto = data.articulo[0];
                    $("#nombreArticulo").html(`${producto.nombre} | <div class="stars-title" style="--calificacion: ${data.calificacion[0].calificacion}"></div>`);
                    $("#descripcionArticulo").text(producto.descripcion);
                    $("#precioProducto").text("$" + producto.precio);
                    if (data.descuento[0].descuento != 0) {
                        $("#precioProducto").css("text-decoration", "line-through solid blue 3px");
                        $("#precioProducto").css("display", "inline");
                        $("#precioProducto1").text(data.descuento[0].descuento + "% | ");
                        $("#precioProducto1").append("$" + (parseFloat(producto.precio) * (1 - data.descuento[0].descuento / 100)).toFixed(2));
                        $("#precioProducto1").css("display","block");
                        $("#precioProducto1").css("color","red");
                    }
                    if (data.stock[0].stock != 0) {
                        $(".product-stock-container").css("display","block");
                        $("#stockProducto").text("Tenemos " + data.stock[0].stock + " en stock. Compra antes de que se acabe!");
                    } else {
                        $(".product-stock-container").css("display","block");
                    }
                    $("#imagenArticulo").attr("src", producto.rutaImagen);
                }
            },
            error: function () {
                $("#nombreArticulo").text("Error al cargar el producto");
                $("#descripcionArticulo").text("");
                $("#precioProducto").text("");
                $("#imagenArticulo").attr("src", "");
            },
        });
    } else {
        $("#nombreArticulo").text("ID del producto no especificado");
        $("#descripcionArticulo").text("");
        $("#precioProducto").text("");
        $("#imagenArticulo").attr("src", "");
    }

    // agregar al historial

    $.ajax({
        type: "POST",
        url: "/controller/historial.controller.php",
        data: {modo: 'getCookie'},
        dataType: "JSON",
        success: function (response) {
            console.log('Primera respuesta:', response);
            if (response.error == 'Error') {
                console.error("ERROR en getCookie");
            } else {
                console.log('Valor recibido:', response.valor);
                $.ajax({
                    type: "POST",
                    url: "/controller/historial.controller.php",
                    data: {
                        modo: 'agregar',
                        idArticulo: productId,
                        id: response.valor
                    },
                    dataType: "JSON",
                    success: function (response2) {
                        console.log('OK en agregar');
                        console.log(response2);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error en agregar:', xhr, status, error);
                    }
                });
            }
        },
        error: function (xhr, status, error) {
            console.error('Error en getCookie:', xhr, status, error);
        }
    });

});