$(document).ready(function () {
    let categorias = ["Teléfonos móviles", "Computadoras y Laptops", "Televisores y Audio", "Accesorios tecnológicos", "Ropa de Hombre", "Ropa de Mujer", "Zapatos y Accesorios", "Ropa para Niños", "Muebles", "Decoración", "Herramientas y Mejoras para el Hogar", "Jardinería", "Productos para el Cuidado de la Piel", "Maquillaje", "Productos para el Cuidado del Cabello", "Suplementos y Vitaminas", "Equipamiento Deportivo", "Ropa Deportiva", "Bicicletas y Patinetes", "Camping y Senderismo", "Juguetes para Niños", "Juegos de Mesa", "Videojuegos y Consolas", "Puzzles y Rompecabezas", "Accesorios para Automóviles", "Accesorios para Motocicletas", "Herramientas y Equipos", "Neumáticos y Llantas", "Comida Gourmet", "Bebidas Alcohólicas", "Alimentos Orgánicos", "Snacks y Dulces", "Ropa de Bebé", "Juguetes para Bebés", "Productos para la Alimentación del Bebé", "Mobiliario Infantil", "Libros Físicos y E-Books", "Música y CDs", "Instrumentos Musicales", "Audiolibros y Podcasts"];
    for (let index = 0; index < categorias.length; index++) {
        const element = categorias[index];

        $("#categorias").append(`<option value="${element}">${element}</option>`);
    }
    $("#imagen").on("change", function () {
        const file = this.files[0];
        const maxSize = 2 * 1024 * 1024;

        if (file) {
            if (file.size > maxSize) {
                alert("El archivo es demasiado grande. El tamaño máximo permitido es de 2 MB.");
                $(this).val("");
                $("#previewContainer").empty();
            } else {
                const reader = new FileReader();
                reader.onload = function (event) {
                    $("#previewContainer").html(`
                        <h4>Vista Previa:</h4>
                        <img src="${event.target.result}" height="150" alt="Vista previa de la imagen">
                    `);
                };
                reader.readAsDataURL(file);
            }
        } else {
            $("#previewContainer").empty();
        }
    });
    $("#form").on("submit", function (e) {
        e.preventDefault();
        let formData = new FormData(this);
        formData.append("mode", "createArticulo");
        $.ajax({
            type: "POST",
            url: "/controller/backoffice.controller.php",
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                console.log(response);
            },
            error: function (xhr, status, message) {
                console.error(xhr, status, message);

            }
        });
    });
});