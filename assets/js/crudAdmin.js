$(document).ready(function () {
    loadTables();
    articulosXPaginaDefault()
    $("#pagination").hide();

    function loadArticles(page = 1, limit = 5) {
        var table = $("#tableSelector").val();
        if (!table) return;

        $.ajax({
            url: "../../controller/crud.controller.php",
            type: "POST",
            data: {
                action: 'readData',
                readAction: "getDataWithPagination",
                table: table,
                page: page,
                limit: limit
            },
            success: function (response) {
                var data = response;
                var rows = "";
                data.forEach(function (item) {
                    var row = "<tr>";
                    for (var key in item) {
                        if (item.hasOwnProperty(key)) {
                            row += "<td>" + item[key] + "</td>";
                        }
                    }
                    row += '<td><button class="editBtn btn btn-sm" data-id="' + item.id + '">Editar</button> <button class="deleteBtn btn btn-sm" data-id="' + item.id + '">Eliminar</button></td></tr>';
                    rows += row;
                });
                $("#dataTable tbody").html(rows);
                if (data.totalPages > 1) {
                    $("#pagination").show();
                    renderPagination(data.totalPages, page);
                } else {
                    $("#pagination").hide();
                }
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud:", status, error);
            }
        });
    }

    function renderPagination(totalPages, currentPage) {
        $("#pagination").empty();
        const paginationNav = $('<nav aria-label="Page navigation example"><ul class="pagination justify-content-center"></ul></nav>');
        
        const prevDisabled = currentPage === 1 ? 'disabled' : '';
        paginationNav.find('ul').append(`
            <li class="page-item ${prevDisabled}">
                <a class="page-link" href="#" aria-label="Previous" data-page="${currentPage - 1}">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
        `);

        for (let i = 1; i <= totalPages; i++) {
            const activeClass = i === currentPage ? 'active' : '';
            paginationNav.find('ul').append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            `);
        }

        const nextDisabled = currentPage === totalPages ? 'disabled' : '';
        paginationNav.find('ul').append(`
            <li class="page-item ${nextDisabled}">
                <a class="page-link" href="#" aria-label="Next" data-page="${currentPage + 1}">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        `);

        $("#pagination").append(paginationNav);
    }

    $("#pagination").on("click", ".page-link", function (event) {
        event.preventDefault();
        const page = $(this).data('page');
        const limit = $("#itemsPerPage").val();
        loadArticles(page, limit);
    });

    function loadTables() {
        $.ajax({
            url: "../../controller/crud.controller.php",
            type: "POST",
            data: { 
                action: "readData",
                readAction: 'readTables'
            },
            dataType: "json",
            success: function(response) {
                if (response && Array.isArray(response)) {
                    $(".tableSelector").empty().append('<option value="">Selecciona una tabla</option>');
                    response.forEach(function(table) {
                        $(".tableSelector").append(`<option value="${table}">${table}</option>`);
                    });
                } else {
                    console.error("Formato de respuesta inesperado:", response);
                    alert("Error: La respuesta del servidor no es válida.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error en la solicitud AJAX:", status, error);
                alert("No se pudieron cargar las tablas. Por favor, intente nuevamente.");
            }
        });
    }
    
    $("#tableSelector").change(function () {
        var table = $(this).val();
        $("#columnSelector").empty().append('<option value="">Selecciona una columna</option>');
        $("#filterInput").val("");
        if (table) {
            loadArticles();
            getColumnas(table, function (keys) {
                agregarColumnas(keys);
            });
        }
    });

    $("#filterInput").change(function () {
        loadArticles();
    });

    $("#pagination").on("click", ".page-btn", function () {
        const page = $(this).data('page');
        const limit = $("#itemsPerPage").val();
        loadArticles(page, limit);
    });

    $("#itemsPerPage").change(function () {
        const limit = $(this).val();
        loadArticles(1, limit);
    });

    $("#dataTable").on("click", ".editBtn", function () {
        var id = $(this).data("id");
        var row = $(this).closest("tr");
        var table = $("#tableSelector").val();

        getColumnas(table, function (keys) {
            row.find("td").not(":last-child").each(function (index) {
                var text = $(this).text();
                $(this).html('<input type="text" name="' + keys[index] + '" value="' + text + '">');
            });

            $(this).replaceWith('<button class="updateBtn btn btn-sm" data-id="' + id + '">Actualizar</button>');
            row.find(".deleteBtn").replaceWith('<button class="cancelBtn btn btn-sm" data-id="' + id + '">Cancelar</button>');
        }.bind(this));
    });

    $("#dataTable").on("click", ".updateBtn", function () {
        var $form = wrapTrInForm(this);
        var formData = $form.serialize();
        var formData2 = reverseSerialize(formData);
        $.ajax({
            url: "../../controller/crud.controller.php",
            type: "POST",
            data: {
                action: "updateData",
                table: $("#tableSelector").val(),
                data: formData,
                id: formData2.id,
            },
            success: function (response) {
                alert("Datos actualizados");
                $("#tableSelector").trigger("change");
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud:", status, error);
            },
        });
    });

    $("#dataTable").on("click", ".cancelBtn", function () {
        $("#tableSelector").trigger("change");
    });

    $("#dataTable").on("click", ".deleteBtn", function () {
        if (confirm("¿Seguro que quiere borrar esta fila?")) {
            var id = $(this).data("id");
            var table = $("#tableSelector").val();  // Obtener la tabla seleccionada
   
            console.log("ID:", id, "Tabla:", table); // Agregar esto para verificar los valores
   
            $.ajax({
                url: "../../controller/crud.controller.php",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    action: 'deleteData',
                    table: table,
                    id: id
                }),
                success: function (response) {
                    alert("Datos eliminados");
                    $("#tableSelector").trigger("change");
                },
                error: function (xhr, status, error) {
                    console.error("Error en la solicitud:", status, error);
                },
            });
        }
    });
   
    $("#tableSelector2").change(function () {
        var table = $(this).val();
        $("#createFormSection").empty(); // Limpiar el formulario previo
    
        if (table) {
            if (table == 'articulo') {
                let formHtml = `
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" id="nombre" name="nombre" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="precio" class="form-label">Precio</label>
                        <input type="number" id="precio" name="precio" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea id="descripcion" name="descripcion" class="form-control"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="categoria" class="form-label">Categoría</label>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" id="stock" name="stock" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Crear</button>
                `;
                $("#createFormSection").html(formHtml);
            } else {
                $.ajax({
                    url: "../../controller/crud.controller.php",
                    type: "POST",
                    data: { action: "getColumnsWithTypes", table: table },
                    success: function (data) {
                        var formHtml = '<form id="createForm">';
                        data.forEach(function (column) {
                            var fieldHtml = '<div class="mb-3">';
                            var columnName = column.field;
    
                            // Evitar campos auto_increment
                            if (column.extra && column.extra.includes("auto_increment")) {
                                return;
                            }
    
                            // Manejo de diferentes tipos de columna
                            switch (true) {
                                case column.type.startsWith("enum"):
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<select id="' + columnName + '" name="' + columnName + '" class="form-select">';
                                    if (column.enum_values && column.enum_values.length > 0) {
                                        column.enum_values.forEach(function (value) {
                                            fieldHtml += '<option value="' + value + '">' + value + "</option>";
                                        });
                                    }
                                    fieldHtml += "</select>";
                                    break;
    
                                case column.type.startsWith("int"):
                                case column.type.startsWith("float"):
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<input type="number" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                                    break;
    
                                case column.type.startsWith("varchar"):
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<input type="text" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                                    break;
    
                                case column.type.startsWith("date"):
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<input type="date" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                                    break;
    
                                case column.type.startsWith("timestamp"):
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<input type="datetime-local" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                                    break;
    
                                case column.type.startsWith("text"):
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<textarea id="' + columnName + '" name="' + columnName + '" class="form-control"></textarea>';
                                    break;
    
                                default:
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<input type="text" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                                    break;
                            }
    
                            fieldHtml += "</div>";
                            formHtml += fieldHtml;
                        });
    
                        // Agregar el botón de creación
                        formHtml += '<button type="submit" class="btn btn-primary">Crear</button></form>';
                        $("#createFormSection").html(formHtml);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error en la solicitud:", status, error);
                    },
                });
            }
        }
    });
    
    

    $("#createFormSection").on("submit", "#createForm", function (e) {
        e.preventDefault();
        var formData = {
            nombre: $('#nombre').val(),
            precio: $('#precio').val(),
            descripcion: $('#descripcion').val(),
            categoria: $('#categoria').val().replace('+', ' '),
            descuento: $('#descuento').val(),
            empresa: $('#empresa').val(),
            stock: $('#stock').val()
        };

        $.ajax({
            url: "../../controller/crud.controller.php",
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({
                action: 'createData',
                table: 'articulo',
                data: formData
            }),
            success: function (response) {
                alert("Registro creado");
                $("#tableSelector2").trigger("change");
                $("#tableSelector").trigger("change");
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud:", xhr, status, error);
            },
        });
    });

    function agregarColumnas(nombresColumnas) {
        $('#table-head').empty();
        $('#columnSelector').empty().append('<option value="">Selecciona una columna</option>');
        let fila = $('<tr></tr>');
        $.each(nombresColumnas, function (index, nombre) {
            let th = $('<th></th>').text(nombre);
            fila.append(th);
            $('#columnSelector').append('<option value="' + nombre + '">' + nombre + '</option>');
        });

        $('#table-head').append(fila);
    }

    function wrapTrInForm(button) {
        var $tr = $(button).closest("tr");
        var $clonedTr = $tr.clone();
        var $form = $("<form></form>").append($clonedTr);
        $tr.replaceWith($form);
        return $form;
    }

    function getColumnas(table, callback) {
        $.ajax({
            type: "POST",
            url: "../../controller/crud.controller.php",
            data: { 
                action: "readData",
                readAction: 'readColumns',
                table: table 
            },
            success: function (response) {
                callback(response);
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud:", xhr, status, error);
            },
        });
    }

    function reverseSerialize(serializedStr) {
        const dataObj = {};
        const pairs = serializedStr.split("&");

        pairs.forEach((pair) => {
            const [key, value] = pair.split("=");
            dataObj[decodeURIComponent(key)] = decodeURIComponent(value || "");
        });

        return dataObj;
    }

    function articulosXPaginaDefault() {
        $("#itemsPerPage").val("5");
    }

    $('#rutaImagen').on('change', function () {
        var file = $(this)[0].files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(file);
        }
    });
});
