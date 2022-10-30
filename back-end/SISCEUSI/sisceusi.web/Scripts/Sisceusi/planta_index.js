$(document).ready(() => {
    $('#btn-buscar').on('click', (e) => filtroGeneral(e));
    $('#btn-buscar-avanzado').on('click', (e) => filtroAvanzado(e));
    $('#btn-exportar').on('click', (e) => exportar(e));
    $('.ir-pagina').on('change', (e) => cambiarPaginaRegistros());
    $('#number-registers').on('change', (e) => cambiarPaginaRegistros());
    $('#cbo-departamento').on('change', (e) => cambiarDepartamento())
    $('#cbo-provincia').on('change', (e) => cambiarProvincia())
    $('#eliminacionRow').on('click', (e) => deshabilitarRegistro())
    cargarDesplegables();
    //$('#btn-buscar')[0].click();
    cargarDatosTabla(listaPlanta)
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
    let idEmpresa = $('#identificador').val()
    let buscar = $('#txt-buscar').val()
    let registros = $('#number-registers').val()
    let pagina = $('.ir-pagina').val()
    let columna = $("#column").val()
    let orden = $("#order").val()
    let params = { idEmpresa, buscar, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}PlantaEmpresa/filtroGeneral?${queryParams}`;
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
    let idEmpresa = $('#identificador').val()
    let direccion = $('#txt-direccion').val();
    let idCiuu = $('#cbo-ciuu').val();
    let telefono = $('#txt-telefono').val();
    let idDepartamento = $('#cbo-departamento').val();
    let idProvincia = $("#cbo-provincia").val();
    let idDistrito = $("#cbo-distrito").val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { idEmpresa, direccion, idCiuu, telefono, idDepartamento, idProvincia, idDistrito, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}PlantaEmpresa/filtroAvanzado?${queryParams}`;
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
            let colDireccion = `<td data-encabezado="Dirección">${x.direccion == null ? "" : x.direccion}</td>`;
            let colCiuu = `<td class="text-center" data-encabezado="CIUU">${x.ciuu.ciuu == null ? "" : x.ciuu.ciuu}</td>`;
            let colTelefono = `<td class="text-center" data-encabezado="Teléfono">${x.telefono == null ? "" : x.telefono}</td>`
            let colUbicacion = `<td class="text-center" data-encabezado="Ubicación">${x.latitud == null ? "" : x.latitud} <br> ${x.longitud == null ? "" : x.longitud}</td>`;
            let colDepartamento = `<td data-encabezado="Departamento">${x.departamento.departamento}</td>`;
            let colProvincia = `<td data-encabezado="Provincia">${x.provincia.provincia}</td>`;
            let colDistrito = `<td data-encabezado="Distrito">${x.distrito.distrito}</td>`;
            let colEstado = `<td data-encabezado="Estado"><span>${x.idEstado == '1' ? 'Habilitado' : 'Deshabilitado'}</span></td>`;
            let btnUsuarios = `<a class="btn btn-sm btn-warning text-white btn-table mx-1" href="${baseUrl}UsuarioPlanta/index/${x.idPlantaEmpresa}" data-toggle="tooltip" data-placement="top" title="Mantenimiento de usuarios"><i class="fa fa-user"></i></a>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete mx-1" data-id="${x.idPlantaEmpresa}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit mx-1" data-id="${x.idPlantaEmpresa}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnUsuarios}${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colNro}${colDireccion}${colCiuu}${colTelefono}${colUbicacion}${colDepartamento}${colProvincia}${colDistrito}${colEstado}${colOptions}</tr>`;
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
    let idEmpresa = $('#identificador').val()
    let buscar = $('#txt-buscar').val()
    let columna = $("#column").val()
    let orden = $("#order").val()
    let params = { idEmpresa, buscar, columna, orden }
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')
    let url = `${baseUrl}PlantaEmpresa/exportarGeneral?${queryParams}`
    location.href = url
}

var exportarAvanzado = () => {
    let idEmpresa = $('#identificador').val()
    let direccion = $('#txt-direccion').val();
    let idCiuu = $('#cbo-ciuu').val();
    let telefono = $('#txt-telefono').val();
    let idDepartamento = $('#cbo-departamento').val();
    let idProvincia = $("#cbo-provincia").val();
    let idDistrito = $("#cbo-distrito").val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { idEmpresa, direccion, idCiuu, telefono, idDepartamento, idProvincia, idDistrito, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')
    let url = `${baseUrl}PlantaEmpresa/exportarAvanzado?${queryParams}`
    location.href = url;
}

/* ================================================
 * FIN EXPORTAR GENERAL | AVANZADO
 * ================================================
 */

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var arrProvincia = []
var arrDistrito = []

var cargarDesplegables = () => {
    cargarParametros(listaCiuu, '#cbo-ciuu', 'Seleccione un CIUU')
    cargarDepartamento(listaDepartamento)
    cargarProvincia(listaProvincia)
    cargarDistrito(listaDistrito)
}

var cargarParametros = (data, idHtml, textoOpcion) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idParametro}">${x.parametro}</option>`).join('');
    options = `<option value="0">-${textoOpcion}-</option>${options}`;
    $(idHtml).html(options);
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
 * INICIO ACTUALIZAR EMPRESA
 * ================================================
 */

var actualizar = (obj) => {
    let idEmpresa = $('#identificador').val()
    let id = $(obj).data('id')
    location.href = `${baseUrl}PlantaEmpresa/NuevaPlanta/${idEmpresa}/${id}`
}

/* ================================================
 * FIN ACTUALIZAR EMPRESA
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
    let url = `${baseUrl}PlantaEmpresa/eliminar?idPlantaEmpresa=${idEliminar}`;
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