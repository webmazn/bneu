$(document).ready(() => {
    $('#btn-grabar').on('click', (e) => grabar())
    $('#cbo-estado').val('1')
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var cargarDesplegables = () => {
    let urlGiro = `${baseUrl}Giro/obtenerListaGiro`;
    let urlGrupoEmpresa = `${baseUrl}GrupoEmpresa/obtenerListaGrupoEmpresa`;
    let urlCiuu = `${baseUrl}Ciuu/obtenerListaCiuu`;
    Promise.all([
        fetch(urlGiro),
        fetch(urlGrupoEmpresa),
        fetch(urlCiuu)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jGiro = responseAll[0]
        jGrupoEmpresa = responseAll[1]
        jCiuu = responseAll[2]        
        if (jGiro.success) cargarGiro(jGiro.object)
        if (jGrupoEmpresa.success) cargarGrupoEmpresa(jGrupoEmpresa.object)
        if (jCiuu.success) cargarCiuu(jCiuu.object)
        cargarDatosIniciales()
    });
}

var cargarGiro = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idGiro}">${x.giro}</option>`).join('');
    options = `<option value="0">-Seleccione un giro del negocio-</option>${options}`;
    $('#cbo-giro').html(options);
}

var cargarGrupoEmpresa = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idGrupoEmpresa}">${x.grupoEmpresa}</option>`).join('');
    options = `<option value="0">-Seleccione un grupo empresarial-</option>${options}`;
    $('#cbo-grupo-empresarial').html(options);
}

var cargarCiuu = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idCiuu}">${x.ciuu}</option>`).join('');
    options = `<option value="0">-Seleccione un CIUU-</option>${options}`;
    $('#cbo-ciuu').html(options);
}

/* ================================================
 * FIN CARGA DESPLEGABLES
 * ================================================
 */

/* ================================================
 * INICIO VALIDAR DATOS
 * ================================================
 */

var grabar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];
    let nombreEmpresa = $("#txt-empresa").val().trim()
    let nombreComercial = $("#txt-nombre-comercial").val().trim()
    let ruc = $('#txt-ruc').val().trim()
    let idGiro = $("#cbo-giro").val()
    let idGrupoEmpresa = $("#cbo-grupo-empresarial").val()
    let idCiuu = $("#cbo-ciuu").val()
    let direccionFiscal = $("#txt-direccion-fiscal").val().trim()
    let correoElectronico = $("#txt-correo-empresa").val().trim()
    let representanteLegal = $('#txt-representante').val().trim()
    let dni = $("#txt-dni-representante").val().trim()
    let idEstado = $("#cbo-estado").val()

    if (validarEspaciosBlanco(nombreEmpresa)) arr.push("Debe ingresar la razón social");
    if (validarEspaciosBlanco(nombreComercial)) arr.push("Debe ingresar el nombre comercial");
    if (validarEspaciosBlanco(ruc)) arr.push("Debe ingresar el Ruc para la validación");
    else if (validarNumerico(ruc)) arr.push("El Ruc debe tener caracteres numéricos");
    else if (validarTamanioRuc(ruc)) arr.push("El Ruc debe tener 11 caracteres");
    else if (validarRuc10(ruc) && validarRuc20(ruc)) arr.push("El Ruc debe empezar con 10 o 20");
    if (validarCombo(idGiro)) arr.push("Debe seleccionar el giro del negocio");
    if (validarCombo(idGrupoEmpresa)) arr.push("Debe seleccionar un grupo empresarial");
    if (validarCombo(idCiuu)) arr.push("Debe seleccionar un CIUU");
    if (validarEspaciosBlanco(direccionFiscal)) arr.push("Debe ingresar la dirección fiscal");
    if (validarEspaciosBlanco(correoElectronico)) arr.push("Debe ingresar un correo electrónico");
    else if (validarCorreoElectronico(correoElectronico)) arr.push("Debe ingresar un correo electrónico válido");
    if (validarEspaciosBlanco(representanteLegal)) arr.push("Debe ingresar los nombres del representante legal");
    if (validarEspaciosBlanco(dni)) arr.push("Debe ingresar el Dni");
    else if (validarNumerico(dni)) arr.push("El Dni debe tener caracteres numéricos");
    else if (validarTamanioDni(dni)) arr.push("El Dni debe tener 8 caracteres");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'registro'));
        return;
    }

    let idEmpresaIndustria = $('#frm').data('id')
    idEmpresaIndustria = idEmpresaIndustria == null ? -1 : idEmpresaIndustria

    validarDatosRegistro(idEmpresaIndustria, ruc)
}

