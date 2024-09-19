if (!localStorage.getItem('authToken')) {
    console.error("debes loguearte primero");
    window.location.href = '/view/admin';
}  
console.log('OK');
console.log(localStorage.getItem('authToken'));
