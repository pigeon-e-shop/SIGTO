$(document).ready(function () {
    let url = `../../controller/index.controller.php`;

    $.ajax({
        type: "GET",
        url: url,
        data: { mode: 'readDetalle'},
        dataType: "JSON",
        success: function (response) {
            console.log("Respuesta del servidor:", response); // Añadir esta línea para depuración

            let content = ''; // Inicializar una variable para acumular el HTML

            if (Array.isArray(response)) { // Verificar que la respuesta sea un array
                // Recorrer cada elemento en la respuesta
                response.forEach(element => {
                    // Concatenar el HTML para cada artículo
                    content += `
                    <a class="articuloLista" href="detalle_producto.html?id=${element.idArticulo}&modo=exclusivo2">
                    <div class="row">
                        <div class="col">
                            <img src="${element.rutaImagen}" alt="${element.nombre}" height="120px">
                        </div>
                        <div class="col">
                            <p><strong>${element.nombre}</strong></p>
                            <p>${element.descripcion}</p>
                            <p>${element.precio}</p>
                        </div>
                    </div>
                    </a>
                    <hr>
                    `;
                });
            } else {
                console.error("La respuesta no es un array:", response);
            }

            // Asignar el HTML acumulado al contenedor
            $("#articulosMain").html(content);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("Error al cargar los artículos:", textStatus, errorThrown);
        }
    });
});
