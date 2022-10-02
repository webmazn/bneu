
var consultarEncuesta = (id) => {
    let url = `${baseUrl}Interno/obtenerPreguntasEncuesta?id=${id}`;
    fetch(url)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            armarPreguntas(j.object)
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos de la planta. Por favor, puede volver a recargar la página.'), 'carga de datos'))
        }
    })
    .catch(error => {
        console.log('Error:' + error.message)
    })
}

var armarPreguntas = (preguntasEncuesta) => {
    preguntasEncuesta.forEach(x => {
        armarPregunta(x)
    })
}

var armarPregunta = (preguntaEncuesta) => {
    if (preguntaEncuesta.idTipoControl == 1) {

    } else if (preguntaEncuesta.idTipoControl == 2) {
        armarListaOpciones(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 3) {

    } else if (preguntaEncuesta.idTipoControl == 4) {
        armarOpcionUnica(preguntaEncuesta)
    } else if (preguntaEncuesta.idTipoControl == 5) {
        //armarTablaMaestra(preguntaEncuesta.listaEncabezadoSecundario)
    }
}

var armarListaOpciones = (preguntaEncuesta) => {
    let respuesta = preguntaEncuesta.listaRespuestaEncuestaPlanta[0].idCampanaEncuesta
    let pregunta = preguntaEncuesta.listaRespuesta.find(x => x.idCampanaEncuesta == respuesta)

    let componente = `<div class="container">` +
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
}

var armarOpcionUnica = (preguntaEncuesta) => {
    let opciones = preguntaEncuesta.listaRespuesta == null ? `` : preguntaEncuesta.listaRespuesta.length == 0 ? '' : preguntaEncuesta.listaRespuesta.map(x =>
        `<div class="col-xm-12 col-sm-12 col-md-2 col-lg-2">` +
           `<div class="form-group">` +
             `<div class="form-check">` +
               `<input class="form-check-input valor-ingresado" type="radio" name="pregunta-${preguntaEncuesta.idCampanaEncuesta}" data-usuario="0" id="pregunta-${preguntaEncuesta.idCampanaEncuesta}-${x.idRespuestaEncuesta}">` +
               `<label class="form-check-label" for="pregunta-${preguntaEncuesta.idCampanaEncuesta}-${x.idRespuestaEncuesta}">${x.respuesta}</label>` +
             `</div>` +
           `</div>` +
         `</div>`).join('');
    opciones = `<div class="row">${opciones}</div>`;

    let componente = `<div class="container">` +
                        `<div class="row">` +
                          `<div class="col-12">` +
                            `<div class="form-group">` +
                              `<label class="font-weight-bold text-azul">${preguntaEncuesta.pregunta}</label>` +
                            `</div>` +
                          `</div>` +
                        `</div>${opciones}` +
                    `</div>`
    $('#pie').prev().after(componente)

    preguntaEncuesta.listaRespuestaEncuestaPlanta.forEach(x => {
        if (x.idRespuestaEncuesta == 0) {  
            $(`#pregunta-${x.idCampanaEncuesta}`).prop('checked', x.respuesta == '1' ? true : false)
        } else {
            $(`#pregunta-${x.idCampanaEncuesta}-${x.idRespuestaEncuesta}`).prop('checked', x.respuesta == '1' ? true : false)
        }        
    })
}

var armarPdf = async () => {


    window.html2canvas = html2canvas

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
}

/*function resolveAfter2Seconds() {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve('resolved');
        }, 2000);
    });
}

async function asyncCall() {
    console.log('calling');
    const result = await resolveAfter2Seconds();
    console.log(result);
}*/

var pdf = () => {
    /*html2canvas(document.body).then((canvas) => {
        const base64image = canvas.toDataURL("image/png");
        function download(source) {
            const fileName = "download.png";
            var el = document.createElement("a");
            el.setAttribute("href", source);
            el.setAttribute("download", fileName);
            document.body.appendChild(el);
            el.click();
            el.remove();
        }
        download(base64image)
    });*/

    /*
    window.jsPDF = window.jspdf.jsPDF;
    window.html2canvas = html2canvas;
    var doc = new jsPDF();
    doc.html(document.querySelector("body"), {
        callback: function (pdf) {
            pdf.save("cv-a4222.pdf");
        }
    });*/

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

}