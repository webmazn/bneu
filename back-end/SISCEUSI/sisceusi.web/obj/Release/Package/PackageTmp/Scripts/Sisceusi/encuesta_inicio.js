$(document).ready(() => {
    $('[name="pregunta01"]').on('change', (e) => cambiarParticipar());
    $('[name="pregunta02"]').on('change', (e) => cambiarTratamientoDatos());
    $('#btn-continuar').on('click', (e) => validarContinuar())
});

var cambiarParticipar = () => {
    let valor = $('#exampleRadios2').prop('checked')
    if (valor) $('#exampleRadios4').prop('checked', valor)
}

var cambiarTratamientoDatos = () => {
    let valor = $('#exampleRadios2').prop('checked')
    if (valor) $('#exampleRadios4').prop('checked', valor)
}

var validarContinuar = () => {
    let aceptaLLenarEncuesta = $('#exampleRadios1').prop('checked') ? '1' : '0'
    let aceptaTratamientoDatos = $('#exampleRadios3').prop('checked') ? '1' : '0'
    let idControlEncuesta = $('#identificador').val()
    let idCampana = $('#identificador-campana').val()

    let url = `${baseUrl}Encuesta/participarTratamientoDatos`;
    let data = { idControlEncuesta, aceptaLLenarEncuesta, aceptaTratamientoDatos, campanaEmpresa: { idCampana }, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            if (!aceptaLLenarEncuesta) location.href = `${baseUrl}Encuesta/Finalizar`
            else location.href = `${baseUrl}Encuesta/Firma/${$('#identificador').val()}`
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al guardar los datos, reintente nuevamente.'), 'registro'))
        }       
        
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}