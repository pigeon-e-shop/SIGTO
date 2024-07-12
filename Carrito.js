let articulos = JSON.parse(localStorage.getItem('articulos')) || [];
let cantArticulos = parseInt(localStorage.getItem('cantArticulos')) || articulos.length;
$("#cantArticulos").html(cantArticulos);

function Articulos(id, nombre, precio, descripcion) {
    this.id = id;
    this.nombre = nombre;
    this.precio = precio;
    this.descripcion = descripcion;
    this.mostrar = function () {
        return this.nombre + " " + this.precio + ", Precio: " + this.descripcion + "<br><br>";
    };
}

let pantalonNikeBlack = new Articulos(1, "Pantalon Nike Guay", 1000, "guay");
let zapasNikeMola = new Articulos(2, "Zapas Nike Molona", 1300, "Mola");

function agregarArt(articulo) {
    articulos.push(articulo);
    cantArticulos = articulos.length;
    localStorage.setItem('articulos', JSON.stringify(articulos));
    localStorage.setItem('cantArticulos', cantArticulos);
    $("#cantArticulos").html(cantArticulos);
    console.log(articulos);
}

function eliminarTodosLosArticulos() {
    articulos = [];
    cantArticulos = 0;
    localStorage.setItem('articulos', JSON.stringify(articulos));
    localStorage.setItem('cantArticulos', cantArticulos);
    $("#cantArticulos").html(cantArticulos);
}

$("#addPantalon").click(() => agregarArt(pantalonNikeBlack));
$("#addZapas").click(() => agregarArt(zapasNikeMola));
$("#btnEliminarTodo").click(eliminarTodosLosArticulos);