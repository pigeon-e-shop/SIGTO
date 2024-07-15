let articulos = JSON.parse(localStorage.getItem('articulos')) || [];
let cantArticulos = Number(localStorage.getItem('cantArticulos')) || articulos.length;
$("#cantArticulos").html(cantArticulos);

function Articulos(id, nombre, precio, descripcion) {
    this.id = id;
    this.nombre = nombre;
    this.precio = precio;
    this.descripcion = descripcion;
}

let pantalonNikeBlack = new Articulos(1, "Pantalon Nike Guay", 1000.50, "Guay");
let zapasNikeMola = new Articulos(2, "Zapas Nike Molona", 1300.99, "Mola");

function agregarArt(articulo) {
    articulos.push(articulo);
    cantArticulos = articulos.length;
    localStorage.setItem('articulos', JSON.stringify(articulos));
    localStorage.setItem('cantArticulos', cantArticulos);
    $("#cantArticulos").html(cantArticulos);
    renderizarArticulos();
}

function eliminarTodosLosArticulos() {
    articulos = [];
    cantArticulos = 0;
    localStorage.setItem('articulos', JSON.stringify(articulos));
    localStorage.setItem('cantArticulos', cantArticulos);
    $("#cantArticulos").html(cantArticulos);
    renderizarArticulos();
}

function renderizarArticulos() {
    const cartItemsList = $("#cartItemsList");
    const cartTotal = $("#cartTotal");
    let total = 0;
    cartItemsList.empty();

    articulos.forEach((articulo, index) => {
        const item = `
            <li>
                <span>${articulo.nombre} - $${articulo.precio}</span>
                <button class="btn-remove" onclick="eliminarArticulo(${index})">Eliminar</button>
            </li>
        `;
        cartItemsList.append(item);
        total += articulo.precio;
    });

    cartTotal.text(total.toFixed(2));
}

function eliminarArticulo(index) {
    articulos.splice(index, 1);
    cantArticulos = articulos.length;
    localStorage.setItem('articulos', JSON.stringify(articulos));
    localStorage.setItem('cantArticulos', cantArticulos);
    $("#cantArticulos").html(cantArticulos);
    renderizarArticulos();
}

$(document).ready(function() {
    renderizarArticulos();
    $(".clear-cart").click(eliminarTodosLosArticulos);
});

$("#addPantalon").click(() => agregarArt(pantalonNikeBlack));
$("#addZapas").click(() => agregarArt(zapasNikeMola));