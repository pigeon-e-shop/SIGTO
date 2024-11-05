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
                action: "getDataWithPagination",
                table: table,
                page: page,
                limit: limit
            },
            success: function (response) {
                var data = response;
                var rows = "";
                data.articles.forEach(function (item) {
                    var row = "<tr>";
                    for (var key in item) {
                        if (item.hasOwnProperty(key) && key !== "idArticulo") {
                            row += "<td>" + item[key] + "</td>";
                        }
                    }
                    row += '<td><button class="editBtn btn btn-sm" data-id="' + item.id + '">Editar</button> <button class="deleteBtn btn btn-sm" data-id="' + item.id + '">Eliminar</button></td></tr>';
                    rows += row;
                });
                // anade a la tabla los datos
                $("#dataTable tbody").html(rows);
                // muestra la paginacion.
                // Lógica para mostrar/ocultar la paginación
                if (data.totalPages > 1) {
                    $("#pagination").show(); // Muestra la paginación si hay más de una página
                    renderPagination(data.totalPages, page);
                } else {
                    $("#pagination").hide(); // Oculta la paginación si solo hay una página
                }
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud:", status, error);
            }
        });
    }

    function renderPagination(totalPages, currentPage) {
        $("#pagination").empty(); // Limpia el contenido anterior
        const paginationNav = $('<nav aria-label="Page navigation example"><ul class="pagination justify-content-center"></ul></nav>');

        // Botón "Anterior"
        const prevDisabled = currentPage === 1 ? 'disabled' : '';
        paginationNav.find('ul').append(`
            <li class="page-item ${prevDisabled}">
                <a class="page-link" href="#" aria-label="Previous" data-page="${currentPage - 1}">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
        `);

        // Botones de página
        for (let i = 1; i <= totalPages; i++) {
            const activeClass = i === currentPage ? 'active' : '';
            paginationNav.find('ul').append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            `);
        }

        // Botón "Siguiente"
        const nextDisabled = currentPage === totalPages ? 'disabled' : '';
        paginationNav.find('ul').append(`
            <li class="page-item ${nextDisabled}">
                <a class="page-link" href="#" aria-label="Next" data-page="${currentPage + 1}">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        `);

        // Añade la navegación de paginación al contenedor
        $("#pagination").append(paginationNav);
    }

    $("#pagination").on("click", ".page-link", function (event) {
        event.preventDefault(); // Previene el comportamiento por defecto del enlace
        const page = $(this).data('page'); // Obtiene el número de página
        const limit = $("#itemsPerPage").val(); // Obtiene el límite de artículos por página
        loadArticles(page, limit); // Carga los artículos de la página seleccionada
    });


    function loadTables() {
        $.ajax({
            url: "../../controller/crud.controller.php",
            type: "GET",
            data: { action: "getTables" },
            success: function (data) {
                data.forEach(function (table) {
                    $(".tableSelector").append('<option value="' + table + '">' + table + "</option>");
                });
            },
            error: function (xhr, status, error) {
                console.error("Error en la solicitud:", status, error);
            },
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
            $.ajax({
                url: "../../controller/crud.controller.php",
                type: "POST",
                data: {
                    action: "deleteData",
                    table: $("#tableSelector").val(),
                    id: id
                },
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
        $("#createFormSection").empty();
        if (table) {
            if (table == 'articulo') {

                let formHtml = `
            <form id="createForm" enctype="multipart/form-data">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>

            <div class="form-group">
                <label for="precio">Precio:</label>
                <input type="number" class="form-control" id="precio" name="precio" step="0.01" required>
            </div>

            <div class="form-group">
                <label for="categoria">Categoría:</label>
                <select class="form-control" id="categoria" name="categoria" required>
                    <option value="Teléfonos móviles">Teléfonos móviles</option>
                    <option value="Computadoras y Laptops">Computadoras y Laptops</option>
                    <option value="Televisores y Audio">Televisores y Audio</option>
                    <option value="Accesorios tecnológicos">Accesorios tecnológicos</option>
                    <option value="Ropa de Hombre">Ropa de Hombre</option>
                    <option value="Ropa de Mujer">Ropa de Mujer</option>
                    <option value="Zapatos y Accesorios">Zapatos y Accesorios</option>
                    <option value="Ropa para Niños">Ropa para Niños</option>
                    <option value="Muebles">Muebles</option>
                    <option value="Decoración">Decoración</option>
                    <option value="Herramientas y Mejoras para el Hogar">Herramientas y Mejoras para el Hogar</option>
                    <option value="Jardinería">Jardinería</option>
                    <option value="Productos para el Cuidado de la Piel">Productos para el Cuidado de la Piel</option>
                    <option value="Maquillaje">Maquillaje</option>
                    <option value="Productos para el Cuidado del Cabello">Productos para el Cuidado del Cabello</option>
                    <option value="Suplementos y Vitaminas">Suplementos y Vitaminas</option>
                    <option value="Equipamiento Deportivo">Equipamiento Deportivo</option>
                    <option value="Ropa Deportiva">Ropa Deportiva</option>
                    <option value="Bicicletas y Patinetes">Bicicletas y Patinetes</option>
                    <option value="Camping y Senderismo">Camping y Senderismo</option>
                    <option value="Juguetes para Niños">Juguetes para Niños</option>
                    <option value="Juegos de Mesa">Juegos de Mesa</option>
                    <option value="Videojuegos y Consolas">Videojuegos y Consolas</option>
                    <option value="Puzzles y Rompecabezas">Puzzles y Rompecabezas</option>
                    <option value="Accesorios para Automóviles">Accesorios para Automóviles</option>
                    <option value="Accesorios para Motocicletas">Accesorios para Motocicletas</option>
                    <option value="Herramientas y Equipos">Herramientas y Equipos</option>
                    <option value="Neumáticos y Llantas">Neumáticos y Llantas</option>
                    <option value="Comida Gourmet">Comida Gourmet</option>
                    <option value="Bebidas Alcohólicas">Bebidas Alcohólicas</option>
                    <option value="Alimentos Orgánicos">Alimentos Orgánicos</option>
                    <option value="Snacks y Dulces">Snacks y Dulces</option>
                    <option value="Ropa de Bebé">Ropa de Bebé</option>
                    <option value="Juguetes para Bebés">Juguetes para Bebés</option>
                    <option value="Productos para la Alimentación del Bebé">Productos para la Alimentación del Bebé</option>
                    <option value="Mobiliario Infantil">Mobiliario Infantil</option>
                    <option value="Libros Físicos y E-Books">Libros Físicos y E-Books</option>
                    <option value="Música y CDs">Música y CDs</option>
                    <option value="Instrumentos Musicales">Instrumentos Musicales</option>
                    <option value="Audiolibros y Podcasts">Audiolibros y Podcasts</option>
                </select>
            </div>

            <div class="form-group">
                <label for="descuento">Descuento:</label>
                <input type="number" class="form-control" id="descuento" name="descuento" required>
            </div>

            <div class="form-group">
                <label for="descripcion">Descripción:</label>
                <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
            </div>

            <div class="form-group row">
                <div class="col">
                <label for="rutaImagen" class="form-label">Nombre Imagen</label>
                <input type="file" id="rutaImagen" name="rutaImagen" class="form-control" accept="image/*">
                </div>
                <div class="col">
                <img id="preview" src="#" alt="Vista previa" style="display:none; margin-top:10px; max-width:200px;">
                </div>
            </div>


            <div class="form-group">
                <label for="stock">Stock:</label>
                <input type="number" class="form-control" id="stock" name="stock" required>
            </div>

            <div class="form-group">
                <label for="empresa">Empresa ID:</label>
                <input type="number" class="form-control" id="empresa" name="empresa" required>
            </div>

            <button type="submit" id="" class="btn btn-primary">Crear</button>
        </form>`;

                $("#createFormSection").html(formHtml);
            } else {
                $.ajax({
                    url: "../../controller/crud.controller.php",
                    type: "GET",
                    data: { action: "getColumnsWithTypes", table: table },
                    success: function (data) {
                        var formHtml = '<form id="createForm" >';
                        data.forEach(function (column) {
                            var fieldHtml = '<div class="mb-3">';
                            var columnName = column.field;
                            if (column.extra && column.extra.includes("auto_increment")) {
                                return;
                            }

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
                                default:
                                    fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                                    fieldHtml += '<input type="text" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                                    break;
                            }
                            fieldHtml += "</div>";
                            formHtml += fieldHtml;
                        });
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
            type: "GET",
            url: "../../controller/crud.controller.php",
            data: { action: "getColumns", table: table },
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

