

/*
 * VALIDACIONES
 */

// General
var validarEspaciosBlanco = (valor) => {
    if (valor.trim() === '') {
        return true;
    }
    return false;
}

var validarNumerico = (valor) => {
    if (!(new RegExp(/[0-9]/).test(valor))) {
        return true;
    }
    return false;
}

var validarTamanioObjecto = (objeto, tamanio) => {
    if (objeto.length < tamanio) {
        return true;
    }
    return false;
}

var validarCombo = (combo) => {
    if (combo == 0) {
        return true;
    }
    return false;
}

var validarEstado = (combo) => {
    if (combo == -1) {
        return true;
    }
    return false;
}

// Correo electronico
var validarCorreoElectronico = (correo) => {
    if (!(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        .test(correo))) {
        return true;
    }
    return false;
}

// Ruc
var validarTamanioRuc = (ruc) => {
    if (ruc.length < 11) {
        return true;
    }
    return false;
}

var validarRuc10 = (ruc) => {
    if (!ruc.startsWith("10")) {
        return true;
    }
    return false;
}

var validarRuc20 = (ruc) => {
    if (!ruc.startsWith("20")) {
        return true;
    }
    return false;
}

//Dni
var validarTamanioDni = (ruc) => {
    if (ruc.length < 8) {
        return true;
    }
    return false;
}

//Contraseña
var validarMiniscMayuscNumCaracEspecial = (pass) => {
    if (!(/[a-zñ]/.test(pass) && /[A-ZÑ]/.test(pass) && /[0-9]/.test(pass) && /[!@#$&*]/.test(pass))) {
        return true;
    }
    return false;
}

var validarMiniscMayuscNumero = (pass) => {
    if (!(/[a-zñ]/.test(pass) && /[A-ZÑ]/.test(pass) && /[0-9]/.test(pass))) {
        return true;
    }
    return false;
}

var validarMiniscMayuscula = (pass) => {
    if (!(/[a-zñ]/.test(pass) && /[A-ZÑ]/.test(pass))) {
        return true;
    }
    return false;
}