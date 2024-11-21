$(document).ready(function () {
    $("#resultados").css("display", "none").empty();

    function debounce(func, wait) {
        let timeout;
        return function(...args) {
            const context = this;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), wait);
        };
    }

    const fetchResults = function() {
        let item = $('input[name="query"]').val().trim();    
        if (item === "") {
            $("#resultados").css("display", "none").empty();
            return;
        }
        $.ajax({
            url: "../../controller/buscador.controller.php",
            type: "GET",
            data: { id: item },
            success: function (response) {
                let results = JSON.parse(response);    
                $("#resultados").html("");
                if (results.length > 0 && Array.isArray(results)) {
                    let list = $("<ul></ul>");
                    results.forEach(function (item) {
                        let listItem = $("<li></li>");
                        let link = $("<a></a>")
                            .attr("href", "view/tienda/detalle_producto.html?modo=exclusivo2&id=" + item.id)
                            .html("<strong>" + item.nombre + "</strong> - $" + item.precio + "<p>" + item.descripcion + "</p>");
    
                        listItem.append(link);
                        list.append(listItem);
                    });
                    $("#resultados").append(list);
                    $("#resultados").css("display", "block");
                } else {
                    $("#resultados").html("<p>No results found.</p>");
                }
            },
            error: function () {
                $("#resultados").html("<p>An error occurred while fetching the results.</p>");
            },
        });
    };
    

    $('input[name="query"]').on("keyup", debounce(fetchResults, 300));

    $(document).click(function () {
        $("#resultados").css("display", "none").empty();
    });
});
