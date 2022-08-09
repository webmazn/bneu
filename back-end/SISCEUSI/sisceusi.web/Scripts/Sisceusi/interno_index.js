$(document).ready(() => {
    $('#btn-buscar').on('click', (e) => filtroGeneral(e));
    $('#btn-buscar-avanzado').on('click', (e) => filtroAvanzado(e));
    $('#btn-exportar').on('click', (e) => exportar(e));
    $('.ir-pagina').on('change', (e) => cambiarPaginaRegistros());
    $('#number-registers').on('change', (e) => cambiarPaginaRegistros());
    $('#eliminacionRow').on('click', (e) => deshabilitarRegistro())
    $('#btn-buscar')[0].click();
});

/* ================================================
 * INICIO ORDENAR COLUMA - PAGINA
 * ================================================
 */

/*
 * si es filtro general
 * true = general, false = avanzado
 */
var bFiltroGeneral = true

var cambiarPagina = (valor) => {
    cambiarPaginaGrilla(valor)
    if (bFiltroGeneral) $('#btn-buscar')[0].click()
    else $('#btn-buscar-avanzado')[0].click()
}

$(".column-filter").click(function (e) {
    let id = e.target.id;
    ordenar(id)
    if (bFiltroGeneral) $('#btn-buscar')[0].click()
    else $('#btn-buscar-avanzado')[0].click()
})

var cambiarPaginaRegistros = () => {
    if (bFiltroGeneral) $('#btn-buscar')[0].click()
    else $('#btn-buscar-avanzado')[0].click()
}


/* ================================================
 * FIN ORDENAR COLUMA - PAGINA
 * ================================================
 */

/* ================================================
 * INICIO BUSQUEDA GENERAL
 * ================================================
 */

var filtroGeneral = (e) => {
    e.preventDefault()
    bFiltroGeneral = true
    let idUsuario = idUsuarioLogin
    let buscar = $('#txt-buscar').val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { idUsuario, buscar, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}Interno/filtroGeneral?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTabla)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
};

/* ================================================
 * FIN BUSQUEDA GENERAL
 * ================================================
 */

/* ================================================
 * INICIO BUSQUEDA AVANZADO
 * ================================================
 */
/*
var filtroAvanzado = (e) => {
    e.preventDefault()
    bFiltroGeneral = false
    let ruc = $('#ruc').val();
    let empresa = $('#empresa').val();
    let representanteLegal = $('#usuario').val();
    let correoElectronico = $('#email').val();
    let fechaInicio = $("#txt-fecha-inicio").val();
    let fechaFin = $("#txt-fecha-fin").val();
    let estado = $("#cbo-estado").val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { ruc, empresa, representanteLegal, correoElectronico, fechaInicio, fechaFin, estado, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}EmpresaIndustria/filtroAvanzado?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTabla)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
}
*/
/* ================================================
 * FIN BUSQUEDA AVANZADO
 * ================================================
 */

/* ================================================
 * INICIO CARGAR DATOS TABLA - BUSQUEDA
 * ================================================
 */

var cargarDatosTabla = (j) => {
    let tabla = $('.tabla-principal').find('table');
    tabla.find('tbody').html('');
    $('#viewPagination').attr('style', 'display: none !important');
    if (j.success) {
        let rs = j.object[0];
        if (rs.totalRegistros == 0) { $('#viewPagination').hide(); $('#view-page-result').hide(); }
        else { $('#view-page-result').show(); $('#viewPagination').show(); }
        $('.inicio-registros').text(rs.registros == 0 ? 'No se encontraron resultados' : (rs.pagina - 1) * rs.registros + 1);
        $('.fin-registros').text(rs.totalRegistros < rs.pagina * rs.registros ? rs.totalRegistros : rs.pagina * rs.registros);
        $('.total-registros').text(rs.totalRegistros);
        $('.pagina').text(rs.pagina);
        $('.ir-pagina').val(rs.pagina);
        $('.ir-pagina').attr('max', rs.totalPaginas);
        $('.total-paginas').text(rs.totalPaginas);

        let numberCellHeader = tabla.find('thead tr th').length;
        let content = renderizar(j.object, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

        tabla.find('.btn-encuesta').each(x => {
            let elementButton = tabla.find('.btn-encuesta')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                iniciarEncuesta(e.currentTarget);
            });
        });
        tabla.find('.btn-delete').each(x => {
            let elementButton = tabla.find('.btn-delete')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminar(e.currentTarget);
            });
        });
        $('[data-toggle="tooltip"]').tooltip();
    } else {
        console.log('No hay resultados');
        $('#viewPagination').hide(); $('#view-page-result').hide();
        $('.inicio-registros').text('No se encontraron resultados');
    }
}

