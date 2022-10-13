﻿
$(document).ready(() => {
    $('form').submit((e) => {
        sendLogin(e);
    })
});

var validarCampos = () => {
    let arr = [];
    if (validarEspaciosBlanco($("#USUARIO").val().trim())) arr.push("Debe ingresar su usuario");
    else if (validarCorreoElectronico($("#USUARIO").val().trim())) arr.push("Debe ingresar un correo electrónico válido");
    if ($("#txt-pswd").val().trim() == '') arr.push("Debe ingresar la contraseña");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('form .form-group:last').after(messageError(error), 'acceso');
        return false;
    }
    return true;
}

var sendLogin = (e) => {
    e.preventDefault();

    $('.seccion-mensaje').html('');
    if (validarCampos()) {
        iniciarSesionConCaptcha();
    }    
}

var iniciarSesionConCaptcha = () => {
    let correoElectronico = $('#USUARIO').val().trim();
    let password = $('#txt-pswd').val().trim();
    let token = grecaptcha.getResponse();
    let data = { correoElectronico, password, token };

    let url = `${baseUrl}Login/iniciarSesion`;
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    $('button[type="submit"]').hide()
    fetch(url, init)
    .then(r => r.json())
    .then(validarInicioSesion)
}

var validarInicioSesion = (data) => {
    if (data.success == true) {
        location.href = `${baseUrl}Interno/Index`;
    } else {
        $('button[type="submit"]').show()
        $('.seccion-mensaje').html(messageError(messageStringGeneric(data.message), 'acceso'))
        grecaptcha.reset();
    }
}