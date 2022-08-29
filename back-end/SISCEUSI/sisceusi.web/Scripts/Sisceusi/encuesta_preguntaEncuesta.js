$(document).ready(() => {
    tituloPrincipal(preguntasEncuesta[0].tituloSeccion)
    preguntasEncuesta.forEach(x => {
        armarPregunta(x)
    })
    armarPieEncuesta()
});

var tituloPrincipal = (tituloSeccion) => {
    let titulo = `<div class="row">` +
                    `<div class="col-12">` +
                      `<div class="container m-0 px-0 py-4">` +
                        `<div class="row">` +
                          `<div class="col-12 d-flex">` +
                            `<div class="bg-light w-100 p-4">` +
                              `<div class="h4 text-cyan">ENC${pad(numeroEncuesta, 4)} CUESTIONARIO - ${tituloSeccion}</div>` +
                            `</div>` +
                          `</div>` +
                        `</div>` +
                      `</div>` +
                    `</div>` +
                  `</div>`
    $('#cuerpo').append(titulo)
}

var armarPregunta = (preguntaEncuesta) => {
    if (preguntaEncuesta.idTipoControl == 1) {

    } else if (preguntaEncuesta.idTipoControl == 2) {
        armarListaOpciones(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 3) {

    } else if (preguntaEncuesta.idTipoControl == 4) {
        armarOpcionUnica(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 5) {
        armarTablaMaestra(preguntaEncuesta.listaEncabezadoSecundario)
    }
}

var armarListaOpciones = (preguntaEncuesta) => {
    let opciones = preguntaEncuesta.listaRespuesta == null ? `` : preguntaEncuesta.listaRespuesta.length == 0 ? '' : preguntaEncuesta.listaRespuesta.map(x => `<option value="${x.idRespuestaEncuesta}">${x.respuesta}</option>`).join('');
    opciones = `<option value="0">-Seleccione una opción-</option>${opciones}`;

    let componente = `<div class="container">` +
                        `<div class="row">` +
                          `<div class="col-xm-12 col-sm-12 col-md-6 col-lg-6">` +
                            `<div class="form-group">` +
                              `<label class="font-weight-bold" for="pregunta-${preguntaEncuesta.idCampanaEncuesta}">${preguntaEncuesta.pregunta}</label>` +
                              `<select id="pregunta-${preguntaEncuesta.idCampanaEncuesta}" class="form-control">` +
                                `${opciones}` +
                              `</select>` +
                            `</div>` +
                          `</div>` +
                        `</div>` +
                    `</div>`
    $('#pie').prev().after(componente)
}

var armarOpcionUnica = (preguntaEncuesta) => {
    let opciones = preguntaEncuesta.listaRespuesta == null ? `` : preguntaEncuesta.listaRespuesta.length == 0 ? '' : preguntaEncuesta.listaRespuesta.map(x =>
        `<div class="col-xm-12 col-sm-12 col-md-2 col-lg-2">` +
           `<div class="form-group">` +
             `<div class="form-check">` +
               `<input class="form-check-input" type="radio" name="pregunta-${preguntaEncuesta.idCampanaEncuesta}" id="pregunta-${preguntaEncuesta.idCampanaEncuesta}-${idRespuestaEncuesta}">` +
               `<label class="form-check-label" for="pregunta-${preguntaEncuesta.idCampanaEncuesta}-${idRespuestaEncuesta}">${x.respuesta}</label>` +
             `</div>` +
           `</div>` +
         `</div>`).join('');
    opciones = `<div class="row">${opciones}</div>`;

    let componente = `<div class="container">` +
                        `<div class="row">` +
                          `<div class="col-12">` +
                            `<div class="form-group">` +
                              `<label class="font-weight-bold">${preguntaEncuesta.pregunta}</label>` +
                            `</div>` +
                          `</div>` +
                        `</div>${opciones}` +
                    `</div>`
    $('#pie').prev().after(componente)
}

var armarTablaMaestra = (listaSecundario) => {
    if (listaSecundario.length > 0) {
        let tablaMaestra = listaSecundario[0].encabezadoPrincipal.tablaMaestra
        //Subtitulo
        //$('#subtitulo-maestra').html(tablaMaestra.subtitulo)
        //if (tablaMaestra.subtitulo) {
        //    let textAyudaMaestra = `<i class="fas fa-question-circle pl-1" data-toggle="tooltip" data-placement="top" title="${tablaMaestra.descripcionIconoAyuda}"></i>`
        //    $('#text-ayuda-maestra').html(textAyudaMaestra)
        //}
        //Pregunta inicial
        //if (tablaMaestra.preguntaInicial) {
        //    let preguntaInicial = ` <label class="font-weight-bold text-azul" for="chk-pregunta-inicial">${tablaMaestra.preguntaInicial}</label>&nbsp;` +
        //                            `<div class="form-check form-check-inline">` +
        //                                `<input id="chk-pregunta-inicial" class="form-check-input" type="checkbox">` +
        //                            `</div>`
        //    $('#pregunta-inicial-maestra').html(preguntaInicial)
        //}
        //Pregunta cierre
        //if (tablaMaestra.preguntaCierre) {
        //    let preguntaCierre = `  <div class="form-check form-check-inline m-0">` +
        //                                `<input id="chk-pregunta-cierre" class="form-check-input" type="checkbox">` +
        //                            `</div>` +
        //                            `<label class="font-weight-bold text-azul m-0" for="chk-pregunta-cierre">No tiene equipos en la sección “FUERZA MOTRIZ – OTROS EQUIPOS ELÉCTRICOS”</label>`
        //    $('#pregunta-cierre-maestra').html(preguntaCierre)
        //}
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
            headPrincipal += `    <th class="text-white text-center border-right" ${columnas > 1 ? `colspan="${columnas}"` : ''}>` +
                                    `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-center align-items-center">${x.encabezadoPrincipal.descripcionIconoAyuda ? `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="${x.encabezadoPrincipal.descripcionIconoAyuda}"></i>` : ''}<span>${x.encabezadoPrincipal.tituloEncabezado} ${x.usarAbreviado == '1' ? x.abreviacion : ''}</span></span></div>` +
                                `</th>`

            let contadorSecundario = 0
            let cantidadSecundario = listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).length
            //Buscar encabezados secundarios relaacionados a los encabezados principales
            listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).forEach(m => {
                contadorSecundario++
                let border = contadorSecundario == cantidadSecundario ? 'border-right' : ''
                if (x.idOrientacion == '1') {
                    headSecundario += ` <th class="text-center ${border}" scope="col">` +
                                            `<div class="d-flex justify-content-center align-items-center"><span class="d-flex justify-content-between align-items-center">${m.descripcionIconoAyuda ? `<i class="fas fa-question-circle mr-1" data-toggle="tooltip" data-placement="right" title="${m.descripcionIconoAyuda}"></i>` : ''}<span>${m.tituloEncabezado} ${m.usarAbreviado == '1' ? m.abreviacion : ''}</span></span></div>` +
                                       `</th>`
                } else {
                    headSecundario += ` <th class="v-top ${border}" scope="col">` +
                                          `<div class="d-flex align-items-start justify-content-center"><span class="d-flex flex-column">${m.descripcionIconoAyuda ? `<i class="fas fa-question-circle mb-1" data-toggle="tooltip" data-placement="right" title="${m.descripcionIconoAyuda}"></i>` : ''}<span class="rotate-texto">${m.tituloEncabezado}</span></span></div>` +
                                        `</th>`
                }                
            })
        })
        //Mostrar en html
        headPrincipal = listaPrincipal.length == 1 && (listaPrincipal[0].encabezadoPrincipal.tituloEncabezado == null || listaPrincipal[0].encabezadoPrincipal.tituloEncabezado == '') ? '' : `<tr class="bg-info">${headPrincipal}</tr>`
        headSecundario = `<tr class="bg-azul text-white">${headSecundario}</tr>`
        //$('.tabla-principal').find('table thead').html(`${headPrincipal}${headSecundario}`)

        //Armar body
        let body = ''
        for (let i = 0; i < tablaMaestra.cantidadFilas; i++) {
            let fila = ''
            listaPrincipal.forEach(x => {
                let contadorSecundario = 0
                let cantidadSecundario = listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).length                
                //Buscar encabezados secundarios relaacionados a los encabezados principales
                listaSecundario.filter(z => z.idEncabezadoPrincipal == x.idEncabezadoPrincipal).forEach(m => {
                    contadorSecundario++
                    let border = contadorSecundario == cantidadSecundario ? 'border-right' : ''
                    fila += armarControlCampo(m, i, border)
                })
            })
            body += `<tr>${fila}</tr>`
        }
        //$('.tabla-principal').find('table tbody').html(body)

        let subtitulo = `<div class="container p-0">` +
                            `<div class="row">` +
                                `<div class="col-12">` +
                                    `<div class="form-group">` +
                                        `<label class="font-weight-bold">${tablaMaestra.subtitulo}</label>${tablaMaestra.descripcionIconoAyuda != '' ? `&nbsp;<i class="fas fa-question-circle pl-1" data-toggle="tooltip" data-placement="top" title="${tablaMaestra.descripcionIconoAyuda}"></i>` : ''}` +
                                    `</div>` +
                                `</div>` +
                            `</div>` +
                        `</div>`

        let componenteTabla = `<div class="${tablaMaestra.idEstiloTabla == '1' ? 'container' : tablaMaestra.idEstiloTabla == '2' ? 'container-fluid' : 'container' }">` +
                                    `${subtitulo}` +
                                    `<div class="container-fluid p-0">` +
                                        `<div class ="row"> ` +
                                            `<div class="col-12">` +
                                                `<div class="table-responsive tabla-principal">` +
                                                    `<table class="table table-striped table-hover">` +
                                                        `<thead>` +
                                                        `${headPrincipal}${headSecundario}` +
                                                        `</thead>` +
                                                        `<tbody>` +
                                                        `${body}`+
                                                        `</tbody>` +
                                                    `</table>` +
                                                `</div>` +
                                            `</div>` +
                                        `</div>` +
                                    `</div>` +
                                `</div>`
        $('#pie').prev().after(componenteTabla)

        $('[data-toggle="tooltip"]').tooltip()
    }
}

