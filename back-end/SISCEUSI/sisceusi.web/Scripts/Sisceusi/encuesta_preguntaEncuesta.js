$(document).ready(() => {
    preguntasEncuesta.forEach(x => {
        armarPregunta(x)
    })    
});

var armarPregunta = (preguntaEncuesta) => {
    if (preguntaEncuesta.idTipoControl == 1) {

    } else if (preguntaEncuesta.idTipoControl == 2) {

    } else if (preguntaEncuesta.idTipoControl == 3) {

    } else if (preguntaEncuesta.idTipoControl == 4) {

    } else if (preguntaEncuesta.idTipoControl == 5) {
        armarTablaMaestra(preguntaEncuesta.listaEncabezadoSecundario)
    }
}

var armarTablaMaestra = (listaSecundario) => {
    if (listaSecundario.length > 0) {
        let tablaMaestra = listaSecundario[0].encabezadoPrincipal.tablaMaestra
        //Titulo principal
        $('.text-cyan').html(tablaMaestra.tituloPrincipal)
        //Subtitulo
        $('#subtitulo-maestra').html(tablaMaestra.subtitulo)
        if (tablaMaestra.subtitulo) {
            let textAyudaMaestra = `<i class="fas fa-question-circle pl-1" data-toggle="tooltip" data-placement="top" title="${tablaMaestra.descripcionIconoAyuda}"></i>`
            $('#text-ayuda-maestra').html(textAyudaMaestra)
        }
        //Pregunta inicial
        if (tablaMaestra.preguntaInicial) {
            let preguntaInicial = ` <label class="font-weight-bold text-azul" for="chk-pregunta-inicial">${tablaMaestra.preguntaInicial}</label>&nbsp;` +
                                    `<div class="form-check form-check-inline">` +
                                        `<input id="chk-pregunta-inicial" class="form-check-input" type="checkbox">` +
                                    `</div>`
            $('#pregunta-inicial-maestra').html(preguntaInicial)
        }
        //Pregunta cierre
        if (tablaMaestra.preguntaCierre) {
            let preguntaCierre = `  <div class="form-check form-check-inline m-0">` +
                                        `<input id="chk-pregunta-cierre" class="form-check-input" type="checkbox">` +
                                    `</div>` +
                                    `<label class="font-weight-bold text-azul m-0" for="chk-pregunta-cierre">No tiene equipos en la sección “FUERZA MOTRIZ – OTROS EQUIPOS ELÉCTRICOS”</label>`
            $('#pregunta-cierre-maestra').html(preguntaCierre)
        }
        //Obtener encabezados principales
        let listaPrincipal = []
        listaSecundario.forEach(x => {
            if (listaPrincipal.filter(y => y.idEncabezadoPrincipal == x.idEncabezadoPrincipal).length == 0)
                listaPrincipal.push(x)
        })
        //Recorrer encabezados principales
        let headPrincipal = '', headSecundario = ''
        listaPrincipal.forEach(x => {
            let columnas = listaSecundario.filter(y => y.idEncabezadoPrincipal == x.idEncabezadoPrincipal).length
            headPrincipal += `    <th class="text-white border-right" ${columnas > 1 ? `colspan="${columnas}"` : ''}>` +
                                    `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center">${x.encabezadoPrincipal.descripcionIconoAyuda ? `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="${x.encabezadoPrincipal.descripcionIconoAyuda}"></i>` : ''}<span>${x.encabezadoPrincipal.tituloEncabezado}</span></span></div>` +
                                `</th>`
            //Buscar encabezados secundarios relaacionados a los encabezados principales
            listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).forEach(m => {
                headSecundario += ` <th class="text-center" scope="col">` +
                                        `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-between align-items-center">${m.descripcionIconoAyuda ? `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="${m.descripcionIconoAyuda}"></i>` : ''}<span>${m.tituloEncabezado}</span></span></div>` +
                                   `</th>`
            })
        })
        //Mostrar en html
        headPrincipal = `<tr class="bg-info">${headPrincipal}</tr>`
        headSecundario = `<tr class="bg-azul text-white">${headSecundario}</tr>`
        $('.tabla-principal').find('table thead').html(`${headPrincipal}${headSecundario}`)

        //Armar body
        let body = ''
        for (let i = 0; i < tablaMaestra.cantidadFilas; i++) {
            let fila = ''
            listaPrincipal.forEach(x => {                
                //Buscar encabezados secundarios relaacionados a los encabezados principales
                listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).forEach(m => {
                    fila += armarControlCampo(m, i + 1)
                })
            })
            body += `<tr>${fila}</tr>`
        }
        $('.tabla-principal').find('table tbody').html(body)

        $('[data-toggle="tooltip"]').tooltip()
    }
}

var armarControlCampo = (secundario, i) => {
    let control = ''
    if (secundario.idTipoControl == 1) {
        let valor = ''
        if (secundario.idParametro > 0) {

        } else if (secundario.idTipoDato == 4) {
            valor = i
        }
        return `<td class="text-center" data-encabezado="${secundario.tituloEncabezado}" scope="row">${valor}</td>`
    } else if (secundario.idTipoControl == 2) {
        let tipoFormatoCampo = secundario.idTipoDato == 1 || secundario.idTipoDato == 2 ? 'number' : 'text'
        return `<td class="text-center" data-encabezado="${secundario.tituloEncabezado}">` +
                    `<input class="form-control form-control-sm" type="${tipoFormatoCampo}">` +
                  `</td>`
    } else if (secundario.idTipoControl == 7) {
        let opciones = ''
        if (secundario.idParametro > 0) {
            opciones = secundario.listaParametro == null ? '' : secundario.listaParametro.length == 0 ? '' : secundario.listaParametro.map((x, y) => {
                return `<div class="form-check form-check-inline">` +
                          `<input class="form-check-input" type="radio" name="pregunta-${i}" id="opcion-${x.id}" value="si" checked>` +
                          `<label class="form-check-label ml-1" for="opcion-${x.id}">${x.parametro}</label>` +
                        `</div>`
            }).join('')
        } else {
            opciones = `<div class="form-check form-check-inline">` +
                          `<input class="form-check-input" type="radio" name="pregunta" id="opcion-${i}" value="si" checked>` +
                          `<label class="form-check-label ml-1" for="opcion-${i}">opcion</label>` +
                        `</div>`
        }
        
        return `<td class="v-top text-center" data-encabezado="${secundario.tituloEncabezado}">${opciones}</td>`
    }
}