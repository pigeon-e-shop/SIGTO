function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

if (!getCookie('authToken')) {
    console.error("debes loguearte primero");
    window.location.href = '/view/admin';
}
console.log('OK');
console.log(getCookie('authToken'));
