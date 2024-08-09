    let contadorInicial = 2; 

    $('#formularioArticulos').on('submit', function(event) {
        event.preventDefault();
        const titulo = $('#titulo').val();
        const descripcion = $('#descripcion').val();
        const precio = Number($('#precio').val());
        const cantidad = Number($('#cantidad').val());

        if (titulo.length === 0 || descripcion.length === 0 || isNaN(precio) || isNaN(cantidad)) {
            alert('Por favor, complete todos los campos correctamente.');
            return;
        }
       
        const newRow = `
            <tr>
                <td>${contadorInicial++}</td>
                <td>${titulo}</td>
                <td>${descripcion}</td>
                <td>$${precio}</td>
                <td>${cantidad}</td>
                <td>
                    <button class="btn btn-primary btn-sm edit">Editar</button>
                    <button class="btn btn-danger btn-sm delete">Eliminar</button>
                </td>
            </tr>
        `;

        $('#tablaArticulos').append(newRow);
        $('#formularioArticulos')[0].reset();
    });

    $('#tablaArticulos').on('click', '.delete', function() {
        $(this).closest('tr').remove();
    });

    $('#tablaArticulos').on('click', '.edit', function() {
        const row = $(this).closest('tr');
        const cells = row.children('td');

        $('#titulo').val(cells.eq(1).text());
        $('#descripcion').val(cells.eq(2).text());
        $('#precio').val(Number(cells.eq(3).text().replace('$', ''))); 
        $('#cantidad').val(cells.eq(4).text());

        row.remove();
    });