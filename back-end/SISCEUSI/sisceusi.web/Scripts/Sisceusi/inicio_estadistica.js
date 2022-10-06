var arrDepartamento = []
var arrProvincia = []
var arrDistrito = []
var arrListaPlanta = []
var arrListaIndicador = []
var arrPlantaFiltrado = []
$(document).ready(() => {
    $('#cbo-departamento').on('change', (e) => cambiarDepartamento())
    $('#cbo-provincia').on('change', (e) => cambiarProvincia())
    $('#cbo-distrito').on('change', (e) => cambiarDistrito())
    $('.ir-pagina').on('change', (e) => cargarTablaPlanta());
    $('#number-registers').on('change', (e) => cargarTablaPlanta());
    cargarDatos()
    google.charts.setOnLoadCallback(drawMap)
});

var cargarDatos = () => {
    if (idRolLogin == null) $('#tbl-planta').html('')
    //filtrar indicador
    arrListaIndicador = listaIndicador
    if (idRolLogin == 3) {
        arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.idPlantaEmpresa == idPlanta)
        arrDepartamento = arrListaPlanta.map(x => x.plantaEmpresa.departamento)
        arrDepartamento = [
        ...new Map(arrDepartamento.map((item) =>[item["idDepartamento"], item])).values(),
        ]
        arrProvincia = arrListaPlanta.map(x => x.plantaEmpresa.provincia)
        arrProvincia = [
        ...new Map(arrProvincia.map((item) =>[item["idProvincia"], item])).values(),
        ]
        arrDistrito = arrListaPlanta.map(x => x.plantaEmpresa.distrito)
        arrDistrito = [
        ...new Map(arrDistrito.map((item) =>[item["idDistrito"], item])).values(),
        ]
    } else if (idRolLogin == 2) {
        arrListaPlanta = listaControlEncuesta.filter(x => x.idSupervisor == idUsuarioLogin)
        arrDepartamento = arrListaPlanta.map(x => x.plantaEmpresa.departamento)
        arrDepartamento = [
        ...new Map(arrDepartamento.map((item) =>[item["idDepartamento"], item])).values(),
        ]
        arrProvincia = arrListaPlanta.map(x => x.plantaEmpresa.provincia)
        arrProvincia = [
        ...new Map(arrProvincia.map((item) =>[item["idProvincia"], item])).values(),
        ]
        arrDistrito = arrListaPlanta.map(x => x.plantaEmpresa.distrito)
        arrDistrito = [
        ...new Map(arrDistrito.map((item) =>[item["idDistrito"], item])).values(),
        ]
    } else {
        arrListaPlanta = listaControlEncuesta
        arrDepartamento = listaControlEncuesta.map(x => x.plantaEmpresa.departamento)
        arrDepartamento = [
        ...new Map(arrDepartamento.map((item) =>[item["idDepartamento"], item])).values(),
        ]
        arrProvincia = listaControlEncuesta.map(x => x.plantaEmpresa.provincia)
        arrProvincia = [
        ...new Map(arrProvincia.map((item) =>[item["idProvincia"], item])).values(),
        ]
        arrDistrito = listaControlEncuesta.map(x => x.plantaEmpresa.distrito)
        arrDistrito = [
        ...new Map(arrDistrito.map((item) =>[item["idDistrito"], item])).values(),
        ]
    }

    cargarDepartamento(arrDepartamento)
    cargarIndicadores()
    cargarTablaPlanta()
    cambiarDepartamento()
}

var cargarDepartamento = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idDepartamento}">${x.departamento}</option>`).join('');
    options = `<option value="0">-Seleccione un departamento-</option>${options}`;
    $('#cbo-departamento').html(options);
}

var departamento
var cambiarDepartamento = () => {
    departamento = $('#cbo-departamento').val()
    provincia = "0"
    distrito = "0"
    $('#cbo-distrito').html(`<option value="0">-Seleccione un distrito-</option>`);
    if (validarCombo(departamento)) {
        departamento = "0"        
        $('#cbo-provincia').html(`<option value="0">-Seleccione una provincia-</option>`)
        //arrListaPlanta = listaControlEncuesta
        arrPlantaFiltrado = arrListaPlanta
    } else {
        const data = arrProvincia.filter(x => x.idProvincia.substr(0, 2) === departamento)
        let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idProvincia}">${x.provincia}</option>`).join('');
        options = `<option value="0">-Seleccione una provincia-</option>${options}`;
        $('#cbo-provincia').html(options);
        //arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento)
        arrPlantaFiltrado = arrListaPlanta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento)
    }
    google.charts.setOnLoadCallback(drawMap)
    armarIndicador(indicador)
    cargarTablaPlanta()
    //google.charts.setOnLoadCallback(drawPieChart);
}

