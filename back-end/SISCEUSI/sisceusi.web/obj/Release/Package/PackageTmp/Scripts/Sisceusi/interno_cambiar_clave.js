$(document).ready(() => {
    $('form').submit((e) => {
        cambiar(e);
    })
});

var cambiar = (e) => {
    e.preventDefault()
    $('.seccion-mensaje').html('');
    let arr = [];

    let passwordActual = $('#txt-pswd-now').val().trim()
    let passwordNuevo = $('#txt-pswd-new').val().trim()
    let passwordConf = $('#txt-pswd-conf').val().trim()
    let token = grecaptcha.getResponse()

    if (validarEspaciosBlanco(passwordActual)) arr.push("Debe ingresar la contraseña actual")

    if (passwordNuevo === passwordConf) {
        if (validarTamanioObjecto(passwordNuevo, 6)) arr.push("La nueva contraseña debe contener 6 o más caracteres");
        else if (validarMiniscMayuscNumero(passwordNuevo)) arr.push("La contraseña debe contener al menos una minúscula, mayúscula y número");
    } else {
        arr.push("La nueva contraseña y la confirmación de contraseña no coinciden")
    }

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'cambiar clave'));
        return;
    }

    $('#btn-cambiar').hide()
    let url = `${baseUrl}Interno/actualizarClave`;
    let data = { password: passwordActual, passwordNuevo, token }
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-cambiar').hide()
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric(j.message)))
            setTimeout(function () {
                location.href = `${baseUrl}Interno/Index`
            }, 4000)
        } else {
            grecaptcha.reset()
            $('#btn-cambiar').show()
            $('.seccion-mensaje').html(messageError(messageStringGeneric(j.message), 'cambiar clave'))
        }
    })
    .catch(error => {
        grecaptcha.reset()
        console.log('Error:' + error.message);
    })
}