    let articleCount = 2; 

    $('#articleForm').on('submit', function(event) {
        event.preventDefault();

        const titulo = $('#titulo').val().trim();
        const descripcion = $('#descripcion').val().trim();
        const precio = parseFloat($('#precio').val().trim());
        const cantidad = parseInt($('#cantidad').val().trim());

        if (titulo.length === 0 || descripcion.length === 0 || isNaN(precio) || isNaN(cantidad)) {
            alert('Por favor, complete todos los campos correctamente.');
            return;
        }

        const newRow = `
            <tr>
                <td>${articleCount++}</td>
                <td>${titulo}</td>
                <td>${descripcion}</td>
                <td>$${precio.toFixed(2)}</td>
                <td>${cantidad}</td>
                <td>
                    <button class="btn btn-primary btn-sm edit">Editar</button>
                    <button class="btn btn-danger btn-sm delete">Eliminar</button>
                </td>
            </tr>
        `;

        $('#articleTableBody').append(newRow);
        $('#articleForm')[0].reset();
    });

    $('#articleTableBody').on('click', '.delete', function() {
        $(this).closest('tr').remove();
    });

    $('#articleTableBody').on('click', '.edit', function() {
        const row = $(this).closest('tr');
        const cells = row.children('td');

        $('#titulo').val(cells.eq(1).text());
        $('#descripcion').val(cells.eq(2).text());
        $('#precio').val(parseFloat(cells.eq(3).text().replace('$', ''))); 
        $('#cantidad').val(cells.eq(4).text());

        row.remove();
    });