var provincia
var cambiarProvincia = () => {
    distrito = "0"
    provincia = $('#cbo-provincia').val()
    if (validarCombo(provincia)) {
        provincia = "0"        
        $('#cbo-distrito').html(`<option value="0">-Seleccione un distrito-</option>`);
        //arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento)
        arrPlantaFiltrado = arrListaPlanta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento)
    } else {
        const data = arrDistrito.filter(x => x.idDistrito.substr(0, 4) === provincia)
        let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idDistrito}">${x.distrito}</option>`).join('');
        options = `<option value="0">-Seleccione un distrito-</option>${options}`;
        $('#cbo-distrito').html(options);
        //arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia)
        arrPlantaFiltrado = arrListaPlanta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia)
    }
    google.charts.setOnLoadCallback(drawMap)
    armarIndicador(indicador)
    cargarTablaPlanta()
}

var distrito
var cambiarDistrito = () => {
    distrito = $('#cbo-distrito').val()
    if (validarCombo(distrito)) {
        distrito = "0"
        //arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia)
        arrPlantaFiltrado = arrListaPlanta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia)
    } else {
        //arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia && x.plantaEmpresa.distrito.idDistrito === distrito)
        arrPlantaFiltrado = arrListaPlanta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia && x.plantaEmpresa.distrito.idDistrito === distrito)
    }
    google.charts.setOnLoadCallback(drawMap)
    armarIndicador(indicador)
    cargarTablaPlanta()
}

var cargarIndicadores = () => {
    let options = arrListaIndicador.length == 0 ? '' : arrListaIndicador.map(x => {
        return `<tr>` +
                    `<td data-encabezado="INDICADORES" scope="row">` +
                        `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="Título de ayuda"></i>${x.nombreIndicador}` +
                    `</td>` +
                    `<td class ="text-center" data-encabezado="Seleccionar">` +
                        `<div class ="form-check form-check-inline">` +
                            `<input class="form-check-input" id="ind-${x.idIndicador}" type="radio" name="radio-tabla">` +
                        `</div>` +
                    `</td>` +
                `</tr>`
    }).join('');
    $('#tbl-indicador').find('tbody').html(options);
    if (arrListaIndicador.length < 10) $('#seccion-indicadores').attr('style', 'height: 500px;')
}

var indicador = null
$(document).on('click', '[name="radio-tabla"]', (e) => {
    let id = $(e.currentTarget)[0].id.split('-')[1]
    indicador = arrListaIndicador.find(x => x.idIndicador == id)
    armarIndicador(indicador)
})

var armarIndicador = (indicador) => {
    if (indicador == null) return

    //let arrIndicadorAgrupacion = indicador.indicadorAgrupacion
    //let arrIndicadorCalculo = indicador.indicadorCalculo
    //if (distrito && distrito != '0') {
    //    arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
    //    arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
    //} else if (provincia && provincia != '0') {
    //    arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
    //    arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
    //} else if (departamento && departamento != '0') {
    //    arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
    //    arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
    //}

    if (indicador.idMetodoCalculo == 1) { //suma
        if (indicador.idTipoControl == 5) {
            //let total = indicador.indicadorTablaMaestra.sum(x => x.valor)
            //initialValue = 0
            //let total = indicador.indicadorCalculo.reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)

            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla
                }
            })

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })
            //console.log(arrReporte)
            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
            //alert(total)
        } else {

        }
    } else if (indicador.idMetodoCalculo == 2) { //conteo
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla
                }
            })

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).length
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {

        }
    } else if (indicador.idMetodoCalculo == 3) { //Maximo
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla
                }
            })

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = Math.max(arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).map(x => x.valor))
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {

        }
    } else if (indicador.idMetodoCalculo == 4) { //Minimo
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla
                }
            })

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = Math.min(arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).map(x => x.valor))
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {

        }
    } else if (indicador.idMetodoCalculo == 5) { //Promedio
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla
                }
            })

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let cantidad = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).length
                let suma = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                let promedio = cantidad <= 0 ? 0 : suma/cantidad
                let arr = [e.etiqueta, promedio]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {

        }
    }
}

