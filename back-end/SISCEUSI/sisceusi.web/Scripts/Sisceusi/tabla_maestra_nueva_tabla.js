$(document).ready(() => {
    $('#btn-agregar-maestra').on('click', (e) => grabarTablaMaestra())
    $('#btn-agregar-principal').on('click', (e) => grabarEncabezadoPrincipal())
    $('#btn-agregar-secundario').on('click', (e) => grabarEncabezadoSecundario())
    
    $('.ir-pagina-principal').on('change', (e) => cambiarPaginaRegistrosPrincipal());
    $('#number-registers-principal').on('change', (e) => cambiarPaginaRegistrosPrincipal());
    $('.ir-pagina-secundario').on('change', (e) => cambiarPaginaRegistrosSecundario());
    $('#number-registers-secundario').on('change', (e) => cambiarPaginaRegistrosSecundario());

    $('#eliminacionRowPrincipal').on('click', (e) => deshabilitarRegistroPrincipal())
    $('#eliminacionRowSecundario').on('click', (e) => deshabilitarRegistroSecundario())

    $('#btn-cancelar-principal').on('click', (e) => cancelarPrincipal())
    $('#btn-cancelar-secundario').on('click', (e) => cancelarSecundario())

    $('#cbo-estado-oficial').val('1')
    cargarDatos()
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var cargarDesplegables = () => {
    let urlGiro = `${baseUrl}Parametro/obtenerListaParametro`
    Promise.all([
        fetch(urlGiro),
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jParametro = responseAll[0]
        if (jParametro.success) cargarParametro(jParametro.object)
        cargarDatosIniciales()
    });
}

var cargarParametro = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idParametro}">${x.parametro}</option>`).join('');
    options = `<option value="0">-Seleccione un parámetro-</option>${options}`;
    $('#cbo-id-parametro').html(options);
}

