$(document).ready(() => {
    $('#btn-grabar-banner').on('click', (e) => grabarBanner())
    $('#fle-slider-01').on('change', (e) => fileChangeBanner(e))
    $('#btn-grabar-publicacion').on('click', (e) => grabarPublicacion())
    $('#fle-publicacion-01').on('change', (e) => fileChangePublicacion(e))
    $('#btn-grabar-enlace').on('click', (e) => grabarEnlace())
    $('#fle-web-01').on('change', (e) => fileChangeLogoWeb(e))
    $('#fle-dgee-01').on('change', (e) => fileChangeLogoDgee(e))
    $('#btn-grabar-logo').on('click', (e) => grabarLogoRedSocial())

    $('.ir-pagina-banner').on('change', (e) => cambiarPaginaRegistrosBanner());
    $('#number-registers-banner').on('change', (e) => cambiarPaginaRegistrosBanner());
    $('.ir-pagina-publicacion').on('change', (e) => cambiarPaginaRegistrosPublicacion());
    $('#number-registers-publicacion').on('change', (e) => cambiarPaginaRegistrosPublicacion());
    $('.ir-pagina-enlace').on('change', (e) => cambiarPaginaRegistrosEnlace());
    $('#number-registers-enlace').on('change', (e) => cambiarPaginaRegistrosEnlace());

    $('#eliminacionRowBanner').on('click', (e) => deshabilitarRegistroBanner())
    $('#eliminacionRowPublicacion').on('click', (e) => deshabilitarRegistroPublicacion())
    $('#eliminacionRowEnlace').on('click', (e) => deshabilitarRegistroEnlace())

    $('#btn-cancelar-banner').on('click', (e) => cancelarBanner())
    $('#btn-cancelar-publicacion').on('click', (e) => cancelarPublicacion())
    $('#btn-cancelar-enlace').on('click', (e) => cancelarEnlace())

    $('#cbo-estado-banner').val('1')
    $('#cbo-estado-publicacion').val('1')
    $('#cbo-estado-enlace').val('1')

    cargarDatos()
});

/* ================================================
 * INICIO BANNER
 * ================================================
 */
var idBanner = -1
var grabarBanner = () => {
    $('.seccion-banner').html('');
    let arr = [];

    let tituloBanner = $("#txt-titulo-banner").val().trim()
    let descripcionBanner = $("#txt-descripcion-banner").val().trim()
    let descripcionFija = $('#txt-descripcion-fija').val().trim()
    let tituloBoton = $("#txt-titulo-boton").val().trim()
    let enlaceBoton = $("#txt-enlace-boton").val().trim()
    let archivoContenidoBanner = $('#fle-slider-01').data('file')
    let idEstado = $("#cbo-estado-banner").val()

    if (validarEspaciosBlanco(tituloBanner)) arr.push("Debe ingresar el título del banner");
    if (validarEspaciosBlanco(descripcionBanner)) arr.push("Debe ingresar la descripción del banner");
    if (validarEspaciosBlanco(descripcionFija)) arr.push("Debe ingresar la descripción fija");
    if (validarEspaciosBlanco(tituloBoton)) arr.push("Debe ingresar el título del botón");
    if (validarEspaciosBlanco(enlaceBoton)) arr.push("Debe ingresar el enlace del botón");
    if (archivoContenidoBanner == undefined) arr.push('Debe cargar la imagen del banner')
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-banner').html(messageError(error, 'registro'));
        return;
    }

    let archivoNuevoBanner = $('#fle-slider-01').data('new')

    let url = `${baseUrl}PaginaHome/grabarBanner`;
    let data = { idBanner, tituloBanner, descripcionBanner, descripcionFija, tituloBoton, enlaceBoton, nombreArchivoBanner, archivoContenidoBanner, nombreArchivoGeneradoBanner, archivoNuevoBanner, idEstado, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idBanner = -1
            limpiarBanner()
            mostrarListaBanner()
            $('#btn-grabar-banner').html('Agregar')
            $('#btn-cancelar-banner').addClass('d-none')
            $('.seccion-banner').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente')))
            setTimeout(function () {
                $('.seccion-banner').html('')
            }, 5000);
        } else {
            $('.seccion-banner').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {
                $('.seccion-banner').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var limpiarBanner = () => {
    $("#txt-titulo-banner").val('')
    $("#txt-descripcion-banner").val('')
    $('#txt-descripcion-fija').val('')
    $("#txt-titulo-boton").val('')
    $("#txt-enlace-boton").val('')
    $('#fle-slider-01').val('')
    $('#fle-slider-01').removeData('file')
    $('#fle-slider-01').removeData('new')
    $('#txt-slider-01').val('')
    $('#cbo-estado-banner').val('1')
}

var nombreArchivoBanner
var fileChangeBanner = (e) => {
    $('.seccion-banner').html('');
    let elFile = $(e.currentTarget);
    var fileContent = e.currentTarget.files[0];

    if (!fileContent) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        return
    }

    switch (fileContent.name.substring(fileContent.name.lastIndexOf('.') + 1).toLowerCase()) {
        case 'png': case 'jpg': case 'jpeg': case 'bmp' : break;
        default:
            elFile.val('')
            elFile.removeData('file')
            elFile.removeData('new')
            $('#txt-slider-01').val('')
            $('.seccion-banner').html(messageError(messageStringGeneric('El archivo tiene una extensión no permitida'), 'carga de archivo'))
            return
    }

    if (fileContent.size > 4194304) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        $('#txt-slider-01').val('')
        $('.seccion-banner').html(messageError(messageStringGeneric('El archivo debe tener un peso máximo de 4MB'), 'carga de archivo'))
        return
    }

    if (e.currentTarget.files.length == 0) {
        $(e.currentTarget).removeData('file')
        $(e.currentTarget).removeData('new')
        return
    }

    let reader = new FileReader();
    reader.onload = function (e) {
        let base64 = e.currentTarget.result.split(',')[1];
        nombreArchivoBanner = fileContent.name;
        $('#txt-slider-01').val(fileContent.name)
        elFile.data('file', base64);
        elFile.data('new', true);
    }
    reader.readAsDataURL(e.currentTarget.files[0]);
}

