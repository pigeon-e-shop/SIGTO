import Alertas from './Alertas.js'
$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get("id");
    const mode = urlParams.get("modo");
    const alertas = new Alertas("#alert-container");
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

    $(document).on('click','.btn-add-to-cart', function (e) {
        // agregar
        e.preventDefault();
        e.stopPropagation();
        
        $.ajax({
            type: "POST",
            url: "/controller/historial.controller.php",
            data: {modo: 'getCookie'},
            dataType: "JSON",
            success: function (response) {
                if (response.error == 'Error') {
                    console.error("Error en getCookie");
                } else {
                    $.ajax({
                        type: "POST",
                        url: "/controller/carrito.controller.php",
                        data: {
                            mode: 'agregar',
                            idUser: response.valor,
                            idArticulo: productId
                        },
                        success: function (response) {
                            console.log(response);
                            if (response.status == 'ok') {
                                alertas.success('articulo agregado correctamente');
                            } else if (response.message == "Debes loguearte primero") {
                                alertas.error("Debes loguearte primero.")
                            } else {
                                alertas.error('Error.');
                            }
                        },
                        error: function (xhr,status,message) {
                            alertas.error('Error.');
                            console.error(xhr,status,message);
                            
                        }
                    });
                }
            }
        });
    });

    // agregar al historial

    $.ajax({
        type: "POST",
        url: "/controller/historial.controller.php",
        data: {modo: 'getCookie'},
        dataType: "JSON",
        success: function (response) {
            if (response.error == 'Error') {
                console.error("ERROR en getCookie");
            } else {
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