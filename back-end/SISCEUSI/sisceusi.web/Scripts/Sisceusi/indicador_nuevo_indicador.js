var arrListaPregunta = []
var arrEncabezadoPrincipal = []
var arrEncabezadoSecundario = []
$(document).ready(() => {
    $('#cbo-estado').val('1')
    $('#cbo-pregunta').on('change', (e) => cambiarPregunta())
    //$('#cbo-columna-principal').on('change', (e) => cambiarEncabezadoPrincipal())
    $('#btn-grabar').on('click', (e) => grabar())
    $('#eliminacionRow').on('click', (e) => deshabilitarRegistro())
    $('#btn-cancelar').on('click', (e) => cancelar())
    cargarDatos()
});

var cargarDatos = () => {
    arrListaPregunta = listaCampanaEncuesta
    cargarPreguntas()
    cargarDatosTablaPrincipal(listaIndicador, 1)
}

var cargarPreguntas = () => {
    let options = arrListaPregunta.length == 0 ? '' : arrListaPregunta.map(x => `<option value="${x.idCampanaEncuesta}">${x.idParametroTabla > 0 ? x.listaEncabezadoSecundario[0].encabezadoPrincipal.tablaMaestra.subtitulo == "" ? `TMA${pad(x.listaEncabezadoSecundario[0].encabezadoPrincipal.tablaMaestra.idTablaMaestra, 4)}` : x.listaEncabezadoSecundario[0].encabezadoPrincipal.tablaMaestra.subtitulo : x.pregunta}</option>`).join('');
    options = `<option value="0">-Seleccione una pregunta-</option>${options}`;
    $('#cbo-pregunta').html(options);
}

var idTipoControl = 0
var cambiarPregunta = () => {
    $('#cbo-columna-principal').val(0)
    $('#cbo-columna-secundaria').val(0)
    let pregunta = $('#cbo-pregunta').val()
    $('#cbo-columna-secundaria').prop('disabled', pregunta == 0)
    $('#cbo-columna-principal').prop('disabled', pregunta == 0)
    if (pregunta == 0) {
        idTipoControl = 0        
    } else {
        let campanaEncuesta = arrListaPregunta.find(x => x.idCampanaEncuesta == pregunta)
        idTipoControl = campanaEncuesta.idTipoControl
        $('#cbo-columna-principal').prop('disabled', !(campanaEncuesta.idParametroTabla > 0))
        if (campanaEncuesta.idParametroTabla > 0) {
            /*arrEncabezadoPrincipal = campanaEncuesta.listaEncabezadoSecundario.map(x => x.encabezadoPrincipal)
            arrEncabezadoPrincipal = [
                ...new Map(arrEncabezadoPrincipal.map((item) =>[item["idEncabezadoPrincipal"], item])).values(),
            ]
            cargarEncabezadoPrincipal()*/
            arrEncabezadoSecundario = campanaEncuesta.listaEncabezadoSecundario
            cargarColumas()
        }        
    }
}

//var cargarEncabezadoPrincipal = () => {
//    let options = arrEncabezadoPrincipal.length == 0 ? '' : arrEncabezadoPrincipal.map(x => `<option value="${x.idEncabezadoPrincipal}">${x.tituloEncabezado == '' ? `ENCPRI${pad(x.idEncabezadoPrincipal, 4)}` : x.tituloEncabezado}</option>`).join('');
//    options = `<option value="0">-Seleccione una columna principal-</option>${options}`;
//    $('#cbo-columna-principal').html(options);
//}

//var cambiarEncabezadoPrincipal = () => {
//    let pregunta = $('#cbo-pregunta').val()    
//    let principal = $('#cbo-columna-principal').val()
//    if (principal == 0) {
//        $('#cbo-columna-secundaria').prop('disabled', true)
//        $('#cbo-columna-secundaria').val(0)
//    } else {
//        let campanaEncuesta = arrListaPregunta.find(x => x.idCampanaEncuesta == pregunta)
//        $('#cbo-columna-secundaria').prop('disabled', !(campanaEncuesta.idParametroTabla > 0))
//        if (campanaEncuesta.idParametroTabla > 0) {
//            arrEncabezadoSecundario = campanaEncuesta.listaEncabezadoSecundario.filter(x => x.encabezadoPrincipal.idEncabezadoPrincipal == principal)
//            cargarEncabezadoSecundario()
//        }
//    }
//}

