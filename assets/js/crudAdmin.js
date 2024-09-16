$(document).ready(function () {
    $.ajax({
      url: "../../controller/crud.controller.php",
      type: "GET",
      data: { action: "getTables" },
      success: function (data) {
        data.forEach(function (table) {
          $(".tableSelector").append('<option value="' + table + '">' + table + "</option>");
        });
      },
      error: function (xhr, status, error) {
        console.error("Error en la solicitud:", status, error);
      },
    });

    $("#tableSelector").change(function () {
      var table = $(this).val();
      $("#columnSelector").empty().append('<option value="">Selecciona una columna</option>');
      $("#filterInput").val(""); 
      if (table) {
        $.ajax({
          url: "../../controller/crud.controller.php",
          type: "GET",
          data: { action: "getColumns", table: table },
          success: function (data) {
            data.forEach(function (column) {
              $("#columnSelector").append('<option value="' + column + '">' + column + "</option>");
            });
            $("#filterInput").trigger("change");
          },
          error: function (xhr, status, error) {
            console.error("Error en la solicitud:", status, error);
          },
        });
      }
    });

    $("#filterInput").change(function () {
      var table = $("#tableSelector").val();
      var column = $("#columnSelector").val();
      var filter = $("#filterInput").val();

      if (table) {
        var url = column ? "../../controller/crud.controller.php?action=getDataFilter&table=" + table + "&column=" + column + "&filter=" + filter : "../../controller/crud.controller.php?action=getData&table=" + table;

        $.ajax({
          url: url,
          type: "GET",
          success: function (data) {
            var rows = "";
            data.forEach(function (item) {
              var row = "<tr>";
              for (var key in item) {
                if (item.hasOwnProperty(key) && key !== "idArticulo") {
                  row += "<td>" + item[key] + "</td>";
                }
              }
              row += '<td><button class="editBtn btn btn-sm" data-id="' + item.idArticulo + '">Editar</button> <button class="deleteBtn btn btn-sm" data-id="' + item.idArticulo + '">Eliminar</button></td></tr>';
              rows += row;
            });
            $("#dataTable tbody").html(rows);
          },
          error: function (xhr, status, error) {
            console.error("Error en la solicitud:", status, error);
          },
        });
      }
    });

    $("#dataTable").on("click", ".editBtn", function () {
      var id = $(this).data("id");
      var row = $(this).closest("tr");
      row
        .find("td")
        .not(":last-child")
        .each(function () {
          var text = $(this).text();
          $(this).html('<input type="text" value="' + text + '">');
        });
      $(this).replaceWith('<button class="updateBtn btn btn-sm" data-id="' + id + '">Actualizar</button>');
      row.find(".deleteBtn").replaceWith('<button class="cancelBtn btn btn-sm" data-id="' + id + '">Cancelar</button>');
    });

    $("#dataTable").on("click", ".updateBtn", function () {
      var id = $(this).data("id");
      var row = $(this).closest("tr");
      var data = {};
      row
        .find("td")
        .not(":last-child")
        .each(function (index) {
          var input = $(this).find("input");
          if (input.length) {
            data[$(this).index()] = input.val();
          }
        });

      console.log(data);

      $.ajax({
        url: "../../controller/crud.controller.php",
        type: "POST",
        data: {
          action: "updateData",
          table: $("#tableSelector").val(),
          data: data,
          id: id,
        },
        success: function (response) {
          alert("Datos actualizados");
          $("#tableSelector").trigger("change");
        },
        error: function (xhr, status, error) {
          console.error("Error en la solicitud:", status, error);
        },
      });
    });

    $("#dataTable").on("click", ".cancelBtn", function () {
      $("#tableSelector").trigger("change");
    });

    $("#dataTable").on("click", ".deleteBtn", function () {
      if (confirm("¿Seguro que quiere borrar esta fila?")) {
        var id = $(this).data("id");
        $.ajax({
          url: "../../controller/crud.controller.php",
          type: "POST",
          data: {
            action: "deleteData",
            table: $("#tableSelector").val(),
            id: id,
          },
          success: function (response) {
            alert("Datos eliminados");
            $("#tableSelector").trigger("change");
          },
          error: function (xhr, status, error) {
            console.error("Error en la solicitud:", status, error);
          },
        });
      }
    });

    $("#tableSelector2").change(function () {
      var table = $(this).val();
      $("#createFormSection").empty();
      if (table) {
        $.ajax({
          url: "../../controller/crud.controller.php",
          type: "GET",
          data: { action: "getColumnsWithTypes", table: table },
          success: function (data) {
            var formHtml = '<form id="createForm">';
            data.forEach(function (column) {
              var fieldHtml = '<div class="mb-3">';
              var columnName = column.field;
              if (column.extra && column.extra.includes("auto_increment")) {
                return;
              }

              switch (true) {
                case column.type.startsWith("enum"):
                  fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                  fieldHtml += '<select id="' + columnName + '" name="' + columnName + '" class="form-select">';
                  if (column.enum_values && column.enum_values.length > 0) {
                    column.enum_values.forEach(function (value) {
                      fieldHtml += '<option value="' + value + '">' + value + "</option>";
                    });
                  }
                  fieldHtml += "</select>";
                  break;
                case column.type.startsWith("int"):
                case column.type.startsWith("float"):
                  fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                  fieldHtml += '<input type="number" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                  break;
                case column.type.startsWith("varchar"):
                default:
                  fieldHtml += '<label for="' + columnName + '" class="form-label">' + columnName + "</label>";
                  fieldHtml += '<input type="text" id="' + columnName + '" name="' + columnName + '" class="form-control">';
                  break;
              }
              fieldHtml += "</div>";
              formHtml += fieldHtml;
            });
            formHtml += '<button type="submit" class="btn btn-primary">Crear</button></form>';
            $("#createFormSection").html(formHtml);
          },
          error: function (xhr, status, error) {
            console.error("Error en la solicitud:", status, error);
          },
        });
      }
    });

    $("#createFormSection").on("submit", "#createForm", function (e) {
      e.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        url: "../../controller/crud.controller.php",
        type: "POST",
        data: {
          action: "createData",
          table: $("#tableSelector2").val(),
          data: formData,
        },
        success: function (response) {
          alert("Registro creado");
          $("#tableSelector2").trigger("change");
        },
        error: function (xhr, status, error) {
          console.error("Error en la solicitud:", status, error);
        },
      });
    });
  });