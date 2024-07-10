// Función para cargar usuarios del localStorage
function cargarUsuarios() {
    let usuariosGuardados = localStorage.getItem('usuarios');
    if (usuariosGuardados) {
        return JSON.parse(usuariosGuardados);
    }
    return [];
}

// Función para guardar usuarios en el localStorage
function guardarUsuarios() {
    localStorage.setItem('usuarios', JSON.stringify(usuarios));
}

// Inicializa usuarios desde el localStorage
let usuarios = cargarUsuarios();

// HECHO A MANO
$("#btnmostrar").click(function () {
    console.log(usuarios);
});

$("#signUpForm").on("submit", function (event) {
    event.preventDefault();
    tomardatos();
});

function Usuario(nombre, apellido, email, password) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.email = email;
    this.password = password;
    this.mostrar = function () {
        return `${this.nombre} ${this.apellido} ${this.email} ${this.password} <br>`;
    };
}

function tomardatos() {
    let nombre = $("#nombreIngresado").val();
    let apellido = $("#apellidoIngresado").val();
    let email = $("#emailIngresado").val();
    let password = $("#passwordIngresado").val();

    let usuario = new Usuario(nombre, apellido, email, password);
    usuarios.push(usuario);

    guardarUsuarios();

    $("#registrationMessage").show().delay(3000).fadeOut();
    document.getElementById('signUpForm').reset();
    updateProgressBar();
    console.log(usuarios);
}

$("#signInBtn").click(function () {
    tomardatos2();
});


function tomardatos2() {
    let mail = $("#emailIS").val();
    let contra = $("#passwordIS").val();
    if (chequear(mail, contra)) {  
        alert("Sesion Iniciadav  ");
        window.open('..//index.html');
    } else {
        alert("Datos Incorrectos");
    }
}



function chequear(mail, contra) {
    for (let i = 0; i < usuarios.length; i++) {
        if (mail == usuarios[i].email && contra == usuarios[i].password) {
            return true;
        }
    }
    return false;
}

//Contraseña
$("#passwordIngresado").on("input", function () {
    updateProgressBar();
});

function updateProgressBar() {
    const password = $("#passwordIngresado").val();
    const progressBar = $("#progress-bar");
    let score = calculatePasswordScore(password);

    let progressText;
    let progressColorClass;

    if (score <= 25) {
        progressText = "Muy débil";
        progressColorClass = "low";
    } else if (score <= 50) {
        progressText = "Débil";
        progressColorClass = "medium";
    } else if (score <= 75) {
        progressText = "Fuerte";
        progressColorClass = "high";
    } else {
        progressText = "Muy fuerte";
        progressColorClass = "very-high";
    }

    progressBar.css("width", `${score}%`);
    progressBar.text(progressText);
    progressBar.attr("class", `progress-bar ${progressColorClass}`);
}


function calculatePasswordScore(password) {
    let score = 0;

    if (password.length > 8) score += 25;
    if (password.length > 15) score += 25;
    if (password.match(/[a-z]/)) score += 10;
    if (password.match(/[A-Z]/)) score += 10;
    if (password.match(/[0-9]/)) score += 20;
    if (password.match(/[^a-zA-Z0-9]/)) score += 35;
    if (password.match("hola123")) score -= 35;

    return score;
}

$("#showPasswordCheckbox").on("change", function () {
    var passwordField = $("#passwordIngresado");
    if ($(this).is(":checked")) {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});

$("#showPasswordCheckbox").on("change", function () {
    var passwordField = $("#passwordIS");
    if ($(this).is(":checked")) {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});