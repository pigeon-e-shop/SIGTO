$(document).ready(function () {
    $("#resultados").css("display", "none");
    $("#resultados").empty();
    $('input[name="buscador"]').on("keyup", function () {
        $("#resultados").css("display", "block");
        let item = $(this).val();
        if (item == "" || item == " ") {
            $("#resultados").css("display", "none");
            $("#resultados").empty();
            return;
        }
        $.ajax({
            url: "http://localhost/SIGTO/model/connection.php?modo=exclusivo&tabla=articulo",
            type: "GET",
            data: { id: item },
            success: function (response) {
                // Parse the JSON response
                let results = response;

                // Clear previous results
                $("#resultados").html("");

                // Check if there are results
                if (results.length > 0) {
                    // Create a list for the results
                    let list = $("<ul></ul>");
                    results.forEach(function (item) {
                        // Create a list item for each result
                        let listItem = $("<li></li>");

                        // Create a link that wraps around all content
                        let link = $("<a></a>")
                            .attr("href", "view/tienda/detalle_producto.html?modo=exclusivo2&id=" + item.idArticulo) // Adjust the URL as needed
                            .html("<strong>" + item.nombre + "</strong> - $" + item.precio + "<p>" + item.descripcion + "</p>");

                        // Append the link to the list item
                        listItem.append(link);

                        // Append the list item to the list
                        list.append(listItem);
                    });
                    // Append the list to the #resultados div
                    $("#resultados").append(list);
                } else {
                    // Handle case with no results
                    $("#resultados").html("<p>No results found.</p>");
                }
            },
            error: function () {
                // Handle AJAX errors
                $("#resultados").html("<p>An error occurred while fetching the results.</p>");
            },
        });
    });
    $(document).click(function () {
        $("#resultados").css("display", "none");
        $("#resultados").empty();
    });
});