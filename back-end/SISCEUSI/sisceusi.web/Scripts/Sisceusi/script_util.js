
/*
 *  Metodo para crear
 *  una lista de Mensajes
 *  con parámetro de entrada un array
 * 
 * **/
var messageArrayGeneric = (arr) => {
    let message = '';
    $.each(arr, function (ind, elem) { message += '<li><small class="mb-0">' + elem + '</li></small>'; });
    return `<ul style="list-style:none;padding-inline-start: 0px; !important">${message}</ul>`;
}

/*
 *  Metodo para crear
 *  una lista de Mensajes
 *  con parámetro de entrada una cadena
 * 
 * **/
var messageStringGeneric = (message) => {
    return `<small class="mb-0">${message}</li></small>`;
}

/*
 *  Metodo para crear
 *  un mensaje de error
 *  con parámetro de entrada una cadena
 * 
 * **/
var messageError = (message, nameError) => {
    return `<div class="alert alert-danger d-flex align-items-stretch" role="alert">` +
                    `<div class="alert-wrap mr-3">` +
                      `<div class="sa">` +
                        `<div class="sa-error">` +
                          `<div class="sa-error-x">` +
                            `<div class="sa-error-left"></div>` +
                            `<div class="sa-error-right"></div>` +
                          `</div>` +
                          `<div class="sa-error-placeholder"></div>` +
                          `<div class="sa-error-fix"></div>` +
                        `</div>` +
                      `</div>` +
                    `</div>` +
                    `<div class="alert-wrap">` +
                      `<h6>Error de ${nameError}</h6>` +
                      `<hr>${message}` +
                    `</div>` +
                  `</div>`;
}

/*
 *  Metodo para crear
 *  un mensaje de success
 *  con parámetro de entrada una cadena
 * 
 * **/
var messageSuccess = (message) => {
    return `<div class="alert alert-success d-flex align-items-stretch" role="alert">` +
                    `<div class="alert-wrap mr-3">` +
                      `<div class="sa">` +
                        `<div class="sa-success">` +
                          `<div class="sa-success-tip"></div>` +
                          `<div class="sa-success-long"></div>` +
                          `<div class="sa-success-placeholder"></div>` +
                          `<div class="sa-success-fix"></div>` +
                        `</div>` +
                      `</div>` +
                    `</div>` +
                    `<div class="alert-wrap">` +
                      `<h6>Bien hecho</h6>` +
                      `<hr>${message}` +
                    `</div>` +
                  `</div>`;
}

/*
 *  Metodo para la paginación 
 *  ir a la siguiente o anterior pagina
 *  ir a la primera pagina o ultma pagina
 * 
 * **/

var cambiarPaginaGrilla = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina").val());
    total = Number($(".total-paginas").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina").val(page);
}

/*
 *  Metodo para ordenar las columnas
 *  DESC de forma descente
 *  ASC de forma ascendente
 *  Funciona con columnas estáticas
 *  antes que carga el DOM
 * 
 * **/

var ordenar = (id) => {
    $(".column-filter").removeClass("fa-sort-up");
    $(".column-filter").removeClass("fa-sort-down");
    $(".column-filter").addClass("fa-sort");

    if ($("#column").val() == id) {
        if ($("#order").val() == "ASC") {
            $("#order").val("DESC")
            $(`#${id}`).removeClass("fa-sort");
            $(`#${id}`).removeClass("fa-sort-up");
            $(`#${id}`).addClass("fa-sort-down");
        } else {
            $("#order").val("ASC")
            $(`#${id}`).removeClass("fa-sort");
            $(`#${id}`).removeClass("fa-sort-down");
            $(`#${id}`).addClass("fa-sort-up");
        }
    } else {
        $("#column").val(id);
        $("#order").val("ASC")
        $(`#${id}`).removeClass("fa-sort");
        $(`#${id}`).removeClass("fa-sort-down");
        $(`#${id}`).addClass("fa-sort-up");
    }
}

/*
 *
 * Indicar cuantos ceros a la
 * izquierda se deberán mostrar Ejm: 000001
 *
 **/
var pad = (str, max) => {
    str = str.toString()
    return str.length < max ? pad("0" + str, max) : str
}

/*
 *
 * Método números enteros: ruc, dni, etc.
 * Ejemplo => DNI: 10225896
 *
 **/
$(document).on("keyup", ".integer-positivo", function (e) {
    $(e.target).val(function (index, value) {
        return value.replace(/\D/g, "");
    });
});