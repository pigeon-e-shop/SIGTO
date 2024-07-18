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

$(".dropdown-submenu").on({
    mouseenter: function () {
        $(this).find(".dropdown-menu").addClass("show");
        $(this).children(".dropdown-item").addClass("show");
    },
    mouseleave: function () {
        $(this).find(".dropdown-menu").removeClass("show");
        $(this).children(".dropdown-item").removeClass("show");
    },
});

$(".dropdown-submenu .dropdown-menu").on("mouseleave", function () {
    $(this).removeClass("show");
    $(this).parent(".dropdown-submenu").children(".dropdown-item").removeClass("show");
});

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
