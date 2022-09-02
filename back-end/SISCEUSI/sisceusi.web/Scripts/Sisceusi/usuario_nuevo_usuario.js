$(document).ready(() => {
    $('#btn-verificar').on('click', (e) => verificarRuc())
    $('#btn-grabar').on('click', (e) => grabar())
    $('#cbo-estado').val('1')
    cargarDesplegables()
});

var verificadoRuc = false
var idEmpresaIndustria = 0
var idPlantaEmpresa = 0

var verificarRuc = () => {
    $('.seccion-mensaje').html('')
    if (verificarCampoRuc()) {
        let url = `${baseUrl}EmpresaIndustria/verificarRuc?ruc=${$('#txt-ruc').val().trim()}`;

        fetch(url)
        .then(r => r.json())
        .then(o => {
            if (!o.success) {
                idEmpresaIndustria = 0
                $('#txt-institucion').val('')
                verificadoRuc = false                
                $('.seccion-mensaje').html(messageError(messageStringGeneric('No se encontró información del Ruc ingresado. Verifique si la empresa fue registrada o regístrela')));
            } else {
                let empresa = o.object
                idEmpresaIndustria = empresa.idEmpresaIndustria
                $('#txt-institucion').val(empresa.nombreEmpresa)
                verificadoRuc = true
            }
        })
        .catch(error => {
            console.log('Error:' + error.message);
        })
    }
}

var verificarCampoRuc = () => {
    let arr = [];
    if (validarEspaciosBlanco($('#txt-ruc').val().trim())) arr.push("Debe ingresar el Ruc para la validación");
    else if (validarNumerico($('#txt-ruc').val().trim())) arr.push("El Ruc debe tener caracteres numéricos");
    else if (validarTamanioRuc($('#txt-ruc').val().trim())) arr.push("El Ruc debe tener 11 caracteres");
    else if (validarRuc10($('#txt-ruc').val().trim()) && validarRuc20($('#txt-ruc').val().trim())) arr.push("El Ruc debe empezar con 10 o 20");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'verificación'));
        return false;
    }
    return true;
}

var grabar = () => {
    $('.seccion-mensaje').html('');
    let arr = [];
    let ruc = $('#txt-ruc').val().trim()
    let correoElectronico = $("#txt-correo").val().trim()
    let nombres = $("#txt-nombre").val().trim()
    let dni = $("#txt-dni").val().trim()
    let password = $('#txt-pswd').val().trim()
    let telefono = $("#txt-telefono").val().trim()
    let idRol = $("#cbo-perfil").val()
    let idEstado = $("#cbo-estado").val()

    if (!verificadoRuc) arr.push("No ha verificado el Ruc");
    if (validarEspaciosBlanco(ruc)) arr.push("Debe ingresar el Ruc para la validación");
    else if (validarNumerico(ruc)) arr.push("El Ruc debe tener caracteres numéricos");
    else if (validarTamanioRuc(ruc)) arr.push("El Ruc debe tener 11 caracteres");
    else if (validarRuc10(ruc) && validarRuc20(ruc)) arr.push("El Ruc debe empezar con 10 o 20");
    if (validarEspaciosBlanco(correoElectronico)) arr.push("Debe ingresar un correo electrónico");
    else if (validarCorreoElectronico(correoElectronico)) arr.push("Debe ingresar un correo electrónico válido");
    if (validarEspaciosBlanco(nombres)) arr.push("Debe ingresar los nombres");
    if (validarEspaciosBlanco(dni)) arr.push("Debe ingresar el Dni");
    else if (validarNumerico(dni)) arr.push("El Dni debe tener caracteres numéricos");
    else if (validarTamanioDni(dni)) arr.push("El Dni debe tener 8 caracteres");
    if (validarEspaciosBlanco(password)) arr.push("Debe ingresar una contraseña");
    else if (validarMiniscMayuscNumero(password)) arr.push("La contraseña debe contener al menos una minúscula, mayúscula y número");
    else if (validarTamanioObjecto(password, 6)) arr.push("La contraseña debe contener 6 o más caracteres");
    //if (validarEspaciosBlanco(telefono)) arr.push("Debe ingresar el teléfono de contacto");
    if (validarCombo(idRol)) arr.push("Debe seleccionar un perfil");
    if (validarEstado(idEstado)) arr.push("Debe seleccionar un estado");

    if (arr.length > 0) {
        let error = messageArrayGeneric(arr);
        $('.seccion-mensaje').html(messageError(error, 'registro'));
        return;
    }

    let idUsuario = $('#frm').data('id')
    idUsuario = idUsuario == null ? -1 : idUsuario

    validarDatosRegistro(idUsuario, correoElectronico, dni) 
}