var armarControlCampo = (secundario, i, border) => {
    let control = ''
    if (secundario.idTipoControl == 1) {
        let valor = ''
        if (secundario.idParametro > 0) {
            valor = secundario.listaParametro[i] == null ? '' : secundario.listaParametro[i].parametro
        } else if (secundario.idTipoDato == 4) {
            valor = i + 1
        }
        return `<td class="text-center ${border}" data-encabezado="${secundario.tituloEncabezado}" scope="row">${valor}</td>`
    } else if (secundario.idTipoControl == 2) {
        let tipoFormatoCampo = secundario.idTipoDato == 1 || secundario.idTipoDato == 2 ? 'number' : 'text'
        let alineacion = secundario.idTipoDato == 1 || secundario.idTipoDato == 2 ? 'text-right' : ''
        return `<td class="text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">` +
                    `<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="form-control form-control-sm w-100 ${alineacion}" type="${tipoFormatoCampo}">` +
                  `</td>`
    } else if (secundario.idTipoControl == 3) {
        return `<td class="text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">` +
                    `<textarea id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="form-control form-control-sm w-100" rows="2"></textarea>` +
                `</td>`
    } else if (secundario.idTipoControl == 4) {
        return `<td class="text-center" data-encabezado="${secundario.tituloEncabezado}">` +
                    `<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="form-control form-control-sm w-100" type="date">` +
                `</td>`
    } else if (secundario.idTipoControl == 5) {
        let opciones = secundario.listaParametro == null ? `` : secundario.listaParametro.length == 0 ? '' : secundario.listaParametro.map(x => `<option value="${x.idParametro}">${x.parametro}</option>`).join('');
        opciones = `<option value="0">-Seleccione una opción-</option>${opciones}`;

        return `<td class="text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">` +
                    `<select id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="form-control form-control-sm w-100">` +
                        `${opciones}` +
                    `</select>` +
                `</td>`
    } else if (secundario.idTipoControl == 6) {
        if (secundario.idOrientacion == '1') {
            return `    <td class="text-center ${border}" data-encabezado="Seleccionar">` +
                            `<div class="form-check form-check-inline"></div>` +
                            `<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="form-check-input" type="checkbox">` +
                        `</td>`
        } else {
            return `   <td class="v-top text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">` +
                          `<div class="form-check form-check-inline">` +
                            `<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="form-check-input" type="checkbox">` +
                          `</div>` +
                        `</td>`
        }
        
    } else if (secundario.idTipoControl == 7) {
        let opciones = ''
        if (secundario.idParametro > 0) {
            opciones = secundario.listaParametro == null ? '' : secundario.listaParametro.length == 0 ? '' : secundario.listaParametro.map((x, y) => {
                return `<div class="form-check form-check-inline">` +
                          `<input class="form-check-input" type="radio" name="enc-${i}" id="param-${i}-${secundario.idEncabezadoSecundario}-${x.idParametro}">` +
                          `<label class="form-check-label ml-1" for="param-${i}-${secundario.idEncabezadoSecundario}-${x.idParametro}">${x.parametro}</label>` +
                        `</div>&nbsp;`
            }).join('')
        } else {
            opciones = `<div class="form-check form-check-inline">` +
                          `<input class="form-check-input" type="radio" name="pregunta-${secundario.idEncabezadoSecundario}" id="encabezado-${i}-${secundario.idEncabezadoSecundario}">` +
                          `<label class="form-check-label ml-1" for="encabezado-${i}-${secundario.idEncabezadoSecundario}">opcion</label>` +
                        `</div>`
        }
        
        return `<td class="v-top text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">${opciones}</td>`
    }
}

