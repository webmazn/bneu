$(document).ready(() => {
    $('#btn-grabar').on('click', (e) => grabar())
    $('#cbo-departamento').on('change', (e) => cambiarDepartamento())
    $('#cbo-provincia').on('change', (e) => cambiarProvincia())
    $('#fle-requisito-01').on('change', (e) => fileChange(e))
    $('#cbo-estado').val('1')
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var arrProvincia = []
var arrDistrito = []

var cargarDesplegables = () => {
    /*let urlGiro = `${baseUrl}Giro/obtenerListaGiro`;
    let urlCiuu = `${baseUrl}Ciuu/obtenerListaCiuu`;
    let urlDepartamento = `${baseUrl}Departamento/obtenerListaDepartamento`;
    let urlProvincia = `${baseUrl}Provincia/obtenerListaProvincia`;
    let urlDistrito = `${baseUrl}Distrito/obtenerListaDistrito`;
    let urlZona = `${baseUrl}Zona/obtenerListaZona`
    let urlEmpresaGas = `${baseUrl}EmpresaGas/obtenerListaEmpresaGas`
    let urlEmpresaLuz = `${baseUrl}EmpresaLuz/obtenerListaEmpresaLuz`
    Promise.all([
        fetch(urlGiro),
        fetch(urlCiuu),
        fetch(urlDepartamento),
        fetch(urlProvincia),
        fetch(urlDistrito),
        fetch(urlZona),
        fetch(urlEmpresaGas),
        fetch(urlEmpresaLuz)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jGiro = responseAll[0]
        jCiuu = responseAll[1]
        jDepartamento = responseAll[2]
        jProvincia = responseAll[3]
        jDistrito = responseAll[4]
        jZona = responseAll[5]
        jEmpresaGas = responseAll[6]
        jEmpresaLuz = responseAll[7]
        if (jGiro.success) cargarGiro(jGiro.object)
        if (jCiuu.success) cargarCiuu(jCiuu.object)
        if (jDepartamento.success) cargarDepartamento(jDepartamento.object)
        if (jProvincia.success) cargarProvincia(jProvincia.object)
        if (jDistrito.success) cargarDistrito(jDistrito.object)
        if (jZona.success) cargarZona(jZona.object)
        if (jEmpresaGas.success) cargarEmpresaGas(jEmpresaGas.object)
        if (jEmpresaLuz.success) cargarEmpresaLuz(jEmpresaLuz.object)
        cargarDatosIniciales()
    });*/

    cargarGiro(listaGiro)
    cargarCiuu(listaCiuu)
    cargarDepartamento(listaDepartamento)
    cargarProvincia(listaProvincia)
    cargarDistrito(listaDistrito)
    cargarZona(listaZona)
    cargarEmpresaGas(listaEmpresaGas)
    cargarEmpresaLuz(listaEmpresaLuz)
    cargarDatosIniciales()
}

var cargarCiuu = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idCiuu}">${x.ciuu}</option>`).join('');
    options = `<option value="0">-Seleccione un CIUU-</option>${options}`;
    $('#cbo-ciuu').html(options);
}

var cargarGiro = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idGiro}">${x.giro}</option>`).join('');
    options = `<option value="0">-Seleccione un giro del negocio-</option>${options}`;
    $('#cbo-giro').html(options);
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

var cargarZona = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idZona}">${x.zona}</option>`).join('');
    options = `<option value="0">-Seleccione una zona-</option>${options}`;
    $('#cbo-zona').html(options);
}

var cargarEmpresaGas = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idEmpresaGas}">${x.empresaGas}</option>`).join('');
    options = `<option value="0">-Seleccione una empresa de gas-</option>${options}`;
    $('#cbo-empresa-gas').html(options);
}

