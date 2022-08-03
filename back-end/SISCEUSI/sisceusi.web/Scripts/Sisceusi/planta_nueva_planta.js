$(document).ready(() => {
    $('#btn-grabar').on('click', (e) => grabar())
    $('#cbo-departamento').on('change', (e) => cambiarDepartamento())
    $('#cbo-provincia').on('change', (e) => cambiarProvincia())
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var arrProvincia = []
var arrDistrito = []

var cargarDesplegables = () => {
    let urlCiuu = `${baseUrl}Ciuu/obtenerListaCiuu`;
    let urlDepartamento = `${baseUrl}Departamento/obtenerListaDepartamento`;
    let urlProvincia = `${baseUrl}Provincia/obtenerListaProvincia`;
    let urlDistrito = `${baseUrl}Distrito/obtenerListaDistrito`;
    Promise.all([
        fetch(urlCiuu),
        fetch(urlDepartamento),
        fetch(urlProvincia),
        fetch(urlDistrito)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jCiuu = responseAll[0]
        jDepartamento = responseAll[1]
        jProvincia = responseAll[2]
        jDistrito = responseAll[3]
        if (jCiuu.success) cargarCiuu(jCiuu.object)
        if (jDepartamento.success) cargarDepartamento(jDepartamento.object)
        if (jProvincia.success) cargarProvincia(jProvincia.object)
        if (jDistrito.success) cargarDistrito(jDistrito.object)
        cargarDatosIniciales()
    });
}

var cargarCiuu = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idCiuu}">${x.ciuu}</option>`).join('');
    options = `<option value="0">-Seleccione un CIUU-</option>${options}`;
    $('#cbo-ciuu').html(options);
}

var cargarDepartamento = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idDepartamento}">${x.departamento}</option>`).join('');
    options = `<option value="0">-Seleccione un departamento-</option>${options}`;
    $('#cbo-departamento').html(options);
}

var cargarProvincia = (data) => {
    arrProvincia = data
    options = `<option value="0">-Seleccione una provincia-</option>`
    $('#cbo-provincia').html(options)
}

var cargarDistrito = (data) => {
    arrDistrito = data
    options = `<option value="0">-Seleccione un distrito-</option>`;
    $('#cbo-distrito').html(options);
}


/* ================================================
 * FIN CARGA DESPLEGABLES
 * ================================================
 */

/* ================================================
 * INICIO EVENTOS CHANGE
 * ================================================
 */
var cambiarDepartamento = () => {
    let departamento = $('#cbo-departamento').val()
    $('#cbo-distrito').html(`<option value="0">-Seleccione un distrito-</option>`);
    if (validarCombo(departamento)) {
        $('#cbo-provincia').html(`<option value="0">-Seleccione una provincia-</option>`)        
    } else {
        const data = arrProvincia.filter(x => x.idProvincia.substr(0, 2) === departamento)
        let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idProvincia}">${x.provincia}</option>`).join('');
        options = `<option value="0">-Seleccione una provincia-</option>${options}`;
        $('#cbo-provincia').html(options);
    }
}
var cambiarProvincia = () => {
    let provincia = $('#cbo-provincia').val()
    if (validarCombo(provincia)) {
        $('#cbo-distrito').html(`<option value="0">-Seleccione un distrito-</option>`);
    } else {
        const data = arrDistrito.filter(x => x.idDistrito.substr(0, 4) === provincia)
        let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idDistrito}">${x.distrito}</option>`).join('');
        options = `<option value="0">-Seleccione un distrito-</option>${options}`;
        $('#cbo-distrito').html(options);
    }
}
/* ================================================
 * FIN VENTOS CHANGE
 * ================================================
 */

/* ================================================
 * INICIO VALIDAR Y GRABAR DATOS
 * ================================================
 */

var grabar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];
    let idEmpresaIndustria = $('#identificador-parent').val()
    let direccion = $("#txt-direccion").val().trim()
    let idCiuu = $("#cbo-ciuu").val()
    let telefono = $('#txt-telefono').val().trim()
    let latitud = $('#txt-latitud').val().trim()
    let longitud = $('#txt-longitud').val().trim()
    let idDepartamento = $("#cbo-departamento").val()
    let idProvincia = $("#cbo-provincia").val()
    let idDistrito = $("#cbo-distrito").val()
    let idEstado = $("#cbo-estado").val()

    if (idEmpresaIndustria == 0) arr.push("El identificador de la empresa es incorrecto")
    if (validarEspaciosBlanco(direccion)) arr.push("Debe ingresar la dirección");
    if (validarCombo(idCiuu)) arr.push("Debe seleccionar un CIUU");
    if (validarEspaciosBlanco(telefono)) arr.push("Debe ingresar el teléfono");
    if (validarEspaciosBlanco(latitud)) arr.push("Debe ingresar la latitud");
    if (validarEspaciosBlanco(longitud)) arr.push("Debe ingresar la longitud");
    if (validarCombo(idDepartamento)) arr.push("Debe seleccionar un departamento");
    if (validarCombo(idProvincia)) arr.push("Debe seleccionar una provincia");
    if (validarCombo(idDistrito)) arr.push("Debe seleccionar un distrito");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error), 'registro');
        return;
    }

    let idPlantaEmpresa = $('#frm').data('id')
    idPlantaEmpresa = idPlantaEmpresa == null ? -1 : idPlantaEmpresa
    

    let url = `${baseUrl}PlantaEmpresa/grabarPlantaEmpresa`;
    let data = { idPlantaEmpresa, idEmpresaIndustria, direccion, idCiuu, telefono, latitud, longitud, idDepartamento, idProvincia, idDistrito, idEstado, idUsuarioCreacion: idUsuarioLogin };
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
 * FIN VALIDAR Y GRABAR DATOS
 * ================================================
 */

/* ================================================
 * INICIO CONSULTAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatosIniciales = () => {
    let id = $('#identificador').val()
    if (id > 0) {
        let url = `${baseUrl}PlantaEmpresa/obtenerPlantaEmpresa?idPlantaEmpresa=${id}`;
        fetch(url)
        .then(r => r.json())
        .then(j => {
            if (j.success) {
                cargarDatos(j.object)
            } else {
                $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la planta. Por favor, puede volver a recargar la página.'), 'carga de datos'))
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
    $('#frm').data('id', data.idPlantaEmpresa);
    $("#cbo-ciuu").val(data.idCiuu)
    $("#cbo-departamento").val(data.idDepartamento)
    cambiarDepartamento()
    $("#cbo-provincia").val(data.idProvincia)
    cambiarProvincia()
    $("#cbo-distrito").val(data.idDistrito)
    $("#txt-direccion").val(data.direccion)
    $('#txt-telefono').val(data.telefono)
    $("#txt-latitud").val(data.latitud)
    $("#txt-longitud").val(data.longitud)
    $('#cbo-estado').val(data.idEstado)
}

/* ================================================
 * FIN CARGAR DATOS ENTIDAD
 * ================================================
 */