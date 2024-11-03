let articulos = [];

$(document).ready(function () {
    const url = `/controller/index.controller.php`;
    const urlParams = new URLSearchParams(window.location.search);
    const filter = urlParams.get("filtro");

    $.ajax({
        type: "GET",
        url: url,
        data: { mode: 'readDetalleLista' },
        dataType: "JSON",
        success: function (response) {
            if (Array.isArray(response)) {
                articulos = response;
                $("#articulosMain").html(generarContenidoArticulos(articulos));
                if (filter && categoriaMap[filter]) {
                    $("#filtroCategoria").val(categoriaMap[filter]).change();
                }
            } else {
                console.error("La respuesta no es un array:", response);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("Error al cargar los artículos:", textStatus, errorThrown);
        }
    });

    $('#filtroCategoria').on('change', function () {
        let selectedValue = $(this).val();
        if (selectedValue !== 'default') {
            let filteredArticulos = articulos.filter(element => element.categoria === selectedValue);
            $("#articulosMain").html(generarContenidoArticulos(filteredArticulos));
        } else {
            $("#articulosMain").html(generarContenidoArticulos(articulos));
        }
    });

    function generarContenidoArticulos(articulos) {
        let content = '';

        articulos.forEach(element => {
            const precio = element.precio;
            const descuento = element.descuento;
            let precioFinal;

            if (!isNaN(precio) && !isNaN(descuento)) {
                if (descuento !== 0) {
                    precioFinal = (precio * (1 - descuento / 100)).toFixed(2);
                    content += `
                        <a class="articuloLista" href="detalle_producto.html?id=${element.id}&modo=exclusivo2">
                            <div class="row">
                                <div class="col-3">
                                    <img src="${element.rutaImagen}" alt="${element.nombre}" height="120px">
                                </div>
                                <div class="col">
                                    <h2><strong>${element.nombre}</strong></h2>
                                    <h4>${element.descripcion}</h4>
                                    <h5 style="text-decoration: line-through solid blue 1.5px">${parseFloat(precio).toLocaleString('es-ES', { style: 'currency', currency: 'USD' })}</h5>
                                    <h4>${parseFloat(precioFinal).toLocaleString('es-ES', { style: 'currency', currency: 'USD' })}</h4>
                                </div>
                                <div class="stars-title col" style="--calificacion: ${element.calificacion}">
                                </div>
                            </div>
                        </a>
                        <hr>
                    `;
                } else {
                    content += `
                        <a class="articuloLista" href="detalle_producto.html?id=${element.id}&modo=exclusivo2">
                            <div class="row">
                                <div class="col-3">
                                    <img src="${element.rutaImagen}" alt="${element.nombre}" height="120px">
                                </div>
                                <div class="col">
                                    <h2><strong>${element.nombre}</strong></h2>
                                    <h4>${element.descripcion}</h4>
                                    <h4>${parseFloat(precio).toLocaleString('es-ES', { style: 'currency', currency: 'USD' })}</h4>
                                </div>
                                <div class="stars-title col" style="--calificacion: ${element.calificacion}">
                                </div>
                            </div>
                        </a>
                        <hr>
                    `;
                }
            } else {
                console.error("Valores inválidos:", { precio, descuento });
            }
        });

        return content;
    }

    let categorias = [
        'Teléfonos móviles', 'Computadoras y Laptops', 'Televisores y Audio',
        'Accesorios tecnológicos', 'Ropa de Hombre', 'Ropa de Mujer',
        'Zapatos y Accesorios', 'Ropa para Niños', 'Muebles', 'Decoración',
        'Herramientas y Mejoras para el Hogar', 'Jardinería',
        'Productos para el Cuidado de la Piel', 'Maquillaje',
        'Productos para el Cuidado del Cabello', 'Suplementos y Vitaminas',
        'Equipamiento Deportivo', 'Ropa Deportiva', 'Bicicletas y Patinetes',
        'Camping y Senderismo', 'Juguetes para Niños', 'Juegos de Mesa',
        'Videojuegos y Consolas', 'Puzzles y Rompecabezas',
        'Accesorios para Automóviles', 'Accesorios para Motocicletas',
        'Herramientas y Equipos', 'Neumáticos y Llantas', 'Comida Gourmet',
        'Bebidas Alcohólicas', 'Alimentos Orgánicos', 'Snacks y Dulces',
        'Ropa de Bebé', 'Juguetes para Bebés',
        'Productos para la Alimentación del Bebé', 'Mobiliario Infantil',
        'Libros Físicos y E-Books', 'Música y CDs', 'Instrumentos Musicales',
        'Audiolibros y Podcasts'
    ];

    let categorias2 = [
        'Teléfonos_móviles', 'Computadoras_y_Laptops', 'Televisores_y_Audio',
        'Accesorios_tecnológicos', 'Ropa_de_Hombre', 'Ropa_de_Mujer',
        'Zapatos_y_Accesorios', 'Ropa_para_Niños', 'Muebles', 'Decoración',
        'Herramientas_y_Mejora_para_el_Hogar', 'Jardinería',
        'Productos_para_el_Cuidado_de_la_Piel', 'Maquillaje',
        'Productos_para_el_Cuidado_del_Cabello', 'Suplementos_y_Vitaminas',
        'Equipamiento_Deportivo', 'Ropa_Deportiva', 'Bicicletas_y_Patinetes',
        'Camping_y_Senderismo', 'Juguetes_para_Niños', 'Juegos_de_Mesa',
        'Videojuegos_y_Consolas', 'Puzzles_y_Rompecabezas',
        'Accesorios_para_Automóviles', 'Accesorios_para_Motocicletas',
        'Herramientas_y_Equipos', 'Neumáticos_y_Llantas', 'Comida_Gourmet',
        'Bebidas_Alcohólicas', 'Alimentos_Orgánicos', 'Snacks_y_Dulces',
        'Ropa_de_Bebé', 'Juguetes_para_Bebés',
        'Productos_para_la_Alimentación_del_Bebé', 'Mobiliario_Infantil',
        'Libros_Físicos_y_E-Books', 'Música_y_CDs', 'Instrumentos_Musicales',
        'Audiolibros_y_Podcasts'
    ];


    function agregarCategorias() {
        let select = $('#filtroCategoria');

        categorias.forEach((categoria, i) => {
            select.append(`<option value="${categoria}">${categoria}</option>`);
        });
    }

    agregarCategorias();

    $('#filtrosSelect').change(function () {
        let selectedValue = $(this).val();

        let filteredArticulos = [...articulos];

        switch (selectedValue) {
            case 'precioMayor':
                filteredArticulos.sort((a, b) => b.precio - a.precio);
                break;
            case 'precioMenor':
                filteredArticulos.sort((a, b) => a.precio - b.precio);
                break;
            case 'descuentoMayor':
                filteredArticulos.sort((a, b) => b.descuento - a.descuento);
                break;
            case 'descuentoMenor':
                filteredArticulos.sort((a, b) => a.descuento - b.descuento);
                break;
            default:
                break;
        }

        $("#articulosMain").html(generarContenidoArticulos(filteredArticulos));
    });

    let keyupTimer;
    $('#filtroNombre').keyup(function (e) {
        keyupTimer = setTimeout(function () {
            $.ajax({
                type: "POST",
                url: "/controller/index.controller.php",
                data: {
                    mode: 'filtrarListaNombre',
                    content: $('#filtroNombre').val()
                },
                success: function (response) {
                    articulos = response;
                    $("#articulosMain").html(generarContenidoArticulos(articulos));
                    $('#filtrosSelect').val('default');
                    $('#filtroCategoria').val('default');
                }
            });
        }, 450);
    });

    let categoriaMap = {};
    categorias.forEach((cat, index) => {
        categoriaMap[categorias2[index]] = cat;
    });

    if (filter) {
        if (categoriaMap[filter]) {
            $("#filtroCategoria").val(categoriaMap[filter]).change();
        }
    }



});