/* ================================================
 * INICIO PAGINACION BANNER
 * ================================================
 */

var cambiarPaginaRegistrosBanner = () => {
    mostrarListaBanner()
}

var cambiarPaginaBanner = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina-banner").val());
    total = Number($(".total-paginas-banner").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina-banner").val(page);
    mostrarListaBanner()
}

var mostrarListaBanner = () => {
    let registros = $('#number-registers-banner').val()
    let pagina = $('.ir-pagina-banner').val()
    let params = { registros, pagina };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}PaginaHome/mostrarListaBanner?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTablaBanner)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
};

var cargarDatosTablaBanner = (j, inicio) => {
    let tabla = $('#tbl-banner');
    tabla.find('tbody').html('');
    $('#viewPagination-banner').attr('style', 'display: none !important');
    if (j.success) {
        let rs = j.object[0];
        if (rs.totalRegistros == 0) { $('#viewPagination-banner').hide(); $('#view-page-result-banner').hide(); }
        else { $('#view-page-result-banner').show(); $('#viewPagination-banner').show(); }
        $('.inicio-registros-banner').text(rs.registros == 0 ? 'No se encontraron resultados' : (rs.pagina - 1) * rs.registros + 1);
        $('.fin-registros-banner').text(rs.totalRegistros < rs.pagina * rs.registros ? rs.totalRegistros : rs.pagina * rs.registros);
        $('.total-registros-banner').text(rs.totalRegistros);
        $('.pagina-banner').text(rs.pagina);
        $('.ir-pagina-banner').val(rs.pagina);
        $('.ir-pagina-banner').attr('max', rs.totalPaginas);
        $('.total-paginas-banner').text(rs.totalPaginas);

        let numberCellHeader = tabla.find('thead tr th').length;
        let content = renderizarPrincipal(j.object, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

        tabla.find('.btn-edit-banner').each(x => {
            let elementButton = tabla.find('.btn-edit-banner')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                actualizarBanner(e.currentTarget);
            });
        });
        tabla.find('.btn-delete-banner').each(x => {
            let elementButton = tabla.find('.btn-delete-banner')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminarBanner(e.currentTarget);
            });
        });
        //armarComboEncabezadoPrincipal(j.object)
        $('[data-toggle="tooltip"]').tooltip();
        if (inicio == null) posicinar('#tbl-banner', 120)
    } else {
        console.log('No hay resultados');
        $('#viewPagination-banner').hide(); $('#view-page-result-banner').hide();
        $('.inicio-registros-banner').text('No se encontraron resultados');
    }
}

