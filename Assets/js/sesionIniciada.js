let modo = "read";
let tabla = "usuario";
let url = `http://localhost/SIGTO/model/connection.php?modo=${modo}&tabla=${tabla}`;

console.log("URL construida:", url);

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
            data.forEach((element) => {
                mostrar(element);
            });
        })
        .catch((error) => console.error("There has been a problem with your fetch operation:", error));
};

let mostrar = (text) => {
    let fila = `<tr> <td>${text.id}</td> <td>${text.email}</td> <td>${text.username}</td> <td>${text.celular}</td> </tr>`;
    $("#usuariosTabla tbody").append(fila);
};

datos();
