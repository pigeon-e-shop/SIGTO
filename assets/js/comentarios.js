$(document).ready(function () {
    let agregarComentario = () => {
        getCookieUser(function (response) {
            if (response.error === "Cookie no encontrada") {
                alert("Debes loguearte para publicar un mensaje");
                window.location.href = "/view/tienda/signIn.html";
                return;
            } else {
                let usuarioId = response.usuario;
                const urlParams = new URLSearchParams(window.location.search);
                const articuloId = urlParams.get("id");

                let calificacion = $("input[name='estrellas']:checked").val();
                let comentario = $("#comentario").val();

                $.ajax({
                    type: "POST",
                    url: "/controller/comentarios.controller.php",
                    data: {
                        mode: "createComment",
                        idArticulo: articuloId,
                        idUsuario: usuarioId,
                        calificacion: calificacion,
                        comentario: comentario,
                    },
                    dataType: "JSON",
                    success: function (response) {
                        location.reload(); 
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr, status, error);
                        alert("Error al agregar el comentario.");
                    },
                });
            }
        });
    };
    let cargarComentarios = () => {
        let comments = $("#comentarios-inner");
        const urlParams = new URLSearchParams(window.location.search);
        const articuloId = urlParams.get("id");
        console.log(articuloId);
        $.ajax({
            type: "POST",
            url: "/controller/comentarios.controller.php?id=" + articuloId,
            data: { mode: "getComments" },
            dataType: "JSON",
            success: function (response) {
                comments.empty();
                if (response.message) {
                    comments.append(`<p>${response.message}</p>`);
                } else {
                    response.forEach((element) => {
                        comments.append(`
                                  <div>
                                                           
                                  <strong>${element.nombre_usuario}</strong> 
                                         <br>      
                              <div class="stars" style="--calificacion: ${element.calificacion}">
                              </div>                         <p>${element.comentario}</p>                     
                              </div>                     <hr>              `
                        );
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error(xhr, status, error);
                comments.append(`<p>Error al cargar comentarios.</p>`);
            },
        });
    };
    function getCookieUser(callback) {
        $.ajax({
            type: "POST",
            url: "/controller/login.controller.php",
            data: { mode: "readCookies" },
            dataType: "JSON",
            success: function (response) {
                callback(response);
            },
        });
    }
    cargarComentarios();
    $("#btn-guardar-comentario").click(function (e) {
        e.preventDefault();
        agregarComentario();
    });
});