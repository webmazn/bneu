$(document).ready(() => {
    $('#btn-agregar-maestra').on('click', (e) => grabarTablaMaestra())
    $('#btn-agregar-principal').on('click', (e) => grabarEncabezadoPrincipal())
    $('#btn-agregar-secundario').on('click', (e) => grabarEncabezadoSecundario())
    

    /*$('#cbo-giro00').on('change', (e) => listarEmpresa00())
    $('#cbo-ciuu00').on('change', (e) => listarEmpresa00())
    $('#txt-filtro00').on('blur', (e) => validarValorFiltro00())
    $('#cbo-filtro00').on('change', (e) => cambiarFiltro00())
    $('#btn-filtro00').on('click', (e) => aplicarFiltro00())*/
    cargarDatos()
});

var idTablaMaestra = -1

var grabarTablaMaestra = () => {
    $('.seccion-mensaje-maestra').html('');
    let arr = [];

    let tituloPrincipal = $("#txt-titulo-principal").val().trim()
    let subtitulo = $("#txt-sub-titulo").val().trim()
    let descripcionIconoAyuda = $("#txt-question-mark").val().trim()
    let preguntaInicial = $("#txt-pregunta-confirmacion-01").val().trim()
    let preguntaCierre = $("#txt-pregunta-confirmacion-02").val().trim()
    let idEstiloTabla = $("#cbo-estilo-tabla").val()

    if (validarEspaciosBlanco(tituloPrincipal)) arr.push("Debe ingresar el título principal o nombre de la tabla maestra");
    if (validarEspaciosBlanco(subtitulo)) arr.push("Debe ingresar el subtítulo descriptivo");
    if (validarEspaciosBlanco(descripcionIconoAyuda)) arr.push("Debe ingresar la escripción del icono de ayuda");
    if (validarEspaciosBlanco(preguntaInicial)) arr.push("Debe ingresar la pregunta inicial");
    if (validarEspaciosBlanco(preguntaCierre)) arr.push("Debe ingresar la pregunta de cierre");
    if (validarCombo(idEstiloTabla)) arr.push("Debe seleccionar el estilo de tabla");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-maestra').html(messageError(error, 'registro'));
        return;
    }

    let url = `${baseUrl}TablaMaestra/grabarTablaMaestra`;
    let data = { idTablaMaestra, tituloPrincipal, subtitulo, descripcionIconoAyuda, preguntaInicial, preguntaCierre, idEstiloTabla, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idTablaMaestra = j.object
            $('.seccion-mensaje-maestra').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente')))
            setTimeout(function () {
                $('.seccion-mensaje-maestra').html('')
            }, 5000);
        } else {
            $('.seccion-mensaje-maestra').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {                
                $('.seccion-mensaje-maestra').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var idEncabezadoPrincipal = -1
var grabarEncabezadoPrincipal = () => {
    $('.seccion-mensaje-principal').html('');

    if (idTablaMaestra == -1) {
        $('.seccion-mensaje-principal').html(messageError(messageStringGeneric('Primero debe registrar los datos de la tabla maestra'), 'registro'))
        return
    }

    let arr = [];

    let tituloEncabezado = $("#txt-titulo-encabezado-principal").val().trim()
    let abreviacion = $("#txt-encabezado-principal-abreviado").val().trim()
    let usarAbreviado = $("#exampleRadios1").prop('checked')
    let descripcionIconoAyuda = $("#txt-question-mark-01").val().trim()

    if (validarEspaciosBlanco(tituloEncabezado)) arr.push("Debe ingresar el título del encabezado principal");
    if (usarAbreviado) if (validarEspaciosBlanco(abreviacion)) arr.push("Debe ingresar la abreviación del encabezado principal");
    //if (validarEspaciosBlanco(descripcionIconoAyuda)) arr.push("Debe ingresar la escripción del icono de ayuda");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-principal').html(messageError(error, 'registro'));
        return;
    }

    usarAbreviado = $("#exampleRadios1").prop('checked') ? '1' : '0'

    let url = `${baseUrl}TablaMaestra/grabarEncabezadoPrincipal`;
    let data = { idEncabezadoPrincipal, idTablaMaestra, tituloEncabezado, abreviacion, usarAbreviado, descripcionIconoAyuda, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            mostrarEncabezadoPrincipal()
            limpiarEncabezadoPrincipal()
            $('.seccion-mensaje-principal').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo')))
            setTimeout(function () {
                $('.seccion-mensaje-principal').html('')
            }, 5000);
        } else {
            $('.seccion-mensaje-principal').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {
                $('.seccion-mensaje-principal').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var idEncabezadoSecundario = -1
var grabarEncabezadoSecundario = () => {
    $('.seccion-mensaje-secundario').html('');

    if ($('#tbl-encabezado-principal').find('thead tr th').length == -1) {
        $('.seccion-mensaje-secundario').html(messageError(messageStringGeneric('Al menos debe existir un encabezado principal registrado'), 'registro'))
        return
    }

    let arr = [];

    let tituloEncabezado = $("#txt-encabezado-secundario").val().trim()
    let abreviacion = $("#txt-encabezado-secundario-abreviado").val().trim()
    let usarAbreviado = $("#exampleRadios3").prop('checked')
    let idEncabezadoPrincipal = $("#cbo-encabezado-principal").val()
    let idOrientacion = $("#cbo-orientacion").val()
    let descripcionIconoAyuda = $("#txt-question-mark-02").val().trim()
    let idTipoControl = $("#cbo-control-respuesta").val()
    let idTipoDato = $("#cbo-tipo-dato").val()
    let idParametro = $("#cbo-id-parametro").val()
    let cantidadFilas = $("#txt-filas-por-defecto").val()
    let agregarFilas = $("#exampleRadios5").prop('checked')

    //if (validarEspaciosBlanco(tituloEncabezado)) arr.push("Debe ingresar el título del encabezado secundario");
    if (usarAbreviado) if (validarEspaciosBlanco(abreviacion)) arr.push("Debe ingresar la abreviación del encabezado principal");    
    if (validarCombo(idEncabezadoPrincipal)) arr.push("Debe seleccionar un encabezado principal");
    if (validarCombo(idOrientacion)) arr.push("Debe seleccionar una orientación");
    //if (validarEspaciosBlanco(descripcionIconoAyuda)) arr.push("Debe ingresar la escripción del icono de ayuda");
    if (validarCombo(idTipoControl)) arr.push("Debe seleccionar un tipo de control de respuesta");
    if (idTipoControl == '1') arr.push("Debe seleccionar un tipo de dato");
    if (validarEspaciosBlanco(cantidadFilas)) arr.push("Debe ingresar la cantidad de filas");
    if (cantidadFilas < 0 || cantidadFilas > 100) arr.push("La cantidad de filas debe ser mayor a 0 y menor a 100");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-secundario').html(messageError(error, 'registro'));
        return;
    }

    usarAbreviado = $("#exampleRadios1").prop('checked') ? '1' : '0'
    agregarFilas = $("#exampleRadios5").prop('checked') ? '1' : '0'

    let url = `${baseUrl}TablaMaestra/grabarEncabezadoSecundario`;
    let data = { idEncabezadoSecundario, idEncabezadoPrincipal, tituloEncabezado, abreviacion, usarAbreviado, idOrientacion, descripcionIconoAyuda, idTipoControl, idTipoDato, idParametro, cantidadFilas, agregarFilas,  idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            mostrarEncabezadoPrincipal()
            limpiarEncabezadoPrincipal()
            $('.seccion-mensaje-secundario').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo')))
            setTimeout(function () {
                $('.seccion-mensaje-secundario').html('')
            }, 5000);
        } else {
            $('.seccion-mensaje-secundario').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {
                $('.seccion-mensaje-secundario').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var limpiarEncabezadoPrincipal = () => {
    $("#txt-titulo-encabezado-principal").val('')
    $("#txt-encabezado-principal-abreviado").val('')
    $("#exampleRadios1").prop('checked', true)
    $("#exampleRadios2").prop('checked', false)
    $("#txt-question-mark-01").val('')
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
    let params = { idTablaMaestra, registros, pagina };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}TablaMaestra/mostrarListaEncabezadoPrincipal?${queryParams}`;
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

var cargarDatosTablaPrincipal = (j) => {
    let tabla = $('#tbl-encabezado-principal');
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
                actualizar(e.currentTarget);
            });
        });
        tabla.find('.btn-delete-principal').each(x => {
            let elementButton = tabla.find('.btn-delete-principal')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminar(e.currentTarget);
            });
        });
        armarComboEncabezadoPrincipal(j.object)
        $('[data-toggle="tooltip"]').tooltip();
        posicinar('#tbl-encabezado-principal', 120)
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
            let colTituloEncabezado = `<td data-encabezado="Nombre del encabezado principal" scope="row"><span class="ml-4">${x.tituloEncabezado}</span></td>`;
            let colAbreviacion = `<td data-encabezado="Abreviatura">${x.abreviacion}</td>`;
            let colUsarAbreviacion = `<td class="text-center" data-encabezado="Usar abreviatura">${x.usarAbreviado == '1' ? 'Si' : 'No'}</td>`
            let colTextoAyuda = `<td data-encabezado="Question mark">${x.descripcionIconoAyuda}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-principal" data-id="${x.idEncabezadoPrincipal}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-principal" data-id="${x.idEncabezadoPrincipal}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colTituloEncabezado}${colAbreviacion}${colUsarAbreviacion}${colTextoAyuda}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

var armarComboEncabezadoPrincipal = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idEncabezadoPrincipal}">${x.tituloEncabezado}</option>`).join('');
    options = `<option value="0">-Seleccione un encabezado principal-</option>${options}`;
    $('#cbo-encabezado-principal').html(options);
}

/**/

var cargarDatos = () => {
    idTablaMaestra = $('#identificador').val()
    mostrarEncabezadoPrincipal()
}

var posicinar = (id, number) => {
    var target_offset = $(id).offset();
    var target_top = target_offset.top - number;
    $('html,body').animate({ scrollTop: target_top }, { duration: "slow" });
}