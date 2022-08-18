$(document).ready(() => {
    armarPregunta()
});

var armarPregunta = () => {
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
        //Pregunta Secundaria
        if (tablaMaestra.preguntaCierre) {
            let preguntaCierre = `  <div class="form-check form-check-inline m-0">` +
                                        `<input id="chk-pregunta-cierre" class="form-check-input" type="checkbox">` +
                                    `</div>` +
                                    `<label class="font-weight-bold text-azul m-0" for="chk-pregunta-cierre">No tiene equipos en la sección “FUERZA MOTRIZ – OTROS EQUIPOS ELÉCTRICOS”</label>`
            $('#pregunta-cierre-maestra').html(preguntaCierre)
        }

        let listaPrincipal = []
        listaSecundario.forEach(x => {
            if (listaPrincipal.filter(y => y.idEncabezadoPrincipal == x.idEncabezadoPrincipal).length == 0)
                listaPrincipal.push(x)
        })

        let headPrincipal = '', headSecundario = ''
        listaPrincipal.forEach(x => {
            let columnas = listaSecundario.filter(y => y.idEncabezadoPrincipal == x.idEncabezadoPrincipal).length
            headPrincipal += `    <th class="text-white border-right" ${columnas > 1 ? `colspan="${columnas}"` : ''}>` +
                                    `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center">${x.encabezadoPrincipal.descripcionIconoAyuda ? `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="${x.encabezadoPrincipal.descripcionIconoAyuda}"></i>` : ''}<span>${x.encabezadoPrincipal.tituloEncabezado}</span></span></div>` +
                                `</th>`

            listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).forEach(m => {
                headSecundario += ` <th class="text-center" scope="col">` +
                                        `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-between align-items-center">${m.descripcionIconoAyuda ? `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="${m.descripcionIconoAyuda}"></i>` : ''}<span>${m.tituloEncabezado}</span></span></div>` +
                                   `</th>`
            })
        })
        headPrincipal = `<tr class="bg-info">${headPrincipal}</tr>`
        headSecundario = `<tr class="bg-azul text-white">${headSecundario}</tr>`
        $('.tabla-principal').find('table thead').html(`${headPrincipal}${headSecundario}`)

        $('[data-toggle="tooltip"]').tooltip()
    }
}