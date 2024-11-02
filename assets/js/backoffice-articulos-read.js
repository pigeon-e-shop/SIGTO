import Alertas from './Alertas.js';
$(document).ready(function () {
    const alertas = new Alertas("#alert-container");
    alertas.info("Bienvenido!")
    $.ajax({
        type: "POST",
        url: "/controller/backoffice.controller.php",
        data: { mode: "getArticulos" },
        success: function (response) {
            response.forEach((element) => {
                const checked = element.VISIBLE == 1 ? "checked" : "";
                const newRow = `
        <tr class="table-row" data-vs="${element.id}">
            <td>${element.id}</td>
            <td>${element.nombre}</td>
            <td>${element.precio}</td>
            <td>${element.descuento}%</td>
            <td>${element.stock}</td>
            <td>
            <a href="${element.rutaImagen}" 
               data-pswp-width="100" 
               data-pswp-height="100" 
               class="my-image">
                <img src="${element.rutaImagen}" height="50" alt="Descripción de la imagen" />
            </a>
         
            </td>
            <td>
                <div class="form-check form-switch">
                    <input class="form-check-input visibilidad" type="checkbox" value="${element.VISIBLE}" id="visibilidad${element.id}" ${checked}/>
                    <label class="form-check-label" for="visibilidad${element.id}"></label>
                </div>
            </td>
            <td>
                <div class="d-inline flex-column align-items-center justify-content-center w-75">
                    <a href="#" class="btn btn-link editar" data-toggle="tooltip" data-placement="top" title="Editar">
                        <i class="bi bi-pencil"></i>
                    </a>
                    <a href="#" class="btn btn-link detalles" data-toggle="tooltip" data-placement="top" title="Ver detalles">
                        <i class="bi bi-info-circle"></i>
                    </a>
                    <a href="#" class="btn btn-link visitPage" data-toggle="tooltip" data-placement="top" title="Ir a página de artículo">
                        <i class="bi bi-box-arrow-up-right"></i>
                    </a>
                </div>
            </td>
        </tr>
    `;
                $("tbody").append(newRow);
            });
            $(".visibilidad").on("change", function () {
                const idArticulo = $(this).closest("tr").data("vs");
                const visibility = $(this).is(":checked") ? 1 : 0;

                $.ajax({
                    type: "POST",
                    url: "/controller/backoffice.controller.php",
                    data: {
                        mode: "cambiarVisibilidad",
                        visibilidad: visibility,
                        idArticulo: idArticulo,
                    },
                    success: function (response) {
                        if (response.status == "success") {
                            alertas.success("Visibilidad Cambiada");
                        }
                    },
                });
            });
        },
    });

    $(document).on("click", ".visitPage", function (e) {
        e.preventDefault();
        const idArticulo = $(this).closest("tr").data("vs");
        window.location.href = `/view/tienda/detalle_producto.html?id=${idArticulo}&modo=exclusivo2`;
    });

    $(document).on("click", '.detalles', function (e) {
        e.preventDefault();
        const idArticulo = $(this).closest("tr").data("vs");
        window.location.href = `/view/backoffice/articulos.detalles.html?id=${idArticulo}`;
    });

    $(document).on("click", '.editar', function (e) {
        e.preventDefault();
        const idArticulo = $(this).closest("tr").data("vs");
        window.location.href = `/view/backoffice/articulos.edit.html?id=${idArticulo}`;
    });

});