var cargarEmpresaLuz = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idEmpresaLuz}">${x.empresaLuz}</option>`).join('');
    options = `<option value="0">-Seleccione una empresa de luz-</option>${options}`;
    $('#cbo-empresa-luz').html(options);
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
    let denominacion = $("#txt-denominacion").val().trim()
    let direccion = $("#txt-direccion").val().trim()
    let idGiro = $("#cbo-giro").val()
    let idCiuu = $("#cbo-ciuu").val()
    let telefono = $('#txt-telefono').val().trim()
    let latitud = $('#txt-latitud').val().trim()
    let longitud = $('#txt-longitud').val().trim()
    let idZona = $("#cbo-zona").val()
    let idDepartamento = $("#cbo-departamento").val()
    let idProvincia = $("#cbo-provincia").val()
    let idDistrito = $("#cbo-distrito").val()
    let idEmpresaGas = $('#cbo-empresa-gas').val()
    let numeroSuministroGas = $('#txt-suministro-gas').val().trim()
    let idEmpresaLuz = $('#cbo-empresa-luz').val()
    let numeroSuministroAlumbrado = $('#txt-suministro-luz').val()
    let idEstado = $("#cbo-estado").val()
    let archivoContenido = $('#fle-requisito-01').data('file')

    if (idEmpresaIndustria == 0) arr.push("El identificador de la empresa es incorrecto")
    if (validarEspaciosBlanco(denominacion)) arr.push("Debe ingresar una denominación")
    if (validarEspaciosBlanco(direccion)) arr.push("Debe ingresar la dirección");
    if (validarCombo(idGiro)) arr.push("Debe seleccionar un giro");
    if (validarCombo(idCiuu)) arr.push("Debe seleccionar un CIUU");
    if (validarEspaciosBlanco(telefono)) arr.push("Debe ingresar el teléfono");
    if (validarEspaciosBlanco(latitud)) arr.push("Debe ingresar la latitud");
    if (validarEspaciosBlanco(longitud)) arr.push("Debe ingresar la longitud");
    if (validarCombo(idDepartamento)) arr.push("Debe seleccionar un departamento");
    if (validarCombo(idProvincia)) arr.push("Debe seleccionar una provincia");
    if (validarCombo(idDistrito)) arr.push("Debe seleccionar un distrito");
    if (validarCombo(idZona)) arr.push("Debe seleccionar una zona");
    if (validarCombo(idEmpresaGas)) arr.push("Debe seleccionar una empresa de gas");
    if (validarEspaciosBlanco(numeroSuministroGas)) arr.push("Debe ingresar el número de suministro de gas");
    if (validarCombo(idEmpresaLuz)) arr.push("Debe seleccionar una empresa de luz");
    if (validarEspaciosBlanco(numeroSuministroAlumbrado)) arr.push("Debe ingresar el número de suministro de luz");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");
    if (archivoContenido == undefined) arr.push('Debe subir el documento solicitud de generación de usuario')

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'registro'));
        return;
    }

    let idPlantaEmpresa = $('#frm').data('id')
    idPlantaEmpresa = idPlantaEmpresa == null ? -1 : idPlantaEmpresa

    let archivoNuevo = $('#fle-requisito-01').data('new');
    archivoContenido = archivoNuevo ? archivoContenido : null

    let url = `${baseUrl}PlantaEmpresa/grabarPlanta`;
    let data = {
        idPlantaEmpresa, idEmpresaIndustria, denominacion, direccion, idGiro, idCiuu, telefono, latitud, longitud, idDepartamento, idProvincia, idDistrito, nombreArchivo, nombreArchivoGenerado,
        idZona, idEmpresaGas, numeroSuministroGas, idEmpresaLuz, numeroSuministroAlumbrado, archivoNuevo, archivoContenido, idEstado, idUsuarioCreacion: idUsuarioLogin
    };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-grabar').hide()
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo. Utilice el buscador para encontrar su nuevo registro.')))
            setTimeout(function () {
                location.href = `${baseUrl}PlantaEmpresa/Index/${$(`#identificador-parent`).val()}`
            }, 3500)
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
        }        
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
    /*let id = $('#identificador').val()
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
    }*/
    cargarDatos(planta)
}

/* ================================================
 * FIN CONSULTAR DATOS ENTIDAD
 * ================================================
 */

/* ================================================
 * INICIO CARGAR DATOS ENTIDAD
 * ================================================
 */

var nombreArchivoGenerado = ''
var cargarDatos = (data) => {
    if (data == null) return
    $('#frm').data('id', data.idPlantaEmpresa);
    $("#cbo-giro").val(data.idGiro)
    $("#cbo-ciuu").val(data.idCiuu)
    $("#cbo-departamento").val(data.idDepartamento)
    cambiarDepartamento()
    $("#cbo-provincia").val(data.idProvincia)
    cambiarProvincia()
    $("#cbo-distrito").val(data.idDistrito)
    $("#cbo-zona").val(data.idZona)
    $("#txt-denominacion").val(data.denominacion)
    $("#txt-direccion").val(data.direccion)
    $('#txt-telefono').val(data.telefono)
    $("#txt-latitud").val(data.latitud)
    $("#txt-longitud").val(data.longitud)
    $('#cbo-empresa-gas').val(data.idEmpresaGas)
    $('#txt-suministro-gas').val(data.numeroSuministroGas)
    $('#cbo-empresa-luz').val(data.idEmpresaLuz)
    $('#txt-suministro-luz').val(data.numeroSuministroAlumbrado)
    $('#txt-requisito-01').val(data.nombreArchivo)
    nombreArchivo = data.nombreArchivo
    nombreArchivoGenerado = data.nombreArchivoGenerado
    $('#fle-requisito-01').data('file', data.archivoContenido);
    $('#fle-requisito-01').data('new', false);
    $('#cbo-estado').val(data.idEstado)
}

/* ================================================
 * FIN CARGAR DATOS ENTIDAD
 * ================================================
 */

var nombreArchivo
var fileChange = (e) => {
    $('.seccion-mensaje').html('');
    let elFile = $(e.currentTarget);
    var fileContent = e.currentTarget.files[0];

    if (!fileContent) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        return
    }

    switch (fileContent.name.substring(fileContent.name.lastIndexOf('.') + 1).toLowerCase()) {
        case 'pdf': case 'doc': case 'docx': break;
        default:
            elFile.val('')
            elFile.removeData('file')
            elFile.removeData('new')
            $('#txt-requisito-01').val('')
            $('.seccion-mensaje').html(messageError(messageStringGeneric('El archivo tiene una extensión no permitida'), 'carga de archivo'))            
            return
    }

    if (fileContent.size > 4194304) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        $('#txt-requisito-01').val('')
        $('.seccion-mensaje').html(messageError(messageStringGeneric('El archivo debe tener un peso máximo de 4MB'), 'carga de archivo'))
        return
    }

    if (e.currentTarget.files.length == 0) {
        $(e.currentTarget).removeData('file')
        $(e.currentTarget).removeData('new')
        return
    }

    let reader = new FileReader();
    reader.onload = function (e) {
        let base64 = e.currentTarget.result.split(',')[1];
        nombreArchivo = fileContent.name;
        $('#txt-requisito-01').val(fileContent.name)
        elFile.data('file', base64);
        elFile.data('new', true);
    }
    reader.readAsDataURL(e.currentTarget.files[0]);
}