var armarPieEncuesta = () => {
    let pie = `<div class="dropdown-divider my-4"></div>` +
                `<div class="container">` +
                  `<div class="row">` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3">` +
                      `<button class="btn btn-warning w-100 mb-3 text-white" data-toggle="tooltip" data-placement="top" title="corrupti minima eum iusto!"><i class="fas fa-question-circle pr-1"></i>Ayuda</button>` +
                    `</div>` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3"></div>` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3"><a class="btn btn-plomo w-100 mb-3" href="${baseUrl}Interno/Index">Salir</a></div>` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3"><a class="btn btn-azul w-100 mb-3" href="javascript:void()" onclick="grabarEncuesta()">Continuar</a></div>` +
                  `</div>` +
                  `<div class="row">` +
                    `<div class ="col-6"></div>` +
                        `<div class ="col-xm-12 col-sm-12 col-md-6 col-lg-6 seccion-mensaje"></div>` +
                  `</div>` +
               ` </div>`

    $('#pie').prev().after(pie)

    $('[data-toggle="tooltip"]').tooltip()
}

var grabarEncuesta = () => {
    let arrRespuestaEncPlanta = []
    let arrRespuestaEncTabla = []

    $(`[id*="pregunta-"]`).each((index, x) => {
        let valor = $(`#${x.id}`).val()
        let arr = x.id.split('-')
        if (arr.length == 2) {
            arrRespuestaEncPlanta.push({
                idControlEncuesta: idControlEncuesta,
                idCampanaEncuesta: x[1],
                idRespuestaEncuesta: 0,
                respuesta: valor
            })
        } else if (arr.length == 3) {
            arrRespuestaEncPlanta.push({
                idControlEncuesta: idControlEncuesta,
                idCampanaEncuesta: x[1],
                idRespuestaEncuesta: x[2],
                respuesta: valor
            })
        }
    })

    $(`[id*="encabezado-"]`).each((index, x) => {
        let valor = $(`#${x.id}`).val()
        let arr = x.id.split('-')
        if (arr.length == 3) {
            arrRespuestaEncTabla.push({
                idControlEncuesta: idControlEncuesta,
                filaTabla: x[1],
                idEncabezadoSecundario: x[2],
                idParametro: 0,
                respuesta: valor
            })
        } else if (arr.length == 4) {
            arrRespuestaEncTabla.push({
                idControlEncuesta: idControlEncuesta,
                filaTabla: x[1],
                idEncabezadoSecundario: x[2],
                idParametro: x[3],
                respuesta: valor
            })
        }
    })

    let url = `${baseUrl}Encuesta/grabarEncuesta`;
    let data = { listaRespuestaEncuestaPlanta: arrRespuestaEncPlanta, listaRespuestaEncuestaTabla: arrRespuestaEncTabla, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            location.href = `${baseUrl}Encuesta/PreguntaEncuesta/${idControlEncuesta}`
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados'), 'registro'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })

}