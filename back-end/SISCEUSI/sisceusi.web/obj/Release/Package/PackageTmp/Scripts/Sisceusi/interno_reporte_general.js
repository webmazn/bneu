$(document).ready(() => {
    $('#btn-reporte').on('click', (e) => generarReporte())
    $('#cbo-campana').on('change', (e) => cambiarCampana())
    $('#btn-excel').on('click', (e) => exportarGeneral())
    cargarDatos()
})

var cargarDatos = () => {
    armarComboCampana(listaCampana)
    armarHeader()
}

var armarComboCampana = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idCampana}">${x.denominacion}</option>`).join('');
    options = `<option value="0">-Seleccione una campaña-</option>${options}`;
    $('#cbo-campana').html(options)
}

var armarHeader = () => {
    let headPrincipal = `<tr class="bg-info">` +
                            `<th class ="text-white border-right" colspan="5">` +
                                `<div class ="d-flex justify-content-center align-items-center"><span class ="d-flex justify-content-center align-items-center"><i class ="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CAMPAÑA</span></span></div>` +
                            `</th>` +
                            `<th class="text-white border-right" colspan="10">` +
                                `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center"><i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>EMPRESA</span></span></div>` +
                            `</th>` +
                            `<th class="text-white border-right" colspan="13">` +
                                `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center"><i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>PLANTA</span></span></div>` +
                            `</th>` +
                            `<th class="text-white border-right" colspan="4">` +
                                `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center"><i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>USUARIO RESPONDE</span></span></div>` +
                            `</th>` +
                            `<th class="text-white border-right" colspan="4">` +
                                `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center"><i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>REVISOR</span></span></div>` +
                            `</th>` +
                        `</tr>`

    let headSecundario = `<tr class="bg-azul text-white">` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CÓDIGO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DENOMINACIÓN</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>SUB SECTOR</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>FECHA INICIO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top border-right" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>FECHA FIN</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>RAZÓN SOCIAL</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>NOMBRE COMERCIAL</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>RUC</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>GIRO DEL NEGOCIO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>GRUPO EMPRESARIAL</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CIUU</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CORREO EMPRESARIAL</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DIRECCIÓN FISCAL</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>REPRESENTANTE LEGAL</span></span></div>` +
                            `</th>` +
                            `<th class="v-top border-right" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DNI</span></span></div>` +
                            `</th>` +

                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DENOMINACIÓN</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>GIRO DEL NEGOCIO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CIUU</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DEPARTAMENTO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>PROVINCIA</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DISTRITO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>ZONA</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DIRECCIÓN</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>TELÉFONO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>EMPRESA GAS</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>NRO. SUMINISTRO GAS</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>EMPRESA DE LUZ</span></span></div>` +
                            `</th>` +
                            `<th class="v-top border-right" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>NRO. SUMINISTRO LUZ</span></span></div>` +
                            `</th>` +
                            
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>NOMBRES</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DNI</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CORREO ELECTRÓNICO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top border-right" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>TELÉFONO</span></span></div>` +
                            `</th>` +

                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>NOMBRES</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>DNI</span></span></div>` +
                            `</th>` +
                            `<th class="v-top" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>CORREO ELECTRÓNICO</span></span></div>` +
                            `</th>` +
                            `<th class="v-top border-right" scope="col">` +
                                `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column text-center"><i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i><span>TELÉFONO</span></span></div>` +
                            `</th>` +
                          `</tr>`

    $('.tabla-principal').find('thead').html(`${headPrincipal}${headSecundario}`)
}

var idCampana = 0
var generarReporte = () => {
    idCampana = $('#cbo-campana').val()
    if (idCampana == 0) {

    } else {
        consultarDatosCampana(idCampana)
    }    
}

var cambiarCampana = () => {
    let id = $('#cbo-campana').val()
    let arr = arrListaCampanaTablaMaestra.filter(x => x.idCampana == id)
    //armarComboTablaMaestra(arr)
}

var arrListaCampanaTablaMaestra = []
var arrListaReporte = []
var arrListaCampanaEncuesta = []
var consultarDatosCampana = (idCampana) => {
    let url = `${baseUrl}Interno/DatosCampana?idCampana=${idCampana}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            arrListaCampanaTablaMaestra = j.listaCampanaTablaMaestra
            arrListaCampanaEncuesta = j.listaCampanaEncuesta
            arrListaReporte = j.listaReporte
            armarComboTablaMaestra(j.listaCampanaTablaMaestra)
            armarBody(j.listaReporte)
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var armarComboTablaMaestra = (data) => {    
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idTablaMaestra}">${x.subtitulo}</option>`).join('');
    options = `<option value="0">-Seleccione una tabla maestra-</option>${options}`;
    $('#cbo-tabla-maestra').html(options)
}

