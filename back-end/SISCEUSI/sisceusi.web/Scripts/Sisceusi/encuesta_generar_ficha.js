var seccion = ''
var contadorSeccion = 0
$(document).ready(() => {
    $('#titulo-ficha').html(`CUE${pad(controlEncuesta.numeroCuestionario, 4)} CUESTIONARIO`)
    listCampanaEncuesta.forEach(x => {
        armarPregunta(x)
    })
    armarBoton()
})

var armarPregunta = (preguntaEncuesta) => {
    if (preguntaEncuesta.idTipoControl == 1) {
        armarCajaTexto(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 2) {
        armarListaOpciones(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 3) {

    } else if (preguntaEncuesta.idTipoControl == 4) {
        armarOpcionUnica(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 5) {
        armarTablaMaestra(preguntaEncuesta)
    }
}

var armarCajaTexto = (preguntaEncuesta) => {
    let respuesta = preguntaEncuesta.listaRespuestaEncuestaPlanta[0].respuesta

    let componente = `<div class="container">` +
                        `<div class="row">` +
                          `<div class="col-xm-12 col-sm-12 col-md-6 col-lg-6">` +
                            `<div class="form-group">` +
                              `<label class="font-weight-bold text-azul" for="pregunta-${preguntaEncuesta.idCampanaEncuesta}">${preguntaEncuesta.pregunta}</label></br>` +
                              `<span>${respuesta}</span>` +
                            `</div>` +
                          `</div>` +
                        `</div>` +
                    `</div>`
    $('#pie').prev().after(componente)

    if (preguntaEncuesta.separador == '1') {
        $('#pie').prev().after('<div class="dropdown-divider my-4 d-none-print"></div>')
    }
}

var armarListaOpciones = (preguntaEncuesta) => {
    let respuesta = preguntaEncuesta.listaRespuestaEncuestaPlanta[0].idCampanaEncuesta
    let pregunta = preguntaEncuesta.listaRespuesta.find(x => x.idCampanaEncuesta == respuesta)

    let componente = `<div class="container ${preguntaEncuesta.separador == '1' ? 'ficha-reporte-print' : ''}">` +
                        `<div class="row">` +
                          `<div class="col-xm-12 col-sm-12 col-md-12 col-lg-12">` +
                            `<div class="form-group">` +
                              `<label class="font-weight-bold text-azul">${preguntaEncuesta.pregunta}</label></br>` +
                              `<span>${pregunta.respuesta}</span>` +
                            `</div>` +
                          `</div>` +
                        `</div>` +
                    `</div>`
    $('#pie').prev().after(componente)
    /*if (preguntaEncuesta.titulo == '1') {
        contadorSeccion++
        $('#pie').prev().after(`<div id="ficha-${contadorSeccion}" data-width="200" data-height="15"></div>`)
        $(`#ficha-${contadorSeccion}`).append(componente)
    } else {
        let height = $(`#ficha-${contadorSeccion}`).data('height')
        height += 15
        $(`#ficha-${contadorSeccion}`).data('height', height)
        $(`#ficha-${contadorSeccion}`).append(componente)
    }*/
    //$('#preguntas-encuesta').append(componente)

    if (preguntaEncuesta.separador == '1') {
        $('#pie').prev().after('<div class="dropdown-divider my-4 d-none-print"></div>')
    }
}

var armarOpcionUnica = (preguntaEncuesta) => {
    let opciones = preguntaEncuesta.listaRespuesta == null ? `` : preguntaEncuesta.listaRespuesta.length == 0 ? '' : preguntaEncuesta.listaRespuesta.map(x =>
        `<div class="col-xm-12 col-sm-12 col-md-2 col-lg-2">` +
           `<div class="form-group">` +
             `<div class="form-check">` +
               `<input class="form-check-input valor-ingresado" type="radio" name="pregunta-${preguntaEncuesta.idCampanaEncuesta}" data-usuario="0" id="pregunta-${preguntaEncuesta.idCampanaEncuesta}-${x.idRespuestaEncuesta}" disabled>` +
               `&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="form-check-label" for="pregunta-${preguntaEncuesta.idCampanaEncuesta}-${x.idRespuestaEncuesta}">${x.respuesta}</label>` +
             `</div>` +
           `</div>` +
         `</div>`).join('');
    opciones = `<div class="row">${opciones}</div>`;

    let componente = `<div class="container ${preguntaEncuesta.separador == '1' ? 'ficha-reporte-print' : ''}">` +
                        `<div class="row">` +
                          `<div class="col-12">` +
                            `<div class="form-group">` +
                              `<label class="font-weight-bold text-azul">${preguntaEncuesta.pregunta}</label>` +
                            `</div>` +
                          `</div>` +
                        `</div>${opciones}` +
                    `</div>`
    $('#pie').prev().after(componente)
    //$('#preguntas-encuesta').append(componente)
    /*if (preguntaEncuesta.titulo == '1') {
        contadorSeccion++
        $('#pie').prev().after(`<div id="ficha-${contadorSeccion}" data-width="200" data-height="15"></div>`)
        $(`#ficha-${contadorSeccion}`).append(componente)
    } else {
        let height = $(`#ficha-${contadorSeccion}`).data('height')
        height += 15
        $(`#ficha-${contadorSeccion}`).data('height', height)
        $(`#ficha-${contadorSeccion}`).append(componente)
    }*/

    preguntaEncuesta.listaRespuestaEncuestaPlanta.forEach(x => {
        if (x.idRespuestaEncuesta == 0) {  
            $(`#pregunta-${x.idCampanaEncuesta}`).prop('checked', x.respuesta == '1' ? true : false)
        } else {
            $(`#pregunta-${x.idCampanaEncuesta}-${x.idRespuestaEncuesta}`).prop('checked', x.respuesta == '1' ? true : false)
        }        
    })

    if (preguntaEncuesta.separador == '1') {
        $('#pie').prev().after('<div class="dropdown-divider my-4 d-none-print"></div>')
    }
}

var armarTablaMaestra = (preguntaEncuesta) => {
    let listaSecundario = preguntaEncuesta.listaEncabezadoSecundario
    if (listaSecundario.length > 0) {
        let tablaMaestra = listaSecundario[0].encabezadoPrincipal.tablaMaestra

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

        let idEncabezado = listaSecundario[0].idEncabezadoSecundario
        let preguntaInicial = tablaMaestra.preguntaInicial == '' ? '' :
                            `<div class="col-xm-12 col-sm-12 col-md-6 col-lg-6">` +
                                `<div class="form-group text-right">` +
                                  `<label for="encabezado-${100}-${idEncabezado}" class="font-weight-bold text-azul">${tablaMaestra.preguntaInicial}&nbsp;</label>` +
                                  `<div class="form-check form-check-inline">` +
                                    `<input id="encabezado-${100}-${idEncabezado}" data-control="6" class="form-check-input valor-ingresado" type="checkbox">` +
                                  `</div>` +
                                `</div>` +
                              `</div>`

        let preguntaFin = tablaMaestra.preguntaCierre == '' ? '' :
                        `<div class="container p-0">` +
                            `<div class="dropdown-divider my-4"></div>` +
                            `<div class="row">` +
                              `<div class="col-12">` +
                                `<div class="form-group text-right m-0">` +
                                  `<div class="form-check form-check-inline m-0">` +
                                    `<input class="form-check-input valor-ingresado" data-control="6" type="checkbox" id="encabezado-${101}-${idEncabezado}">` +
                                  `</div>` +
                                  `<label class="font-weight-bold text-azul m-0" for="encabezado-${101}-${idEncabezado}">${tablaMaestra.preguntaCierre}&nbsp;</label>` +
                                `</div>` +
                              `</div>` +
                            `</div>` +
                          `</div>`

        let subtitulo = `<div class="container p-0">` +
                            `<div class="row">` +
                                `<div class="${tablaMaestra.preguntaInicio == '' ? 'col-12' : 'col-xm-12 col-sm-12 col-md-6 col-lg-6'}">` +
                                    `<div class="form-group">` +
                                        `<label class="font-weight-bold text-azul">${tablaMaestra.subtitulo}</label>${tablaMaestra.descripcionIconoAyuda != '' ? `&nbsp;<i class="fas fa-question-circle pl-1" data-toggle="tooltip" data-placement="top" title="${tablaMaestra.descripcionIconoAyuda}"></i>` : ''}` +
                                    `</div>` +
                                `</div>` +
                                `${preguntaInicial}` +
                            `</div>` +
                        `</div>`

        let componenteTabla = `<div class="${tablaMaestra.idEstiloTabla == '1' ? 'container' : tablaMaestra.idEstiloTabla == '2' ? 'container-fluid' : 'container'} ${preguntaEncuesta.separador == '1' ? 'ficha-reporte-print' : ''}">` +
                                    `${subtitulo}` +
                                    `<div class="container-fluid p-0">` +
                                        `<div class ="row"> ` +
                                            `<div class="col-12">` +
                                                `<div class="table-responsive tabla-principal tabla-impresion">` +
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
                                    `${preguntaFin}` +
                                `</div>`
        $('#pie').prev().after(componenteTabla)
        //$('#preguntas-encuesta').append(componenteTabla)

        /*let tamanio = tablaMaestra.cantidadFilas
        let heightTabla = tamanio * 10
        if (preguntaEncuesta.titulo == '1') {
            contadorSeccion++
            $('#pie').prev().after(`<div id="ficha-${contadorSeccion}" data-width="200" data-height="${heightTabla}"></div>`)
            $(`#ficha-${contadorSeccion}`).append(componenteTabla)
        } else {
            let height = $(`#ficha-${contadorSeccion}`).data('height')
            height += heightTabla
            $(`#ficha-${contadorSeccion}`).data('height', height)
            $(`#ficha-${contadorSeccion}`).append(componenteTabla)
        }*/

        $('[data-toggle="tooltip"]').tooltip()

        if (preguntaEncuesta.separador == '1') {
            $('#pie').prev().after('<div class="dropdown-divider my-4 d-none-print"></div>')
        }

        preguntaEncuesta.listaEncabezadoSecundario.length == 0 ? '' : preguntaEncuesta.listaEncabezadoSecundario.map((m, n) => {
            m.listaRespuestaEncuestaTabla.length == 0 ? '' : m.listaRespuestaEncuestaTabla.map((a, b) => {                    
                if (a.idParametro == 0) {
                    let tipoControl = $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}`).data('control')
                    if (tipoControl == 2 || tipoControl == 3) {
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}`).html(a.respuesta)
                    } else if (tipoControl == 4) {
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}`).html(a.respuesta)
                    } else if (tipoControl == 5) {
                        let parametro = preguntaEncuesta.listaEncabezadoSecundario.find(x => x.idEncabezadoSecundario == a.idEncabezadoSecundario).listaParametro.filter(y => y.idParametro == a.respuesta)
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}`).html(parametro.parametro)
                    } else if (tipoControl == 6 || tipoControl == 7) {
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}`).prop('checked', a.respuesta == '1' ? true : false)
                    }
                } else {
                    let tipoControl = $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}-${a.idParametro}`).data('control')
                    if (tipoControl == 2 || tipoControl == 3) {
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}-${a.idParametro}`).html(a.respuesta)
                    } else if (tipoControl == 4) {
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}-${a.idParametro}`).html(a.respuesta)
                    } else if (tipoControl == 5) {
                        let parametro = preguntaEncuesta.listaEncabezadoSecundario.find(x => x.idEncabezadoSecundario == a.idEncabezadoSecundario).listaParametro.filter(y => y.idParametro == a.respuesta)
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}-${a.idParametro}`).html(parametro.parametro)
                    } else if (tipoControl == 6 || tipoControl == 7) {
                        $(`#encabezado-${a.filaTabla}-${a.idEncabezadoSecundario}-${a.idParametro}`).prop('checked', a.respuesta == '1' ? true : false)
                    }
                }
            })
        })
        
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
        return `<td class="text-center ${border}" data-encabezado="${secundario.tituloEncabezado}" scope="row"><span id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-component="span">${valor}</span></td>`
    } else if (secundario.idTipoControl == 2) {
        let tipoFormatoCampo = secundario.idTipoDato == 1 || secundario.idTipoDato == 2 ? 'number' : 'text'
        let alineacion = secundario.idTipoDato == 1 || secundario.idTipoDato == 2 ? 'text-right' : ''
        return `<td id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="text-center ${border}" data-control="2" data-encabezado="${secundario.tituloEncabezado}">` +
                    //`<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-usuario="0" class="form-control form-control-sm w-100 ${alineacion} valor-ingresado" type="${tipoFormatoCampo}">` +
                `</td>`
    } else if (secundario.idTipoControl == 3) {
        return `<td id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-control="3" data-encabezado="${secundario.tituloEncabezado}">` +
                    //`<textarea  data-usuario="0" class="form-control form-control-sm w-100 valor-ingresado" rows="2"></textarea>` +
                `</td>`
    } else if (secundario.idTipoControl == 4) {
        return `<td id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-control="4" data-encabezado="${secundario.tituloEncabezado}">` +
                    //`<input  data-usuario="0" class="form-control form-control-sm w-100 valor-ingresado" type="date">` +
                `</td>`
    } else if (secundario.idTipoControl == 5) {
        let opciones = secundario.listaParametro == null ? `` : secundario.listaParametro.length == 0 ? '' : secundario.listaParametro.map(x => `<option value="${x.idParametro}">${x.parametro}</option>`).join('');
        opciones = `<option value="0">-Seleccione una opción-</option>${opciones}`;

        return `<td id="encabezado-${i}-${secundario.idEncabezadoSecundario}" class="text-center ${border}" data-control="5" data-encabezado="${secundario.tituloEncabezado}">` +
                    /*`<select  data-usuario="0" class="form-control form-control-sm w-100 valor-ingresado">` +
                        `${opciones}` +
                    `</select>` +*/
                `</td>`
    } else if (secundario.idTipoControl == 6) {
        if (secundario.idOrientacion == '1') {
            return `    <td class="text-center ${border}" data-encabezado="Seleccionar">` +
                            `<div class="form-check form-check-inline"></div>` +
                            `<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-control="6" class="form-check-input valor-ingresado" type="checkbox">` +
                        `</td>`
        } else {
            return `   <td class="v-top text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">` +
                          `<div class="form-check form-check-inline">` +
                            `<input id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-control="6" class="form-check-input valor-ingresado" type="checkbox">` +
                          `</div>` +
                        `</td>`
        }
        
    } else if (secundario.idTipoControl == 7) {
        let opciones = ''
        if (secundario.idParametro > 0) {
            opciones = secundario.listaParametro == null ? '' : secundario.listaParametro.length == 0 ? '' : secundario.listaParametro.map((x, y) => {
                return `<div class="form-check form-check-inline">` +
                          `<input class="form-check-input valor-ingresado" data-usuario="0" type="radio" name="enc-${i}" id="encabezado-${i}-${secundario.idEncabezadoSecundario}-${x.idParametro}" data-control="7">` +
                          `<label class="form-check-label ml-1" for="encabezado-${i}-${secundario.idEncabezadoSecundario}-${x.idParametro}">${x.parametro}</label>` +
                        `</div>&nbsp;`
            }).join('')
        } else {
            opciones = `<div class="form-check form-check-inline">` +
                          `<input class="form-check-input valor-ingresado" data-usuario="0" type="radio" name="rad-${secundario.idEncabezadoSecundario}" id="encabezado-${i}-${secundario.idEncabezadoSecundario}" data-control="7">` +
                          `<label class="form-check-label ml-1" for="encabezado-${i}-${secundario.idEncabezadoSecundario}">opcion</label>` +
                        `</div>`
        }
        
        return `<td class="v-top text-center ${border}" data-encabezado="${secundario.tituloEncabezado}">${opciones}</td>`
    }
}

