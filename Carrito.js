let articulos = [];
let cantArticulos = 0;
$("#cantArticulos").html(cantArticulos);
9


function Articulos(id,nombre, precio, descripcion) {
    this.id = id;
    this.nombre = nombre;
    this.precio = precio;
    this.descripcion = descripcion;
    this.mostrar = function () {
        return this.nombre + " " + this.precio + ", Precio: " + this.descripcion + "<br>"+  "<br>";
    };
}
let pantalonNikeBlack = new Articulos(1,"Pantalon Nike Guay", 1000, "guay");

let zapasNikeMola = new Articulos(2,"Zapas Nike Molona", 1300, "Mola");


function agregarArt (articulo) {
    articulos.push(articulo);
    cantArticulos++;
    console.log(articulos)
    $("#cantArticulos").html(cantArticulos);
}