var validarAgrupacion = (arrIndicadorAgrupacion) => {
    if (distrito && distrito != '0') {
        if (idRolLogin == 3) {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        } else if (idRolLogin == 2) {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        } else {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        }        
    } else if (provincia && provincia != '0') {
        if (idRolLogin == 3) {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        } else if (idRolLogin == 2) {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        } else {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        }        
    } else if (departamento && departamento != '0') {
        if (idRolLogin == 3) {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        } else if (idRolLogin == 2) {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        } else {
            arrIndicadorAgrupacion = arrIndicadorAgrupacion.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        }
    }
    return arrIndicadorAgrupacion
}

var validarCalculo = (arrIndicadorCalculo) => {
    if (distrito && distrito != '0') {
        if (idRolLogin == 3) {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        } else if (idRolLogin == 2) {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        } else {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        }
        //arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
    } else if (provincia && provincia != '0') {
        if (idRolLogin == 3) {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        } else if (idRolLogin == 2) {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        } else {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        }
        //arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
    } else if (departamento && departamento != '0') {
        if (idRolLogin == 3) {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        } else if (idRolLogin == 2) {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        } else {
            arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        }
        //arrIndicadorCalculo = arrIndicadorCalculo.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
    }
    return arrIndicadorCalculo
}

var cambiarPagina = (boton) => {
    var total = 0, page = 0;
    page = Number($(".ir-pagina").val());
    total = Number($(".total-paginas").text());

    if (boton == 1) page = 1;
    if (boton == 2) if (page > 1) page--;
    if (boton == 3) if (page < total) page++;
    if (boton == 4) page = total;

    $(".ir-pagina").val(page);
    cargarTablaPlanta()
}

var cargarTablaPlanta = () => {
    let registroMostrar = $('#number-registers').val()
    let paginaActual = $(".ir-pagina").val()    

    let totalReg = arrPlantaFiltrado.length
    let totalPag = Math.ceil(totalReg / registroMostrar)

    if (paginaActual <= 0) paginaActual = 1
    if (paginaActual > totalPag) paginaActual = totalPag

    let arrPlantaFiltro = []
    for (let i = (paginaActual - 1) * registroMostrar; i < (paginaActual * registroMostrar) ; i++) {
        if (arrPlantaFiltrado[i] != undefined) arrPlantaFiltro.push(arrPlantaFiltrado[i])
        //listing_table.innerHTML += obj[i].number + "<br>";
    }

    let rs = {
        registros: registroMostrar,
        pagina: paginaActual,
        totalRegistros: totalReg,
        totalPaginas: totalPag
    }
    cargarDatosTabla(rs, arrPlantaFiltro)
}

