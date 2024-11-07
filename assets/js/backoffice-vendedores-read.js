$(document).ready(function () {

    async function readVendedores() {
        $("#tableBody").empty("")
        $.ajax({
            type: "POST",
            url: "/controller/backoffice.controller.php",
            data: {
                mode: 'getVendedores'
            },
            dataType: "JSON",
            success: function (response) {
                response.forEach(element => {
                    let content =
                        `
                    <tr>
                        <td>${element.id}</td>
                        <td>${element.nombre}</td>
                        <td>${element.apellido}</td>
                        <td>${element.email}</td>
                        <td>${element.telefono}</td>
                        <td>
                            <button class="btn btn-link eliminar" type="button" data-bs-custom-class="custom-popover" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-title="Eliminar"><i class="bi bi-ban"></i></button>
                        </td>
                    </tr>
                    `
                    $("#tableBody").append(content);
                    $('[data-bs-toggle="popover"]').popover();
    
                });
            }
        });
    }
    $(document).on("click", '.eliminar', function (e) {
        e.preventDefault();
        const idVendedor = $(this).closest('tr').find('td:first').text();
        const nombre = $(this).closest('tr').find('td').eq(1).text();
        if (confirm("Eliminar a " +  nombre + "?")) {
            $.ajax({
                type: "POST",
                url: "/controller/backoffice.controller.php",
                data: {
                    mode: 'banVendedor',
                    idVendedor: idVendedor
                },
                dataType: "JSON",
                success: function (response) {
                    readVendedores();
                },
                beforeSend: function () {
                    if (!confirm("Seguro?")) {
                        return false;
                    }
                }
            });
        }
    });
    $(document).on('click',"#agregarVendedor", function (e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/controller/backoffice.controller.php",   
            data: {
                mode: 'agregarVendedor',
                email: $("#emailModal").val()
            },
            dataType: "JSON",
            success: function (response) {
                if (response.status == "error") {
                    console.log(response);
                }
            }
        });
    });

    readVendedores();
});