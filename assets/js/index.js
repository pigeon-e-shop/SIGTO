import Alertas from './Alertas.js'
let idUser;
const alertas = new Alertas();
$(document).ready(function () {
    $("#dropdownCategorias").hover(
        function () {
            $(this).addClass("show");
            $(this).find(".dropdown-menu").addClass("show");
        },
        function () {
            $(this).removeClass("show");
            $(this).find(".dropdown-menu").removeClass("show");
        }
    );
    $(".dropdown-submenu").hover(
        function () {
            $(this).find(".dropdown-menu").addClass("show");
            $(this).children(".dropdown-item").addClass("show");
        },
        function () {
            $(this).find(".dropdown-menu").removeClass("show");
            $(this).children(".dropdown-item").removeClass("show");
        }
    );
    $(".dropdown-submenu .dropdown-menu").mouseleave(function () {
        $(this).removeClass("show");
        $(this).parent(".dropdown-submenu").children(".dropdown-item").removeClass("show");
    });
    checklogin();

    function checklogin() {
        $.ajax({
            type: "POST",
            url: "/controller/login.controller.php",
            data: { mode: 'readCookies' },
            dataType: "JSON",
            success: function (redcookies) {
                idUser = redcookies.usuario;
                if (redcookies.error == "Cookie no encontrada") {
                    $('#contenedor-usuario-login').html(`<div class="dropdown">
                                <button type="button" class="fa-solid fa-user btn border-0" data-bs-toggle="dropdown" data-toggle="dropdown" data-bs-auto-close="outside"></button>
                                <div class="dropdown-menu col-md-6">
                                    <a class="dropdown-item" href="view/tienda/signIn.html">Inicia sesion ahora</a>
                                    <a class="dropdown-item" href="view/tienda/signUp.html">Aun no tienes cuenta? Registrate ya!</a>
                                </div>
                            </div>`);
                    
                } else {
                    $("#contenedor-usuario-login").html(`<a href="/view/tienda/usuario.html" class="fa-solid fa-user border-0"></a>`)
                }
            },
            error: function (xhr, status, error) {
            }
        });
    }
    $(document).on('click','.agregarArt',function (e) { 
        e.preventDefault();
        // agregar a la bd.
        $.ajax({
            type: "POST",
            url: "/controller/carrito.controller.php",
            data: {
                mode: 'agregar',
                idUser: idUser,
                idArticulo: $('.agregarArt').data('id')
            },
            success: function (response) {
                if (response.status == 'ok') {
                    alertas.success('articulo agregado correctamente')
                } else {
                    alertas.error('Error.');
                }
            },
            error: function () {
                alertas.error('Error.');
            }
        });
    });
});