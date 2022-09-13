$(document).ready(() => {
    $('#btn-grabar').on('click', (e) => grabar())
    $('#btn-observar').on('click', (e) => observar())
});

var grabar = () => {
    let arr = []
    let idControlEncuesta = $('#identificador').val()
    let fechaRevision = $('#fecha-revision').val()
    let idMetodoVerificacion = $('#cbo-metodo-verificacion').val()
    let idValidezEntrevista = $('#cbo-validez-entrevista').val()
    let resultadoValidezEntrevista = $('#txt-validez-entrevista').val().trim()
    let idFase = 5
    
    if (validarCombo(idMetodoVerificacion)) arr.push("Debe seleccionar un método de verificación");
    if (validarCombo(idValidezEntrevista)) arr.push("Debe seleccionar la validez de la entrevista");
    if (validarEspaciosBlanco(resultadoValidezEntrevista)) arr.push("Debe ingresar un resultado para la validez de la entrevista");

    

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-revision').html(messageError(error, 'registro'));
        return;
    }

    let url = `${baseUrl}Encuesta/GuardarRevisionEncuesta`;
    let data = { idControlEncuesta, fechaRevision, idFase, idMetodoVerificacion, idValidezEntrevista, resultadoValidezEntrevista, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-grabar').hide()
            $('.seccion-mensaje-revision').html(messageSuccess(messageStringGeneric('Se registró la revisión exitosamente.')))
            setTimeout(function () {
                location.href = `${baseUrl}Interno/Index`
            }, 3500)
        } else {
            $('.seccion-mensaje-revision').html(messageError(messageStringGeneric('Ocurrió un problema al guardar los datos, reintente nuevamente.'), 'registro'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var observar = () => {
    let arr = []
    let idControlEncuesta = $('#identificador').val()
    let idFase = 3

    let url = `${baseUrl}Encuesta/GuardarObservacionEncuesta`;
    let data = { idControlEncuesta, idFase, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-observar').hide()
            $('.seccion-mensaje-observado').html(messageSuccess(messageStringGeneric('Se registró la observación exitosamente.')))
            setTimeout(function () {
                location.href = `${baseUrl}Interno/Index`
            }, 3500)
        } else {
            $('.seccion-mensaje-observado').html(messageError(messageStringGeneric('Ocurrió un problema al guardar los datos, reintente nuevamente.'), 'registro'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

$("#grabar-encuesta").on("hidden.bs.modal", function () {
    $('.seccion-mensaje-revision').html('')
})
