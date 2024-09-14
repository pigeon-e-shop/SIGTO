$(document).ready(function () {
    class Articulo {
        constructor(id, nombre, precio, descripcion, rutaImagen) {
            this.id = id;
            this.nombre = nombre;
            this.precio = precio;
            this.descripcion = descripcion;
            this.rutaImagen = rutaImagen;
        }
    }

    class Articulos {
        constructor() {
            this.articulos = [];
            this.cantArticulos = Number(localStorage.getItem('cantArticulos')) || 0;

            // Renderizamos los artículos en el carrito
            this.renderizarArticulos();

            $(".clear-cart").click(() => this.eliminarTodosLosArticulos());
            this.mostrarArticulosEnIndex(); // Asegúrate de llamar a esta función después de la inicialización
        }

        // Función para cargar artículos
        async cargarArticulos() {
            try {
                const response = await retornarDatos();
                return response; // Retorna directamente los datos
            } catch (error) {
                console.error("Error al cargar artículos:", error);
                return []; // Devuelve un array vacío en caso de error
            }
        }

        async mostrarArticulosEnIndex() {
            const $carouselInner = $("#articulosCarrusel .carousel-inner");
            $carouselInner.html(""); // Vaciar contenido existente

            try {
                const articulos = await this.cargarArticulos(); // Espera la resolución de la promesa

                console.log("Artículos cargados:", articulos);

                // Verifica que articulos sea un array antes de iterar
                if (Array.isArray(articulos) && articulos.length > 0) {
                    let slideHTML = "";
                    let isActive = true;

                    articulos.forEach((articulo, index) => {
                        if (index % 3 === 0) { // Empieza una nueva slide cada 3 artículos
                            if (slideHTML) {
                                $carouselInner.append(`<div class="carousel-item ${isActive ? 'active' : ''}">
                                    <div class="row">
                                        ${slideHTML}
                                    </div>
                                </div>`);
                                slideHTML = "";
                                isActive = false;
                            }
                        }

                        // Añade el artículo a la slide actual
                        slideHTML += `
                        <div class="col-md-4">
                        <div class="card">
                        <a href="http://localhost/view/tienda/detalle_producto.html?id=${articulo.idArticulo}&modo=exclusivo2"
                        <img src="${articulo.rutaImagen}" width="300" height="400" class="card-img-top" alt="${articulo.nombre}" />
                        <div class="card-body">
                                        <h5 class="card-title">${articulo.nombre}</h5>
                                        <p class="card-text">${articulo.descripcion}</p>
                                        <p class="card-text">USD $${articulo.precio}</p>
                                        <a class="btn btn-primary agregarArt" id="agregarArtIndex">Agregar carrito</a>
                                    </div>
                                    </a>
                                </div>
                            </div>
                        `;
                    });

                    // Añadir la última slide
                    if (slideHTML) {
                        $carouselInner.append(`<div class="carousel-item">
                            <div class="row">
                                ${slideHTML}
                            </div>
                        </div>`);
                    }

                } else {
                    console.warn("No se encontraron artículos.");
                    $("#articulosCarrusel").html("<p>No se encontraron artículos.</p>");
                }
            } catch (error) {
                console.error("Error al obtener los datos:", error);
                $("#articulosCarrusel").html("<p>Hubo un error al cargar los artículos.</p>");
            }
        }



        agregarArt(articulo) {
            this.articulos.push(articulo);
            this.cantArticulos = this.articulos.length;
            localStorage.setItem('articulos', JSON.stringify(this.articulos));
            localStorage.setItem('cantArticulos', this.cantArticulos);
            $("#cantArticulos").html(this.cantArticulos);
            this.renderizarArticulos();
        }

        eliminarTodosLosArticulos() {
            this.articulos = [];
            this.cantArticulos = 0;
            localStorage.setItem('articulos', JSON.stringify(this.articulos));
            localStorage.setItem('cantArticulos', this.cantArticulos);
            $("#cantArticulos").html(this.cantArticulos);
            this.renderizarArticulos();
        }

        renderizarArticulos() {
            const cartItemsList = $("#cartItemsList");
            const cartTotal = $("#cartTotal");
            let total = 0;
            cartItemsList.empty();

            this.articulos.forEach((articulo, index) => {
                const item = `
                    <li>
                        <img src="${articulo.rutaImagen}" width="100" height="100" class="articuloImagen">
                        <span class="articuloTexto">${articulo.nombre} - $${articulo.precio}</span>
                        <button class="btn-remove" onclick="articulos.eliminarArticulo(${index})">Eliminar</button>
                    </li>
                `;
                cartItemsList.append(item);
                total += articulo.precio;
            });

            cartTotal.text(total.toFixed(2));
        }

        eliminarArticulo(index) {
            this.articulos.splice(index, 1);
            this.cantArticulos = this.articulos.length;
            localStorage.setItem('articulos', JSON.stringify(this.articulos));
            localStorage.setItem('cantArticulos', this.cantArticulos);
            $("#cantArticulos").html(this.cantArticulos);
            this.renderizarArticulos();
        }
    }

    let retornarDatos = () => {
        return new Promise((resolve, reject) => {
            let url = `http://localhost/controller/index.controller.php`;
            $.ajax({
                url: url,
                dataType: "JSON",
                type: 'GET',
                data: { mode: 'readDetalle' },
                success: function (response) {
                    if (response && Array.isArray(response)) {
                        resolve(response);
                    } else {
                        reject("La respuesta no es un array JSON válido");
                    }
                },
                error: function (error) {
                    reject("Error en la solicitud AJAX: " + error.statusText);
                }
            });
        });
    };


    $(document).ready(async function () {
        window.articulos = new Articulos(); // Guarda la instancia en el objeto global para acceder desde eventos
    });
});