var armarBoton = () => {

    $('#pie').prev().removeClass('d-none-print')

    let boton = `<div class="container">` +
                  `<div class="row">` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3">` +
                      `<button class="btn btn-warning w-100 mb-3 text-white" data-toggle="tooltip" data-placement="top" title="Lorem ipsum dolor sit amet consectetur adipisicing elit. Quidem ipsum voluptate, repudiandae aperiam ducimus eaque cum? Ipsum, similique quae excepturi at quisquam obcaecati modi nulla debitis corrupti minima eum iusto!"><i class="fas fa-question-circle pr-1"></i>Ayuda</button>` +
                    `</div>` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3"><a class="btn btn-success w-100 mb-3" href="javascript:print()">Imprimir</a></div>` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3"></div>` +
                    `<div class="col-xm-12 col-sm-12 col-md-3 col-lg-3"><a class="btn btn-plomo w-100 mb-3" href="javascript:history.back()">Atrás</a></div>` +                    
                  `</div>` +
                `</div>`
    $('#pie').prev().after(boton)
}

/*var armarPdf = () => {
    window.jsPDF = window.jspdf.jsPDF
    window.html2canvas = html2canvas
    var doc = new jsPDF("p", "mm", "a4");
    let tam = $('[id*="ficha-"]').length
    $('[id*="ficha-"]').each((index, x) => {
        html2canvas($(x)[0], { scale: 2 }).then(canvas => {
            var x = canvas.toDataURL("image/jpeg")
            let width = $(`#ficha-${(index + 1)}`).data('width')
            let height = $(`#ficha-${(index + 1)}`).data('height')

            //doc.addImage(x, 'JPEG', 0, 20, width, 200);
            //por columna es x 40
            //registro ex x 10

            //pregunta normal width: 150 : altura: 40

            //pregunta un componente width: 200
            //pregunta un componente height: 15

            //pregunta tabla width: 200
            //pregunta tabla x fila: 10

            doc.addImage(x, "JPEG", 0, 20, width, height)
            if ((tam - 1) == index) {
                doc.save("body.pdf")
            } else {
                doc.addPage()
            }
        });
    })    
}

var pdf = () => {
    let tabla = $('.table-print')[0]

    window.jsPDF = window.jspdf.jsPDF;
    window.html2canvas = html2canvas;
    var doc = new jsPDF("p", "mm", "a4");
    html2canvas(tabla, { scale: 2 }).then(canvas => {
        var x = canvas.toDataURL("image/jpeg", 0.95);
        doc.addImage(x, "JPEG", 30, 30, 148, 150);
        doc.addPage();
        doc.addImage(x, "JPEG", 30, 30, 148, 150);
        doc.save("body.pdf");
    });

}*/