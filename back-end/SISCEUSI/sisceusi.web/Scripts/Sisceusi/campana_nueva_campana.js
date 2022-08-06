$(document).ready(() => {
    //$('#btn-verificar').on('click', (e) => verificarRuc())
    $('#btn-grabar').on('click', (e) => grabar())
    $('#cbo-giro00').on('change', (e) => listarEmpresa00())
    $('#cbo-ciuu00').on('change', (e) => listarEmpresa00())
    $('#txt-filtro00').on('blur', (e) => validarValorFiltro00())
    $('#cbo-filtro00').on('change', (e) => cambiarFiltro00())
    $('#btn-filtro00').on('click', (e) => aplicarFiltro00())

    $('#cbo-giro01').on('change', (e) => listarEmpresa01())
    $('#cbo-ciuu01').on('change', (e) => listarEmpresa01())
    $('#txt-filtro01').on('blur', (e) => validarValorFiltro01())
    $('#cbo-filtro01').on('change', (e) => cambiarFiltro01())
    $('#btn-filtro01').on('click', (e) => aplicarFiltro01())

    $('#cbo-tipo-empresa').on('change', (e) => mostrarListaEmpresa())
    $('#cbo-revisor').on('change', (e) => mostrarListaRevisor())

    $('#agregarPregunta').on('click', (e) => validarAgregarTablaMaestra())
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var arrEmpresa = []

var arrEmpresaFiltro00 = []
var arrEmpresaFiltro01 = []

var arrEmpresa00 = []
var arrEmpresa01 = []

var arrEmpresaSelect00 = []
var arrEmpresaSelect01 = []

var arrEmpresaPerfil00 = []
var arrEmpresaPerfil01 = []

var arrRevisor00 = []
var arrRevisor01 = []

var cargarDesplegables = () => {
    let urlGiro = `${baseUrl}Giro/obtenerListaGiro`;
    let urlCiuu = `${baseUrl}Ciuu/obtenerListaCiuu`;
    let urlEmpresa = `${baseUrl}EmpresaIndustria/obtenerListaEmpresaIndustria`;
    //let urlEmpresa = `${baseUrl}PlantaEmpresa/obtenerListaPlantaEmpresa`;
    let urlRevisor = `${baseUrl}Usuario/obtenerListaRevisor`;    
    Promise.all([
        fetch(urlGiro),
        fetch(urlCiuu),
        fetch(urlEmpresa),
        fetch(urlRevisor)        
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jGiro = responseAll[0]
        jCiuu = responseAll[1]
        jEmpresa = responseAll[2]
        jRevisor = responseAll[3]
        
        if (jGiro.success) cargarGiro(jGiro.object)
        if (jCiuu.success) cargarCiuu(jCiuu.object)
        if (jEmpresa.success) cargarEmpresa(jEmpresa.object)
        if (jRevisor.success) cargarRevisor(jRevisor.object) 
        cargarDatosIniciales()        
    });
}

var cargarEmpresa = (data) => {
    arrEmpresa = data
    listarEmpresa00()
    listarEmpresa01()
}

var cargarRevisor = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idUsuario}">${x.nombres}</option>`).join('');
    options = `<option value="0">-Seleccione supervisor-</option>${options}`
    $('#cbo-revisor').html(options);
    $('#list02').html(`<select id="source02" data-text="Empresas disponibles" data-search="Buscar empresa"></select><select id="destination02" data-text="Empresas seleccionadas" data-search="Buscar empresa"></select>`);

    if ($("#listSwapWrap").length) {
        $('#source02, #destination02').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
}

var cargarGiro = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idGiro}">${x.giro}</option>`).join('');
    options = `<option value="0">-Seleccione un giro del negocio-</option>${options}`;
    $('#cbo-giro00').html(options);
    $('#cbo-giro01').html(options);
}

var cargarCiuu = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idCiuu}">${x.ciuu}</option>`).join('');
    options = `<option value="0">-Seleccione un CIUU-</option>${options}`;
    $('#cbo-ciuu00').html(options);
    $('#cbo-ciuu01').html(options);
}

