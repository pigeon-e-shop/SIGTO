class Alertas {
    constructor(contenedor) {
        this.contenedor = contenedor;
    }

    success(texto) {
        this.showAlert("success", texto);
    }

    error(texto) {
        this.showAlert("danger", texto);
    }

    warning(texto) {
        this.showAlert("warning", texto);
    }

    showAlert(tipo, texto) {
        const alertElement = $(`
            <div class="alert alert-${tipo} alert-dismissible fade show" role="alert">
                ${texto}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        `);

        $(this.contenedor).append(alertElement);

        setTimeout(() => {
            alertElement.removeClass('show');
            alertElement.addClass('fade');

            setTimeout(() => {
                alertElement.remove();
            }, 150);
        }, 3000);
    }
}

export default Alertas;
