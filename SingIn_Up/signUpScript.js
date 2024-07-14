function createUser(nombre, apellido, email, password, offersAccepted) {
    return {
        nombre: nombre,
        apellido: apellido,
        email: email,
        password: password,
        offersAccepted: offersAccepted
    };
}

function createUserManager() {
    const users = [];

    return {
        addUser: function(user) {
            users.push(user);
        },
        getUsers: function() {
            return users;
        }
    };
}

const userManager = createUserManager();

document.getElementById('signUpForm').addEventListener('submit', function (event) {
    event.preventDefault();

    const nombre = document.getElementById('nombre').value;
    const apellido = document.getElementById('apellido').value;
    const email = document.getElementById('emailInput').value;
    const password = document.getElementById('password').value;
    const offersAccepted = document.getElementById('gridCheck2').checked;

    const newUser = createUser(nombre, apellido, email, password, offersAccepted);
    userManager.addUser(newUser);

    console.log(userManager.getUsers());

    const messageElement = document.getElementById('registrationMessage');
    messageElement.style.display = 'block';
    setTimeout(() => {
        messageElement.style.display = 'none';
    }, 3000);

    document.getElementById('signUpForm').reset();
    updateProgressBar(); 
});

function updateProgressBar() {
    const password = document.getElementById('password').value;
    const progressBar = document.getElementById('progress-bar');
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

    progressBar.style.width = `${score}%`;
    progressBar.textContent = progressText;
    progressBar.className = `progress-bar ${progressColorClass}`;
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
    var passwordField = $("#password");
    if ($(this).is(":checked")) {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});
  