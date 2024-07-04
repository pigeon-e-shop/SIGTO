$("#showPasswordCheckbox").on("change", function () {
  var passwordField = $("#inputPassword4");
  if ($(this).is(":checked")) {
    passwordField.attr("type", "text");
  } else {
    passwordField.attr("type", "password");
  }
});

let usuarios = [];

function Usuarios(mail, contra) {
  this.mail = mail;
  this.contra = contra;
  this.mostrar = function () {
    return "Mail: " + this.mail + "Contrasena: " + this.contra;
  };
}

$("#btn").click(function () {
  tomardatos();
});

function tomardatos() {
  // tomar datos

  let mail = $("#inputEmail4").val();
  let contra = $("#inputPassword4").val();

  if (chequear(mail,contra)) {
    window.location.href("/index.html")
  } else {

    // mensaje de alerta.

  }
}

function agregar(mail, contra) {
  let usuario = new Usuarios(mail, contra);
  usuarios.push(usuario);
  console.log("agregado");
}

function chequear(mail,contra) {
  
  for (let i = 0; i < usuarios.length; i++) {
    
    if (mail == usuarios[i].mail && contra == usuarios[i].contra) {
      
      return true;

    } else {

      return false;

    }
    
  }

}

agregar("santi@gmail.com", "124423");
