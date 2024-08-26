$(document).ready(function () {
    let url = `http://localhost/SIGTO/model/connection.php`;

    $.ajax({
        type: "GET",
        url: url,
        data: { modo: 'read', tabla: 'articulo' },
        dataType: "JSON",
        success: function (response) {
            let content = ''; // Inicializar una variable para acumular el HTML

            // Recorrer cada elemento en la respuesta
            response.forEach(element => {
                // Concatenar el HTML para cada artículo
                content += `
                <a href="detalle_producto.html?id=${element.idArticulo}&modo=exclusivo2">
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
                `;
            });

            // Asignar el HTML acumulado al contenedor
            $("#articulosMain").html(content);
        },
        error: function (error) {
            console.error("Error al cargar los artículos:", error);
        }
    });
});
