$(document).ready(() => {
    $('#btn-buscar').on('click', (e) => filtroGeneral(e));
    $('#btn-buscar-avanzado').on('click', (e) => filtroAvanzado(e));
    $('#btn-exportar').on('click', (e) => exportar(e));
    $('.ir-pagina').on('change', (e) => cambiarPaginaRegistros());
    $('#number-registers').on('change', (e) => cambiarPaginaRegistros());
    $('#eliminacionRow').on('click', (e) => deshabilitarRegistro())
    //cargarDesplegables();
    //$('#btn-buscar')[0].click();
    cargarDatosTabla(listaTablaMaestra)
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
    let buscar = $('#txt-buscar').val()
    let registros = $('#number-registers').val()
    let pagina = $('.ir-pagina').val()
    let columna = $("#column").val()
    let orden = $("#order").val()
    let params = { buscar, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}TablaMaestra/filtroGeneral?${queryParams}`;
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
    let subtitulo = $('#txt-titulo-pricipal').val();
    let fechaInicio = $('#txt-fecha-inicio').val();
    let fechaFin = $('#txt-fecha-fin').val();
    let usuario = $('#usuario').val();
    let estado = $("#cbo-estado").val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { subtitulo, fechaInicio, fechaFin, usuario, estado, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}TablaMaestra/filtroAvanzado?${queryParams}`;
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
            let colNro = `<td class="text-center" data-encabezado="Item" scope="row">${(pagina - 1) * registros + (i + 1)}</td>`;
            let colCodigo = `<td class="text-center" data-encabezado="Código">TMA${pad(x.idTablaMaestra, 4)}</td>`;
            //let colTituloPrincipal = `<td data-encabezado="Título principal">${x.tituloPrincipal}</td>`;
            let colSubtitulo = `<td data-encabezado="Sub título">${x.subtitulo}</td>`
            let colUsuario = `<td class="text-center" data-encabezado="Usuario registro">${x.usuarioRegistro.nombres}</td>`;
            let colFechaRegistro = `<td class="text-center" data-encabezado="Fecha registro">${x.txtFechaCreacion}</td>`;
            let colEstado = `<td data-encabezado="Estado"><span>${x.idEstado == '1' ? 'Habilitado' : 'Deshabilitado'}</span></td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete mx-1" data-id="${x.idTablaMaestra}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit mx-1" data-id="${x.idTablaMaestra}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colNro}${colCodigo}${colSubtitulo}${colUsuario}${colFechaRegistro}${colEstado}${colOptions}</tr>`;
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
 * INICIO EXPORTAR GENERAL | AVANZADO
 * ================================================
 */

var exportar = () => {
    if (bFiltroGeneral) exportarGeneral()
    else exportarAvanzado()
}

var exportarGeneral = () => {
    let buscar = $('#txt-buscar').val()
    let columna = $("#column").val()
    let orden = $("#order").val()
    let params = { buscar, columna, orden }
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')
    let url = `${baseUrl}TablaMaestra/exportarGeneral?${queryParams}`
    location.href = url
}

var exportarAvanzado = () => {
    let subtitulo = $('#txt-titulo-pricipal').val();
    let fechaInicio = $('#txt-fecha-inicio').val();
    let fechaFin = $('#txt-fecha-fin').val();
    let usuario = $('#usuario').val();
    let estado = $("#cbo-estado").val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { subtitulo, fechaInicio, fechaFin, usuario, estado, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');
    let url = `${baseUrl}TablaMaestra/exportarAvanzado?${queryParams}`
    location.href = url;
}

/* ================================================
 * FIN EXPORTAR GENERAL | AVANZADO
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR
 * ================================================
 */

var actualizar = (obj) => {
    let id = $(obj).data('id')
    location.href = `${baseUrl}TablaMaestra/NuevaTablaMaestra/${id}`
}

/* ================================================
 * FIN ACTUALIZAR
 * ================================================
 */

/* ================================================
 * INICIO ELIMINAR
 * ================================================
 */
var idEliminar = 0
var eliminar = (obj) => {
    idEliminar = $(obj).data('id')
    $('#modalConfirmacion').modal('show')
}

var deshabilitarRegistro = () => {
    let url = `${baseUrl}TablaMaestra/eliminar?idTablaMaestra=${idEliminar}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-buscar')[0].click();
            $('#modalConfirmacion').modal('hide')
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}
/* ================================================
 * FIN ELIMINAR
 * ================================================
 */