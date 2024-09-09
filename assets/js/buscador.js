// cuando el documento esta cargado hace esto:
$(document).ready(function () {
	// oculta el elemento con id resultados usando css
    $("#resultados").css("display", "none");
	// elimina los `hijos` del elemento resultados
    $("#resultados").empty();
	// funcion que lee el evento `keyup` del elemento input con nombre buscador
    $('input[name="buscador"]').on("keyup", function () {
		// hace visible el elemento resultados
        $("#resultados").css("display", "block");
		// toma el id 
        let item = $(this).val();
        if (item == "" || item == " ") {
            $("#resultados").css("display", "none");
            $("#resultados").empty();
            return;
        }
        $.ajax({
            url: "http://localhost/controller/buscador.controller.php",
            type: "GET",
            data: { id: item },
            success: function (response) {
                let results = response;

                $("#resultados").html("");

                if (results.length > 0) {
                    let list = $("<ul></ul>");
                    results.forEach(function (item) {
                        let listItem = $("<li></li>");
                        let link = $("<a></a>")
                            .attr("href", "view/tienda/detalle_producto.html?modo=exclusivo2&id=" + item.idArticulo) //
                            .html("<strong>" + item.nombre + "</strong> - $" + item.precio + "<p>" + item.descripcion + "</p>");
							
                        listItem.append(link);
						list.append(listItem);
                    });
                    $("#resultados").append(list);
                } else {
                    $("#resultados").html("<p>No results found.</p>");
                }
            },
            error: function () {
                $("#resultados").html("<p>An error occurred while fetching the results.</p>");
            },
        });
    });
    $(document).click(function () {
        $("#resultados").css("display", "none");
        $("#resultados").empty();
    });
});