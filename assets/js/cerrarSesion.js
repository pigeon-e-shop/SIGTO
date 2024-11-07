
//Al hacer click en #cerrarSesion Tiene que llamar con ajax a la funcion delete cookies que esta en el archivo login.Controller.php
//y despues redirigir al index

import Alertas from './Alertas.js';
const alertas = new Alertas ("#alert-container");
$("#cerrarSesion").click(cerrarSesion);

function cerrarSesion() {
    $.ajax({
        url: '/controller/login.controller.php',
        type: 'POST',
        data: { mode: 'deleteCookies' },
        success: function(response) {
            alertas.info('Cookies eliminadas:' + response.status);
            window.location.href = "/";
        },
        error: function(xhr, status, error) {
            alertas.warning('Error al eliminar cookies:' + error);
        }
    });
}