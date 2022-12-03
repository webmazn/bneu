$(document).ready(() => {
    $('[name="pregunta01"]').on('change', (e) => cambiarParticipar());
    $('[name="pregunta02"]').on('change', (e) => cambiarTratamientoDatos());
    $('#btn-continuar').on('click', (e) => validarContinuar())
    cargarDatos()
});

var cargarDatos = () => {
    cargarParametros(listaEmpresaGas, '#cbo-empresa-gas', 'Seleccione una empresa de gas')
    cargarParametros(listaEmpresaLuz, '#cbo-empresa-luz', 'Seleccione una empresa de luz')
    $('#cbo-empresa-gas').val(planta.idEmpresaGas)
    $('#txt-suministro-gas').val(planta.numeroSuministroGas)
    $('#cbo-empresa-luz').val(planta.idEmpresaLuz)
    $('#txt-suministro-luz').val(planta.numeroSuministroAlumbrado)
}

var cargarParametros = (data, idHtml, textoOpcion) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idParametro}">${x.parametro}</option>`).join('');
    options = `<option value="0">-${textoOpcion}-</option>${options}`;
    $(idHtml).html(options);
}

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
    let idEmpresaGas = $('#cbo-empresa-gas').val()
    let numeroSuministroGas = $('#txt-suministro-gas').val().trim()
    let idEmpresaLuz = $('#cbo-empresa-luz').val()
    let numeroSuministroAlumbrado = $('#txt-suministro-luz').val().trim()

    let url = `${baseUrl}Encuesta/participarTratamientoDatos`;
    let data = { idControlEncuesta, aceptaLLenarEncuesta, aceptaTratamientoDatos, campanaEmpresa: { idCampana }, plantaEmpresa: { idPlantaEmpresa: planta.idPlantaEmpresa, idEmpresaGas, numeroSuministroGas, idEmpresaLuz, numeroSuministroAlumbrado }, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            //if (!aceptaLLenarEncuesta) location.href = `${baseUrl}Encuesta/Finalizar`
            if (aceptaLLenarEncuesta == '0') location.href = `${baseUrl}Interno/Index`
            else location.href = `${baseUrl}Encuesta/Firma/${$('#identificador').val()}`
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al guardar los datos, reintente nuevamente.'), 'registro'))
        }       
        
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}