var cargarColumas = () => {
    let options = arrEncabezadoSecundario.length == 0 ? '' : arrEncabezadoSecundario.map(x => `<option value="${x.idEncabezadoSecundario}">${x.encabezadoPrincipal.tituloEncabezado == "" ? "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" : x.encabezadoPrincipal.tituloEncabezado} - ${x.tituloEncabezado}</option>`).join('');
    options = `<option value="0">-Seleccione una columna-</option>${options}`;
    $('#cbo-columna-principal').html(options);
    $('#cbo-columna-secundaria').html(options);
}

var idIndicador = -1
var grabar = () => {
    $('.seccion-mensaje').html('');
    let arr = []

    let nombreIndicador = $('#txt-indicador').val().trim()
    let idCampanaEncuesta = $('#cbo-pregunta').val()
    let idEncSecundarioAgrupacion = $('#cbo-columna-principal').val()
    let idEncSecundarioCalculo = $('#cbo-columna-secundaria').val()
    let idMetodoCalculo = $('#cbo-metodo-calculo').val()
    //let idEstado = $('#cbo-estado').val()

    if (validarEspaciosBlanco(nombreIndicador)) arr.push("Debe ingresar el nombre del indicador");
    if (validarCombo(idCampanaEncuesta)) arr.push("Debe seleccionar una pregunta");
    if (idTipoControl == 5) {
        if (validarCombo(idEncSecundarioAgrupacion)) arr.push("Debe seleccionar una columna agrupación");
        if (validarCombo(idEncSecundarioCalculo)) arr.push("Debe seleccionar una columna cálculo");
    }    
    if (validarCombo(idMetodoCalculo)) arr.push("Debe seleccionar un método de cálculo");
    //if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'registro'));
        return;
    }

    let url = `${baseUrl}Indicador/grabar`;
    let data = { idIndicador, nombreIndicador, idCampana, idCampanaEncuesta, idEncSecundarioAgrupacion, idEncSecundarioCalculo, idTipoControl, idMetodoCalculo, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    $('#btn-grabar').hide()
    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        $('#btn-grabar').show()
        if (j.success) {            
            limpiarIndicador()
            mostrarEncabezadoPrincipal()
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo. Utilice el buscador para encontrar su nuevo registro.')))
            setTimeout(function () {
                $('.seccion-mensaje').html('')
            }, 4000)
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var limpiarIndicador = () => {
    idIndicador = -1
    $('#txt-indicador').val('')
    $('#cbo-pregunta').val(0)
    $('#cbo-columna-principal').val(0)
    $('#cbo-columna-secundaria').val(0)
    $('#cbo-metodo-calculo').val(0)
    //$('#cbo-estado').val("1")
    cambiarPregunta()
    $('#btn-grabar').html('Agregar')
    $('#btn-cancelar').addClass('d-none')
}

/* ================================================
 * INICIO MOSTRAR LISTA INDICADOR
 * ================================================
 */

var cambiarPaginaRegistrosPrincipal = () => {
    mostrarEncabezadoPrincipal()
}

var cambiarPaginaPrincipal = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina-principal").val());
    total = Number($(".total-paginas-principal").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina-principal").val(page);
    mostrarEncabezadoPrincipal()
}

var mostrarEncabezadoPrincipal = () => {
    let registros = $('#number-registers-principal').val()
    let pagina = $('.ir-pagina-principal').val()
    let params = { idCampana, registros, pagina };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}Indicador/mostrarListaIndicador?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTablaPrincipal)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
};

var cargarDatosTablaPrincipal = (j, inicio) => {
    let tabla = $('#tbl-indicador');
    tabla.find('tbody').html('');
    $('#viewPagination-principal').attr('style', 'display: none !important');
    if (j.success) {
        let rs = j.object[0];
        if (rs.totalRegistros == 0) { $('#viewPagination-principal').hide(); $('#view-page-result-principal').hide(); }
        else { $('#view-page-result-principal').show(); $('#viewPagination-principal').show(); }
        $('.inicio-registros-principal').text(rs.registros == 0 ? 'No se encontraron resultados' : (rs.pagina - 1) * rs.registros + 1);
        $('.fin-registros-principal').text(rs.totalRegistros < rs.pagina * rs.registros ? rs.totalRegistros : rs.pagina * rs.registros);
        $('.total-registros-principal').text(rs.totalRegistros);
        $('.pagina-principal').text(rs.pagina);
        $('.ir-pagina-principal').val(rs.pagina);
        $('.ir-pagina-principal').attr('max', rs.totalPaginas);
        $('.total-paginas-principal').text(rs.totalPaginas);

        let numberCellHeader = tabla.find('thead tr th').length;
        let content = renderizarPrincipal(j.object, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

        tabla.find('.btn-edit-principal').each(x => {
            let elementButton = tabla.find('.btn-edit-principal')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                actualizarPrincipal(e.currentTarget);
            });
        });
        tabla.find('.btn-delete-principal').each(x => {
            let elementButton = tabla.find('.btn-delete-principal')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminarPrincipal(e.currentTarget);
            });
        });

        $('[data-toggle="tooltip"]').tooltip();
        if (inicio == null) posicinar('#tbl-indicador', 120)
    } else {
        console.log('No hay resultados');
        $('#viewPagination-principal').hide(); $('#view-page-result-principal').hide();
        $('.inicio-registros-principal').text('No se encontraron resultados');
    }
}