/* ================================================
 * FIN CARGAR DATOS TABLA - BUSQUEDA
 * ================================================
 */

/* ================================================
 * INICIO RENDERIZAR DATOS TABLA - BUSQUEDA
 * ================================================
 */

var renderizar = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let bloque = x.controlEncuesta.aceptaLLenarEncuesta === '' ? 1 :
                x.controlEncuesta.aceptaLLenarEncuesta === '0' ? 0 : 
                x.controlEncuesta.aceptaFirmarEncuesta === '' ? 2 : 3

            let colNro = `<td class="text-center" data-encabezado="Item" scope="row">${(pagina - 1) * registros + (i + 1)}</td>`;
            let colCodigo = `<td class="text-center" data-encabezado="Código">ENC${pad(x.campana.idCampana, 4)}</td>`;
            let colEmpresa = `<td data-encabezado="Nombre y Apellido">${x.empresa.nombreEmpresa}</td>`;
            let colPlanta = `<td data-encabezado="Tipo usuario"><span>${x.planta.denominacion}</span></td>`
            let colTipoEncuesta = `<td class="text-center" data-encabezado="Fecha registro">${x.tipoEncuesta.tipoEncuesta}</td>`;
            let colCampana = `<td class="text-center" data-encabezado="Fecha registro">${x.campana.denominacion}</td>`;
            let colFecha = `<td class="text-center" data-encabezado="Fecha registro">${x.txtFechaHoraLlenado}</td>`;
            let colEtapa = `<td data-encabezado="Estado"><span>${x.etapa.etapa}</span></td>`;
            let btnDescargar = `<div class="btn btn-sm btn-warning btn-table text-white"><i class="fa fa-download"></i></div>`
            let btnObservar = `<div class="btn btn-sm btn-success btn-table"><i class="fa fa-eye"></i></div>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete" data-id="${0}"><i class="fa fa-trash"></i></div>`;
            let btnEncuesta = `<div class="btn btn-sm btn-info btn-table btn-encuesta" data-id="${x.controlEncuesta.idControlEncuesta}" data-bloque="${bloque}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnDescargar}${btnObservar}${btnEliminar}${btnEncuesta}</td>`;
            let row = `<tr>${colNro}${colCodigo}${colEmpresa}${colPlanta}${colTipoEncuesta}${colCampana}${colFecha}${colEtapa}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

/* ================================================
 * FIN RENDERIZAR DATOS TABLA - BUSQUEDA
 * ================================================
 */

/* ================================================
 * INICIO INICIAR ENCUESTA
 * ================================================
 */

var iniciarEncuesta = (obj) => {
    let id = $(obj).data('id')
    let bloque = $(obj).data('bloque')
    if (bloque == 0) {

    } else if (bloque == 1) {
        location.href = `${baseUrl}Encuesta/Inicio/${id}`
    } else if (bloque == 2) {
        location.href = `${baseUrl}Encuesta/Firma/${id}`
    } else if (bloque == 3) {
        location.href = `${baseUrl}Encuesta/Formulario/${id}`
    }
    
}

/* ================================================
 * FIN INICIAR ENCUESTA
 * ================================================
 */