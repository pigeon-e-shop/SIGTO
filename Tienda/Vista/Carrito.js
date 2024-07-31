let imagenes = {
    1 : "../imagenesProductos/pantalon-nike-club-black.JPG",
    2 : "../imagenesProductos/nike-vomero-17-black.JPG",
    3 : "../imagenesProductos/camisetaPumaGris.jpg",
    4 : "../imagenesProductos/mandoPs5.jpg",
    5 : "../imagenesProductos/googlePlayCard50.jpg",
    6 : "../imagenesProductos/usbMemory.jpg",
    7 : "../imagenesProductos/lapizLabialRojo.jpg",
    8 : "../imagenesProductos/rimel.jpg",
    9 : "../imagenesProductos/lapizLabialAzul.jpg"
}
let articulos = JSON.parse(localStorage.getItem('articulos')) || [];
let cantArticulos = Number(localStorage.getItem('cantArticulos')) || articulos.length;
$("#cantArticulos").html(cantArticulos);

function Articulos(id, nombre, precio, descripcion) {
    this.id = id;
    this.nombre = nombre;
    this.precio = precio;
    this.descripcion = descripcion;
  
    
}

let pantalonNikeBlack = new Articulos(1, "Pantalon Nike Guay", 25.50, "Guay");
let zapasNikeMola = new Articulos(2, "Zapas Nike Molona", 79.99, "Mola");
let camisetaPumaGris = new Articulos(3, "Camiseta Puma gris", 39.99, "100% Gris");
let mandoPs5 = new Articulos(4, "mando Ps5", 79.99, "A jugar sin descanso");
let googleCard50 = new Articulos(5, "Google Play Card 50 Dolar", 50, "50 dolar pal free");
let usbMemory30 = new Articulos(6, "Usb Memory 30 Gb", 19.99, "Lo justo y necesario");
let lapizLabialRojo = new Articulos(7, "Lapiz Labial Rojo", 9.99, "Rojo");
let rimel = new Articulos(8, "rimel", 39.99, "Pestañas increibles");
let lapizLabialAzul = new Articulos(9, "Lapiz Labial Azul", 19.99, "Azul");



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
                <img src="${imagenes[articulo.id]}" width="100" height="100" class="articuloImagen">
                <span class="articuloTexto">${articulo.nombre} - $${articulo.precio}</span>
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