var cargarDatosTabla = (rs, arrPlantaFiltro) => {
    let tabla = $('#tbl-planta');
    tabla.find('tbody').html('');
    $('#viewPagination').attr('style', 'display: none !important');
    if (arrPlantaFiltro.length > 0) {
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
        let content = renderizar(arrPlantaFiltro, numberCellHeader, rs.pagina, rs.registros);
        tabla.find('tbody').html(content);

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

var renderizar = (data, numberCellHeader, pagina, registros) => {
    let doRenderizar = data.length > 0;
    let content = `<tr><th colspan='${numberCellHeader}'>No existe información</th></tr>`;

    if (doRenderizar) {
        content = data.map((x, i) => {
            let colCodigo = `<td class="text-center" data-encabezado="Código">CUE${pad(x.numeroCuestionario, 4)}</td>`;
            let colEmpresa = `<td data-encabezado="Empresa">${x.plantaEmpresa.empresa.nombreEmpresa}</td>`;
            let colPlanta = `<td data-encabezado="Planta"><span>${x.plantaEmpresa.denominacion}</span></td>`
            let colDepartamento = `<td data-encabezado="Departamento">${x.plantaEmpresa.departamento.departamento}</td>`;
            let colProvincia = `<td data-encabezado="Departamento">${x.plantaEmpresa.provincia.provincia}</td>`;
            let colDistrito = `<td data-encabezado="Departamento">${x.plantaEmpresa.distrito.distrito}</td>`;
            let btnEditar = `<div class="btn btn-sm btn-success btn-table btn-observar" data-id="${x.idControlEncuesta}"><i class="fa fa-eye"></i></div>`;
            let colOptions = `<td class="text-center text-center text-xs-right" data-encabezado="Gestión">${btnEditar}</td>`;
            let row = `<tr>${colCodigo}${colEmpresa}${colPlanta}${colDepartamento}${colProvincia}${colDistrito}${colOptions}</tr>`;
            return row;
        }).join('');
    };
    return content;
};

var drawMap = () => {

    let arrMapa = []
    arrMapa.push(['Latitud', 'Longitud', 'Nombre', 'Marker'])
    arrPlantaFiltrado.forEach(x => {
        let arr = []
        arr.push(parseInt(x.plantaEmpresa.latitud))
        arr.push(parseInt(x.plantaEmpresa.longitud))
        arr.push(idRolLogin == null ? "" : x.plantaEmpresa.denominacion)
        arr.push('blue')
        arrMapa.push(arr)
    })

    //var data = google.visualization.arrayToDataTable([
    //['Latitud', 'Longitud', 'Nombre', 'Marker'],
    //[-9.189967, -75.015152, 'UBICACIÓN NÚMERO 01', 'blue'],
    //[-6.459052, -77.927939, 'UBICACIÓN NÚMERO 02', 'green'],
    //[-12.352521, -72.211233, 'UBICACIÓN NÚMERO 03', 'pink'],
    //[-11.965887, -76.081003, 'UBICACIÓN NÚMERO 04', 'green']
    //]);
    var data = google.visualization.arrayToDataTable(arrMapa);
    var url = 'https://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/';
    var options = {
        mapType: 'styledMap',
        zoomLevel: 5,
        showTooltip: true,
        showInfoWindow: true,
        useMapTypeControl: false,
        icons: {
            blue: {
                normal: url + 'Map-Marker-Ball-Azure-icon.png',
                selected: url + 'Map-Marker-Ball-Right-Azure-icon.png'
            },
            green: {
                normal: url + 'Map-Marker-Push-Pin-1-Chartreuse-icon.png',
                selected: url + 'Map-Marker-Push-Pin-1-Right-Chartreuse-icon.png'
            },
            pink: {
                normal: url + 'Map-Marker-Ball-Pink-icon.png',
                selected: url + 'Map-Marker-Ball-Right-Pink-icon.png'
            }
        },
        maps: {
            // Your custom mapTypeId holding custom map styles.
            styledMap: {
                name: 'Styled Map', // This name will be displayed in the map type control.
                styles: [
                  { featureType: 'poi.attraction', stylers: [{ color: '#fce8b2' }] },
                  { featureType: 'road.highway', stylers: [{ hue: '#0277bd' }, { saturation: -50 }] },
                  { featureType: 'road.highway', elementType: 'labels.icon', stylers: [{ hue: '#000' }, { saturation: 100 }, { lightness: 50 }] },
                  { featureType: 'landscape', stylers: [{ hue: '#259b24' }, { saturation: 10 }, { lightness: -22 }] }
                ]
            }
        }
    };
    var map = new google.visualization.Map(document.getElementById('chart_div'));
    map.draw(data, options);
};

var drawPieChart = (arr) => {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Nombre');
    data.addColumn('number', 'Valor');
    //data.addRows([
    //  ['Valor 01', 3],
    //  ['Valor 02', 1],
    //  ['Valor 03', 2],
    //  ['Valor 04', 1]
    //]);
    data.addRows(arr)
    var options = {
        // title:'TOTAL ENERGÍA COMPRADA',
        backgroundColor: '#f8f9fa',
        legend: { position: 'bottom' },
        // 'width':400,
        // 'height':300
    };
    var chart = new google.visualization.PieChart(document.getElementById('pie-chart'));
    chart.draw(data, options);
}

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