var listarEmpresa00 = () => {
    let data = arrEmpresa
    let giro = $('#cbo-giro00').val()
    let ciuu = $('#cbo-ciuu00').val()
    if (giro > 0) {
        data = data.filter(x => x.idGiro == giro)
    }
    if (ciuu > 0) {
        data = data.filter(x => x.idCiuu == ciuu)
    }
    let options = arrEmpresa.length == 0 ? '' : data.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    $('#tab01 .listboxswap').remove()
    $('#list00').after(`<select id="source00" data-text="Empresas para seleccionar" data-search="Buscar empresa">${options}</select><select id="destination00" data-text="Empresas seleccionadas" data-search="Buscar empresa"></select>`);

    if ($("#listSwapWrap").length) {
        $('#source00, #destination00').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
    arrEmpresaFiltro00 = data
}

var listarEmpresa01 = () => {
    let data = arrEmpresa
    let giro = $('#cbo-giro01').val()
    let ciuu = $('#cbo-ciuu01').val()
    if (giro > 0) {
        data = data.filter(x => x.idGiro == giro)
    }
    if (ciuu > 0) {
        data = data.filter(x => x.idCiuu == ciuu)
    }
    let options = arrEmpresa.length == 0 ? '' : data.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    $('#tab02 .listboxswap').remove()
    $('#list01').after(`<select id="source01" data-text="Empresas piloto para seleccionar" data-search="Buscar empresa">${options}</select><select id="destination01" data-text="Empresas piloto seleccionadas" data-search="Buscar empresa"></select>`);

    if ($("#listSwapWrap").length) {
        $('#source01, #destination01').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
    arrEmpresaFiltro01 = data
}

/* ================================================
 * FIN CARGA DESPLEGABLES
 * ================================================
 */

/* ================================================
 * INICIO VALIDACION FILTRO
 * ================================================
 */

var validarValorFiltro00 = () => {
    let combo = $('#cbo-filtro00').val()
    let valor = $('#txt-filtro00').val()
    let nuevoValor = 0
    if (combo == 1) {
        nuevoValor = valor > 100 ? 100 : valor < 0 ? 0 : valor;
    } else if (combo == 2) {
        nuevoValor = valor > arrEmpresaFiltro00.length ? arrEmpresaFiltro00.length : valor < 0 ? 0 : Math.round(valor);
    } else {
        nuevoValor = ''
    }
    $('#txt-filtro00').val(nuevoValor)
}

var validarValorFiltro01 = () => {
    let combo = $('#cbo-filtro01').val()
    let valor = $('#txt-filtro01').val()
    let nuevoValor = 0
    if (combo == 1) {
        nuevoValor = valor > 100 ? 100 : valor < 0 ? 0 : valor;
    } else if (combo == 2) {
        nuevoValor = valor > arrEmpresaFiltro01.length ? arrEmpresaFiltro01.length : valor < 0 ? 0 : Math.round(valor);
    } else {
        nuevoValor = ''
    }
    $('#txt-filtro01').val(nuevoValor)
}

var cambiarFiltro00 = () => {
    let combo = $('#cbo-filtro00').val()
    if (combo == 1) {
        $('#txt-filtro00').val(0)
    } else if (combo == 2) {
        $('#txt-filtro00').val(0)
    } else {
        $('#txt-filtro00').val('')
    }
}

var cambiarFiltro01 = () => {
    let combo = $('#cbo-filtro01').val()
    if (combo == 1) {
        $('#txt-filtro01').val(0)
    } else if (combo == 2) {
        $('#txt-filtro01').val(0)
    } else {
        $('#txt-filtro01').val('')
    }
}

var aplicarFiltro00 = () => {
    let combo = $('#cbo-filtro00').val()
    if (combo == 1) {
        let porc = $('#txt-filtro00').val()
        let cantidad = Math.round(arrEmpresaFiltro00.length * porc / 100)
        aleatorioEmpresa00(cantidad)
    } else if (combo == 2) {
        let cantidad = Math.round($('#txt-filtro00').val())
        aleatorioEmpresa00(cantidad)
    }
}

var aplicarFiltro01 = () => {
    let combo = $('#cbo-filtro01').val()
    if (combo == 1) {
        let porc = $('#txt-filtro01').val()
        let cantidad = Math.round(arrEmpresaFiltro01.length * porc / 100)
        aleatorioEmpresa01(cantidad)
    } else if (combo == 2) {
        let cantidad = Math.round($('#txt-filtro01').val())
        aleatorioEmpresa01(cantidad)
    }
}

/* ================================================
 * FIN VALIDACION FILTRO
 * ================================================
 */

/* ================================================
 * INICIO ALEATORIO EMPRESA
 * ================================================
 */
var aleatorioEmpresa00 = (cantidad) => {
    arrEmpresa00 = arrEmpresaFiltro00.slice()
    arrEmpresaSelect00 = []
    for (let i = 0; i < cantidad; i++) {
        const aleatorio = arrEmpresa00[Math.floor(Math.random() * arrEmpresa00.length)];
        const index = arrEmpresa00.findIndex(x => x == aleatorio)
        arrEmpresa00.splice(index, 1)
        arrEmpresaSelect00.push(aleatorio)
    }
    procesoSeleccion00()
    arrEmpresaPerfil00 = arrEmpresaSelect00.slice()
    arrRevisor00 = []
    $('#cbo-tipo-empresa').val(0)
    mostrarListaEmpresa()
}

var aleatorioEmpresa01 = (cantidad) => {
    arrEmpresa01 = arrEmpresaFiltro01.slice()
    arrEmpresaSelect01 = []
    for (let i = 0; i < cantidad; i++) {
        const aleatorio = arrEmpresa01[Math.floor(Math.random() * arrEmpresa01.length)];
        const index = arrEmpresa01.findIndex(x => x == aleatorio)
        arrEmpresa01.splice(index, 1)
        arrEmpresaSelect01.push(aleatorio)
    }
    procesoSeleccion01()
    arrEmpresaPerfil01 = arrEmpresaSelect01.slice()
    arrRevisor01 = []
    $('#cbo-tipo-empresa').val(0)
    mostrarListaEmpresa()
}

var procesoSeleccion00 = () => {
    let optionsSource = arrEmpresa00.length == 0 ? '' : arrEmpresa00.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    let optionsDestination = arrEmpresaSelect00.length == 0 ? '' : arrEmpresaSelect00.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    $('#tab01 .listboxswap').remove()
    $('#list00').after(`<select id="source00" data-text="Empresas para seleccionar" data-search="Buscar empresa">${optionsSource}</select><select id="destination00" data-text="Empresas seleccionadas" data-search="Buscar empresa">${optionsDestination}</select>`);

    if ($("#listSwapWrap").length) {
        $('#source00, #destination00').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
}

var procesoSeleccion01 = () => {
    let optionsSource = arrEmpresa01.length == 0 ? '' : arrEmpresa01.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    let optionsDestination = arrEmpresaSelect01.length == 0 ? '' : arrEmpresaSelect01.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    $('#tab02 .listboxswap').remove()
    $('#list01').after(`<select id="source01" data-text="Empresas piloto para seleccionar" data-search="Buscar empresa">${optionsSource}</select><select id="destination01" data-text="Empresas piloto seleccionadas" data-search="Buscar empresa">${optionsDestination}</select>`);

    if ($("#listSwapWrap").length) {
        $('#source01, #destination01').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
}
/* ================================================
 * FIN ALEATORIO EMPRESA
 * ================================================
 */

/* ================================================
 * INICIO SELECCIONAR EMPRESA
 * ================================================
 */
$(document).on('click', '#tab01 .listboxswap .listbox_controls .add, #tab01 .listboxswap .listbox_controls .remove', function () {
    arrEmpresa00 = []
    arrEmpresaSelect00 = []
    $('#tab01 .listboxswap .source_wrapper .listbox_option').each(function () {
        let id = $(this).data('value')
        const obj = arrEmpresaFiltro00.find(x => x.idEmpresaIndustria == id)
        arrEmpresa00.push(obj)
    });
    $('#tab01 .listboxswap .destination_wrapper .listbox_option').each(function () {
        let id = $(this).data('value')
        const obj = arrEmpresaFiltro00.find(x => x.idEmpresaIndustria == id)
        arrEmpresaSelect00.push(obj)
    });
    arrEmpresaPerfil00 = arrEmpresaSelect00.slice()
    arrRevisor00 = []
    $('#cbo-tipo-empresa').val(0)
    mostrarListaEmpresa()
})

$(document).on('click', '#tab02 .listboxswap .listbox_controls .add, #tab02 .listboxswap .listbox_controls .remove', function () {
    arrEmpresa01 = []
    arrEmpresaSelect01 = []
    $('#tab02 .listboxswap .source_wrapper .listbox_option').each(function () {
        let id = $(this).data('value')
        const obj = arrEmpresaFiltro01.find(x => x.idEmpresaIndustria == id)
        arrEmpresa01.push(obj)
    });
    $('#tab02 .listboxswap .destination_wrapper .listbox_option').each(function () {
        let id = $(this).data('value')
        const obj = arrEmpresaFiltro01.find(x => x.idEmpresaIndustria == id)
        arrEmpresaSelect01.push(obj)
    });
    arrEmpresaPerfil01 = arrEmpresaSelect01.slice()
    arrRevisor01 = []
    $('#cbo-tipo-empresa').val(0)
    mostrarListaEmpresa()
})

$(document).on('click', '#tab03 .listboxswap .listbox_controls .add, #tab03 .listboxswap .listbox_controls .remove', function () {
    let revisor = $('#cbo-revisor').val()
    if (revisor > 0) {
        let combo = $('#cbo-tipo-empresa').val()
        if (combo == 1) arrEmpresaPerfil00 = []
        else if (combo == 2) arrEmpresaPerfil01 = []
        $('#tab03 .listboxswap .source_wrapper .listbox_option').each(function () {
            let id = $(this).data('value')            
            if (combo == 1) {
                const obj = arrEmpresaSelect00.find(x => x.idEmpresaIndustria == id)
                arrEmpresaPerfil00.push(obj)
            } else if (combo == 2) {
                const obj = arrEmpresaSelect01.find(x => x.idEmpresaIndustria == id)
                arrEmpresaPerfil01.push(obj)
            }
        });

        let arr = []
        $('#tab03 .listboxswap .destination_wrapper .listbox_option').each(function () {
            let id = $(this).data('value')
            if (combo == 1) {
                const obj = arrEmpresaSelect00.find(x => x.idEmpresaIndustria == id)
                arr.push(obj)
            } else if (combo == 2) {
                const obj = arrEmpresaSelect01.find(x => x.idEmpresaIndustria == id)
                arr.push(obj)
            }
        });

        if (combo == 1) {
            let index = arrRevisor00.findIndex(x => x.idUsuario == revisor)
            if (index > -1) {
                arrRevisor00[index].listaEmpresa = arr
            } else {
                arrRevisor00.push({
                    idUsuario: revisor,
                    listaEmpresa: arr
                })
            }
        } else if (combo == 2) {
            let index = arrRevisor01.findIndex(x => x.idUsuario == revisor)
            if (index > -1) {
                arrRevisor01[index].listaEmpresa = arr
            } else {
                arrRevisor01.push({
                    idUsuario: revisor,
                    listaEmpresa: arr
                })
            }
        }
              
    }    
})
/* ================================================
 * FIN SELECCIONAR EMPRESA
 * ================================================
 */

/* ================================================
 * INICIO SELECCIONAR REVISOR
 * ================================================
 */
var mostrarListaEmpresa = () => {
    $('#cbo-revisor').val(0)
    let combo = $('#cbo-tipo-empresa').val()
    let optionsSource = ''
    if (combo == 1) {
        optionsSource = arrEmpresaPerfil00.length == 0 ? '' : arrEmpresaPerfil00.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    } else if (combo == 2) {        
        optionsSource = arrEmpresaPerfil01.length == 0 ? '' : arrEmpresaPerfil01.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    }

    $('#tab03 .listboxswap').remove()
    $('#list02').html(`<select id="source02" data-text="Empresas seleccionadas" data-search="Buscar empresa">${optionsSource}</select><select id="destination02" data-text="Empresas seleccionadas" data-search="Buscar empresa"></select>`);

    if ($("#listSwapWrap").length) {
        $('#source02, #destination02').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
}

var mostrarListaRevisor = () => {
    let arr = []
    let combo = $('#cbo-tipo-empresa').val()
    let revisor = $('#cbo-revisor').val()
    if (revisor != 0) {
        if (combo == 1) {
            let index = arrRevisor00.findIndex(x => x.idUsuario == revisor)
            if (index != -1) {
                let obj = arrRevisor00.find(x => x.idUsuario == revisor)
                arr = obj.listaEmpresa
            }
        } else if (combo == 2) {
            let index = arrRevisor01.findIndex(x => x.idUsuario == revisor)
            if (index != -1) {
                let obj = arrRevisor01.find(x => x.idUsuario == revisor)
                arr = obj.listaEmpresa
            }
        }        
    }

    let optionsDestination = arr.length == 0 ? '' : arr.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');

    let optionsSource = ''
    if (combo == 1) {
        optionsSource = arrEmpresaPerfil00.length == 0 ? '' : arrEmpresaPerfil00.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    } else if (combo == 2) {
        optionsSource = arrEmpresaPerfil01.length == 0 ? '' : arrEmpresaPerfil01.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    }

    $('#tab03 .listboxswap').remove()
    $('#list02').html(`<select id="source02" data-text="Empresas seleccionadas" data-search="Buscar empresa">${optionsSource}</select><select id="destination02" data-text="Empresas seleccionadas" data-search="Buscar empresa">${optionsDestination}</select>`);

    if ($("#listSwapWrap").length) {
        $('#source02, #destination02').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
    }
}
/* ================================================
 * FIN SELECCIONAR REVISOR
 * ================================================
 */

/* ================================================
 * INICIO VALIDAR Y GRABAR DATOS
 * ================================================
 */

var grabar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];
    let idCampana = $('#frm').data('id')
    idCampana = idCampana == null ? -1 : idCampana
    let denominacion = $('#txt-denominacion').val().trim()
    let fechaInicioPiloto = $('#txt-desde-piloto').val()
    let fechaFinPiloto = $('#txt-hasta-piloto').val()
    let fechaInicioEncuesta = $('#txt-desde-real').val()
    let fechaFinEncuesta = $('#txt-hasta-real').val()
    let observaciones = $('#txt-observaciones').val().trim()
    let idGiroOficial = $('#cbo-giro00').val()
    let idCiuuOficial = $('#cbo-ciuu00').val()
    let idGiroPiloto = $('#cbo-giro01').val()
    let idCiuuPiloto = $('#cbo-ciuu01').val()
    let idEstado = $('#chk-anular').prop('checked') ? '0' : '1'

    if (validarEspaciosBlanco(denominacion)) arr.push("Debe ingresar una denominación")
    if (validarEspaciosBlanco(observaciones)) arr.push("Debe ingresar una observación")
    if (arrEmpresaSelect00.length == 0 && arrEmpresaSelect01.length == 0) arr.push("No ha seleccionado ninguna empresa para la campaña")
    else if (arrEmpresaPerfil00.length > 0 || arrEmpresaPerfil01.length > 0) arr.push("Hay empresas que no han sido asignados con un supervisor")

    let arrPregunta = []
    $('#contenedorEncuesta').find('.seccion-pregunta').each((x, y) => {
        let tipoControl = $(y).find('label .tituloPregunta').data('tipo')
        let idTipoControl = tipoControl === 'txt' ? 1 : tipoControl === 'cbo' ? 2 : tipoControl === 'chk' ? 3 : tipoControl === 'rad' ? 4 : tipoControl === 'tbl' ? 5 : 0
        if (tipoControl === 'txt') {
            arrPregunta.push({
                idCampanaEncuesta: $(y)[0].id == "" ? -1 : $(y)[0].id.split('-')[1],
                pregunta: $(y).find('div div input').val(),
                numeroOrdenPregunta: x,
                idTipoControl: idTipoControl,
                idParametroTabla: 0,
                listaRespuesta: []
            })
        } else if (tipoControl === 'cbo') {
            let arrRespuesta = []
            $(y).find('.control-pregunta').each((m, n) => {
                arrRespuesta.push({
                    idRespuestaEncuesta: $(n)[0].id == "" ? -1 : $(n)[0].id.split('-')[1],
                    respuesta: $(n).find('div input.form-control').val(),
                    numeroOrdenRespuesta: m,
                    idValorRespuesta: '0'
                })
            })
            arrPregunta.push({
                idCampanaEncuesta: $(y)[0].id == "" ? -1 : $(y)[0].id.split('-')[1],
                pregunta: $(y).find('div div input').val(),
                numeroOrdenPregunta: x,
                idTipoControl: idTipoControl,
                idParametroTabla: 0,
                listaRespuesta: arrRespuesta
            })
        } else if (tipoControl === 'chk') {
            let arrRespuesta = []
            $(y).find('.control-pregunta').each((m, n) => {
                arrRespuesta.push({
                    idRespuestaEncuesta: $(n)[0].id == "" ? -1 : $(n)[0].id.split('-')[1],
                    respuesta: $(n).find('div input.form-control').val(),
                    numeroOrdenRespuesta: m,
                    idValorRespuesta: $(n).find('div div div input').prop('checked') ? '1' : '0'
                })
            })
            arrPregunta.push({
                idCampanaEncuesta: $(y)[0].id == "" ? -1 : $(y)[0].id.split('-')[1],
                pregunta: $(y).find('div div input').val(),
                numeroOrdenPregunta: x,
                idTipoControl: idTipoControl,
                idParametroTabla: 0,
                listaRespuesta: arrRespuesta
            })
        } else if (tipoControl === 'rad') {
            let arrRespuesta = []
            $(y).find('.control-pregunta').each((m, n) => {
                arrRespuesta.push({
                    idRespuestaEncuesta: $(n)[0].id == "" ? -1 : $(n)[0].id.split('-')[1],
                    respuesta: $(n).find('div input.form-control').val(),
                    numeroOrdenRespuesta: m,
                    idValorRespuesta: $(n).find('div div div input').prop('checked') ? '1' : '0'
                })
            })
            arrPregunta.push({
                idCampanaEncuesta: $(y)[0].id == "" ? -1 : $(y)[0].id.split('-')[1],
                pregunta: $(y).find('div div input').val(),
                numeroOrdenPregunta: x,
                idTipoControl: idTipoControl,
                idParametroTabla: 0,
                listaRespuesta: arrRespuesta
            })
        } else if (tipoControl === 'tbl') {
            arrPregunta.push({
                idCampanaEncuesta: $(y)[0].id == "" ? -1 : $(y)[0].id.split('-')[1],
                //pregunta: $(y).find('div div input').val(),
                pregunta: '',
                numeroOrdenPregunta: x,
                idTipoControl: idTipoControl,
                idParametroTabla: $(y).find('div div select').val(),
                listaRespuesta: []
            })
        }
    })

    if (arrPregunta.length == 0) arr.push("Debe agregar al menos una pregunta a la encuesta")

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'registro'));
        return;
    }

    let arrCampanaEmpresa = []
    arrRevisor00.forEach(x => {
        x.listaEmpresa.forEach(z => {
            arrCampanaEmpresa.push({
                idCampana: idCampana,
                idEmpresaIndustria: z.idEmpresaIndustria,
                participarEnPiloto: '0',
                participarEnOficial: '1',
                idSupervisorPiloto: 0,
                idSupervisorOficial: x.idUsuario
            })
        })        
    })

    arrRevisor01.forEach(x => {
        x.listaEmpresa.forEach(z => {
            let index = arrCampanaEmpresa.findIndex(x => x.idEmpresaIndustria == z.idEmpresaIndustria)
            if (index != -1) {
                arrCampanaEmpresa[index].participarEnPiloto = '1',
                arrCampanaEmpresa[index].idSupervisorPiloto = x.idUsuario
            } else {
                arrCampanaEmpresa.push({
                    idCampana: idCampana,
                    idEmpresaIndustria: z.idEmpresaIndustria,
                    participarEnPiloto: '1',
                    participarEnOficial: '0',
                    idSupervisorPiloto: x.idUsuario,
                    idSupervisorOficial: 0
                })
            }
        })
    })

    let url = `${baseUrl}Campana/grabarCampana`;
    let data = { idCampana, denominacion, fechaInicioPiloto, fechaFinPiloto, fechaInicioEncuesta, fechaFinEncuesta, observaciones, idGiroOficial, idCiuuOficial, idGiroPiloto, idCiuuPiloto, idEstado, listaCampanaEmpresa: arrCampanaEmpresa, listaPregunta: arrPregunta, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) { $('#btn-grabar').hide() }
        j.success ?
        $('.seccion-mensaje').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo. Utilice el buscador para encontrar su nuevo registro.'))) :
        $('.seccion-mensaje').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

/* ================================================
 * FIN VALIDAR Y GRABAR DATOS
 * ================================================
 */

/* ================================================
 * INICIO CONSULTAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatosIniciales = () => {
    let id = $('#identificador').val()
    if (id > 0) {
        let url = `${baseUrl}Campana/obtenerCampana?idCampana=${id}`;
        fetch(url)
        .then(r => r.json())
        .then(j => {
            if (j.success) {
                cargarDatos(j.object)
            } else {
                $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la planta. Por favor, puede volver a recargar la página.'), 'carga de datos'))
            }
        })
        .catch(error => {
            console.log('Error:' + error.message)
        })
    }
}

/* ================================================
 * FIN CONSULTAR DATOS ENTIDAD
 * ================================================
 */

/* ================================================
 * INICIO CARGAR DATOS ENTIDAD
 * ================================================
 */

var cargarDatos = (data) => {
    if (data == null) return
    $('#frm').data('id', data.idCampana)
    $('#txt-denominacion').val(data.denominacion)
    $('#txt-desde-piloto').val(data.txtFechaInicioPiloto === '0001-01-01' ? '' : data.txtFechaInicioPiloto)
    $('#txt-hasta-piloto').val(data.txtFechaFinPiloto === '0001-01-01' ? '' : data.txtFechaFinPiloto)
    $('#txt-desde-real').val(data.txtFechaInicioEncuesta === '0001-01-01' ? '' : data.txtFechaInicioEncuesta)
    $('#txt-hasta-real').val(data.txtFechaFinEncuesta === '0001-01-01' ? '' : data.txtFechaFinEncuesta)
    $('#txt-observaciones').val(data.observaciones)
    $('#chk-anular').prop('checked', data.idEstado == '1' ? false : true)
    $('#cbo-giro00').val(data.idGiroOficial)
    $('#cbo-ciuu00').val(data.idCiuuOficial)
    $('#cbo-giro01').val(data.idGiroPiloto)    
    $('#cbo-ciuu01').val(data.idCiuuPiloto)
    listarEmpresa00()
    listarEmpresa01()

    arrEmpresa00 = arrEmpresaFiltro00.slice()
    data.listaCampanaEmpresa.map(x => {
        if (x.participarEnOficial === '1') {
            arrEmpresaSelect00.push(x.empresaIndustria)
            let index = arrEmpresa00.findIndex(y => y.idEmpresaIndustria == x.empresaIndustria.idEmpresaIndustria)
            if (index != -1) {
                arrEmpresa00.splice(index, 1)
            }
        }
    })
    procesoSeleccion00()

    arrEmpresa01 = arrEmpresaFiltro01.slice()
    data.listaCampanaEmpresa.map(x => {
        if (x.participarEnPiloto === '1') {
            arrEmpresaSelect01.push(x.empresaIndustria)
            let index = arrEmpresa01.findIndex(y => y.idEmpresaIndustria == x.empresaIndustria.idEmpresaIndustria)
            if (index != -1) {
                arrEmpresa01.splice(index, 1)
            }
        }
    })
    procesoSeleccion01()

    data.listaCampanaEmpresa.map(x => {
        if (x.participarEnOficial === '1') {
            let index = arrRevisor00.findIndex(y => y.idUsuario == x.idSupervisorOficial)
            if (index != -1) {
                let obj = arrRevisor00.find(y => y.idUsuario == x.idSupervisorOficial)
                let arr = obj.listaEmpresa.slice()
                arr.push(x.empresaIndustria)
                arrRevisor00[index].listaEmpresa = arr
            } else {
                let arr = []
                arr.push(x.empresaIndustria)
                arrRevisor00.push({
                    idUsuario: x.idSupervisorOficial,
                    listaEmpresa: arr
                })
            }
        }
        if (x.participarEnPiloto === '1') {
            let index = arrRevisor01.findIndex(y => y.idUsuario == x.idSupervisorPiloto)
            if (index != -1) {
                let obj = arrRevisor01.find(y => y.idUsuario == x.idSupervisorPiloto)
                let arr = obj.listaEmpresa.slice()
                arr.push(x.empresaIndustria)
                arrRevisor01[index].listaEmpresa = arr
            } else {
                let arr = []
                arr.push(x.empresaIndustria)
                arrRevisor01.push({
                    idUsuario: x.idSupervisorPiloto,
                    listaEmpresa: arr
                })
            }
        }
    })

    data.listaPregunta.map(x => {
        armarPreguntas(x)
    })
    
}

var armarPreguntas = (x) => {
    $('html, body').animate({
        scrollTop: ($("#contenedorEncuesta").offset().top - $(".menu-nav").height() - 70)
    }, 'slow');

    if (x.idTipoControl == 1) {
        var htmlTxt =
          `<div class="col-12 my-2 pt-3 border bg-light seccion-pregunta" id="p-${x.idCampanaEncuesta}">` +
            `<div class="form-group">` +
            `<label class="font-weight-bold d-flex justify-content-between align-items-center">` +
                `<div class="d-flex justify-content-between align-items-center">` +
                  `<i class="fas fa-trash mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="right" title="" data-original-title="Eliminar" onclick="eliminarPregunta(this)"></i>` +
                  `<span class="tituloPregunta" data-tipo="txt"></span>` +
                `</div>` +
                `<i class="fas fa-sort mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="left" title="" data-original-title="Mover"></i>` +
              `</label>` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">TÍTULO DE LA PREGUNTA</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su pregunta" aria-describedby="inputGroup1" value="${x.pregunta}" required="">` +
                `<div class="input-group-append"></div>` +
              `</div>` +
            `</div>` +
          `</div>`;
        $("#ninguna-pregunta").hide();
        $("#contenedorEncuesta").append(htmlTxt);
        $('[data-toggle="tooltip"]').tooltip();
        conteoPreguntasV2();
    } else if (x.idTipoControl == 2) {
        var htmlCbo =
          `<div class="col-12 my-2 pt-3 border bg-light seccion-pregunta" id="p-${x.idCampanaEncuesta}">` +
            `<div class="form-group">` +
              `<label class="font-weight-bold d-flex justify-content-between align-items-center">` +
                `<div class="d-flex justify-content-between align-items-center">` +
                  `<i class="fas fa-trash mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="right" title="" data-original-title="Eliminar" onclick="eliminarPregunta(this)"></i>` +
                  `<span class="tituloPregunta" data-tipo="cbo"></span>` +
                `</div>` +
                `<i class="fas fa-sort mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="left" title="" data-original-title="Mover"></i>` +
              `</label>` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">TÍTULO DE LA PREGUNTA</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su pregunta" aria-describedby="inputGroup1" value="${x.pregunta}" required="">` +
                `<div class="input-group-append"></div>` +
              `</div>` +
            `</div>` +
            `{r}` +

          `</div>`;

        let respuesta = x.listaRespuesta.length == 0 ? '' : x.listaRespuesta.map(y => {
            return `<div class="form-group control-pregunta" id="r-${y.idRespuestaEncuesta}">` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">OPCIÓN DE RESPUESTA</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su respuesta" aria-describedby="inputGroup1" value="${y.respuesta}" required="">` +
                `<div class="input-group-append">` +
                  `<button class="btn btn-danger" onclick="eliminarOpcion(this)"><i class="fa fa-trash"></i></button>` +
                  `<button class="btn btn-info" onclick="copiarOpcion(this)"><i class="fa fa-plus"></i></button>` +
                `</div>` +
              `</div>` +
            `</div>`
        }).join('')
        htmlCbo = htmlCbo.replace("{r}", respuesta)
        $("#ninguna-pregunta").hide();
        $("#contenedorEncuesta").append(htmlCbo);
        $('[data-toggle="tooltip"]').tooltip();
        conteoPreguntasV2()
    } else if (x.idTipoControl == 3) {
        var htmlChk =
          `<div class="col-12 my-2 pt-3 border bg-light seccion-pregunta" id="p-${x.idCampanaEncuesta}">` +
            `<div class="form-group">` +
              `<label class="font-weight-bold d-flex justify-content-between align-items-center">` +
                `<div class="d-flex justify-content-between align-items-center">` +
                  `<i class="fas fa-trash mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="right" title="" data-original-title="Eliminar" onclick="eliminarPregunta(this)"></i>` +
                  `<span class="tituloPregunta" data-tipo="chk"></span>` +
                `</div>` +
                `<i class="fas fa-sort mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="left" title="" data-original-title="Mover"></i>` +
              `</label>` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">TÍTULO DE LA PREGUNTA</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su pregunta" aria-describedby="inputGroup1" value="${x.pregunta}" required="">` +
                `<div class="input-group-append"></div>` +
              `</div>` +
            `</div>` +
            `{r}` +
          `</div>`;
        let respuesta = x.listaRespuesta.length == 0 ? '' : x.listaRespuesta.map(y => {
            return `<div class="form-group control-pregunta" id="r-${y.idRespuestaEncuesta}">` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">OPCIÓN DE RESPUESTA</div>` +
                  `<div class="input-group-text border-0 bg-white">` +
                    `<input type="checkbox" ${y.idValorRespuesta == '1' ? 'checked' : ''}>` +
                  `</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su respuesta" aria-describedby="inputGroup1" value="${y.respuesta}" required="">` +
                `<div class="input-group-append">` +
                  `<button class="btn btn-danger" onclick="eliminarOpcion(this)"><i class="fa fa-trash"></i></button>` +
                  `<button class="btn btn-info" onclick="copiarOpcion(this)"><i class="fa fa-plus"></i></button>` +
                `</div>` +
              `</div>` +
            `</div>`
        }).join('')
        htmlChk = htmlChk.replace("{r}", respuesta)
        $("#ninguna-pregunta").hide();
        $("#contenedorEncuesta").append(htmlChk);
        $('[data-toggle="tooltip"]').tooltip();
        conteoPreguntasV2();
    } else if (x.idTipoControl == 4) {
        var htmlRad =
          `<div class="col-12 my-2 pt-3 border bg-light seccion-pregunta" id="p-${x.idCampanaEncuesta}">` +
            `<div class="form-group">` +
              `<label class="font-weight-bold d-flex justify-content-between align-items-center">` +
                `<div class="d-flex justify-content-between align-items-center">` +
                  `<i class="fas fa-trash mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="right" title="" data-original-title="Eliminar" onclick="eliminarPregunta(this)"></i>` +
                  `<span class="tituloPregunta" data-tipo="rad"></span>` +
                `</div>` +
                `<i class="fas fa-sort mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="left" title="" data-original-title="Mover"></i>` +
              `</label>` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">TÍTULO DE LA PREGUNTA</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su pregunta" aria-describedby="inputGroup1" value="${x.pregunta}" required="">` +
                `<div class="input-group-append"></div>` +
              `</div>` +
            `</div>` +
            `{r}` +
          `</div>`;
        let respuesta = x.listaRespuesta.length == 0 ? '' : x.listaRespuesta.map(y => {
            return `<div class="form-group control-pregunta" id="r-${y.idRespuestaEncuesta}">` +
              `<div class="input-group">` +
                `<div class="input-group-prepend">` +
                  `<div class="input-group-text border-0 bg-white font-weight-bold">OPCIÓN DE RESPUESTA</div>` +
                  `<div class="input-group-text border-0 bg-white">` +
                    `<input type="radio" name="opciones" ${y.idValorRespuesta == '1' ? 'checked' : ''}>` +
                  `</div>` +
                `</div>` +
                `<input class="form-control" type="text" placeholder="Ingrese la descripción de su respuesta" aria-describedby="inputGroup1" value="${y.respuesta}" required="">` +
                `<div class="input-group-append">` +
                  `<button class="btn btn-danger" onclick="eliminarOpcion(this)"><i class="fa fa-trash"></i></button>` +
                  `<button class="btn btn-info" onclick="copiarOpcion(this)"><i class="fa fa-plus"></i></button>` +
                `</div>` +
              `</div>` +
            `</div>` 
        }).join('')
        htmlRad = htmlRad.replace("{r}", respuesta)
        $("#ninguna-pregunta").hide();
        $("#contenedorEncuesta").append(htmlRad);
        $('[data-toggle="tooltip"]').tooltip();
        conteoPreguntasV2();
    } else if (x.idTipoControl == 5) {
        var htmlTbl =
      `<div class="col-12 my-2 pt-3 border bg-light seccion-pregunta" id="p-${x.idCampanaEncuesta}">` +
        `<div class="form-group">` +
          `<label class="font-weight-bold d-flex justify-content-between align-items-center">` +
            `<div class="d-flex justify-content-between align-items-center">` +
              `<i class="fas fa-trash mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="right" title="" data-original-title="Eliminar" onclick="eliminarPregunta(this)"></i>` +
              `<span class="tituloPregunta" data-tipo="tbl"></span>` +
            `</div>` +
            `<i class="fas fa-sort mr-2 ayuda-tooltip cursor-pointer" data-toggle="tooltip" data-placement="left" title="" data-original-title="Mover"></i>` +
          `</label>` +
          `<div class="input-group">` +
            `<div class="input-group-prepend">` +
              `<div class="input-group-text border-0 bg-white font-weight-bold">SELECCIONAR TABLA</div>` +
            `</div>` +
            `<select class="form-control" aria-describedby="inputGroup10">` +
              `<option>-Seleccione una tabla maestra-</option>` +
              `<option value="1">Tabla maestra 01</option>` +
              `<option value="2">Tabla maestra 02</option>` +
            `</select>` +
            `<div class="input-group-append"></div>` +
          `</div>` +
        `</div>` +
      `</div>`;
        $("#ninguna-pregunta").hide();
        $("#contenedorEncuesta").append(htmlTbl);
        $('[data-toggle="tooltip"]').tooltip();
        $('#contenedorEncuesta').find(`#p-${x.idCampanaEncuesta}`).find('div div select').val(x.idParametroTabla)
        conteoPreguntasV2();
    }

}

