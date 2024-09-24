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
            url: "http://localhost/controller/login.controller.php",
            data: { mode: 'readCookies' },
            dataType: "JSON",
            success: function (redcookies) {
                console.log('Cookies read response:', redcookies);
                if (redcookies.includes("Cookie not found")) {
                    $.ajax({
                        type: "POST",
                        url: "http://localhost/controller/login.controller.php",
                        data: { mode: 'setCookies', username: '', password: '' },
                        dataType: "JSON",
                        success: function (response) {
                            console.log('Cookie created:', response);
                        },
                        error: function (xhr2, status2, error2) {
                            console.error('Set cookies error:', xhr2, status2, error2);
                        }
                    });
                } else {
                    $.ajax({
                        type: "POST",
                        url: "http://localhost/controller/login.controller.php",
                        data: {
                            mode: 'logIn',
                            username: redcookies.username,
                            password: redcookies.password
                        },
                        dataType: "JSON",
                        success: function (response) {
                            console.log('Login response:', response);
                            if (Array.isArray(response)) {
                                console.log('Session not started');
                            } else if (Array.isArray(response) && response.includes("OK")) {
                            }
                        },
                        error: function (error) {
                            console.error('Login error:', error);
                        }
                    });
                }
            },
            error: function (xhr, status, error) {
                console.log('Error checking cookies:', xhr, status, error);
                $.ajax({
                    type: "POST",
                    url: "../../controller/login.controller.php",
                    data: { mode: 'setCookies', username: '', password: '' },
                    dataType: "JSON",
                    success: function (response) {
                        console.log('Cookie created:', response);
                    },
                    error: function (xhr2, status2, error2) {
                        console.error('Set cookies error:', xhr2, status2, error2);
                    }
                });
            }
        });
    }
});