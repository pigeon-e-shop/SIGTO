$("#btn").click(function () {
  tomardatos2();
});

function tomardatos2() {
  let mail = $("#inputEmail4").val();
  let contra = $("#inputPassword4").val();

  if (chequear(mail,contra)) {
    window.location.href("/index.html")
  } else {
  }
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