function conteoPreguntasV2() {
    var arregloComponentes = $("#contenedorEncuesta .seccion-pregunta");
    arregloComponentes.each(function (index, element) {
        var span = $(element).find(".tituloPregunta");
        var ctrl = span.data('tipo');
        var item = index + 1;
        var tipo = "";
        switch (ctrl) {
            case 'txt':
                tipo = "CAJA DE TEXTO";
                break;
            case 'cbo':
                tipo = "LISTA DE OPCIONES";
                break;
            case 'chk':
                tipo = "MÚLTIPLES OPCIONES";
                break;
            case 'rad':
                tipo = "ÚNICA OPCIÓN";
                break;
            case 'tbl':
                tipo = "TABLA MAESTRA";
                break;
        }
        span.empty().text("PREGUNTA " + item + " (" + tipo + ")");
    });
}

/* ================================================
 * FIN CARGAR DATOS ENTIDAD
 * ================================================
 */

var validarAgregarTablaMaestra = () => {
    let tipoControl = $('#cbo-list-tipo-control').val()
    if (tipoControl === 'tbl') {
        
        //let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idGiro}">${x.giro}</option>`).join('');
        let options = `<option value="1">Maestro 1</option><option value="2">Maestro 2</option><option value="3">Maestro 3</option>`;
        options = `<option value="0">-Seleccione una tabla maestra-</option>${options}`
        var componente = $("#contenedorEncuesta .seccion-pregunta:last")
        componente.find('div div select').html(options)
    }
    
}