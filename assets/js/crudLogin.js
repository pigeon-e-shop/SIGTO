function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) {
        return decodeURIComponent(parts.pop().split(';').shift());
    }
    return null; // Retorna null si la cookie no existe
}

if (getCookie('authToken') !== 'true') {
    console.error("Debes loguearte primero");
    window.location.href = '/view/admin';
} else {
    console.log('OK');
    console.log(getCookie('authToken'));
}