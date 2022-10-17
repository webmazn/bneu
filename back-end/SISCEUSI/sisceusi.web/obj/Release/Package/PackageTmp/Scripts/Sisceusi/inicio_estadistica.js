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

            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.filter(x => x.etiqueta !== "").map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla,
                    "controlEncuesta": x.controlEncuesta.idControlEncuesta
                }
            })

            let arrIntegrado = []
            arrEtiqueta.forEach(e => {
                let arr = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla && x.controlEncuesta.idControlEncuesta == e.controlEncuesta).map(x => {
                    return {
                        'etiqueta': e.etiqueta,
                        'valor': x.valor,
                    }
                })
                arr.forEach(x => {
                    arrIntegrado.push(x)
                })
            })

            initialValue = 0
            let arrReporte = []
            arrIntegrado.forEach(x => {
                let index = arrReporte.findIndex(e => e[0] === x.etiqueta)
                if (index == -1) {
                    let suma = arrIntegrado.filter(e => e.etiqueta == x.etiqueta).reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                    let arr = [x.etiqueta, suma]
                    arrReporte.push(arr)
                }
            })

            /*initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })*/

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))

        } else {
            let arrIndicadorCampanaEncuesta = validarCampanaEncuesta(indicador.indicadorCampanaEncuesta)

            let arrEtiqueta = []
            if (indicador.idTipoControl == 1) {
                arrEtiqueta.push({ "etiqueta": "" })
            } else {
                arrEtiqueta = arrIndicadorCampanaEncuesta.map(x => {
                    return {
                        "etiqueta": x.etiqueta
                    }
                })
                arrEtiqueta = [
                    ...new Map(arrEtiqueta.map((item) =>[item["etiqueta"], item])).values(),
                ]
            }            

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = 0
                if (indicador.idTipoControl == 1)
                    totalEtiqueta = arrIndicadorCampanaEncuesta.reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                else
                    totalEtiqueta = arrIndicadorCampanaEncuesta.filter(x => x.etiqueta == e.etiqueta).length
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        }
    } else if (indicador.idMetodoCalculo == 2) { //conteo
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.filter(x => x.etiqueta !== "").map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla,
                    "controlEncuesta": x.controlEncuesta.idControlEncuesta
                }
            })

            let arrIntegrado = []
            arrEtiqueta.forEach(e => {
                let arr = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla && x.controlEncuesta.idControlEncuesta == e.controlEncuesta).map(x => {
                    return {
                        'etiqueta': e.etiqueta,
                        'valor': x.valor,
                    }
                })
                arr.forEach(x => {
                    arrIntegrado.push(x)
                })
            })

            let arrReporte = []
            arrIntegrado.forEach(x => {
                let index = arrReporte.findIndex(e => e[0] === x.etiqueta)
                if (index == -1) {
                    let contar = arrIntegrado.filter(e => e.etiqueta == x.etiqueta).length
                    let arr = [x.etiqueta, contar]
                    arrReporte.push(arr)
                }
            })

            /*initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).length
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })*/

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {
            let arrIndicadorCampanaEncuesta = validarCampanaEncuesta(indicador.indicadorCampanaEncuesta)

            let arrEtiqueta = []
            if (indicador.idTipoControl == 1) {
                arrEtiqueta.push({ "etiqueta": "" })
            } else {
                arrEtiqueta = arrIndicadorCampanaEncuesta.map(x => {
                    return {
                        "etiqueta": x.etiqueta
                    }
                })
                arrEtiqueta = [
                    ...new Map(arrEtiqueta.map((item) =>[item["etiqueta"], item])).values(),
                ]
            }

            initialValue = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = 0
                if (indicador.idTipoControl == 1)
                    totalEtiqueta = arrIndicadorCampanaEncuesta.reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                else
                    totalEtiqueta = arrIndicadorCampanaEncuesta.filter(x => x.etiqueta == e.etiqueta).length
                let arr = [e.etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        }
    } else if (indicador.idMetodoCalculo == 3) { //Maximo
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            let arrEtiqueta = arrIndicadorAgrupacion.filter(x => x.etiqueta !== "").map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla,
                    "controlEncuesta": x.controlEncuesta.idControlEncuesta
                }
            })

            let arrIntegrado = []
            arrEtiqueta.forEach(e => {
                let arr = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla && x.controlEncuesta.idControlEncuesta == e.controlEncuesta).map(x => {
                    return {
                        'etiqueta': e.etiqueta,
                        'valor': x.valor
                    }
                })
                arr.forEach(x => {
                    arrIntegrado.push(x)
                })
            })

            let arrReporte = []
            arrIntegrado.forEach(x => {
                let index = arrReporte.findIndex(e => e[0] === x.etiqueta)
                if (index == -1) {
                    maxValor = Math.max(...arrIntegrado.filter(e => e.etiqueta == x.etiqueta).map(x => x.valor))
                    let arr = [x.etiqueta, maxValor]
                    arrReporte.push(arr)
                }
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {
            let arrIndicadorCampanaEncuesta = validarCampanaEncuesta(indicador.indicadorCampanaEncuesta)

            let arrEtiqueta = []
            if (indicador.idTipoControl == 1) {
                arrEtiqueta.push({ "etiqueta": "" })
            } else {
                arrEtiqueta = arrIndicadorCampanaEncuesta.map(x => {
                    return {
                        "etiqueta": x.etiqueta
                    }
                })
                arrEtiqueta = [
                    ...new Map(arrEtiqueta.map((item) =>[item["etiqueta"], item])).values(),
                ]
            }

            initialValue = 0
            let arrReporte = []
            let totalEtiqueta = 0
            if (indicador.idTipoControl == 1) {
                totalEtiqueta = Math.max(...arrIndicadorCampanaEncuesta.map(x => x.valor))
                let arr = [arrEtiqueta[0].etiqueta, totalEtiqueta]
                arrReporte.push(arr)
            } else {
                let arrConteo = []
                let cont = 1
                arrEtiqueta.forEach(e => {
                    let totalEtiqueta = arrIndicadorCampanaEncuesta.filter(x => x.etiqueta == e.etiqueta).length
                    arrConteo.push({
                        'etiqueta': e.etiqueta,
                        'total': totalEtiqueta
                    })
                })
                let maxValor = Math.max(...arrConteo.map(x => x.total))
                let obj = arrConteo.filter(x => x.total == maxValor)
                obj.forEach(e => {
                    let arr = [e.etiqueta, e.total]
                    arrReporte.push(arr)
                })                
            }            

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        }
    } else if (indicador.idMetodoCalculo == 4) { //Minimo
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            //let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
            //    return {
            //        "etiqueta": x.etiqueta,
            //        "filaTabla": x.filaTabla
            //    }
            //})

            //initialValue = 0
            //let arrReporte = []
            //arrEtiqueta.forEach(e => {
            //    let totalEtiqueta = Math.min(arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).map(x => x.valor))
            //    let arr = [e.etiqueta, totalEtiqueta]
            //    arrReporte.push(arr)
            //})

            let arrEtiqueta = arrIndicadorAgrupacion.filter(x => x.etiqueta !== "").map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla,
                    "controlEncuesta": x.controlEncuesta.idControlEncuesta
                }
            })

            let arrIntegrado = []
            arrEtiqueta.forEach(e => {
                let arr = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla && x.controlEncuesta.idControlEncuesta == e.controlEncuesta).map(x => {
                    return {
                        'etiqueta': e.etiqueta,
                        'valor': x.valor
                    }
                })
                arr.forEach(x => {
                    arrIntegrado.push(x)
                })
            })

            let arrReporte = []
            arrIntegrado.forEach(x => {
                let index = arrReporte.findIndex(e => e[0] === x.etiqueta)
                if (index == -1) {
                    minValor = Math.min(...arrIntegrado.filter(e => e.etiqueta == x.etiqueta).map(x => x.valor))
                    let arr = [x.etiqueta, minValor]
                    arrReporte.push(arr)
                }
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {
            let arrIndicadorCampanaEncuesta = validarCampanaEncuesta(indicador.indicadorCampanaEncuesta)

            let arrEtiqueta = []
            if (indicador.idTipoControl == 1) {
                arrEtiqueta.push({ "etiqueta": "" })
            } else {
                arrEtiqueta = arrIndicadorCampanaEncuesta.map(x => {
                    return {
                        "etiqueta": x.etiqueta
                    }
                })
                arrEtiqueta = [
                    ...new Map(arrEtiqueta.map((item) =>[item["etiqueta"], item])).values(),
                ]
            }

            initialValue = 0
            let arrReporte = []
            let totalEtiqueta = 0
            if (indicador.idTipoControl == 1) {
                valMin = Math.min(...arrIndicadorCampanaEncuesta.map(x => x.valor))
                let arr = [arrEtiqueta[0].etiqueta, valMin]
                arrReporte.push(arr)
            } else {
                let arrConteo = []
                let cont = 1
                arrEtiqueta.forEach(e => {
                    let totalEtiqueta = arrIndicadorCampanaEncuesta.filter(x => x.etiqueta == e.etiqueta).length
                    arrConteo.push({
                        'etiqueta': e.etiqueta,
                        'total': totalEtiqueta
                    })
                })
                let minValor = Math.min(...arrConteo.map(x => x.total))
                let obj = arrConteo.filter(x => x.total == minValor)
                obj.forEach(e => {
                    let arr = [e.etiqueta, e.total]
                    arrReporte.push(arr)
                })
            }

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        }
    } else if (indicador.idMetodoCalculo == 5) { //Promedio
        if (indicador.idTipoControl == 5) {
            let arrIndicadorAgrupacion = validarAgrupacion(indicador.indicadorAgrupacion)
            let arrIndicadorCalculo = validarCalculo(indicador.indicadorCalculo)

            //let arrEtiqueta = arrIndicadorAgrupacion.map(x => {
            //    return {
            //        "etiqueta": x.etiqueta,
            //        "filaTabla": x.filaTabla
            //    }
            //})

            //initialValue = 0
            //let arrReporte = []
            //arrEtiqueta.forEach(e => {
            //    let cantidad = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).length
            //    let suma = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla).reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
            //    let promedio = cantidad <= 0 ? 0 : suma/cantidad
            //    let arr = [e.etiqueta, promedio]
            //    arrReporte.push(arr)
            //})

            let arrEtiqueta = arrIndicadorAgrupacion.filter(x => x.etiqueta !== "").map(x => {
                return {
                    "etiqueta": x.etiqueta,
                    "filaTabla": x.filaTabla,
                    "controlEncuesta": x.controlEncuesta.idControlEncuesta
                }
            })

            let arrIntegrado = []
            arrEtiqueta.forEach(e => {
                let arr = arrIndicadorCalculo.filter(x => x.filaTabla == e.filaTabla && x.controlEncuesta.idControlEncuesta == e.controlEncuesta).map(x => {
                    return {
                        'etiqueta': e.etiqueta,
                        'valor': x.valor
                    }
                })
                arr.forEach(x => {
                    arrIntegrado.push(x)
                })
            })

            initialValue = 0
            let arrReporte = []
            arrIntegrado.forEach(x => {
                let index = arrReporte.findIndex(e => e[0] === x.etiqueta)
                if (index == -1) {
                    let cantidad = arrIntegrado.filter(e => e.etiqueta == x.etiqueta).length
                    let suma = arrIntegrado.filter(e => e.etiqueta == x.etiqueta).reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                    let promedio = cantidad <= 0 ? 0 : suma/cantidad
                    let arr = [x.etiqueta, promedio]
                    arrReporte.push(arr)
                }
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
        } else {
            let arrIndicadorCampanaEncuesta = validarCampanaEncuesta(indicador.indicadorCampanaEncuesta)

            let arrEtiqueta = []
            if (indicador.idTipoControl == 1) {
                arrEtiqueta.push({ "etiqueta": "" })
            } else {
                arrEtiqueta = arrIndicadorCampanaEncuesta.map(x => {
                    return {
                        "etiqueta": x.etiqueta
                    }
                })
                arrEtiqueta = [
                    ...new Map(arrEtiqueta.map((item) =>[item["etiqueta"], item])).values(),
                ]
            }

            let initialValue = 0
            let promedio = 0
            let arrReporte = []
            arrEtiqueta.forEach(e => {
                let totalEtiqueta = 0
                if (indicador.idTipoControl == 1) {
                    conteo = arrIndicadorCampanaEncuesta.length
                    suma = arrIndicadorCampanaEncuesta.reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
                    promedio = conteo <= 0 ? 0 : suma / conteo
                } else
                    promedio = arrIndicadorCampanaEncuesta.filter(x => x.etiqueta == e.etiqueta).length
                let arr = [e.etiqueta, promedio]
                arrReporte.push(arr)
            })

            $('#titulo-grafico').html(indicador.nombreIndicador.toUpperCase())
            google.charts.setOnLoadCallback(drawPieChart(arrReporte))
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

var validarCampanaEncuesta = (arrIndicadorCampanaEncuesta) => {
    if (distrito && distrito != '0') {
        if (idRolLogin == 3) {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        } else if (idRolLogin == 2) {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        } else {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia && x.controlEncuesta.plantaEmpresa.idDistrito == distrito)
        }
    } else if (provincia && provincia != '0') {
        if (idRolLogin == 3) {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        } else if (idRolLogin == 2) {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        } else {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento && x.controlEncuesta.plantaEmpresa.idProvincia == provincia)
        }
    } else if (departamento && departamento != '0') {
        if (idRolLogin == 3) {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.plantaEmpresa.idPlantaEmpresa == idPlanta && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        } else if (idRolLogin == 2) {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.idSupervisor == idUsuarioLogin && x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        } else {
            arrIndicadorCampanaEncuesta = arrIndicadorCampanaEncuesta.filter(x => x.controlEncuesta.plantaEmpresa.idDepartamento == departamento)
        }
    }
    return arrIndicadorCampanaEncuesta
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
    posicinar('#cuerpo', 120)
    let id = $(obj).data('id')
    location.href = `${baseUrl}Interno/EncuestaFicha/${id}`
    $('#cbo-departamento').val('0')
    cambiarDepartamento()
    cargarIndicadores()    
}

/* ================================================
 * FIN OBSERVAR
 * ================================================
 */

var posicinar = (id, number) => {
    var target_offset = $(id).offset();
    var target_top = target_offset.top - number;
    $('html,body').animate({ scrollTop: target_top }, { duration: "slow" });
}
