$(document).ready(function () {
    // Cargar tablas
    $.ajax({
        type: "GET",
        url: "http://localhost/SIGTO/controller/crud.php",
        data: { action: 'getTables' },
        dataType: "json",
        success: function (response) {
            if (Array.isArray(response)) {
                let $tablas = $('#tablas');
                $tablas.empty();
                $tablas.append('<option value="">Selecciona una tabla</option>');
                $.each(response, function (index, table) {
                    $tablas.append(`<option value="${table}">${table}</option>`);
                });
            } else {
                console.error('Invalid response:', response);
            }
        },
        error: function (xhr, status, error) {
            console.error('AJAX Error:', status, error);
        }
    });

    // Cargar columnas al seleccionar una tabla
    $('#tablas').on('change', function () {
        let tablaSeleccionada = $(this).val();
        if (tablaSeleccionada) {
            $.ajax({
                type: "GET",
                url: "http://localhost/SIGTO/controller/crud.php",
                data: { action: 'getTableFields', table: tablaSeleccionada },
                dataType: "json",
                success: function (fields) {
                    if (fields) {
                        // Llamada para procesar los campos
                        processFields(fields);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX Error:', status, error);
                }
            });
        }
    });
    
    function processFields(fields) {
        let $form = $('#addDataForm');
        $form.empty(); // Limpiar el formulario
    
        $.each(fields, function (index, field) {
            if (!field.auto_increment) { // No incluir campos auto_increment
                if (field.data_type.startsWith('enum')) {
                    // Campo ENUM
                    let options = field.data_type.match(/\((.*?)\)/)[1].split(',').map(opt => opt.replace(/'/g, ''));
                    $form.append(`<div class="mb-3">
                        <label for="${field.name}" class="form-label">${field.name}</label>
                        <select id="${field.name}" name="${field.name}" class="form-select">
                            ${options.map(option => `<option value="${option}">${option}</option>`).join('')}
                        </select>
                    </div>`);
                } else {
                    // Campo de texto o número
                    $form.append(`<div class="mb-3">
                        <label for="${field.name}" class="form-label">${field.name}</label>
                        <input type="${field.data_type.includes('int') ? 'number' : 'text'}" id="${field.name}" name="${field.name}" class="form-control">
                    </div>`);
                }
            }
        });
    
        // Opcional: Llamada para cargar los nombres de las columnas
        loadColumnNames();
    }
    
    function loadColumnNames() {
        // Aquí puedes hacer otra llamada AJAX si necesitas cargar los nombres de las columnas por separado
        console.log('Column names and types processed.');
    }    

    // Cargar datos al seleccionar una columna
    $('#columnas').on('change', function () {
        let tablaSeleccionada = $('#tablas').val();
        let columnaSeleccionada = $(this).val();
        if (tablaSeleccionada && columnaSeleccionada) {
            $.ajax({
                type: "GET",
                url: "http://localhost/SIGTO/controller/crud.php",
                data: {
                    action: 'getData',
                    table: tablaSeleccionada,
                    column: columnaSeleccionada
                },
                dataType: "json",
                success: function (response) {
                    let $datos = $('#datos');
                    $datos.empty();
    
                    if (response && response.length > 0) {
                        let thead = '<thead><tr>';
                        $.each(response[0], function (key) {
                            thead += `<th>${key}</th>`;
                        });
                        thead += '</tr></thead>';
    
                        let tbody = '<tbody>';
                        $.each(response, function (index, row) {
                            tbody += '<tr>';
                            $.each(row, function (key, value) {
                                if (key === 'categoria') {
                                    tbody += `<td><select id="${key}" disabled></select></td>`;
                                } else {
                                    tbody += `<td><input id="${key}" value="${value}" readonly="readonly" title="${value}"></td>`;
                                }
                            });
                            tbody += `<td><button data-index="${index}" class="btn btn-danger btn-delete">Delete</button></td>`;
                            tbody += `<td><button data-index="${index}" class="btn btn-warning btn-edit">Edit</button></td>`;
                            tbody += '</tr>';
                        });
                        tbody += '</tbody>';
    
                        $datos.html(`<table>${thead}${tbody}</table>`);
    
                        // Cargar opciones de categoría
                        loadCategoryOptions();
                    } else {
                        $datos.html('<p>No hay datos disponibles.</p>');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX Error:', status, error);
                }
            });
        } else {
            $('#datos').empty();
        }
    });

    // Filtro de datos
    $("#inputFiltro").on("keyup", function () {
        let filter = $(this).val();
        let tablaSeleccionada = $('#tablas').val();
        let columnaSeleccionada = $('#columnas').val();
        $.ajax({
            type: "GET",
            url: "http://localhost/SIGTO/controller/crud.php",
            data: {
                action: 'getDataFilter',
                table: tablaSeleccionada,
                column: columnaSeleccionada,
                filter: filter
            },
            dataType: "json",
            success: function (response) {
                let $datos = $('#datos');
                $datos.empty();

                if (response && response.length > 0) {
                    let thead = '<thead><tr>';
                    $.each(response[0], function (key) {
                        thead += `<th>${key}</th>`;
                    });
                    thead += '</tr></thead>';

                    let tbody = '<tbody>';
                    $.each(response, function (index, row) {
                        tbody += '<tr>';
                        $.each(row, function (key, value) {
                            if (key === 'categoria') {
                                tbody += `<td><select id="${key}" disabled></select></td>`;
                            } else {
                                tbody += `<td><input id="${key}" value="${value}" readonly="readonly" title="${value}"></td>`;
                            }
                        });
                        tbody += `<td><button data-index="${index}" class="btn btn-danger btn-delete">Delete</button></td>`;
                        tbody += `<td><button data-index="${index}" class="btn btn-warning btn-edit">Edit</button></td>`;
                        tbody += '</tr>';
                    });
                    tbody += '</tbody>';

                    $datos.html(`<table>${thead}${tbody}</table>`);

                    // Cargar opciones de categoría
                    $.ajax({
                        type: "GET",
                        url: "http://localhost/SIGTO/controller/crud.php",
                        data: {
                            action: 'getEnumValues',
                            table: $('#tablas').val(),
                            column: 'categoria'
                        },
                        dataType: "json",
                        success: function (options) {
                            if (Array.isArray(options)) {
                                $('#datos select').each(function () {
                                    let $select = $(this);
                                    $select.empty();
                                    $.each(options, function (index, option) {
                                        $select.append(`<option value="${option}">${option}</option>`);
                                    });

                                    // Establecer la opción seleccionada para cada select
                                    let selectedValue = $select.closest('tr').find('input').val();
                                    $select.val(selectedValue); // Seleccionar la opción correspondiente
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('AJAX Error:', status, error);
                        }
                    });
                } else {
                    $datos.html('<p>No hay datos disponibles.</p>');
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX Error:', status, error);
            }
        });
    });

    // Editar fila
    $(document).on('click', '.btn-edit', function () {
        let row = $(this).closest('tr');
        row.find('input').prop('readonly', false);
        row.find('select').prop('disabled', false);
        $(this).replaceWith('<button class="btn btn-success btn-save">Save</button>');
        row.find('.btn-delete').replaceWith('<button class="btn btn-warning btn-cancel">Cancel</button>');
    });

    // Guardar cambios
    $(document).on('click', '.btn-save', function () {
        let row = $(this).closest('tr');
        row.find('input').prop('readonly', true);
        row.find('select').prop('disabled', true);
        $(this).replaceWith('<button class="btn btn-warning btn-edit">Edit</button>');
        row.find('.btn-cancel').replaceWith('<button class="btn btn-danger btn-delete">Delete</button>');
        btnSave(row);
    });

    // Cancelar edición
    $(document).on('click', '.btn-cancel', function () {
        let row = $(this).closest('tr');
        row.find('input').prop('readonly', true);
        row.find('select').prop('disabled', true);
        $(this).replaceWith('<button class="btn btn-danger btn-delete">Delete</button>');
        row.find('.btn-save').replaceWith('<button class="btn btn-warning btn-edit">Edit</button>');
    });
});

// Función para guardar los cambios
function btnSave(row) {
    // Recopila los datos del input editado
    let updatedData = {};
    row.find('input').each(function () {
        let key = $(this).attr('id'); // Suponiendo que el id del input es el nombre de la columna
        let value = $(this).val();
        updatedData[key] = value;
    });
    row.find('select').each(function () {
        let key = $(this).attr('id'); // Suponiendo que el id del select es el nombre de la columna
        let value = $(this).val();
        updatedData[key] = value;
    });

    // Aquí deberías enviar los datos actualizados al servidor para guardar los cambios
    $.ajax({
        type: "GET",
        url: "http://localhost/SIGTO/controller/crud.php",
        data: {
            action: 'updateDataArticulos',
            table: $('#tablas').val(),
            column: $('#columnas').val(),
            data: updatedData
        },
        success: function (response) {
            if (response.success) {
                alert('Datos actualizados correctamente.');
            } else {
                alert('Error al actualizar los datos.');
            }
        },
        error: function (xhr, status, error) {
            console.error('AJAX Error:', status, error);
        }
    });
}

function loadCategoryOptions() {
    let tablaSeleccionada = $('#tablas').val();
    $.ajax({
        type: "GET",
        url: "http://localhost/SIGTO/controller/crud.php",
        data: {
            action: 'getEnumValues',
            table: tablaSeleccionada,
            column: 'categoria'
        },
        dataType: "json",
        success: function (options) {
            if (Array.isArray(options)) {
                $('#datos select').each(function () {
                    let $select = $(this);
                    $select.empty();
                    $.each(options, function (index, option) {
                        $select.append(`<option value="${option}">${option}</option>`);
                    });

                    // Establecer la opción seleccionada para cada select
                    let selectedValue = $select.closest('tr').find('input[id="categoria"]').val();
                    $select.val(selectedValue); // Seleccionar la opción correspondiente
                });
            }
        },
        error: function (xhr, status, error) {
            console.error('AJAX Error:', status, error);
        }
    });
}

// Mostrar modal para agregar datos
$(document).ready(function () {
    $('#agregacion button').on('click', function () {
        let tablaSeleccionada = $('#tablas').val();
        if (tablaSeleccionada) {
            // Limpiar el formulario del modal
            $('#addDataForm').empty();
            
            // Obtener los campos de la tabla
            $.ajax({
                type: "GET",
                url: "http://localhost/SIGTO/controller/crud.php",
                data: {
                    action: 'getTableFields',
                    table: tablaSeleccionada
                },
                dataType: "json",
                success: function (response) {
                    if (response && Array.isArray(response.fields)) {
                        // Agregar los campos al formulario del modal
                        $.each(response.fields, function (index, field) {
                            if (field.auto_increment) return; // Ignorar campos autoincrementales
                            
                            let inputType = field.data_type === 'enum' ? 'select' : 'input';
                            let inputHtml;
                            
                            if (inputType === 'input') {
                                inputHtml = `<div class="mb-3">
                                                <label for="${field.name}" class="form-label">${field.name}</label>
                                                <input type="text" class="form-control" id="${field.name}" name="${field.name}">
                                            </div>`;
                            } else if (inputType === 'select') {
                                inputHtml = `<div class="mb-3">
                                                <label for="${field.name}" class="form-label">${field.name}</label>
                                                <select class="form-select" id="${field.name}" name="${field.name}"></select>
                                            </div>`;
                                
                                // Obtener opciones para el campo de tipo enum
                                $.ajax({
                                    type: "GET",
                                    url: "http://localhost/SIGTO/controller/crud.php",
                                    data: {
                                        action: 'getEnumValues',
                                        table: tablaSeleccionada,
                                        column: field.name
                                    },
                                    dataType: "json",
                                    success: function (options) {
                                        if (Array.isArray(options)) {
                                            let $select = $(`#${field.name}`);
                                            $.each(options, function (index, option) {
                                                $select.append(`<option value="${option}">${option}</option>`);
                                            });
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.error('AJAX Error:', status, error);
                                    }
                                });
                            }
                            
                            $('#addDataForm').append(inputHtml);
                        });
                        
                        // Mostrar el modal
                        $('#addDataModal').modal('show');
                    } else {
                        console.error('Invalid response:', response);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX Error:', status, error);
                }
            });
        } else {
            alert('Selecciona una tabla primero.');
        }
    });

    // Guardar los datos del formulario
    $('#addDataForm').on('submit', function (event) {
    event.preventDefault();
    let tablaSeleccionada = $('#tablas').val();
    
    // Recopilar datos del formulario
    let formData = $(this).serialize();
    $.ajax({
        type: "POST",
        url: "http://localhost/SIGTO/controller/crud.php",
        data: {
            action: 'insertData',
            table: tablaSeleccionada,
            data: formData
        },
        success: function (response) {
            if (response.success) {
                alert('Datos agregados correctamente.');
                $('#addDataModal').modal('hide');
                $('#tablas').trigger('change'); // Recargar los datos para mostrar los cambios
            } else {
                alert('Error al agregar los datos.');
            }
        },
        error: function (xhr, status, error) {
            console.error('AJAX Error:', status, error);
        }
    });
});
});