/* ================================================
 * FIN CARGA DESPLEGABLES
 * ================================================
 */

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
    let idEstado = $("#cbo-estado-oficial").val()

    if (validarEspaciosBlanco(tituloPrincipal)) arr.push("Debe ingresar el título principal o nombre de la tabla maestra");
    if (validarEspaciosBlanco(subtitulo)) arr.push("Debe ingresar el subtítulo descriptivo");
    //if (validarEspaciosBlanco(descripcionIconoAyuda)) arr.push("Debe ingresar la escripción del icono de ayuda");
    if (validarEspaciosBlanco(preguntaInicial)) arr.push("Debe ingresar la pregunta inicial");
    if (validarEspaciosBlanco(preguntaCierre)) arr.push("Debe ingresar la pregunta de cierre");
    if (validarCombo(idEstiloTabla)) arr.push("Debe seleccionar el estilo de tabla");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-maestra').html(messageError(error, 'registro'));
        return;
    }

    let url = `${baseUrl}TablaMaestra/grabarTablaMaestra`;
    let data = { idTablaMaestra, tituloPrincipal, subtitulo, descripcionIconoAyuda, preguntaInicial, preguntaCierre, idEstiloTabla, idEstado, idUsuarioCreacion: idUsuarioLogin };
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
    let posicion = $("#txt-posicion-principal").val()
    let descripcionIconoAyuda = $("#txt-question-mark-01").val().trim()

    //if (validarEspaciosBlanco(tituloEncabezado)) arr.push("Debe ingresar el título del encabezado principal");
    if (usarAbreviado) if (validarEspaciosBlanco(abreviacion)) arr.push("Debe ingresar la abreviación del encabezado principal");
    if (validarEspaciosBlanco(posicion)) arr.push("Debe ingresar la posición");
    if (posicion < 0 || posicion > 100) arr.push("La posición debe ser mayor a 0 y menor a 100");
    //if (validarEspaciosBlanco(descripcionIconoAyuda)) arr.push("Debe ingresar la escripción del icono de ayuda");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-principal').html(messageError(error, 'registro'));
        return;
    }

    usarAbreviado = $("#exampleRadios1").prop('checked') ? '1' : '0'

    let url = `${baseUrl}TablaMaestra/grabarEncabezadoPrincipal`;
    let data = { idEncabezadoPrincipal, idTablaMaestra, tituloEncabezado, abreviacion, usarAbreviado, posicion, descripcionIconoAyuda, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idEncabezadoPrincipal = -1
            $('#btn-agregar-principal').html('Agregar')
            $('#btn-cancelar-principal').parent().addClass('d-none')
            armarComboEncabezadoPrincipal()
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
    let posicion = $("#txt-posicion-secundario").val()
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
    if (validarEspaciosBlanco(posicion)) arr.push("Debe ingresar la posición");
    if (posicion < 0 || posicion > 100) arr.push("La posición debe ser mayor a 0 y menor a 100");
    if (validarCombo(idEncabezadoPrincipal)) arr.push("Debe seleccionar un encabezado principal");
    if (validarCombo(idOrientacion)) arr.push("Debe seleccionar una orientación");
    //if (validarEspaciosBlanco(descripcionIconoAyuda)) arr.push("Debe ingresar la escripción del icono de ayuda");
    if (validarCombo(idTipoControl)) arr.push("Debe seleccionar un tipo de control de respuesta");
    if (idTipoControl == '1') if (idTipoDato == '0') arr.push("Debe seleccionar un tipo de dato");
    if (validarEspaciosBlanco(cantidadFilas)) arr.push("Debe ingresar la cantidad de filas");
    if (cantidadFilas < 0 || cantidadFilas > 100) arr.push("La cantidad de filas debe ser mayor a 0 y menor a 100");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje-secundario').html(messageError(error, 'registro'));
        return;
    }

    usarAbreviado = $("#exampleRadios3").prop('checked') ? '1' : '0'
    agregarFilas = $("#exampleRadios5").prop('checked') ? '1' : '0'

    let url = `${baseUrl}TablaMaestra/grabarEncabezadoSecundario`;
    let data = { idEncabezadoSecundario, idEncabezadoPrincipal, tituloEncabezado, abreviacion, usarAbreviado, posicion, idOrientacion, descripcionIconoAyuda, idTipoControl, idTipoDato, idParametro, cantidadFilas, agregarFilas,  idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idEncabezadoSecundario = -1
            $('#btn-agregar-secundario').html('Agregar')
            $('#btn-cancelar-secundario').parent().addClass('d-none')
            mostrarEncabezadoSecundario()
            limpiarEncabezadoSecundario()
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
    $('#txt-posicion-principal').val('')
    $("#exampleRadios1").prop('checked', true)
    $("#exampleRadios2").prop('checked', false)
    $("#txt-question-mark-01").val('')
}

var limpiarEncabezadoSecundario = () => {
    $("#txt-encabezado-secundario").val('')
    $("#txt-encabezado-secundario-abreviado").val('')
    $("#exampleRadios3").prop('checked', true)
    $("#exampleRadios4").prop('checked', false)
    $('#txt-posicion-secundario').val('')
    $("#txt-question-mark-02").val('')
    $("#cbo-encabezado-principal").val('0')
    $("#cbo-orientacion").val('0')
    $("#cbo-control-respuesta").val('0')
    $("#cbo-tipo-dato").val('0')
    $("#cbo-id-parametro").val('0')
    $("#txt-filas-por-defecto").val('12')
    $("#exampleRadios5").prop('checked', true)
    $("#exampleRadios6").prop('checked', false)
}

