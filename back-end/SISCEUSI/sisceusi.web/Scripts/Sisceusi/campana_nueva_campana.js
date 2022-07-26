$(document).ready(() => {
    //$('#btn-verificar').on('click', (e) => verificarRuc())
    //$('#btn-grabar').on('click', (e) => grabar())
    cargarDesplegables()
});

/* ================================================
 * INICIO CARGA DESPLEGABLES
 * ================================================
 */

var cargarDesplegables = () => {
    let urlEmpresa = `${baseUrl}EmpresaIndustria/obtenerListaEmpresaIndustria`;
    let urlRevisor = `${baseUrl}Usuario/obtenerListaRevisor`;
    Promise.all([
        fetch(urlEmpresa),
        fetch(urlRevisor)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jEmpresa = responseAll[0]
        jRevisor = responseAll[1]
        if (jEmpresa.success) cargarEmpresa(jEmpresa.object)
        if (jRevisor.success) cargarRevisor(jRevisor.object)
        inicializarListasSeleccionables()
        //cargarDatosIniciales()        
    });
}

var cargarEmpresa = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idEmpresaIndustria}">${x.nombreEmpresa}</option>`).join('');
    $('#tab01').html(`<select id="source00" data-text="Empresas para seleccionar" data-search="Buscar empresa">${options}</select><select id="destination00" data-text="Empresas seleccionadas" data-search="Buscar empresa"></select>`);
    $('#tab02').html(`<select id="source01" data-text="Empresas piloto para seleccionar" data-search="Buscar empresa">${options}</select><select id="destination01" data-text="Empresas piloto seleccionadas" data-search="Buscar empresa"></select>`);
}

var cargarRevisor = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idUsuario}">${x.nombres}</option>`).join('');
    $('#tab03').html(`<select id="source02" data-text="Perfiles para seleccionar" data-search="Buscar empresa">${options}</select><select id="destination02" data-text="Perfiles seleccionadas" data-search="Buscar empresa"></select>`);
}

var inicializarListasSeleccionables = () => {
    if ($("#listSwapWrap").length) {
        $('#source00, #destination00').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
        $('#source01, #destination01').listswap({
            truncate: true,
            height: 250,
            label_add: '>',
            label_remove: '<',
            is_scroll: true,
        });
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
 * FIN CARGA DESPLEGABLES
 * ================================================
 */
