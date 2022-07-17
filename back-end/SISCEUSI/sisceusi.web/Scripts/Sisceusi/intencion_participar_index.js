
$(document).ready(() => {
    $('form').submit((e) => {        
        send(e);
    })
});

var validarCampos = () => {
    let arr = [];
    if (validarEspaciosBlanco($("#RUC").val().trim())) arr.push("Debe ingresar el Ruc");
    else if (validarNumerico($('#RUC').val().trim())) arr.push("El Ruc debe tener caracteres numéricos");
    else if (validarTamanioRuc($('#RUC').val().trim())) arr.push("El Ruc debe tener 11 caracteres");
    else if (validarRuc10($('#RUC').val().trim()) && validarRuc20($('#RUC').val().trim())) arr.push("El Ruc debe empezar con 10 o 20");
    if (validarEspaciosBlanco($("#EMPRESA").val().trim())) arr.push("Debe ingresar el nombre de la empresa");
    if (validarEspaciosBlanco($("#USUARIO").val().trim())) arr.push("Debe ingresar un correo electrónico");
    else if (validarCorreoElectronico($("#USUARIO").val().trim())) arr.push("Debe ingresar un correo electrónico válido");
    if (validarEspaciosBlanco($("#REPLEGAL").val().trim())) arr.push("Debe ingresar el nombre del representante legal");
    if (validarEspaciosBlanco($("#DNI").val().trim())) arr.push("Debe ingresar el Dni");
    else if (validarNumerico($('#DNI').val().trim())) arr.push("El Dni debe tener caracteres numéricos");
    else if (validarTamanioDni($('#DNI').val().trim())) arr.push("El Dni debe tener 8 caracteres");
    if (validarEspaciosBlanco($("#TEL").val().trim())) arr.push("Debe ingresar el teléfono de contacto");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('form .form-group:last').after(messageError(error), 'registro');
        return false;
    }
    return true;
}

var send = (e) => {
    e.preventDefault();

    if ($('form .form-group:last').next().hasClass('alert')) $('form .form-group:last').next().remove();
    if (validarCampos()) {
        registrarConCaptcha();
    }
}

var registrarConCaptcha = () => {
    let ruc = $('#RUC').val().trim();
    let nombreEmpresa = $('#EMPRESA').val().trim();
    let correoElectronico = $('#USUARIO').val().trim();
    let representanteLegal = $('#REPLEGAL').val().trim();
    let dni = $('#DNI').val().trim();
    let telefono = $('#TEL').val().trim();
    let token = grecaptcha.getResponse();
    let data = { ruc, nombreEmpresa, correoElectronico, representanteLegal, dni, telefono, token };

    let url = `${baseUrl}IntencionParticipar/registrar`;
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(validar)
}

var validar = (data) => {
    if (data.success == true) {
        $('form .form-group:last').after(messageSuccess(messageStringGeneric(data.message)));
        $('button[type="submit"]').hide()
        setTimeout(function () {
            location.href = `${baseUrl}Inicio/Index`;
        }, 3500);
    } else {
        $('form .form-group:last').after(messageError(messageStringGeneric(data.message), 'registro'));
        grecaptcha.reset();
    }
}