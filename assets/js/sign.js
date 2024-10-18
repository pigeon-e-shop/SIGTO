$(document).ready(function () {
    $("#signInBtn").click(function (e) {
        e.preventDefault();
        let url = "../../controller/login.controller.php";
        let mode = "logIn";
        $.ajax({
            type: "POST",
            url: url,
            data: {
                mode: mode,
                username: $("#emailIS").val(),
                password: $("#passwordIS").val(),
            },
            dataType: "JSON",
            success: function (response) {
                if (response.status === "OK") {
                    const successAlert = $(`
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            ${response.message || "Login successful!"}
                        </div>
                    `);
                    $("#alertContainer").append(successAlert);
                    
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: {
                            mode: "setCookies",
                            username: $("#emailIS").val(),
                        },
                        dataType: "JSON",
                        success: function (response) {
                            window.location.href = "/";
                        },
                        error: function (xhr, status, error) {
                            console.error("Error setting cookies: ", error);
                        },
                    });
                } else {
                    // Show error message
                    const errorAlert = $(`
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            ${response.message || "Login failed. Please try again."}
                        </div>
                    `);
                    $("#alertContainer").append(errorAlert);
                }
            },
            error: function (xhr, status, error) {
                const errorMessage = $(`
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        An unexpected error occurred: ${error}
                    </div>
                `);
                $("#alertContainer").append(errorMessage);
                console.error("Status: " + status);
                console.error("Error: " + error);
                console.error("Response Text: " + xhr.responseText);
            },
        });
    });    
    $("#signUpBtn").click(function (e) {
        e.preventDefault();
        try {
            if (!$("#apellidoIngresado").val()) {
                throw new Error("Apellido not set");
            }
            if (!$("#nombreIngresado").val()) {
                throw new Error("Nombre not set");
            }
            if (!$("#emailIngresado").val()) {
                throw new Error("Email not set");
            }
            if (!$("#passwordIngresado").val()) {
                throw new Error("Contrasena not set");
            }
            $.ajax({
                type: "POST",
                url: "/controller/login.controller.php",
                data: {
                    mode: "registrar",
                    apellido: $("#apellidoIngresado").val(),
                    nombre: $("#nombreIngresado").val(),
                    email: $("#emailIngresado").val(),
                    contrasena: $("#passwordIngresado").val(),
                },
                success: function (response) {
                    if (response.status == "error") {
                        throw new Error(response.message);
                    } else {
                        $("#modalTr").click();
                    }
                },
                error: function (xhr, status, error) {
                    throw new Error("ERROR" + xhr, status, error);
                },
            });
        } catch (error) {
            let alertMessage;

            switch (error.message) {
                case "Apellido not set":
                    alertMessage = "Error: Apellido is required.";
                    break;
                case "Nombre not set":
                    alertMessage = "Error: Nombre is required.";
                    break;
                case "Email not set":
                    alertMessage = "Error: Email is required.";
                    break;
                case "Contraseña not set":
                    alertMessage = "Error: Contraseña is required.";
                    break;
                default:
                    alertMessage = error.message;
                    break;
            }

            const alertElement = $(`
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            ${alertMessage}
        </div>
    `);

            $("#alertContainer").append(alertElement);

            setTimeout(() => {
                alertElement.alert("close");
            }, 5000);
        }
    });
    $("#showPasswordCheckbox").click(function () {
        var passwordField = $("#passwordIS");
        if (this.checked) {
            passwordField.attr("type", "text");
        } else {
            passwordField.attr("type", "password");
        }
    });
    $("#modalTr").click(function (e) { 
        e.preventDefault();
        window.location.href = "/";
    });
});
