$(document).ready(() => {
    $('#btn-buscar').on('click', (e) => filtroGeneral(e));
    $('#btn-buscar-avanzado').on('click', (e) => filtroAvanzado(e));
    //$('#btn-exportar').on('click', (e) => exportar(e));
    $('.ir-pagina').on('change', (e) => cambiarPaginaRegistros());
    $('#number-registers').on('change', (e) => cambiarPaginaRegistros());
    cargarDatosTabla(listaCampana)
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
    let buscar = $('#txt-buscar').val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { idSubSector, buscar, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}Inicio/filtroGeneralCampanaSubSector?${queryParams}`;
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

var filtroAvanzado = (e) => {
    e.preventDefault()
    bFiltroGeneral = false
    let denominacion = $('#txt-denominacion').val();
    let ruc = $('#ruc').val();
    let empresa = $('#empresa').val();
    let fechaInicio = $("#txt-fecha-inicio").val();
    let fechaFin = $("#txt-fecha-fin").val();
    //let estado = $("#cbo-estado").val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { idSubSector, denominacion, ruc, empresa, fechaInicio, fechaFin, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}Inicio/filtroAvanzadoCampanaSubSector?${queryParams}`;
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

        tabla.find('.btn-edit').each(x => {
            let elementButton = tabla.find('.btn-edit')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                actualizar(e.currentTarget);
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
            let colNro = `<td class="text-center" data-encabezado="Item" scope="row">${(pagina - 1) * registros + (i + 1)}</td>`;
            let colCodigo = `<td class="text-center" data-encabezado="Código">ENC${pad(x.idCampana, 4)}</td>`;
            let colFechaRegistro = `<td class="text-center" data-encabezado="Fecha registro">${x.txtFechaCreacion}</td>`;
            let colDenominacion = `<td data-encabezado="Denominación">${x.denominacion}</td>`;
            let colSubSector = `<td data-encabezado="Sub sector">${x.subSector.subSector}</td>`;
            let colEstado = `<td data-encabezado="Estado"><span>${x.etapa.etapa}</span></td>`;
            let btnReporte = `<a class="btn btn-sm btn-primary btn-table" data-id="${x.idCampana}" href="${baseUrl}Inicio/Estadistica/${x.idCampana}/${idSubSector}" data-toggle="tooltip" data-placement="top" title="Ver reporte"><i class="fa fa-chart-pie"></i></a>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnReporte}</td>`;
            let row = `<tr>${colNro}${colCodigo}${colDenominacion}${colSubSector}${colFechaRegistro}${colEstado}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

/* ================================================
 * FIN RENDERIZAR DATOS TABLA - BUSQUEDA
 * ================================================
 */