/* ================================================
 * FIN VALIDAR DATOS
 * ================================================
 */

/* ================================================
 * INICIO VALIDAR DATOS CON BD
 * ================================================
 */

var validarDatosRegistro = (id, ruc) => {
    let urlVerificarRucPorIdEmpresa = `${baseUrl}EmpresaIndustria/verificarRucPorIdEmpresa?id=${id}&ruc=${ruc}`;
    Promise.all([
        fetch(urlVerificarRucPorIdEmpresa)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jRuc = responseAll[0]
        if (jRuc.success) {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('El Ruc ya está siendo usado'), 'registro'))
        } else {
            grabarDatos()
        }
    });
}

/* ================================================
 * FIN VALIDAR DATOS CON BD
 * ================================================
 */

/* ================================================
 * INICIO GRABAR DATOS
 * ================================================
 */

var grabarDatos = () => {
    let idEmpresaIndustria = $('#frm').data('id')
    idEmpresaIndustria = idEmpresaIndustria == null ? -1 : idEmpresaIndustria

    let nombreEmpresa = $("#txt-empresa").val().trim()
    let nombreComercial = $("#txt-nombre-comercial").val().trim()
    let ruc = $('#txt-ruc').val().trim()
    let idGiro = $("#cbo-giro").val()
    let idGrupoEmpresa = $("#cbo-grupo-empresarial").val()
    let idCiuu = $("#cbo-ciuu").val()
    let direccionFiscal = $("#txt-direccion-fiscal").val().trim()
    let correoElectronico = $("#txt-correo-empresa").val().trim()
    let representanteLegal = $('#txt-representante').val().trim()
    let dni = $("#txt-dni-representante").val().trim()
    let idEstado = $("#cbo-estado").val()

    let url = `${baseUrl}EmpresaIndustria/grabarEmpresaIndustria`;
    let data = { idEmpresaIndustria, nombreEmpresa, nombreComercial, ruc, idGiro, idGrupoEmpresa, idCiuu, direccionFiscal, correoElectronico, representanteLegal, dni, idEstado, idUsuarioCreacion: idUsuarioLogin };
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
 * FIN GRABAR DATOS
 * ================================================
 */

/* ================================================
 * INICIO CONSULTAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatosIniciales = () => {
    let id = $('#identificador').val()
    if (id > 0) {
        let url = `${baseUrl}EmpresaIndustria/obtenerEmpresaIndustria?idEmpresaIndustria=${id}`;
        fetch(url)
        .then(r => r.json())
        .then(j => {
            if (j.success) {
                cargarDatos(j.object)
            } else {
                $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la empresa. Por favor, puede volver a recargar la página.'), 'carga de datos'))
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
    $('#frm').data('id', data.idEmpresaIndustria);
    $("#txt-empresa").val(data.nombreEmpresa)
    $("#txt-nombre-comercial").val(data.nombreComercial)
    $('#txt-ruc').val(data.ruc)
    $("#cbo-giro").val(data.idGiro)
    $("#cbo-grupo-empresarial").val(data.idGrupoEmpresa)
    $("#cbo-ciuu").val(data.idCiuu)
    $("#txt-direccion-fiscal").val(data.direccionFiscal)
    $("#txt-correo-empresa").val(data.correoElectronico)
    $('#txt-representante').val(data.representanteLegal)
    $("#txt-dni-representante").val(data.dni)
    $("#cbo-estado").val(data.idEstado)
}

/* ================================================
 * FIN CARGAR DATOS ENTIDAD
 * ================================================
 */