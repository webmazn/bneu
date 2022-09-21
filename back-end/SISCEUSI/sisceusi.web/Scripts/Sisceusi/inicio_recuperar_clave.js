$('form').submit((e) => {
    recuperar(e);
})

var recuperar = (e) => {
    e.preventDefault()
    $('.seccion-mensaje').html('');
    let arr = [];

    let correo = $('#txt-correo').val().trim()
    let dni = $('#txt-dni').val().trim()
    let token = grecaptcha.getResponse()

    if (validarEspaciosBlanco(correo)) arr.push("Debe ingresar un correo electrónico");
    else if (validarCorreoElectronico(correo)) arr.push("Debe ingresar un correo electrónico válido");
    if (validarEspaciosBlanco(dni)) arr.push("Debe ingresar el Dni");
    else if (validarNumerico(dni)) arr.push("El Dni debe tener caracteres numéricos");
    else if (validarTamanioDni(dni)) arr.push("El Dni debe tener 8 caracteres");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'recuperar clave'));
        return;
    }

    $('#btn-recuperar').hide()
    let url = `${baseUrl}Inicio/enviarCorreoRecuperar`;
    let data = { correoElectronico: correo, dni, token }
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric(j.message)))
            setTimeout(function () {
                location.href = `${baseUrl}Inicio/Index`
            }, 5000)
        } else {
            grecaptcha.reset()
            $('#btn-recuperar').show()
            $('.seccion-mensaje').html(messageError(messageStringGeneric(j.message), 'recuperar clave'))
        }
    })
    .catch(error => {
        grecaptcha.reset()
        console.log('Error:' + error.message);
    })
}