var renderizarPrincipal = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let colCodigo = `<td class="text-center" data-encabezado="Código">BAN${pad(x.idBanner, 4)}</td>`;
            let colTituloBanner = `<td data-encabezado="Título banner" scope="row"><span>${x.tituloBanner}</span></td>`;
            let colDescripcionBanner = `<td data-encabezado="Descripción banner">${x.descripcionBanner}</td>`;
            let colDescripcionFija = `<td data-encabezado="Descripción banner">${x.descripcionFija}</td>`;
            let colTituloBoton = `<td class="text-center" data-encabezado="Título botón">${x.tituloBoton}</td>`
            let colEnlaceBoton = `<td class="text-center" data-encabezado="Posición">${x.enlaceBoton}</td>`;
            let colNombreArchivoBanner = `<td data-encabezado="Enlace botón" style="min-width:180px;"><div class="btn btn-sm btn-info btn-table"><i class="fa fa-image"></i></div><span class="ml-2">${x.nombreArchivoBanner}</span></td>`;
            let colEstado = `<td class="text-center" data-encabezado="Estado">${x.idEstado == "0" ? "Deshabilitado" : "Habilitado"}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-banner mx-1" data-id="${x.idBanner}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-banner mx-1" data-id="${x.idBanner}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colCodigo}${colTituloBanner}${colDescripcionBanner}${colDescripcionFija}${colTituloBoton}${colEnlaceBoton}${colNombreArchivoBanner}${colEstado}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

/* ================================================
 * INICIO PAGINACION BANNER
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR BANNER
 * ================================================
 */

var actualizarBanner = (obj) => {
    let id = $(obj).data('id')
    let url = `${baseUrl}PaginaHome/obtenerBanner?idBanner=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            cargarDatosBanner(j.object)
        } else {
            $('.seccion-banner').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos del banner. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var nombreArchivoGeneradoBanner = ''
var cargarDatosBanner = (data) => {
    $('#btn-grabar-banner').html('Actualizar')
    $('#btn-cancelar-banner').removeClass('d-none')
    idBanner = data.idBanner
    $("#txt-titulo-banner").val(data.tituloBanner)
    $("#txt-descripcion-banner").val(data.descripcionBanner)
    $('#txt-descripcion-fija').val(data.descripcionFija)
    $("#txt-titulo-boton").val(data.tituloBoton)
    $("#txt-enlace-boton").val(data.enlaceBoton)
    $('#fle-slider-01').val('')
    nombreArchivoBanner = data.nombreArchivoBanner
    nombreArchivoGeneradoBanner = data.nombreArchivoGeneradoBanner    
    $('#fle-slider-01').data('file', data.archivoContenidoBanner)
    $('#fle-slider-01').data('new', false)
    $('#txt-slider-01').val(data.nombreArchivoBanner)
    $('#cbo-estado-banner').val(data.idEstado)
}

/* ================================================
 * FIN ACTUALIZAR BANNER
 * ================================================
 */

/* ================================================
 * INICIO ELIMINAR BANNER
 * ================================================
 */
var idEliminarBanner = 0
var eliminarBanner = (obj) => {
    idEliminarBanner = $(obj).data('id')
    $('#modalConfirmacionBanner').modal('show')
}

var deshabilitarRegistroBanner = () => {
    let url = `${baseUrl}PaginaHome/eliminarBanner?idBanner=${idEliminarBanner}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idBanner = -1
            $('#btn-grabar-banner').html('Agregar')
            $('#btn-cancelar-banner').parent().removeClass('d-none')
            mostrarListaBanner()
            limpiarBanner()
            $('#modalConfirmacionBanner').modal('hide')
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}
/* ================================================
 * FIN ELIMINAR BANNER
 * ================================================
 */

/* ================================================
 * INICIO CANCELAR
 * ================================================
 */
var cancelarBanner = () => {
    limpiarBanner()
    $('#btn-grabar-banner').html('Agregar')
    $('#btn-cancelar-banner').addClass('d-none')
}

/* ================================================
 * FIN CANCELAR
 * ================================================
 */

/* ================================================
 * FIN BANNER
 * ================================================
 */

/* ================================================
 * INICIO PUBLICACION
 * ================================================
 */
var idPublicacion = -1
var grabarPublicacion = () => {
    $('.seccion-publicacion').html('');
    let arr = [];

    let tituloPublicacion = $("#txt-titulo-publicacion").val().trim()
    let descripcionPublicacion = $("#txt-descripcion-publicacion").val().trim()
    let limiteCaracter = $("#txt-limite-caracter").val().trim()
    let textoEnlacePublicacion = $("#txt-texto-enlace-publicacion").val().trim()
    let enlacePublicacion = $("#txt-enlace-publicacion").val().trim()
    let archivoContenidoPublicacion = $('#fle-publicacion-01').data('file')
    let idEstado = $("#cbo-estado-publicacion").val()

    if (validarEspaciosBlanco(tituloPublicacion)) arr.push("Debe ingresar el título de la publicación");
    if (validarEspaciosBlanco(descripcionPublicacion)) arr.push("Debe ingresar la descripción de la publicación");
    if (validarEspaciosBlanco(limiteCaracter)) arr.push("Debe ingresar un límite de caracter");
    else if (limiteCaracter < 1) arr.push("El límite de caracter debe ser mayor a cero");
    if (validarEspaciosBlanco(textoEnlacePublicacion)) arr.push("Debe ingresar un texto para el enlace");
    if (validarEspaciosBlanco(enlacePublicacion)) arr.push("Debe ingresar un enlace para la publicación");
    if (archivoContenidoPublicacion == undefined) arr.push('Debe cargar la imagen de la publicación')
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado")

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-publicacion').html(messageError(error, 'registro'));
        return;
    }

    let archivoNuevoPublicacion = $('#fle-publicacion-01').data('new')

    let url = `${baseUrl}PaginaHome/grabarPublicacion`;
    let data = { idPublicacion, tituloPublicacion, descripcionPublicacion, nombreArchivoPublicacion, archivoContenidoPublicacion, nombreArchivoGeneradoPubli, archivoNuevoPublicacion, limiteCaracter, textoEnlacePublicacion, enlacePublicacion, idEstado, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idPublicacion = -1
            limpiarPublicacion()
            mostrarListaPublicacion()
            $('#btn-grabar-publicacion').html('Agregar')
            $('#btn-cancelar-publicacion').addClass('d-none')
            $('.seccion-publicacion').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente')))
            setTimeout(function () {
                $('.seccion-publicacion').html('')
            }, 5000);
        } else {
            $('.seccion-publicacion').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {
                $('.seccion-publicacion').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var limpiarPublicacion = () => {
    $("#txt-titulo-publicacion").val('')
    $("#txt-descripcion-publicacion").val('')
    $('#fle-publicacion-01').val('')
    $('#fle-publicacion-01').removeData('file')
    $('#fle-publicacion-01').removeData('new')
    $('#txt-publicacion-01').val('')
    $("#txt-limite-caracter").val('300')
    $("#txt-texto-enlace-publicacion").val('')
    $("#txt-enlace-publicacion").val('')
    $('#cbo-estado-publicacion').val('1')
}

var nombreArchivoPublicacion
var fileChangePublicacion = (e) => {
    $('.seccion-publicacion').html('');
    let elFile = $(e.currentTarget);
    var fileContent = e.currentTarget.files[0];

    if (!fileContent) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        return
    }

    switch (fileContent.name.substring(fileContent.name.lastIndexOf('.') + 1).toLowerCase()) {
        case 'png': case 'jpg': case 'jpeg': case 'bmp': break;
        default:
            elFile.val('')
            elFile.removeData('file')
            elFile.removeData('new')
            $('#txt-publicacion-01').val('')
            $('.seccion-publicacion').html(messageError(messageStringGeneric('El archivo tiene una extensión no permitida'), 'carga de archivo'))
            return
    }

    if (fileContent.size > 4194304) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        $('#txt-publicacion-01').val('')
        $('.seccion-publicacion').html(messageError(messageStringGeneric('El archivo debe tener un peso máximo de 4MB'), 'carga de archivo'))
        return
    }

    if (e.currentTarget.files.length == 0) {
        $(e.currentTarget).removeData('file')
        $(e.currentTarget).removeData('new')
        return
    }

    let reader = new FileReader();
    reader.onload = function (e) {
        let base64 = e.currentTarget.result.split(',')[1];
        nombreArchivoPublicacion = fileContent.name;
        $('#txt-publicacion-01').val(fileContent.name)
        elFile.data('file', base64);
        elFile.data('new', true);
    }
    reader.readAsDataURL(e.currentTarget.files[0]);
}

/* ================================================
 * INICIO PAGINACION BANNER
 * ================================================
 */

var cambiarPaginaRegistrosPublicacion = () => {
    mostrarListaPublicacion()
}

var cambiarPaginaPublicacion = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina-publicacion").val());
    total = Number($(".total-paginas-publicacion").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina-publicacion").val(page);
    mostrarListaPublicacion()
}

var mostrarListaPublicacion = () => {
    let registros = $('#number-registers-publicacion').val()
    let pagina = $('.ir-pagina-publicacion').val()
    let params = { registros, pagina };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}PaginaHome/mostrarListaPublicacion?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTablaPublicacion)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
};

var cargarDatosTablaPublicacion = (j, inicio) => {
    let tabla = $('#tbl-publicacion');
    tabla.find('tbody').html('');
    $('#viewPagination-publicacion').attr('style', 'display: none !important');
    if (j.success) {
        let rs = j.object[0];
        if (rs.totalRegistros == 0) { $('#viewPagination-publicacion').hide(); $('#view-page-result-publicacion').hide(); }
        else { $('#view-page-result-publicacion').show(); $('#viewPagination-publicacion').show(); }
        $('.inicio-registros-publicacion').text(rs.registros == 0 ? 'No se encontraron resultados' : (rs.pagina - 1) * rs.registros + 1);
        $('.fin-registros-publicacion').text(rs.totalRegistros < rs.pagina * rs.registros ? rs.totalRegistros : rs.pagina * rs.registros);
        $('.total-registros-publicacion').text(rs.totalRegistros);
        $('.pagina-publicacion').text(rs.pagina);
        $('.ir-pagina-publicacion').val(rs.pagina);
        $('.ir-pagina-publicacion').attr('max', rs.totalPaginas);
        $('.total-paginas-publicacion').text(rs.totalPaginas);

        let numberCellHeader = tabla.find('thead tr th').length;
        let content = renderizarPublicacion(j.object, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

        tabla.find('.btn-edit-publicacion').each(x => {
            let elementButton = tabla.find('.btn-edit-publicacion')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                actualizarPublicacion(e.currentTarget);
            });
        });
        tabla.find('.btn-delete-publicacion').each(x => {
            let elementButton = tabla.find('.btn-delete-publicacion')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminarPublicacion(e.currentTarget);
            });
        });
        //armarComboEncabezadoPrincipal(j.object)
        $('[data-toggle="tooltip"]').tooltip();
        if (inicio == null) posicinar('#tbl-publicacion', 120)
    } else {
        console.log('No hay resultados');
        $('#viewPagination-publicacion').hide(); $('#view-page-result-publicacion').hide();
        $('.inicio-registros-publicacion').text('No se encontraron resultados');
    }
}

var renderizarPublicacion = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let colCodigo = `<td class="text-center" data-encabezado="Código">PUB${pad(x.idPublicacion, 4)}</td>`;
            let colTituloPublicacion = `<td data-encabezado="Título banner" scope="row"><span>${x.tituloPublicacion}</span></td>`;
            let colDescripcionPublicacion = `<td data-encabezado="Descripción banner">${x.descripcionPublicacion}</td>`;
            let colNombreArchivoPublicacion = `<td data-encabezado="Enlace botón" style="min-width:180px;"><div class="btn btn-sm btn-info btn-table"><i class="fa fa-image"></i></div><span class="ml-2">${x.nombreArchivoPublicacion}</span></td>`;
            let colEnlacePublicacion = `<td data-encabezado="Enlace publicación">${x.enlacePublicacion}</td>`;
            let colEstado = `<td class="text-center" data-encabezado="Estado">${x.idEstado == "0" ? "Deshabilitado" : "Habilitado"}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-publicacion mx-1" data-id="${x.idPublicacion}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-publicacion mx-1" data-id="${x.idPublicacion}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colCodigo}${colTituloPublicacion}${colDescripcionPublicacion}${colNombreArchivoPublicacion}${colEnlacePublicacion}${colEstado}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

/* ================================================
 * FIN PAGINACION PUBLICACION
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR PUBLICACION
 * ================================================
 */

var actualizarPublicacion = (obj) => {
    let id = $(obj).data('id')
    let url = `${baseUrl}PaginaHome/obtenerPublicacion?idPublicacion=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            cargarDatosPublicacion(j.object)
        } else {
            $('.seccion-publicacion').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la publicación. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var nombreArchivoGeneradoPubli = ''
var cargarDatosPublicacion = (data) => {
    $('#btn-grabar-publicacion').html('Actualizar')
    $('#btn-cancelar-publicacion').removeClass('d-none')
    idPublicacion = data.idPublicacion
    $("#txt-titulo-publicacion").val(data.tituloPublicacion)
    $("#txt-descripcion-publicacion").val(data.descripcionPublicacion)
    $('#fle-publicacion-01').val('')
    nombreArchivoPublicacion = data.nombreArchivoPublicacion
    nombreArchivoGeneradoPubli = data.nombreArchivoGeneradoPubli
    $('#fle-publicacion-01').data('file', data.archivoContenidoPublicacion)
    $('#fle-publicacion-01').data('new', false)
    $('#txt-publicacion-01').val(data.nombreArchivoPublicacion)
    $("#txt-limite-caracter").val(data.limiteCaracter)
    $("#txt-texto-enlace-publicacion").val(data.textoEnlacePublicacion)
    $("#txt-enlace-publicacion").val(data.enlacePublicacion)
    $('#cbo-estado-publicacion').val(data.idEstado)
}

/* ================================================
 * FIN ACTUALIZAR PUBLICACION
 * ================================================
 */

/* ================================================
 * INICIO ELIMINAR PUBLICACION
 * ================================================
 */
var idEliminarPublicacion = 0
var eliminarPublicacion = (obj) => {
    idEliminarPublicacion = $(obj).data('id')
    $('#modalConfirmacionPublicacion').modal('show')
}

var deshabilitarRegistroPublicacion = () => {
    let url = `${baseUrl}PaginaHome/eliminarPublicacion?idPublicacion=${idEliminarPublicacion}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idPublicacion = -1
            $('#btn-grabar-publicacion').html('Agregar')
            $('#btn-cancelar-publicacion').parent().removeClass('d-none')
            mostrarListaPublicacion()
            limpiarPublicacion()
            $('#modalConfirmacionPublicacion').modal('hide')
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}
/* ================================================
 * FIN ELIMINAR PUBLICACION
 * ================================================
 */

/* ================================================
 * INICIO CANCELAR
 * ================================================
 */
var cancelarPublicacion = () => {
    limpiarPublicacion()
    $('#btn-grabar-publicacion').html('Agregar')
    $('#btn-cancelar-publicacion').addClass('d-none')
}

/* ================================================
 * FIN CANCELAR
 * ================================================
 */

/* ================================================
 * FIN PUBLICACION
 * ================================================
 */

/* ================================================
 * INICIO ENLACE
 * ================================================
 */

var idEnlace = -1
var grabarEnlace = () => {
    $('.seccion-enlace').html('');
    let arr = [];

    let tituloEnlace = $("#txt-titulo-enlace").val().trim()
    let descripcionEnlace = $("#txt-descripcion-enlace").val().trim()
    let idEstado = $("#cbo-estado-enlace").val()

    if (validarEspaciosBlanco(tituloEnlace)) arr.push("Debe ingresar el título del enlace");
    if (validarEspaciosBlanco(descripcionEnlace)) arr.push("Debe ingresar la descripción del enlace");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-enlace').html(messageError(error, 'registro'));
        return;
    }

    let url = `${baseUrl}PaginaHome/grabarEnlace`;
    let data = {
        idEnlace, tituloEnlace, descripcionEnlace, idEstado, idUsuarioCreacion: idUsuarioLogin
    };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idEnlace = -1
            limpiarEnlace()
            mostrarListaEnlace()
            $('#btn-grabar-enlace').html('Agregar')
            $('#btn-cancelar-enlace').addClass('d-none')
            $('.seccion-enlace').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente')))
            setTimeout(function () {
                $('.seccion-enlace').html('')
            }, 5000);
        } else {
            $('.seccion-enlace').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {
                $('.seccion-enlace').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var limpiarEnlace = () => {
    $("#txt-titulo-enlace").val('')
    $("#txt-descripcion-enlace").val('')
    $('#cbo-estado-enlace').val('1')
}

/* ================================================
 * INICIO PAGINACION ENLACE
 * ================================================
 */

var cambiarPaginaRegistrosEnlace = () => {
    mostrarListaEnlace()
}

var cambiarPaginaEnlace = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina-enlace").val());
    total = Number($(".total-paginas-enlace").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina-enlace").val(page);
    mostrarListaEnlace()
}

var mostrarListaEnlace = () => {
    let registros = $('#number-registers-enlace').val()
    let pagina = $('.ir-pagina-enlace').val()
    let params = { registros, pagina };
    let queryParams = Object.keys(params).map(x => params[x] == null ? x : `${x}=${params[x]}`).join('&')

    let url = `${baseUrl}PaginaHome/mostrarListaEnlace?${queryParams}`;
    let headers = new Headers();
    headers.append('Content-Type', 'application/json');
    let method = 'GET';

    const request = new Request(url, { method: method, headers: headers });
    fetch(request)
        .then(r => {
            if (r.status == 204) return null;
            else return r.json();
        })
        .then(cargarDatosTablaEnlace)
    .catch(error => {
        console.log('Error: ' + error.message);
    });
};

var cargarDatosTablaEnlace = (j, inicio) => {
    let tabla = $('#tbl-enlace');
    tabla.find('tbody').html('');
    $('#viewPagination-enlace').attr('style', 'display: none !important');
    if (j.success) {
        let rs = j.object[0];
        if (rs.totalRegistros == 0) { $('#viewPagination-enlace').hide(); $('#view-page-result-enlace').hide(); }
        else { $('#view-page-result-enlace').show(); $('#viewPagination-enlace').show(); }
        $('.inicio-registros-enlace').text(rs.registros == 0 ? 'No se encontraron resultados' : (rs.pagina - 1) * rs.registros + 1);
        $('.fin-registros-enlace').text(rs.totalRegistros < rs.pagina * rs.registros ? rs.totalRegistros : rs.pagina * rs.registros);
        $('.total-registros-enlace').text(rs.totalRegistros);
        $('.pagina-enlace').text(rs.pagina);
        $('.ir-pagina-enlace').val(rs.pagina);
        $('.ir-pagina-enlace').attr('max', rs.totalPaginas);
        $('.total-paginas-enlace').text(rs.totalPaginas);

        let numberCellHeader = tabla.find('thead tr th').length;
        let content = renderizarEnlace(j.object, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

        tabla.find('.btn-edit-enlace').each(x => {
            let elementButton = tabla.find('.btn-edit-enlace')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                actualizarEnlace(e.currentTarget);
            });
        });

        tabla.find('.btn-delete-enlace').each(x => {
            let elementButton = tabla.find('.btn-delete-enlace')[x];
            $(elementButton).on('click', (e) => {
                e.preventDefault();
                eliminarEnlace(e.currentTarget);
            });
        });
        //armarComboEncabezadoPrincipal(j.object)
        $('[data-toggle="tooltip"]').tooltip();
        if (inicio == null) posicinar('#tbl-enlace', 120)
    } else {
        console.log('No hay resultados');
        $('#viewPagination-publicacion').hide(); $('#view-page-result-publicacion').hide();
        $('.inicio-registros-publicacion').text('No se encontraron resultados');
    }
}

var renderizarEnlace = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let colCodigo = `<td class="text-center" data-encabezado="Código">ENL${pad(x.idEnlace, 4)}</td>`;
            let colTituloEnlace = `<td data-encabezado="Título enlace" scope="row"><span>${x.tituloEnlace}</span></td>`;
            let colDescripcionEnlace = `<td data-encabezado="Descripción enlace">${x.descripcionEnlace}</td>`;
            let colEstado = `<td class="text-center" data-encabezado="Estado">${x.idEstado == "0" ? "Deshabilitado" : "Habilitado"}</td>`;
            let btnEliminar = `<div class="btn btn-sm btn-danger btn-table btn-delete-enlace mx-1" data-id="${x.idEnlace}"><i class="fa fa-trash"></i></div>`;
            let btnEditar = `<div class="btn btn-sm btn-info btn-table btn-edit-enlace mx-1" data-id="${x.idEnlace}"><i class="fa fa-edit"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEliminar}${btnEditar}</td>`;
            let row = `<tr>${colCodigo}${colTituloEnlace}${colDescripcionEnlace}${colEstado}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

/* ================================================
 * FIN PAGINACION ENLACE
 * ================================================
 */

/* ================================================
 * INICIO ACTUALIZAR ENLACE
 * ================================================
 */

var actualizarEnlace = (obj) => {
    let id = $(obj).data('id')
    let url = `${baseUrl}PaginaHome/obtenerEnlace?idEnlace=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            cargarDatosEnlace(j.object)
        } else {
            $('.seccion-enlace').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la publicación. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var cargarDatosEnlace = (data) => {
    $('#btn-grabar-enlace').html('Actualizar')
    $('#btn-cancelar-enlace').removeClass('d-none')
    idEnlace = data.idEnlace
    $("#txt-titulo-enlace").val(data.tituloEnlace)
    $("#txt-descripcion-enlace").val(data.descripcionEnlace)
    $('#cbo-estado-enlace').val(data.idEstado)
}

/* ================================================
 * FIN ACTUALIZAR PUBLICACION
 * ================================================
 */

/* ================================================
 * INICIO ELIMINAR PUBLICACION
 * ================================================
 */
var idEliminarEnlace = 0
var eliminarEnlace = (obj) => {
    idEliminarEnlace = $(obj).data('id')
    $('#modalConfirmacionEnlace').modal('show')
}

var deshabilitarRegistroEnlace = () => {
    let url = `${baseUrl}PaginaHome/eliminarEnlace?idEnlace=${idEliminarEnlace}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            idEnlace = -1
            $('#btn-grabar-enlace').html('Agregar')
            $('#btn-cancelar-enlace').parent().removeClass('d-none')
            mostrarListaEnlace()
            limpiarEnlace()
            $('#modalConfirmacionEnlace').modal('hide')
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}
/* ================================================
 * FIN ELIMINAR PUBLICACION
 * ================================================
 */

/* ================================================
 * INICIO CANCELAR
 * ================================================
 */
var cancelarEnlace = () => {
    limpiarEnlace()
    $('#btn-grabar-enlace').html('Agregar')
    $('#btn-cancelar-enlace').addClass('d-none')
}

/* ================================================
 * FIN CANCELAR
 * ================================================
 */

/* ================================================
 * FIN ENLACE
 * ================================================
 */

/* ================================================
 * INICIO LOGO RED SOCIAL
 * ================================================
 */

var idLogoRedSocial = -1
var grabarLogoRedSocial = () => {
    $('.seccion-logo').html('');
    let arr = [];

    let archivoContenidoLogoWeb = $('#fle-web-01').data('file')
    let archivoContenidoLogoDgee = $('#fle-dgee-01').data('file')
    let enlaceFacebook = $("#txt-facebook").val().trim()
    let enlaceTwiter = $("#txt-twiter").val().trim()
    let enlaceInstangram = $("#txt-instangram").val().trim()
    let enlaceYoutube = $("#txt-youtube").val().trim()
    let enlaceWhatsApp = $("#txt-whatsapp").val().trim()
    let enlaceLinkedin = $("#txt-linkedin").val().trim()
    let tituloNavegador = $('#txt-titulo-navegador').val()
    let chatbot = $('#chk-chatbot').prop('checked') ? '1' : '0'
    
    if (archivoContenidoLogoWeb == undefined) arr.push('Debe cargar la imagen principal de la web')
    if (archivoContenidoLogoDgee == undefined) arr.push('Debe cargar la imagen de la DGEE')
    //if (validarEspaciosBlanco(enlaceFacebook)) arr.push("Debe ingresar el enlace para Facebook");
    //if (validarEspaciosBlanco(enlaceTwiter)) arr.push("Debe ingresar el enlace para Twiter");
    //if (validarEspaciosBlanco(enlaceInstangram)) arr.push("Debe ingresar el enlace para Instangram");
    //if (validarEspaciosBlanco(enlaceYoutube)) arr.push("Debe ingresar el enlace para Youtube");
    //if (validarEspaciosBlanco(enlaceWhatsApp)) arr.push("Debe ingresar el enlace para WhatsApp");
    //if (validarEspaciosBlanco(enlaceLinkedin)) arr.push("Debe ingresar el enlace para Linkedin");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-logo').html(messageError(error, 'registro'));
        return;
    }

    let archivoNuevoLogoWeb = $('#fle-web-01').data('new')
    let archivoNuevoLogoDgee = $('#fle-dgee-01').data('new')

    let url = `${baseUrl}PaginaHome/grabarLogoRedSocial`;
    let data = {
        idLogoRedSocial,
        nombreArchivoLogoWeb, nombreArchivoGeneradoLogoWeb, archivoNuevoLogoWeb, archivoContenidoLogoWeb,
        nombreArchivoLogoDgee, nombreArchivoGeneradoLogoDgee, archivoNuevoLogoDgee, archivoContenidoLogoDgee,
        enlaceFacebook, enlaceTwiter, enlaceInstangram, enlaceYoutube, enlaceWhatsApp, enlaceLinkedin, tituloNavegador, chatbot, idUsuarioCreacion: idUsuarioLogin
        };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            let entidad = j.object
            idLogoRedSocial = entidad.idLogoRedSocial
            cargarDatosLogoRedSocial(entidad)
            $('.seccion-logo').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente')))
            setTimeout(function () {
                $('.seccion-logo').html('')
            }, 5000);
        } else {
            $('.seccion-logo').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
            setTimeout(function () {
                $('.seccion-logo').html('')
            }, 5000);
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var nombreArchivoLogoWeb
var fileChangeLogoWeb = (e) => {
    $('.seccion-logo').html('');
    let elFile = $(e.currentTarget);
    var fileContent = e.currentTarget.files[0];

    if (!fileContent) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        return
    }

    switch (fileContent.name.substring(fileContent.name.lastIndexOf('.') + 1).toLowerCase()) {
        case 'png': case 'jpg': case 'jpeg': case 'bmp': break;
        default:
            elFile.val('')
            elFile.removeData('file')
            elFile.removeData('new')
            $('#txt-web-01').val('')
            $('.seccion-logo').html(messageError(messageStringGeneric('El archivo tiene una extensión no permitida'), 'carga de archivo'))
            return
    }

    if (fileContent.size > 4194304) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        $('#txt-web-01').val('')
        $('.seccion-logo').html(messageError(messageStringGeneric('El archivo debe tener un peso máximo de 4MB'), 'carga de archivo'))
        return
    }

    if (e.currentTarget.files.length == 0) {
        $(e.currentTarget).removeData('file')
        $(e.currentTarget).removeData('new')
        return
    }

    let reader = new FileReader();
    reader.onload = function (e) {
        let base64 = e.currentTarget.result.split(',')[1];
        nombreArchivoLogoWeb = fileContent.name;
        $('#txt-web-01').val(fileContent.name)
        elFile.data('file', base64);
        elFile.data('new', true);
    }
    reader.readAsDataURL(e.currentTarget.files[0]);
}

var nombreArchivoLogoDgee
var fileChangeLogoDgee = (e) => {
    $('.seccion-logo').html('');
    let elFile = $(e.currentTarget);
    var fileContent = e.currentTarget.files[0];

    if (!fileContent) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        return
    }

    switch (fileContent.name.substring(fileContent.name.lastIndexOf('.') + 1).toLowerCase()) {
        case 'png': case 'jpg': case 'jpeg': case 'bmp': break;
        default:
            elFile.val('')
            elFile.removeData('file')
            elFile.removeData('new')
            $('#txt-dgee-01').val('')
            $('.seccion-logo').html(messageError(messageStringGeneric('El archivo tiene una extensión no permitida'), 'carga de archivo'))
            return
    }

    if (fileContent.size > 4194304) {
        elFile.val('')
        elFile.removeData('file')
        elFile.removeData('new')
        $('#txt-dgee-01').val('')
        $('.seccion-logo').html(messageError(messageStringGeneric('El archivo debe tener un peso máximo de 4MB'), 'carga de archivo'))
        return
    }

    if (e.currentTarget.files.length == 0) {
        $(e.currentTarget).removeData('file')
        $(e.currentTarget).removeData('new')
        return
    }

    let reader = new FileReader();
    reader.onload = function (e) {
        let base64 = e.currentTarget.result.split(',')[1];
        nombreArchivoLogoDgee = fileContent.name;
        $('#txt-dgee-01').val(fileContent.name)
        elFile.data('file', base64);
        elFile.data('new', true);
    }
    reader.readAsDataURL(e.currentTarget.files[0]);
}

var nombreArchivoGeneradoLogoWeb = ''
var nombreArchivoGeneradoLogoDgee = ''
var cargarDatosLogoRedSocial = (data) => {
    if (data == null) return
    idLogoRedSocial = data.idLogoRedSocial

    $("#txt-facebook").val(data.enlaceFacebook)
    $("#txt-twiter").val(data.enlaceTwiter)
    $("#txt-instangram").val(data.enlaceInstangram)
    $("#txt-youtube").val(data.enlaceYoutube)
    $("#txt-whatsapp").val(data.enlaceWhatsApp)
    $("#txt-linkedin").val(data.enlaceLinkedin)

    $('#fle-web-01').val('')
    nombreArchivoLogoWeb = data.nombreArchivoLogoWeb
    nombreArchivoGeneradoLogoWeb = data.nombreArchivoGeneradoLogoWeb
    $('#fle-web-01').data('file', data.archivoContenidoLogoWeb)
    $('#fle-web-01').data('new', false)
    $('#txt-web-01').val(data.nombreArchivoLogoWeb)

    $('#fle-dgee-01').val('')
    nombreArchivoLogoDgee = data.nombreArchivoLogoDgee
    nombreArchivoGeneradoLogoDgee = data.nombreArchivoGeneradoLogoDgee
    $('#fle-dgee-01').data('file', data.archivoContenidoLogoDgee)
    $('#fle-dgee-01').data('new', false)
    $('#txt-dgee-01').val(data.nombreArchivoLogoDgee)
}

/* ================================================
 * FIN LOGO RED SOCIAL
 * ================================================
 */

var cargarDatos = () => {
    cargarDatosTablaBanner(listaBanner, 1)
    cargarDatosTablaPublicacion(listaPublicacion, 1)
    cargarDatosTablaEnlace(listaEnlace, 1)
    cargarDatosLogoRedSocial(logoRedSocial)
}

var posicinar = (id, number) => {
    var target_offset = $(id).offset();
    var target_top = target_offset.top - number;
    $('html,body').animate({ scrollTop: target_top }, { duration: "slow" });
}