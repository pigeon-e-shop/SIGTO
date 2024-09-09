let idArticulo = 57; // Cambia este valor por el ID que deseas buscar
let modo = "read";
let tabla = "articulo";
let url = `http://localhost/controller/index.controller.php`;

let ajaxConn = () => {
    $.ajax({
        url: url, 
        dataType: "JSON",
        data: {mode: 'readDetalle'},
        success: function (response) {
            console.log(response);
            if (response && Array.isArray(response)) {
                let articulo = response.find(art => art.idArticulo == idArticulo);
                if (articulo) {
                    $("#nombreArticulo").html(articulo.nombre);
                    $("#descripcionArticulo").html(articulo.descripcion);
                    $("#precioProducto").html(`$${articulo.precio}`);
                    $("#imagenArticulo").attr('src',articulo.rutaImagen);
                } else {
                    console.log("Artículo no encontrado");
                }
            } else {
                console.log("La respuesta no es un array JSON válido");
            }
        },
        error: function (error) {
            console.error("Error en la solicitud AJAX:", error);
        }
    });
};

let retornarDatos = () => {
    $.ajax({
        url: url, 
        dataType: "JSON",
        success: function (response) {
            console.log(response);
            if (response && Array.isArray(response)) {
                return JSON.parse(response);
            } else {
                console.log("La respuesta no es un array JSON válido");
            }
        },
        error: function (error) {
            console.error("Error en la solicitud AJAX:", error);
        }
    });
};

ajaxConn();