var renderizarPrincipal = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let colCodigo = `<td class="text-center" data-encabezado="Código">${x.idIndicador}</td>`;
            let colNombreIndicador = `<td data-encabezado="Nombre indicador" scope="row"><span class="ml-4">${x.nombreIndicador}</span></td>`;
            let colPregunta = `<td data-encabezado="Pregunta">${x.campanaEncuesta.tablaMaestra.idTablaMaestra > 0 ? x.campanaEncuesta.tablaMaestra == "" ? `TMA${pad(x.campanaEncuesta.tablaMaestra.idTablaMaestra, 4)}` : x.campanaEncuesta.tablaMaestra.subtitulo : x.campanaEncuesta.pregunta}</td>`;
            let colColumnaPrincipal = `<td class="text-center" data-encabezado="Columna Agrupación">${x.encSecundarioAgrupacion.tituloEncabezado}</td>`
            let colColumnaSecundario = `<td class="text-center" data-encabezado="Columna Cálculo">${x.encSecundarioCalculo.tituloEncabezado}</td>`;
            let colMetodoCalculo = `<td class="text-center" data-encabezado="Método calculado">${x.metodoCalculo.metodoCalculo}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-principal" data-id="${x.idIndicador}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-principal" data-id="${x.idIndicador}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colCodigo}${colNombreIndicador}${colPregunta}${colColumnaPrincipal}${colColumnaSecundario}${colMetodoCalculo}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

/* ================================================
 * FIN MOSTRAR LISTA INDICADOR
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR SECUNDARIO
 * ================================================
 */

var actualizarPrincipal = (obj) => {
    let id = $(obj).data('id')
    let url = `${baseUrl}Indicador/obtenerIndicador?idIndicador=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            cargarDatosIndicador(j.object)
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos del encabezado secundario. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var cargarDatosIndicador = (data) => {
    $('#btn-grabar').html('Actualizar')
    $('#btn-cancelar').removeClass('d-none')
    idIndicador = data.idIndicador
    $('#txt-indicador').val(data.nombreIndicador)
    $('#cbo-pregunta').val(data.idCampanaEncuesta)
    cambiarPregunta()
    $('#cbo-columna-principal').val(data.idEncSecundarioAgrupacion)
    $('#cbo-columna-secundaria').val(data.idEncSecundarioCalculo)
    $('#cbo-metodo-calculo').val(data.idMetodoCalculo)
    idTipoControl = data.idTipoControl
    //$('#cbo-estado').val(data.idEstado)
}

/* ================================================
 * FIN ACTUALIZAR SECUNDARIO
 * ================================================
 */

/* ================================================
 * INICIO ELIMINAR PRINCIPAL
 * ================================================
 */
var idEliminarPrincipal = 0
var eliminarPrincipal = (obj) => {
    idEliminarPrincipal = $(obj).data('id')
    $('#modalConfirmacion').modal('show')
}

var deshabilitarRegistro = () => {
    let url = `${baseUrl}Indicador/eliminar?idIndicador=${idEliminarPrincipal}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            limpiarIndicador()
            mostrarEncabezadoPrincipal()
            $('#modalConfirmacion').modal('hide')
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}
/* ================================================
 * FIN ELIMINAR PRINCIPAL
 * ================================================
 */

/* ================================================
 * INICIO CANCELAR
 * ================================================
 */
var cancelar = () => {
    limpiarIndicador()
}
/* ================================================
 * FIN CANCELAR
 * ================================================
 */

var posicinar = (id, number) => {
    var target_offset = $(id).offset();
    var target_top = target_offset.top - number;
    $('html,body').animate({ scrollTop: target_top }, { duration: "slow" });
}