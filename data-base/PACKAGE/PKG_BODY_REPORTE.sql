--------------------------------------------------------
-- Archivo creado  - miércoles-septiembre-21-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_REPORTE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_REPORTE" AS

  PROCEDURE USP_SEL_LIST_CONTROL_ENC(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT 
    cen.idControlEncuesta, nvl(cen.numeroCuestionario, 0) numeroCuestionario, cen.idSupervisor,
    pem.idPlantaEmpresa, pem.denominacion planta, pem.latitud, pem.longitud, pem.direccion,
    emp.nombreEmpresa,
    dep.idDepartamento, dep.departamento, 
    pro.idProvincia, pro.provincia, 
    dis.idDistrito, dis.distrito, pzo.parametro zona
    --zon.zona
    FROM T_GEND_CONTROL_ENCUESTA cen
    INNER JOIN T_GENM_PLANTA_EMPRESA pem ON cen.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = '1'
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = '1'
    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = '1'
    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = '1'
    
    INNER JOIN T_MAE_DEPARTAMENTO dep ON pem.idDepartamento = dep.idDepartamento
    INNER JOIN T_MAE_PROVINCIA pro ON pem.idProvincia = pro.idProvincia
    INNER JOIN T_MAE_DISTRITO dis ON pem.idDistrito = dis.idDistrito
    LEFT JOIN  T_GENM_PARAMETRO pzo ON pem.idZona = pzo.idParametro
    --INNER JOIN T_MAE_ZONA zon ON pem.idZona = zon.idZona
    
    WHERE   cam.idCampana = piIdCampana AND cen.idTipoEncuesta = 2 AND cen.idEtapa = 3 AND cen.idFase = 5 AND cen.idEstado = '1'
    ORDER BY cen.idControlEncuesta, cen.numeroCuestionario ASC;
  END USP_SEL_LIST_CONTROL_ENC;
  
  PROCEDURE USP_SEL_PREGUNTA_ENCUESTA(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT 
    *
    FROM T_GENM_CAMPANA_ENCUESTA
    WHERE 
    idCampana = piIdCampana
    AND idEstado = '1'
    ORDER BY numeroOrdenPregunta ASC;
  END USP_SEL_PREGUNTA_ENCUESTA;
  
  PROCEDURE USP_SEL_LIST_RESP_ENC_PLANTA(
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    *
    FROM    T_GEND_RESP_ENCUESTA_PLANTA
    WHERE   idCampanaEncuesta = piIdCampanaEncuesta AND idEstado = '1';
  END USP_SEL_LIST_RESP_ENC_PLANTA;
  
  PROCEDURE USP_SEL_LIST_RESP_ENC_TABLA(
    piIdCampana NUMBER,
    piIdEncabezadoSecundario NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    *
    FROM    T_GEND_RESP_ENCUESTA_TABLA
    WHERE   idEncabezadoSecundario = piIdEncabezadoSecundario AND idEstado = '1' AND idControlEncuesta in (
                SELECT cen.idControlEncuesta
                FROM T_GEND_CONTROL_ENCUESTA cen
                INNER JOIN T_GENM_PLANTA_EMPRESA pem ON cen.idPlantaEmpresa = pem.idPlantaEmpresa
                INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa
                INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana
                WHERE cam.idCampana = piIdCampana);
  END USP_SEL_LIST_RESP_ENC_TABLA;

END PKG_SISCEUSI_REPORTE;

/
