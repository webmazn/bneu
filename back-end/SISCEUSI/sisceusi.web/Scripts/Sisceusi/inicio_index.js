
$(document).ready(() => {
    $('#btnPrueba').on('click', (e) => consultarUsuario());
});

var consultarUsuario = () => {

    let urlUsuario = `${baseUrl}Inicio/obtenerUsuario`;

    fetch(urlUsuario)
    .then(r => r.json())
    .then(d => {
        console.log(d)
    })
    .catch(error => {
        console.log('Hubo un problema con la petición Fetch:' + error.message);
        location.href = `${baseUrl}Inicio/obtenerUsuario`
    })
}