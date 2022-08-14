$(document).ready(() => {
    $('#btn-grabar').on('click', (e) => grabar())
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var cargarDesplegables = () => {
    let urlGiro = `${baseUrl}Parametro/obtenerListaParametro`
    Promise.all([
        fetch(urlGiro),
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jParametro = responseAll[0]
        if (jParametro.success) cargarParametro(jParametro.object)
        cargarDatosIniciales()
    });
}

var cargarParametro = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idParametro}">${x.parametro}</option>`).join('');
    options = `<option value="0">-Seleccione un parent parámetro-</option>${options}`;
    $('#cbo-parent').html(options);
}

/* ================================================
 * FIN CARGA DESPLEGABLES
 * ================================================
 */

/* ================================================
 * INICIO VALIDAR DATOS
 * ================================================
 */
var idParametro = -1
var grabar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];
    let parametro = $("#txt-parametro").val().trim()
    let idParentParametro = $("#cbo-parent").val()
    let idTipoParametro = $("#cbo-tipo-parametro").val()
    let idEstado = $("#cbo-estado").val()

    if (validarEspaciosBlanco(parametro)) arr.push("Debe ingresar el nombre del parámetro");
    //if (validarCombo(parentParametro)) arr.push("Debe seleccionar un parent parámetro");
    if (validarCombo(idTipoParametro)) arr.push("Debe seleccionar un tipo de parámetro");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'registro'));
        return;
    }

    let url = `${baseUrl}Parametro/grabarParametro`;
    let data = { idParametro, parametro, idParentParametro, idTipoParametro, idEstado, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) { $('#btn-grabar').hide() }
        j.success ?
        $('.seccion-mensaje').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo. Utilice el buscador para encontrar su nuevo registro.'))) :
        $('.seccion-mensaje').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

/* ================================================
 * FIN VALIDAR DATOS
 * ================================================
 */

/* ================================================
 * INICIO CONSULTAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatosIniciales = () => {
    let id = $('#identificador').val()
    if (id > 0) {
        let url = `${baseUrl}Parametro/obtenerParametro?idParametro=${id}`;
        fetch(url)
        .then(r => r.json())
        .then(j => {
            if (j.success) {
                cargarDatos(j.object)
            } else {
                $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos del parámetro. Por favor, puede volver a recargar la página.'), 'carga de datos'))
            }
        })
        .catch(error => {
            console.log('Error:' + error.message)
        })
    }
}

/* ================================================
 * FIN CONSULTAR DATOS ENTIDAD
 * ================================================
 */

/* ================================================
 * INICIO CARGAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatos = (data) => {
    if (data == null) return
    idParametro = data.idParametro
    $("#txt-parametro").val(data.parametro)
    $("#cbo-parent").val(data.idParentParametro)
    $("#cbo-tipo-parametro").val(data.idTipoParametro)
    $("#cbo-estado").val(data.idEstado)
}

/* ================================================
 * FIN CARGAR DATOS ENTIDAD
 * ================================================
 */