var armarBody = (data) => {
    let content = data.map((x, i) => {
        let colCodigo = `<td class="text-center" data-encabezado="Código" scope="row">ENC${pad(x.idCampana, 4)}</td>`;
        let colCampana = `<td class="text-center" data-encabezado="Campana" scope="row">${x.campana}</td>`;
        let colSubsector = `<td class="text-center" data-encabezado="Sub Sector" scope="row">${x.subsector}</td>`;
        let colFechaInicioEncuesta = `<td class="text-center" data-encabezado="Fecha Inicio Encuesta" scope="row">${x.txtFechaInicioEncuesta}</td>`
        let colFechaFinEncuesta = `<td class="text-center" data-encabezado="Fecha Fin Encuesta" scope="row">${x.txtFechaFinEncuesta}</td>`;
        let colNombreEmrpesa = `<td class="text-center" data-encabezado="Nombre Empresa" scope="row">${x.nombreEmpresa}</td>`;
        let colNombreComercial = `<td class="text-center" data-encabezado="Nombre Comercial" scope="row">${x.nombreComercial}</td>`;
        let colRuc = `<td class="text-center" data-encabezado="Ruc" scope="row">${x.ruc}</td>`;
        let colGiroEmpresa = `<td class="text-center" data-encabezado="Giro Empresa" scope="row">${x.giroEmpresa}</td>`;
        let colGrupoEmpresa = `<td class="text-center" data-encabezado="Grupo Empresa" scope="row">${x.grupoEmpresa}</td>`;
        let colCiuuEmpresa = `<td class="text-center" data-encabezado="Ciuu Empresa" scope="row">${x.ciuuEmpresa}</td>`;
        let colCorreoEmpresarial = `<td class="text-center" data-encabezado="Correo Empresarial" scope="row">${x.correoEmpresarial}</td>`;
        let colDireccionFiscal = `<td class="text-center" data-encabezado="Dirección fiscal" scope="row">${x.direccionFiscal}</td>`;
        let colRepresentanteLegal = `<td class="text-center" data-encabezado="Representante Legal" scope="row">${x.representanteLegal}</td>`;
        let colDniRepresentante = `<td class="text-center" data-encabezado="Dni Representante" scope="row">${x.dniRepresentante}</td>`;
        let colPlanta = `<td class="text-center" data-encabezado="Planta" scope="row">${x.planta}</td>`;
        let colGiroPlanta = `<td class="text-center" data-encabezado="Giro Planta" scope="row">${x.giroPlanta}</td>`;
        let colCiuuPlanta = `<td class="text-center" data-encabezado="Ciuu planta" scope="row">${x.ciuuPlanta}</td>`;
        let colDepartamento = `<td class="text-center" data-encabezado="Departamento" scope="row">${x.departamento}</td>`;
        let colProvincia = `<td class="text-center" data-encabezado="Provincia" scope="row">${x.provincia}</td>`;
        let colDistrito = `<td class="text-center" data-encabezado="Distrito" scope="row">${x.distrito}</td>`;
        let colZona = `<td class="text-center" data-encabezado="Zona" scope="row">${x.zona}</td>`;
        let colDireccion = `<td class="text-center" data-encabezado="Dirección" scope="row">${x.direccion}</td>`;
        let colTelefonoPlanta = `<td class="text-center" data-encabezado="Teléfono Planta" scope="row">${x.telefonoPlanta}</td>`;
        let colEmpresaGas = `<td class="text-center" data-encabezado="Empresa Gas" scope="row">${x.empresaGas}</td>`;
        let colNumeroSuministroGas = `<td class="text-center" data-encabezado="Número Suministro Gas" scope="row">${x.numeroSuministroGas}</td>`;
        let colEmpresaLuz = `<td class="text-center" data-encabezado="Empresa Luz" scope="row">${x.empresaLuz}</td>`;
        let colNumeroSuministroAlumbrado = `<td class="text-center" data-encabezado="Número Suministro Alumbrado" scope="row">${x.numeroSuministroAlumbrado}</td>`;
        let colEncuestado = `<td class="text-center" data-encabezado="Encuestado" scope="row">${x.encuestado}</td>`;
        let colDniEncuestado = `<td class="text-center" data-encabezado="Dni Encuestado" scope="row">${x.dniEncuestado}</td>`;
        let colCorreoEncuestado = `<td class="text-center" data-encabezado="Correo Encuestado" scope="row">${x.correoEncuestado}</td>`;
        let colTelefonoEncuestado = `<td class="text-center" data-encabezado="Teléfono Encuestado" scope="row">${x.telefonoEncuestado}</td>`;
        let colRevisor = `<td class="text-center" data-encabezado="Revisor" scope="row">${x.revisor}</td>`;
        let colDniRevisor = `<td class="text-center" data-encabezado="Dni Revisor" scope="row">${x.dniRevisor}</td>`;
        let colCorreoRevisor = `<td class="text-center" data-encabezado="Correo Revisor" scope="row">${x.correoRevisor}</td>`;
        let colTelefonoRevisor = `<td class="text-center" data-encabezado="Teléfono Revisor" scope="row">${x.telefonoRevisor}</td>`;
        let row = `<tr>${colCodigo}${colCampana}${colSubsector}${colFechaInicioEncuesta}${colFechaFinEncuesta}${colNombreEmrpesa}${colNombreComercial}${colRuc}${colGiroEmpresa}${colGrupoEmpresa}${colCiuuEmpresa}${colCorreoEmpresarial}${colDireccionFiscal}` +
            `${colRepresentanteLegal}${colDniRepresentante}${colPlanta}${colGiroPlanta}${colCiuuPlanta}${colDepartamento}${colProvincia}${colDistrito}${colZona}${colDireccion}${colTelefonoPlanta}${colEmpresaGas}${colNumeroSuministroGas}${colEmpresaLuz}${colNumeroSuministroAlumbrado}` +
            `${colEncuestado}${colDniEncuestado}${colCorreoEncuestado}${colTelefonoEncuestado}${colRevisor}${colDniRevisor}${colCorreoRevisor}${colTelefonoRevisor}</tr>`;
        return row;
    }).join('');
    $('.tabla-principal').find('tbody').html(content)
}

var exportarGeneral = () => {
    let idCampana = $('#cbo-campana').val()
    if (idCampana > 0) {
        //let idTablaMaestra = $('#cbo-tabla-maestra').val()
        let params = { idCampana }
        let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')
        let url = `${baseUrl}Interno/exportarGeneral?${queryParams}`
        location.href = url
    }    
}