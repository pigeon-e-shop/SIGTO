let idArticulo = 1; // Cambia este valor por el ID que deseas buscar
let modo = "read";
let tabla = "Articulos";
let url = `http://localhost/SIGTO/model/connection.php?modo=${modo}&tabla=${tabla}`;

let datos = () => {
    fetch(url)
        .then((response) => {
            console.log("Respuesta recibida:", response);
            if (!response.ok) {
                throw new Error("Network response was not ok " + response.statusText);
            }
            return response.json();
        })
        .then((data) => {
            console.log("Datos recibidos en formato JSON:", data);

            // Asumiendo que data es un objeto que contiene la información del artículo
            if (data && data.length > 0) {
                let articulo = data[0]; // Obtén el primer artículo de la respuesta

                // Actualiza los elementos con jQuery
                $("#nombreArticulo").html(articulo.nombreArticulo);
                $("#precioArticulo").html("$" + articulo.precio.toFixed(2));
                $("#fotoArticulo").html(`<img src="${articulo.foto}" alt="${articulo.nombreArticulo}" />`);
                $("#descripcionArticulo").html(articulo.descripcionArticulo);
            } else {
                console.log("No se encontraron artículos");
            }
        })
        .catch((error) => console.error("There has been a problem with your fetch operation:", error));
};

datos();