/* ================================================
 * INICIO MOSTRAR ENCABEZADO PRINCIPAL
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
        //armarComboEncabezadoPrincipal(j.object)
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
            let colCodigo = `<td class="text-center" data-encabezado="Código">${x.idEncabezadoPrincipal}</td>`;
            let colTituloEncabezado = `<td data-encabezado="Nombre del encabezado principal" scope="row"><span class="ml-4">${x.tituloEncabezado}</span></td>`;
            let colAbreviacion = `<td data-encabezado="Abreviatura">${x.abreviacion}</td>`;
            let colUsarAbreviacion = `<td class="text-center" data-encabezado="Usar abreviatura">${x.usarAbreviado == '1' ? 'Si' : 'No'}</td>`
            let colTextoAyuda = `<td data-encabezado="Question mark">${x.descripcionIconoAyuda}</td>`;
            let colPosicion = `<td class="text-center" data-encabezado="Posición">${x.posicion}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-principal" data-id="${x.idEncabezadoPrincipal}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-principal" data-id="${x.idEncabezadoPrincipal}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colCodigo}${colTituloEncabezado}${colAbreviacion}${colUsarAbreviacion}${colTextoAyuda}${colPosicion}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

var armarComboEncabezadoPrincipal = () => {
    let url = `${baseUrl}TablaMaestra/obtenerListaEncabezadoPrincipal?idTablaMaestra=${idTablaMaestra}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            let data = j.object
            let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idEncabezadoPrincipal}">${x.idEncabezadoPrincipal}_${x.tituloEncabezado == null ? "" : x.tituloEncabezado}</option>`).join('');
            options = `<option value="0">-Seleccione un encabezado principal-</option>${options}`;
            $('#cbo-encabezado-principal').html(options);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })    
}

/* ================================================
 * FIN MOSTRAR ENCABEZADO PRINCIPAL
 * ================================================
 */

/* ================================================
 * INICIO MOSTRAR ENCABEZADO SECUNDARIO
 * ================================================
 */

var cambiarPaginaRegistrosSecundario = () => {
    mostrarEncabezadoSecundario()
}

var cambiarPaginaSecundario = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina-secundario").val());
    total = Number($(".total-paginas-secundario").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina-secundario").val(page);
    mostrarEncabezadoSecundario()
}

var mostrarEncabezadoSecundario = () => {
    let registros = $('#number-registers-secundario').val()
    let pagina = $('.ir-pagina-secundario').val()
    let params = { idTablaMaestra, registros, pagina };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}TablaMaestra/mostrarListaEncabezadoSecundario?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTablaSecundario)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
};

var cargarDatosTablaSecundario = (j) => {
    let tabla = $('#tbl-encabezado-secundario');
    tabla.find('tbody').html('');
    $('#viewPagination-secundario').attr('style', 'display: none !important');
    if (j.success) {
        let rs = j.object[0];
        if (rs.totalRegistros == 0) { $('#viewPagination-secundario').hide(); $('#view-page-result-secundario').hide(); }
        else { $('#view-page-result-secundario').show(); $('#viewPagination-secundario').show(); }
        $('.inicio-registros-secundario').text(rs.registros == 0 ? 'No se encontraron resultados' : (rs.pagina - 1) * rs.registros + 1);
        $('.fin-registros-secundario').text(rs.totalRegistros < rs.pagina * rs.registros ? rs.totalRegistros : rs.pagina * rs.registros);
        $('.total-registros-secundario').text(rs.totalRegistros);
        $('.pagina-secundario').text(rs.pagina);
        $('.ir-pagina-secundario').val(rs.pagina);
        $('.ir-pagina-secundario').attr('max', rs.totalPaginas);
        $('.total-paginas-secundario').text(rs.totalPaginas);

        let numberCellHeader = tabla.find('thead tr th').length;
        let content = renderizarSecundario(j.object, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

        tabla.find('.btn-edit-secundario').each(x => {
            let elementButton = tabla.find('.btn-edit-secundario')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                actualizarSecundario(e.currentTarget);
            });
        });
        tabla.find('.btn-delete-secundario').each(x => {
            let elementButton = tabla.find('.btn-delete-secundario')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminarSecundario(e.currentTarget);
            });
        });

        $('[data-toggle="tooltip"]').tooltip();
        posicinar('#tbl-encabezado-secundario', 120)
    } else {
        console.log('No hay resultados');
        $('#viewPagination-secundario').hide(); $('#view-page-result-secundario').hide();
        $('.inicio-registros-secundario').text('No se encontraron resultados');
    }
}

