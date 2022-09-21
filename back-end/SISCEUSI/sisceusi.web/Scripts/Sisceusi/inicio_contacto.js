$(document).ready(() => {
    $('#btn-enviar').on('click', () => enviar());
});

var enviar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];

    let nombres = $('#txt-nombres').val().trim()
    let correo = $('#txt-correo').val().trim()
    let telefono = $('#txt-telefono').val().trim()
    let asunto = $('#txt-asunto').val().trim()

    if (validarEspaciosBlanco(nombres)) arr.push("Debe ingresar los nombres");
    if (validarEspaciosBlanco(correo)) arr.push("Debe ingresar un correo electrónico");
    else if (validarCorreoElectronico(correo)) arr.push("Debe ingresar un correo electrónico válido");
    if (validarEspaciosBlanco(telefono)) arr.push("Debe ingresar un teléfono o celular");
    if (validarEspaciosBlanco(asunto)) arr.push("Debe ingresar un asunto");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'contacto'));
        return;
    }

    $('#btn-enviar').hide()
    let url = `${baseUrl}Inicio/enviarContacto`;
    let data = { nombres, correo, telefono, asunto }
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-enviar').hide()
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric("Se envió la solicitud exitosamente. Nuestro equipo pronto se pondrá en contacto con usted. Lo estamos redirigiendo.")))
            setTimeout(function () {
                location.href = `${baseUrl}Inicio/Index`
            }, 4000)
        } else {
            $('#btn-enviar').show()
            $('.seccion-mensaje').html(messageError(messageStringGeneric("Ocurrió un problema al enviar la solicitud."), 'contacto'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}