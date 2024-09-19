$(document).ready(function () {
    var Articulos = {
        articulos: [],
        cantArticulos: 0,

        cargarArticulos: function () {
            var self = this;
            return new Promise(function (resolve, reject) {
                retornarDatos().then(resolve).catch(reject);
            });
        },

        imageExists: function (url) {
            return new Promise(function (resolve) {
                var img = new Image();

                img.onload = function () {
                    resolve(true);
                };

                img.onerror = function () {
                    resolve(false);
                };

                img.onabort = function () {
                    resolve(false);
                };

                img.src = url;
            });
        },


        mostrarArticulosEnIndex: function () {
            var $carouselInner = $("#articulosCarrusel .carousel-inner");
            $carouselInner.html("");

            this.cargarArticulos().then(function (articulos) {
                if (Array.isArray(articulos) && articulos.length > 0) {
                    var slideHTML = "";
                    var isActive = true;

                    articulos.forEach(function (articulo, index) {
                        if (index % 3 === 0) {
                            if (slideHTML) {
                                $carouselInner.append(`
                                    <div class="carousel-item ${isActive ? 'active' : ''}">
                                        <div class="row">
                                            ${slideHTML}
                                        </div>
                                    </div>
                                `);
                                slideHTML = "";
                                isActive = false;
                            }
                        }


                        slideHTML += `
                                    <div class="col-md-4">
                                        <div class="card">
                                            <a href="../../view/tienda/detalle_producto.html?id=${articulo.id}&modo=exclusivo2">
                                                <img src="${articulo.rutaImagen}" width="300" height="400" class="card-img-top" alt="${articulo.nombre}" />
                                                <div class="card-body">
                                                    <h5 class="card-title">${articulo.nombre}</h5>
                                                    <p class="card-text">${articulo.descripcion}</p>
                                                    <p class="card-text">USD $${articulo.precio}</p>
                                                    <a class="btn btn-primary agregarArt" data-id="${articulo.idArticulo}">Agregar carrito</a>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                `;
                    });

                    if (slideHTML) {
                        $carouselInner.append(`
                            <div class="carousel-item">
                                <div class="row">
                                    ${slideHTML}
                                </div>
                            </div>
                        `);
                    }

                } else {
                    console.warn("No se encontraron artículos.");
                    $("#articulosCarrusel").html("<p>No se encontraron artículos.</p>");
                }
            }).catch(function (error) {
                console.error("Error al obtener los datos:", error);
                $("#articulosCarrusel").html("<p>Hubo un error al cargar los artículos.</p>");
            });
        },

        agregarArt: function (articulo) {
            this.articulos.push(articulo);
            this.cantArticulos = this.articulos.length;
            localStorage.setItem('articulos', JSON.stringify(this.articulos));
            localStorage.setItem('cantArticulos', this.cantArticulos);
            $("#cantArticulos").html(this.cantArticulos);
            this.renderizarArticulos();
        },

        eliminarTodosLosArticulos: function () {
            this.articulos = [];
            this.cantArticulos = 0;
            localStorage.setItem('articulos', JSON.stringify(this.articulos));
            localStorage.setItem('cantArticulos', this.cantArticulos);
            $("#cantArticulos").html(this.cantArticulos);
            this.renderizarArticulos();
        },

        renderizarArticulos: function () {
            var cartItemsList = $("#cartItemsList");
            var cartTotal = $("#cartTotal");
            var total = 0;
            cartItemsList.empty();

            this.articulos.forEach(function (articulo, index) {
                var item = `
                    <li>
                        <img src="${articulo.rutaImagen}" width="100" height="100" class="articuloImagen">
                        <span class="articuloTexto">${articulo.nombre} - $${articulo.precio}</span>
                        <button class="btn-remove" onclick="Articulos.eliminarArticulo(${index})">Eliminar</button>
                    </li>
                `;
                cartItemsList.append(item);
                total += articulo.precio;
            });

            cartTotal.text(total.toFixed(2));
        },

        eliminarArticulo: function (index) {
            this.articulos.splice(index, 1);
            this.cantArticulos = this.articulos.length;
            localStorage.setItem('articulos', JSON.stringify(this.articulos));
            localStorage.setItem('cantArticulos', this.cantArticulos);
            $("#cantArticulos").html(this.cantArticulos);
            this.renderizarArticulos();
        }
    };

    function retornarDatos() {
        return new Promise(function (resolve, reject) {
            var url = `../../controller/index.controller.php`;
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
    }

    Articulos.mostrarArticulosEnIndex();
});