var renderizarSecundario = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let colTituloEncabezado = `<td data-encabezado="Nombre del encabezado principal" scope="row"><span class="ml-4">${x.tituloEncabezado}</span></td>`;
            let colAbreviacion = `<td data-encabezado="Abreviatura">${x.abreviacion}</td>`;
            //let colUsarAbreviacion = `<td class="text-center" data-encabezado="Usar abreviatura">${x.usarAbreviado == '1' ? 'Si' : 'No'}</td>`            
            let colEncabezadoPrincipal = `<td class="text-center" data-encabezado="Encabezado principal">${x.encabezadoPrincipal.tituloEncabezado}</td>`;
            let colTextoAyuda = `<td data-encabezado="Question mark">${x.descripcionIconoAyuda}</td>`;
            let colTipoDato = `<td class="text-center" data-encabezado="Tipo de dato">${x.tipoDato.tipoDato}</td>`;
            let colParametro = `<td class="text-center" data-encabezado="ID Parámetro">${x.parametro.parametro}</td>`;
            let colPosicion = `<td class="text-center" data-encabezado="Posición">${x.posicion}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-secundario" data-id="${x.idEncabezadoSecundario}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-secundario" data-id="${x.idEncabezadoSecundario}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colTituloEncabezado}${colAbreviacion}${colEncabezadoPrincipal}${colTextoAyuda}${colTipoDato}${colParametro}${colPosicion}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};
/* ================================================
 * INICIO MOSTRAR ENCABEZADO SECUNDARIO
 * ================================================
 */

/* ================================================
 * INICIO CONSULTAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatos = () => {
    idTablaMaestra = $('#identificador').val()
    armarComboEncabezadoPrincipal()
    cargarDatosIniciales()
    mostrarEncabezadoPrincipal()
    mostrarEncabezadoSecundario()
    setTimeout(function () {
        posicinar('#cuerpo', 120)
    }, 2000)    
}

var cargarDatosIniciales = () => {
    let id = $('#identificador').val()
    if (id > 0) {
        let url = `${baseUrl}TablaMaestra/obtenerTablaMaestra?idTablaMaestra=${id}`;
        fetch(url)
        .then(r => r.json())
        .then(j => {
            if (j.success) {
                cargarDatosTablaMaestra(j.object)
            } else {
                $('.seccion-mensaje-maestra').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la tabla maestra. Por favor, puede volver a recargar la página.'), 'carga de datos'))
            }
        })
        .catch(error => {
            console.log('Error:' + error.message)
        })
    }
}

var cargarDatosTablaMaestra = (data) => {
    $("#txt-titulo-principal").val(data.tituloPrincipal)
    $("#txt-sub-titulo").val(data.subtitulo)
    $("#txt-question-mark").val(data.descripcionIconoAyuda)
    $("#txt-pregunta-confirmacion-01").val(data.preguntaInicial)
    $("#txt-pregunta-confirmacion-02").val(data.preguntaCierre)
    $("#cbo-estilo-tabla").val(data.idEstiloTabla)
    $("#cbo-estado-oficial").val(data.idEstado)
}

/* ================================================
 * FIN CONSULTAR DATOS ENTIDAD
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR PRINCIPAL
 * ================================================
 */

var actualizarPrincipal = (obj) => {
    let id = $(obj).data('id')
    let url = `${baseUrl}TablaMaestra/obtenerEncabezadoPrincipal?idEncabezadoPrincipal=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            cargarDatosPrincipal(j.object)
        } else {
            $('.seccion-mensaje-principal').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos del encabezado principal. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var cargarDatosPrincipal = (data) => {
    $('#btn-agregar-principal').html('Actualizar')
    $('#btn-cancelar-principal').parent().removeClass('d-none')
    idEncabezadoPrincipal = data.idEncabezadoPrincipal
    $("#txt-titulo-encabezado-principal").val(data.tituloEncabezado)
    $("#txt-encabezado-principal-abreviado").val(data.abreviacion)
    $("#exampleRadios1").prop('checked', data.usarAbreviado == '1' ? true : false)
    $("#exampleRadios2").prop('checked', data.usarAbreviado == '0' ? true : false)
    $("#txt-posicion-principal").val(data.posicion)
    $("#txt-question-mark-01").val(data.descripcionIconoAyuda)
}

/* ================================================
 * FIN ACTUALIZAR PRINCIPAL
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR SECUNDARIO
 * ================================================
 */

var actualizarSecundario = (obj) => {
    let id = $(obj).data('id')
    let url = `${baseUrl}TablaMaestra/obtenerEncabezadoSecundario?idEncabezadoSecundario=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            cargarDatosSecundario(j.object)
        } else {
            $('.seccion-mensaje-secundario').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos del encabezado secundario. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var cargarDatosSecundario = (data) => {
    $('#btn-agregar-secundario').html('Actualizar')
    $('#btn-cancelar-secundario').parent().removeClass('d-none')
    idEncabezadoSecundario = data.idEncabezadoSecundario
    $("#txt-encabezado-secundario").val(data.tituloEncabezado)
    $("#txt-encabezado-secundario-abreviado").val(data.abreviacion)
    $("#exampleRadios3").prop('checked', data.usarAbreviado == '1' ? true : false)
    $("#exampleRadios4").prop('checked', data.usarAbreviado == '0' ? true : false)
    $("#txt-posicion-secundario").val(data.posicion)
    $("#txt-question-mark-02").val(data.descripcionIconoAyuda)
    $("#cbo-encabezado-principal").val(data.idEncabezadoPrincipal)
    $("#cbo-orientacion").val(data.idOrientacion)
    $("#cbo-control-respuesta").val(data.idTipoControl)
    $("#cbo-tipo-dato").val(data.idTipoDato)
    $("#cbo-id-parametro").val(data.idParametro)
    $("#txt-filas-por-defecto").val(data.cantidadFilas)
    $("#exampleRadios5").prop('checked', data.agregarFilas == '1' ? true : false)
    $("#exampleRadios6").prop('checked', data.agregarFilas == '0' ? true : false)
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
    $('#modalConfirmacionPrincipal').modal('show')
}

var deshabilitarRegistroPrincipal = () => {
    let url = `${baseUrl}TablaMaestra/eliminarPrincipal?idEncabezadoPrincipal=${idEliminarPrincipal}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idEncabezadoPrincipal = -1
            $('#btn-agregar-principal').html('Agregar')
            $('#btn-cancelar-principal').parent().removeClass('d-none')
            mostrarEncabezadoPrincipal()
            limpiarEncabezadoPrincipal()
            $('#modalConfirmacionPrincipal').modal('hide')
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
 * INICIO ELIMINAR SECUNDARIO
 * ================================================
 */
var idEliminarSecundario = 0
var eliminarSecundario = (obj) => {
    idEliminarSecundario = $(obj).data('id')
    $('#modalConfirmacionSecundario').modal('show')
}

var deshabilitarRegistroSecundario = () => {
    let url = `${baseUrl}TablaMaestra/eliminarSecundario?idEncabezadoSecundario=${idEliminarSecundario}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idEncabezadoSecundario = -1
            $('#btn-agregar-secundario').html('Agregar')
            $('#btn-cancelar-secundario').parent().removeClass('d-none')
            mostrarEncabezadoSecundario()
            limpiarEncabezadoSecundario()
            $('#modalConfirmacionSecundario').modal('hide')
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}
/* ================================================
 * FIN ELIMINAR SECUNDARIO
 * ================================================
 */

/* ================================================
 * INICIO CANCELAR
 * ================================================
 */
var cancelarPrincipal = () => {
    limpiarEncabezadoPrincipal()
    $('#btn-cancelar-principal').parent().addClass('d-none')
}

var cancelarSecundario = () => {
    limpiarEncabezadoSecundario()
    $('#btn-cancelar-secundario').parent().addClass('d-none')
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