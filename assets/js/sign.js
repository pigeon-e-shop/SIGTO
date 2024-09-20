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
                password: $("#passwordIS").val()
            },
            dataType: "JSON",
            success: function (response) {
                console.log(response);
                $.ajax({
                    type: "POST",
                    url: url,
                    data: {
                        mode: "setCookies",
                        username: $("#emailIS").val(),
                    },
                    dataType: "JSON",
                    success: function (response) {
                        console.log(response);
                        window.location.href = "/"
                    },
                    error: function (xhr, status, error) {
                        console.error("Status: " + status);
                        console.error("Error: " + error);
                        console.error("Response Text: " + xhr.responseText);
                    }
                });
            },
            error: function (xhr, status, error) {
                console.error("Status: " + status);
                console.error("Error: " + error);
                console.error("Response Text: " + xhr.responseText);
            }            
        });
    });
    $("#showPasswordCheckbox").click(function () {
        var passwordField = $("#passwordIS");
        if (this.checked) {
            passwordField.attr("type", "text");
        } else {
            passwordField.attr("type", "password");
        }
    });    
});