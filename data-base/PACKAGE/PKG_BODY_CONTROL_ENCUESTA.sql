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
    cen.idControlEncuesta, cen.aceptaLLenarEncuesta, cen.aceptaTratamientoDatos, cen.aceptaFirmarEncuesta,    
    cam.idCampana, cam.denominacion,
    emp.idEmpresaIndustria, emp.nombreEmpresa, emp.nombreComercial, emp.ruc,
    pem.idPlantaEmpresa, pem.denominacion planta, pem.idEmpresaGas, pem.numeroSuministroGas, pem.idEmpresaLuz, pem.numeroSuministroAlumbrado
    FROM T_GEND_CONTROL_ENCUESTA cen
    INNER JOIN T_GENM_PLANTA_EMPRESA pem ON cen.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = '1'
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = '1'
    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = '1'
    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = '1'
    WHERE   idControlEncuesta = piIdControlEncuesta;
  END USP_SEL_OBJECT;
  
  PROCEDURE USP_UPD_PART_TRAT_DATOS(
    piIdControlEncuesta NUMBER,
    piIdCampana NUMBER,
    piAceptaLLenarEncuesta VARCHAR2,
    piAceptaTratamientoDatos VARCHAR2,
    piIdUsuarioResponde NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vNumeroCuestionario NUMBER := 0;
  BEGIN
    
    SELECT
    MAX(cen.numeroCuestionario) + 1 INTO vNumeroCuestionario
    FROM    T_GEND_CONTROL_ENCUESTA cen
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa
    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana
    WHERE cam.idCampana = piIdCampana;
  
    UPDATE T_GEND_CONTROL_ENCUESTA SET
    aceptallenarencuesta = piAceptaLLenarEncuesta,
    aceptatratamientodatos = piAceptaTratamientoDatos,
    idUsuarioModificacion = piIdUsuarioCreacion,
    numeroCuestionario = vNumeroCuestionario,
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

END PKG_SISCEUSI_CONTROL_ENCUESTA;

/
