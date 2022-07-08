
$(document).ready(() => {
    $('form').submit((e) => {
        sendLogin(e);
    })
});

var validarCampos = () => {
    let arr = [];
    if ($("#USUARIO").val().trim() == '') arr.push("Debe ingresar su usuario");
    else if (!(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test($("#USUARIO").val()))) arr.push("Debe ingresar un correo electrónico válido");
    if ($("#txt-pswd").val().trim() == '') arr.push("Debe ingresar la contraseña");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('form .form-group:last').after(messageError(error));
        return false;
    }
    return true;
}

var sendLogin = (e) => {
    e.preventDefault();

    if ($('form .form-group:last').next().hasClass('alert')) $('form .form-group:last').next().remove();
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

    fetch(url, init)
    .then(r => r.json())
    .then(validarInicioSesion)
}

var validarInicioSesion = (data) => {
    if (data.success == true) {
        location.href = `${baseUrl}Interno/Inicio`;
    } else {
        $('form .form-group:last').after(messageError(messageStringGeneric(data.message)));
        grecaptcha.reset();
    }
}