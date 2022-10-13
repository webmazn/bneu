$(document).ready(() => {
    $('#btn-buscar').on('click', (e) => filtroGeneral(e));
    $('#btn-buscar-avanzado').on('click', (e) => filtroAvanzado(e));
    $('#btn-exportar').on('click', (e) => exportar(e));
    $('.ir-pagina').on('change', (e) => cambiarPaginaRegistros());
    $('#number-registers').on('change', (e) => cambiarPaginaRegistros());
    $('#eliminacionRow').on('click', (e) => deshabilitarRegistro())
    $('#cbo-departamento').on('change', (e) => cambiarDepartamento())
    $('#cbo-provincia').on('change', (e) => cambiarProvincia())
    $('#btn-buscar')[0].click();
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var arrProvincia = []
var arrDistrito = []

var cargarDesplegables = () => {
    cargarRevisor(listaRevisor)
    cargarParametros(listaSubSector, '#cbo-sub-sector', 'Seleccione un sub sector')
    cargarParametros(listaCiuu, '#cbo-ciuu', 'Seleccione una actividad')
    cargarParametros(listaZona, '#cbo-zona', 'Seleccione una zona')
    cargarDepartamento(listaDepartamento)
    cargarProvincia(listaProvincia)
    cargarDistrito(listaDistrito)    
}

var cargarRevisor = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idUsuario}">${x.nombres}</option>`).join('');
    options = `<option value="0" selected>-Filtre y seleccione un supervisor-</option>${options}`;
    let content = `<label class="font-weight-bold" for="cbo-revisor">SUPERVISOR</label>` +
                    `<select class="selectpicker form-control border rounded">` +
                    `${options}` +
                    `</select>` 
    $('.list-revisor').html(content);

    if ($(".selectpicker").length > 0) {
        const e = document.querySelector(".selectpicker");
        document.querySelector(".selectpicker"), new Choices(e, {
            placeholder: !1,
            itemSelectText: "",
            allowHTML: !1
        });
        let t = e.getAttribute("class");
        window.onload = function () {
            e.parentElement.setAttribute("class", t)
        }
    }
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

var filtroAvanzado = (e) => {
    e.preventDefault()
    bFiltroGeneral = false
    let idUsuario = idUsuarioLogin
    let denominacion = $('#txt-denominacion').val().trim() 
    let ruc = idRolLogin == 3 ? '' : $('#ruc').val();
    let empresa = idRolLogin == 3 ? '' : $('#empresa').val();
    let idDepartamento = $('#cbo-departamento').val();
    let idProvincia = $("#cbo-provincia").val();
    let idDistrito = $("#cbo-distrito").val();
    let idZona = $("#cbo-zona").val();
    let idSubSector = $("#cbo-sub-sector").val();
    let idCiuu = $('#cbo-ciuu').val();
    let idRevisor = idRolLogin == 2 ? 0 : $('select.selectpicker').val()
    let idTipoEncuesta = $('#cbo-tipo-encuesta').val();
    let fechaInicio = $("#txt-fecha-inicio").val();
    let fechaFin = $("#txt-fecha-fin").val();
    let estado = $("#cbo-estado").val();
    let registros = $('#number-registers').val();
    let pagina = $('.ir-pagina').val();
    let columna = $("#column").val();
    let orden = $("#order").val();
    let params = { idUsuario, denominacion, ruc, empresa, idDepartamento, idProvincia, idDistrito, idZona, idSubSector, idCiuu, idRevisor, idTipoEncuesta, fechaInicio, fechaFin, estado, registros, pagina, columna, orden };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&');

    let url = `${baseUrl}Interno/filtroAvanzado?${queryParams}`;
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
        tabla.find('.btn-download').each(x => {
            let elementButton = tabla.find('.btn-download')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                descargar(e.currentTarget);
            });
        });
        tabla.find('.btn-observar').each(x => {
            let elementButton = tabla.find('.btn-observar')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                observar(e.currentTarget);
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
            let bloque =
                idRolLogin == 3 && x.controlEncuesta.idFase < 2 ?
                //Encuestado
                x.controlEncuesta.aceptaLLenarEncuesta === '' ? 1 :
                x.controlEncuesta.aceptaLLenarEncuesta === '0' ? 0 : 
                x.controlEncuesta.aceptaFirmarEncuesta === '' ? 2 : 
                x.controlEncuesta.fechaHoraLlenado == null ? 3 : 4
                :
                //Revisor
                4

            let fase = x.controlEncuesta.fase.idFase
            let verEncuesta = x.etapa.idEtapa == 0 || x.etapa.idEtapa == 1 || x.etapa.idEtapa == 3 ? false :
                                idRolLogin == 3 && (fase < 2 || fase == 3) ? true :
                                idRolLogin == 2 && (fase == 2 || fase == 4) ? true : false

            //let verFicha = x.tipoEncuesta.idTipoEncuesta == 2 && x.etapa.idEtapa == 3
            //let verFicha = x.tipoEncuesta.idTipoEncuesta == 2 && ((x.etapa.idEtapa == 3 && fase == 5) || fase == 5)
            let verFicha = x.tipoEncuesta.idTipoEncuesta == 2 && (fase == 2 || fase == 3 || fase == 4 || fase == 5)

            let colNro = `<td class="text-center" data-encabezado="Item" scope="row">${(pagina - 1) * registros + (i + 1)}</td>`;
            let colCodigo = `<td class="text-center" data-encabezado="Código">ENC${pad(x.campana.idCampana, 4)}</td>`;
            let colEmpresa = `<td data-encabezado="Nombre y Apellido">${x.empresa.nombreEmpresa}</td>`;
            let colPlanta = `<td data-encabezado="Tipo usuario"><span>${x.planta.denominacion}</span></td>`
            let colTipoEncuesta = `<td class="text-center" data-encabezado="Fecha registro">${x.tipoEncuesta.tipoEncuesta}</td>`;
            let colCampana = `<td class="text-center" data-encabezado="Fecha registro">${x.campana.denominacion}</td>`;
            let colFecha = `<td class="text-center" data-encabezado="Fecha registro">${x.txtFechaHoraLlenado}</td>`;
            let colEtapa = `<td data-encabezado="Estado"><span>${x.etapa.etapa}</span></td>`;
            let colFase = `<td data-encabezado="Fase Enc."><span>${x.controlEncuesta.fase.fase}</span></td>`;
            //let btnDescargar = `<div class="btn btn-sm btn-warning btn-table text-white"><i class="fa fa-download"></i></div>`
            let btnObservar = `<div class="btn btn-sm btn-success btn-table btn-observar mx-1" data-id="${x.controlEncuesta.idControlEncuesta}"><i class="fa fa-eye"></i></div>`;
            //let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete" data-id="${0}"><i class="fa fa-trash"></i></div>`;
            let btnEncuesta = `<div class="btn btn-sm btn-info btn-table btn-encuesta mx-1" data-id="${x.controlEncuesta.idControlEncuesta}" data-bloque="${bloque}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${verFicha ? btnObservar : ''}${ verEncuesta ? btnEncuesta : ''}</td>`;
            let row = `<tr>${colNro}${colCodigo}${colEmpresa}${colPlanta}${colTipoEncuesta}${colCampana}${colFecha}${colEtapa}${colFase}${colOptions}</tr>`;
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
        //Mostrar mensaje cuando no acepto participar en la encuesta
    } else if (bloque == 1) {
        location.href = `${baseUrl}Encuesta/Inicio/${id}`
    } else if (bloque == 2) {
        location.href = `${baseUrl}Encuesta/Firma/${id}`
    } else if (bloque == 3) {
        location.href = `${baseUrl}Encuesta/Formulario/${id}`
    } else if (bloque == 4) {
        location.href = `${baseUrl}Encuesta/PreguntaEncuesta/${id}`
    }    
}

/* ================================================
 * FIN INICIAR ENCUESTA
 * ================================================
 */

/* ================================================
 * INICIO DESCARGAR
 * ================================================
 */

var idDescargar
var descargar = (obj) => {
    let id = $(obj).data('id')
    consultarEncuesta(id)
}

/* ================================================
 * FIN DESCARGAR
 * ================================================
 */

/* ================================================
 * INICIO OBSERVAR
 * ================================================
 */

var idObservar
var observar = (obj) => {
    let id = $(obj).data('id')
    location.href = `${baseUrl}Interno/EncuestaFicha/${id}`
}

/* ================================================
 * FIN OBSERVAR
 * ================================================
 */