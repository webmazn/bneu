var arrDepartamento = []
var arrProvincia = []
var arrDistrito = []
var arrListaPlanta = []
var arrListaIndicador = []
$(document).ready(() => {
    $('#cbo-departamento').on('change', (e) => cambiarDepartamento())
    $('#cbo-provincia').on('change', (e) => cambiarProvincia())
    $('#cbo-distrito').on('change', (e) => cambiarDistrito())
    cargarDatos()
    google.charts.setOnLoadCallback(drawMap)
});

var cargarDatos = () => {
    arrListaPlanta = listaControlEncuesta
    arrListaIndicador = listaIndicador
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
    cargarDepartamento(arrDepartamento)
    cargarIndicadores()
}

var cargarDepartamento = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idDepartamento}">${x.departamento}</option>`).join('');
    options = `<option value="0">-Seleccione un departamento-</option>${options}`;
    $('#cbo-departamento').html(options);
}

var departamento
var cambiarDepartamento = () => {
    departamento = $('#cbo-departamento').val()
    $('#cbo-distrito').html(`<option value="0">-Seleccione un distrito-</option>`);
    if (validarCombo(departamento)) {
        $('#cbo-provincia').html(`<option value="0">-Seleccione una provincia-</option>`)
        arrListaPlanta = listaControlEncuesta
    } else {
        const data = arrProvincia.filter(x => x.idProvincia.substr(0, 2) === departamento)
        let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idProvincia}">${x.provincia}</option>`).join('');
        options = `<option value="0">-Seleccione una provincia-</option>${options}`;
        $('#cbo-provincia').html(options);
        arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento)
    }
    google.charts.setOnLoadCallback(drawMap)
}

var provincia
var cambiarProvincia = () => {
    provincia = $('#cbo-provincia').val()
    if (validarCombo(provincia)) {
        $('#cbo-distrito').html(`<option value="0">-Seleccione un distrito-</option>`);
        arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento)
    } else {
        const data = arrDistrito.filter(x => x.idDistrito.substr(0, 4) === provincia)
        let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idDistrito}">${x.distrito}</option>`).join('');
        options = `<option value="0">-Seleccione un distrito-</option>${options}`;
        $('#cbo-distrito').html(options);
        arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia)
    }
    google.charts.setOnLoadCallback(drawMap)
}

var cambiarDistrito = () => {
    let distrito = $('#cbo-distrito').val()
    if (validarCombo(provincia)) {
        arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia)
    } else {
        arrListaPlanta = listaControlEncuesta.filter(x => x.plantaEmpresa.departamento.idDepartamento === departamento && x.plantaEmpresa.provincia.idProvincia === provincia && x.plantaEmpresa.distrito.idDistrito === distrito)
    }
    google.charts.setOnLoadCallback(drawMap)
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
}

$(document).on('click', '[name="radio-tabla"]', (e) => {
    let id = $(e.currentTarget)[0].id.split('-')[1]
    let indicador = arrListaIndicador.find(x => x.idIndicador == id)
    if (indicador.idMetodoCalculo == 1) { //suma
        if (indicador.idTipoControl == 5) {
            //let total = indicador.indicadorTablaMaestra.sum(x => x.valor)
            initialValue = 0
            let total = indicador.indicadorTablaMaestra.reduce((previousValue, currentValue) => previousValue + currentValue.valor, initialValue)
            alert(total)
        }
        
    } else if (indicador.idMetodoCalculo == 2) { //conteo

    } else if (indicador.idMetodoCalculo == 3) { //acumulado

    }
})

var drawMap = () => {

    let arrMapa = []
    arrMapa.push(['Latitud', 'Longitud', 'Nombre', 'Marker'])
    arrListaPlanta.forEach(x => {
        let arr = []
        arr.push(parseInt(x.plantaEmpresa.latitud))
        arr.push(parseInt(x.plantaEmpresa.longitud))
        arr.push(x.plantaEmpresa.denominacion)
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