var validarDatosRegistro = (id, correo, dni) => {
    let urlVerificarCorreo = `${baseUrl}Usuario/verificarCorreo?id=${id}&correo=${correo}`;
    let urlVerificarDni = `${baseUrl}Usuario/verificarDni?id=${id}&dni=${dni}`;
    Promise.all([
        fetch(urlVerificarCorreo),
        fetch(urlVerificarDni)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jCorreo = responseAll[0]
        jDni = responseAll[1]
        if (jCorreo.success && jDni.success) {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('El correo electrónico y el dni ya están siendo usados'), 'registro'))
        } else if (jCorreo.success) {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('El correo electrónico ya está en uso'), 'registro'))
        } else if (jCorreo.success) {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('El dni ya está en uso'), 'registro'))
        } else {
            grabarDatos()
        }
    });
}

var grabarDatos = () => {
    let idUsuario = $('#frm').data('id')
    idUsuario = idUsuario == null ? -1 : idUsuario

    let correoElectronico = $("#txt-correo").val().trim()
    let nombres = $("#txt-nombre").val().trim()
    let dni = $("#txt-dni").val().trim()
    let password = $('#txt-pswd').val().trim()
    let telefono = $("#txt-telefono").val().trim()
    let idRol = $("#cbo-perfil").val()
    let idEstado = $("#cbo-estado").val()

    let url = `${baseUrl}Usuario/grabarUsuario`;
    let data = { idUsuario, idEmpresaIndustria, idPlantaEmpresa, idRol, correoElectronico, nombres, dni, password, telefono, idEstado, idUsuarioCreacion: idUsuarioLogin };
    let init = { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) };

    fetch(url, init)
    .then(r => r.json())
    .then(j => {
        if (j.success) {
            $('#btn-grabar').hide()
            $('.seccion-mensaje').html(messageSuccess(messageStringGeneric('Los datos ingresados fueron guardados exitosamente, verifique su bandeja para comprobarlo. Utilice el buscador para encontrar su nuevo registro.')))
            setTimeout(function () {
                location.href = `${baseUrl}Usuario/Index`
            }, 3500)
        } else {
            $('.seccion-mensaje').html(messageError(messageStringGeneric('Verifique que los datos sean correctamente ingresados, complete todos los campos obligatorios e intente otra vez.'), 'registro'))
        }        
    })
    .catch(error => {
        console.log('Error:' + error.message);
    })
}

var cargarDesplegables = () => {
    /*let urlRol = `${baseUrl}Rol/obtenerListaRol`;
    Promise.all([
        fetch(urlRol)
    ])
    .then(r => Promise.all(r.map(v => v.json())))
    .then((responseAll) => {
        jRol = responseAll[0]
        if (jRol.success) cargarRoles(jRol.object)
        cargarDatosIniciales()
    });*/
    cargarRoles(listaRol)
    cargarDatosIniciales()
}

var cargarRoles = (data) => {
    let options = data.length == 0 ? '' : data.map(x => `<option value="${x.idRol}">${x.rol}</option>`).join('');
    options = `<option value="0">-Seleccione un perfil de usuario-</option>${options}`;
    $('#cbo-perfil').html(options);
}

var cargarDatosIniciales = () => {
    /*let id = $('#identificador').val()
    if (id > 0) {
        let url = `${baseUrl}Usuario/obtenerUsuario?idUsuario=${id}`;
        fetch(url)
        .then(r => r.json())
        .then(j => {
            if (j.success) {
                cargarDatos(j.object)
            } else {
                $('.seccion-mensaje').html(messageError(messageStringGeneric('Ocurrió un problema al cargar los datos del usuario. Por favor, puede volver a recargar la página.'), 'carga de datos'))
            }
        })
        .catch(error => {
            console.log('Error:' + error.message)
        })
    }*/
    cargarDatos(usuario)
}

var cargarDatos = (data) => {
    if (data == null) return
    $('#frm').data('id', data.idUsuario);
    verificadoRuc = true
    idEmpresaIndustria = data.idEmpresaIndustria
    idPlantaEmpresa = data.idPlantaEmpresa
    $('#txt-ruc').val(data.empresaIndustria.ruc)
    $('#txt-institucion').val(data.empresaIndustria.nombreEmpresa)
    $('#txt-correo').val(data.correoElectronico)
    $('#txt-nombre').val(data.nombres)
    $('#txt-dni').val(data.dni)
    $('#txt-pswd').val(data.password)
    $('#txt-telefono').val(data.telefono)
    $('#cbo-perfil').val(data.idRol)
    $('#cbo-estado').val(data.idEstado)
}