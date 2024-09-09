let modo = "read";
let tabla = "articulo";
let url = `http://localhost/SIGTO/model/connection.php?modo=${modo}&tabla=${tabla}`;

console.log("URL construida:", url);

let datos = () => {
    fetch(url)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.text(); // Cambiamos temporalmente a .text() para ver el contenido completo
    })
    .then(text => {
        console.log("Response Text:", text); // Verificamos el contenido de la respuesta
        return JSON.parse(text); // Parseamos manualmente
    })
    .then(data => {
        console.log("Parsed Data:", data);
        data.forEach((element) => {
            mostrar(element);
        });
    })
    .catch(error => console.error('There has been a problem with your fetch operation:', error));
};

let mostrar = (text) => {
    let fila = `<tr> <td>${text.idArticulo}</td> <td>${text.nombre}</td> <td>${text.descripcion}</td> <td>${text.precio}</td> </tr>`;
    $("#usuariosTabla tbody").append(fila);
};

let ajaxConn = () => {
    $.ajax({
        url: "http://localhost/SIGTO/model/connection.php?modo=read&tabla=articulo",
        data: "data",
        dataType: "JSON",
        success: function (response) {
            response.forEach(element => {
                mostrar(element)
            });
        },
        error: function (error) {
            alert(error)
        }
    });
};

//datos();

ajaxConn();