class ModalController {
    constructor(modalId) {
        this.modalId = modalId;
        this.initialize();
    }

    initialize() {
        // Abrir el modal con el botón
        $("#openModalBtn").on("click", () => {
            this.open();
        });

        // Acción al cerrar el modal
        $(`#${this.modalId}`).on("hidden.bs.modal", () => {
            console.log("Modal closed");
            this.onClose(); // Llama a la función de cierre
        });

        // Botón de guardar cambios
        $("#saveChanges").on("click", () => {
            console.log("Changes saved");
            this.onSave(); // Llama a la función de guardado
            this.close(); // Cierra el modal después de guardar
        });
    }

    open() {
        $(`#${this.modalId}`).modal("show");
    }

    close() {
        $(`#${this.modalId}`).modal("hide");
    }

    onClose() {
        $('input[name="direccionEnvio"][value="existente"]').prop("checked", true);
    }

    onSave() {
        /*
      <input type="text" class="form-control" name="calleModal" id="calleModal" aria-describedby="helpId" placeholder="Calle" />
      <input type="number" class="form-control" name="npuertaModal" id="npuertaModal" placeholder="Numero de puerta" />
      */


    }
}

$(document).ready(function () {
    const modalController = new ModalController("myModal");

    // Mostrar el modal cuando la opción "nueva" esté seleccionada
    $('input[name="direccionEnvio"]').on("change", function () {
        if ($(this).val() === "nueva" && $(this).is(":checked")) {
            modalController.open();
        }
    });

    // Lógica para guardar cambios cuando se hace clic en "Save changes"
    $("#saveChanges").on("click", function () {
        let calle = $("#calleModal").val();
        let numero = $("#npuertaModal").val();

        let id = Math.random().toString(36).substr(2, 9);

        // Crear un nuevo radio input con los valores del modal
        let nuevoRadio = `
          <div>
              <input type="radio" name="direccionEnvio" id="envioNuevo${id}" value="${calle}, Nº ${numero}" />
              <label for="envioNuevo${id}">
                  Envío a: ${calle}  ${numero}
              </label>
          </div>
      `;

        // Agregar el nuevo radio al fieldset
        $("#fieldset1").append(nuevoRadio);

        // Cambiar la selección del radio a "nueva"
        $(`#envioNuevo${id}`).prop("checked", true);

        // Cerrar el modal
        modalController.close();
    });
});
