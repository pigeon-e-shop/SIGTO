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
                                    <img src="${articulo.rutaImagen}" width="300" height="400" class="card-img-top" alt="${articulo.nombre}" />
                                    <div class="card-body">
                                        <h5 class="card-title">${articulo.nombre}</h5>
                                        <p class="card-text">${articulo.descripcion}</p>
                                        <p class="card-text">USD $${articulo.precio}</p>
                                        <a class="btn btn-primary agregarArt" onclick="articulos.agregarArt(new Articulo(${articulo.id}, '${articulo.nombre}', ${articulo.precio}, '${articulo.descripcion}', '${articulo.rutaImagen}'))">Agregar carrito</a>
                                    </div>
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

    // Define the URL and retornarDatos function
    

    let retornarDatos = () => {
        return new Promise((resolve, reject) => {
            let modo = "readDetalle";
            let url = `http://localhost/index.controller.php`;
            $.ajax({
                url: url,
                contentType: "application/json",
                type: "GET",
                data: {mode: modo},
                success: function (response) {
                    try {
                        const parsedResponse = (response);
                        if (Array.isArray(parsedResponse)) {
                            resolve(parsedResponse); // Resuelve la promesa con los datos
                        } else {
                            console.log("La respuesta no es un array JSON válido");
                            resolve([]); // Resuelve la promesa con un array vacío si la respuesta no es válida
                        }
                    } catch (error) {
                        console.error("Error al analizar la respuesta JSON:", error);
                        resolve([]); // Resuelve con un array vacío en caso de error de análisis
                    }
                },
                error: function (error) {
                    console.error("Error en la solicitud AJAX:", error);
                    reject(error); // Rechaza la promesa en caso de error
                }
            });
        });
    };

    $(document).ready(async function () {
        window.articulos = new Articulos(); // Guarda la instancia en el objeto global para acceder desde eventos
    });
});
