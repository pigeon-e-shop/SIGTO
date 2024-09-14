$(document).ready(function () {
    $("#signInBtn").click(function (e) {
        e.preventDefault();
        let url = "http://localhost/controller/login.controller.php";
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
            success: function () {
                $.ajax({
                    type: "POST",
                    url: url,
                    data: {
                        mode: "setCookies",
                        username: $("#emailIS").val(),
                        password: $("#passwordIS").val()
                    },
                    dataType: "JSON",
                    success: function () {
                        location.reload();
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
});