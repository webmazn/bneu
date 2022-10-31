--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_CONTROL_ENCUESTA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_CONTROL_ENCUESTA" AS

  PROCEDURE USP_SEL_OBJECT(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT 
    cen.idControlEncuesta, cen.aceptaLLenarEncuesta, cen.aceptaTratamientoDatos, cen.aceptaFirmarEncuesta, cen.idSupervisor, cen.idEtapa, cen.idFase, cen.numeroCuestionario,
    cam.idCampana, cam.denominacion,
    emp.idEmpresaIndustria, emp.nombreEmpresa, emp.nombreComercial, emp.ruc,
    pem.idPlantaEmpresa, pem.denominacion planta, pem.idEmpresaGas, pem.numeroSuministroGas, pem.idEmpresaLuz, pem.numeroSuministroAlumbrado, cen.fechahorallenado, pem.direccion,
    usu.nombres nombreRevisor,
    dep.departamento, pro.provincia, dis.distrito, 
    --zon.zona, gas.empresagas, luz.empresaluz
    pzo.parametro zona, pga.parametro empresagas, plu.parametro empresaluz
    FROM T_GEND_CONTROL_ENCUESTA cen
    INNER JOIN T_GENM_PLANTA_EMPRESA pem ON cen.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = '1'
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = '1'
    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = '1'
    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = '1'
    
    INNER JOIN T_MAE_DEPARTAMENTO dep ON pem.idDepartamento = dep.idDepartamento
    INNER JOIN T_MAE_PROVINCIA pro ON pem.idProvincia = pro.idProvincia
    INNER JOIN T_MAE_DISTRITO dis ON pem.idDistrito = dis.idDistrito
    LEFT JOIN  T_GENM_PARAMETRO pzo ON pem.idZona = pzo.idParametro
    LEFT JOIN  T_GENM_PARAMETRO pga ON pem.idEmpresaGas = pga.idParametro
    LEFT JOIN  T_GENM_PARAMETRO plu ON pem.idEmpresaLuz = plu.idParametro    
    /*INNER JOIN T_MAE_ZONA zon ON pem.idZona = zon.idZona
    INNER JOIN T_MAE_EMPRESA_GAS gas ON pem.idEmpresaGas = gas.idEmpresaGas
    INNER JOIN T_MAE_EMPRESA_LUZ luz ON pem.idEmpresaLuz = luz.idEmpresaLuz */
    INNER JOIN T_GENM_USUARIO usu ON cen.idSupervisor = usu.idUsuario
    
    WHERE   idControlEncuesta = piIdControlEncuesta;
  END USP_SEL_OBJECT;
  
  PROCEDURE USP_UPD_PART_TRAT_DATOS(
    piIdControlEncuesta NUMBER,
    piIdCampana NUMBER,
    piAceptaLLenarEncuesta VARCHAR2,
    piAceptaTratamientoDatos VARCHAR2,
    piIdPlantaEmpresa NUMBER,
    piIdEmpresaGas NUMBER,
    piNumeroSuministroGas VARCHAR2,
    piIdEmpresaLuz NUMBER,
    piNumeroSuministroAlumbrado VARCHAR2,
    piIdUsuarioResponde NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vNumeroCuestionario NUMBER := 0;
  BEGIN
    
    SELECT NVL(numeroCuestionario,0) INTO vNumeroCuestionario FROM T_GEND_CONTROL_ENCUESTA WHERE idControlEncuesta = piIdControlEncuesta;
    
    IF vNumeroCuestionario = 0 THEN
        SELECT
        nvl(MAX(cen.numeroCuestionario),0) + 1 INTO vNumeroCuestionario
        FROM    T_GEND_CONTROL_ENCUESTA cen
        INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa
        INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana
        WHERE cen.idTipoEncuesta = (SELECT idTipoEncuesta FROM T_GEND_CONTROL_ENCUESTA WHERE idControlEncuesta = piIdControlEncuesta) AND cam.idCampana = piIdCampana;
    END IF;    
    
    UPDATE T_GENM_PLANTA_EMPRESA pe SET
      pe.idEmpresaGas = piIdEmpresaGas,
      pe.numeroSuministroGas = piNumeroSuministroGas,
      pe.idEmpresaLuz = piIdEmpresaLuz,
      pe.numeroSuministroAlumbrado = piNumeroSuministroAlumbrado,
      pe.idUsuarioModificacion = piIdUsuarioCreacion,
      pe.fechaModificacion = SYSDATE,
      pe.ipModificacion = piIpCreacion
      WHERE pe.IdPlantaEmpresa = piIdPlantaEmpresa;
  
    UPDATE T_GEND_CONTROL_ENCUESTA SET
    aceptallenarencuesta = piAceptaLLenarEncuesta,
    aceptatratamientodatos = piAceptaTratamientoDatos,
    idUsuarioModificacion = piIdUsuarioCreacion,
    numeroCuestionario = vNumeroCuestionario,
    idUsuarioResponde = piIdUsuarioCreacion,
    fechaModificacion = SYSDATE,
    ipModificacion = piIpCreacion
    WHERE 
    idControlEncuesta = piIdControlEncuesta;
    
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_PART_TRAT_DATOS;
  
  PROCEDURE USP_UPD_FIRMAR_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piAceptaFirmarEncuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GEND_CONTROL_ENCUESTA SET
    aceptafirmarencuesta = piAceptaFirmarEncuesta,
    idUsuarioModificacion = piIdUsuarioCreacion,
    fechaModificacion = SYSDATE,
    ipModificacion = piIpCreacion
    WHERE 
    idControlEncuesta = piIdControlEncuesta;
    
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_FIRMAR_ENCUESTA;
  
  PROCEDURE USP_UPD_FORM_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piFechaHoraLlenado DATE,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GEND_CONTROL_ENCUESTA SET
    fechaHoraLlenado = piFechaHoraLlenado,
    idUsuarioModificacion = piIdUsuarioCreacion,
    fechaModificacion = SYSDATE,
    ipModificacion = piIpCreacion
    WHERE 
    idControlEncuesta = piIdControlEncuesta;
    
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_FORM_ENCUESTA;
  
  PROCEDURE USP_SEL_PREGUNTA_ENCUESTA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT 
    *
    --MIN(numeroOrdenPregunta) numeroOrdenPregunta
    FROM T_GENM_CAMPANA_ENCUESTA
    WHERE 
    idCampana = (SELECT cem.idCampana FROM T_GEND_CONTROL_ENCUESTA cen
                INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = '1'
                WHERE idControlEncuesta = piIdControlEncuesta) 
    AND idEstado = '1'
    ORDER BY numeroOrdenPregunta ASC;
  END USP_SEL_PREGUNTA_ENCUESTA;
  
  PROCEDURE USP_SEL_RESPUESTA_ENCUESTA(
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    *
    FROM T_GEND_RESPUESTA_ENCUESTA
    WHERE idEstado = '1' AND idCampanaEncuesta = piIdCampanaEncuesta
    ORDER BY numeroOrdenRespuesta ASC; 
  END USP_SEL_RESPUESTA_ENCUESTA;
  
  PROCEDURE USP_SEL_LIST_ENC_SECUNDARIO(
    piIdParametroTabla NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    ens.idencabezadosecundario, ens.tituloEncabezado, ens.abreviacion, ens.usarAbreviado, ens.posicion, ens.idOrientacion, ens.descripcionIconoAyuda, ens.idTipoControl, ens.idTipoDato, ens.idParametro, 
    enp.idEncabezadoPrincipal, enp.tituloEncabezado tituloEncabezadoPrincipal, enp.abreviacion abreviacionPrincipal, enp.usarAbreviado usarAbreviadoPrincipal, enp.posicion posicionPrincipal, enp.descripcionIconoAyuda descripcionIconoAyudaPrinc,
    tma.idTablaMaestra, tma.subtitulo, tma.descripcionIconoAyuda descripcionIconoAyudaMaes, tma.preguntaInicial, tma.preguntaCierre, tma.idEstiloTabla, tma.cantidadFilas, tma.agregarFilas
    FROM    T_GEND_ENCABEZADO_SECUNDARIO ens
    INNER JOIN T_GEND_ENCABEZADO_PRINCIPAL enp ON ens.idEncabezadoPrincipal = enp.idEncabezadoPrincipal AND enp.idEstado = '1'
    INNER JOIN T_GENM_TABLA_MAESTRA tma ON enp.idTablaMaestra = tma.idTablaMaestra AND tma.idEstado = '1'
    WHERE
    tma.idTablaMaestra = piIdParametroTabla AND ens.idEstado = '1'
    ORDER BY enp.posicion, ens.posicion ASC;
  END USP_SEL_LIST_ENC_SECUNDARIO;
  
  PROCEDURE USP_SEL_PARAMETRO(
    piIdParametro NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_PARAMETRO
    WHERE idparentparametro = piIdParametro AND idEstado = '1'; 
  END USP_SEL_PARAMETRO;
  
  PROCEDURE USP_UPD_OBSERVACION_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piIdFase NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GEND_CONTROL_ENCUESTA SET
    idFase = piIdFase,
    fechaObservacion = SYSDATE,
    idUsuarioModificacion = piIdUsuarioCreacion,
    fechaModificacion = SYSDATE,
    ipModificacion = piIpCreacion
    WHERE 
    idControlEncuesta = piIdControlEncuesta;
    
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_OBSERVACION_ENCUESTA;
  
  PROCEDURE USP_UPD_REVISAR_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piIdFase NUMBER,
    piFechaRevision DATE,
    piIdMetodoVerificacion NUMBER,
    piIdValidezEntrevista NUMBER,
    piResultadoValidezEntrevista VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS 
  BEGIN
    UPDATE T_GEND_CONTROL_ENCUESTA SET
    idFase = piIdFase,
    fechaRevision = piFechaRevision,
    idMetodoVerificacion = piIdMetodoVerificacion,
    idValidezEntrevista = piIdValidezEntrevista,
    resultadoValidezEntrevista = piResultadoValidezEntrevista,
    idUsuarioModificacion = piIdUsuarioCreacion,
    fechaModificacion = SYSDATE,
    ipModificacion = piIpCreacion
    WHERE 
    idControlEncuesta = piIdControlEncuesta;
    
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_REVISAR_ENCUESTA;

END PKG_SISCEUSI_CONTROL_ENCUESTA;

/
