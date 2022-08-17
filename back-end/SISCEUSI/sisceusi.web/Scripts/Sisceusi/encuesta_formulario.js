$(document).ready(() => {
    $('#btn-continuar').on('click', (e) => validarContinuar())
});

var validarContinuar = () => {
    let idControlEncuesta = $('#identificador').val()
    let fechaHoraLlenado = $('#fecha-encuesta').val()

    let url = `${baseUrl}Encuesta/formularioEncuesta`;
    let data = { idControlEncuesta, fechaHoraLlenado, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            location.href = `${baseUrl}Encuesta/PreguntaEncuesta/${$('#identificador').val()}`
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al guardar los datos, reintente nuevamente.'), 'registro'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}