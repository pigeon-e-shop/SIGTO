$(document).ready(function () {
    const url = `/controller/index.controller.php`;

    $.ajax({
        type: "GET",
        url: url,
        data: { mode: 'readDetalle' },
        dataType: "JSON",
        success: function (response) {
            let content = '';

            if (Array.isArray(response)) {
                const discountRequests = response.map(element => {
                    return $.ajax({
                        type: "POST",
                        url: url,
                        data: { mode: 'getDiscount', id: element.id }
                    }).then(discountResponse => {
                        const descuento = discountResponse["0"]["descuento"];
                        const precio = element.precio;
                        if (!isNaN(precio) && !isNaN(descuento)) {
                            if (descuento !== 0) {
                                const precioFinal = (precio * (1 - descuento / 100)).toFixed(2);
                                content += `
                                    <a class="articuloLista" href="detalle_producto.html?id=${element.id}&modo=exclusivo2">
                                        <div class="row">
                                            <div class="col-3">
                                                <img src="${element.rutaImagen}" alt="${element.nombre}" height="120px">
                                            </div>
                                            <div class="col">
                                                <p><h2><strong>${element.nombre}</strong></h2></p>
                                                <p><h4>${element.descripcion}</h4></p>
                                                <h5 style="text-decoration: line-through solid blue 1.5px">${precio}</h5>
                                                <h4>${"$" + precioFinal}</h4>
                                            </div>
                                        </div>
                                    </a>
                                    <hr>
                                `;
                            } else {
                                content += `
                                    <a class="articuloLista" href="detalle_producto.html?id=${element.id}&modo=exclusivo2">
                                        <div class="row">
                                            <div class="col-3">
                                                <img src="${element.rutaImagen}" alt="${element.nombre}" height="120px">
                                            </div>
                                            <div class="col">
                                                <p><h2><strong>${element.nombre}</strong></h2></p>
                                                <p><h4>${element.descripcion}</h4></p>
                                                <p><h4>${precio}</h4></p>
                                            </div>
                                        </div>
                                    </a>
                                    <hr>
                                `;
                            }
                        } else {
                            console.error("Valores inválidos:", { precio, descuento });
                        }
                    });
                });

                $.when(...discountRequests).done(function () {
                    $("#articulosMain").html(content);
                });

            } else {
                console.error("La respuesta no es un array:", response);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("Error al cargar los artículos:", textStatus, errorThrown);
        }
    });
});
