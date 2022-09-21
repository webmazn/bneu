/*$(document).ready(() => {
    $('#btn-enviar-bot').on('click', () => enviar());
});*/

$(document).on('click', '#btn-enviar-bot', () => {
    enviar()
})

$("#modalChatBot").on("hidden.bs.modal", function () {
    limpiar()
})


var limpiar = () => {
    $('#btn-enviar-bot').show()
    $('.seccion-mensaje').html('')
    $('#recipient-name').val('')
    $('#message-text').val('')
}

var enviar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];

    let correo = $('#recipient-name').val().trim()
    let asunto = $('#message-text').val().trim()

    if (validarEspaciosBlanco(correo)) arr.push("Debe ingresar un correo electrónico");
    else if (validarCorreoElectronico(correo)) arr.push("Debe ingresar un correo electrónico válido");
    if (validarEspaciosBlanco(asunto)) arr.push("Debe ingresar un mensaje");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'contacto'));
        return;
    }

    $('#btn-enviar-bot').hide()
    let url = `${baseUrl}Inicio/enviarContactoBot`;
    let data = { correo, asunto }
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric("Se envió la solicitud exitosamente. Nuestro equipo pronto se pondrá en contacto con usted.")))
        } else {
            $('#btn-enviar-bot').show()
            $('.seccion-mensaje').html(messageError(messageStringGeneric("Ocurrió un problema al enviar la solicitud."), 'contacto'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}