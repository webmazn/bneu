
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


var messageError = (message) => {
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
                      `<h6>Error de acceso</h6>` +
                      `<hr>${message}` +
                    `</div>` +
                  `</div>`;
}