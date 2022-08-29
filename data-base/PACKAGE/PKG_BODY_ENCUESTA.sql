--------------------------------------------------------
-- Archivo creado  - lunes-agosto-29-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_ENCUESTA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_ENCUESTA" AS

  PROCEDURE USP_PRC_GUARDAR_RESP_ENC_PLAN(
    piIdControlEncuesta NUMBER,
    piIdCampanaEncuesta NUMBER,
    piIdRespuestaEncuesta NUMBER,
    piRespuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdRespuestaEncuesta > 0 THEN
        SELECT
            (SELECT idRespuestaEncuestaPlanta FROM T_GEND_RESP_ENCUESTA_PLANTA WHERE idControlEncuesta = piIdControlEncuesta AND idCampanaEncuesta = piIdCampanaEncuesta AND idRespuestaEncuesta = piIdRespuestaEncuesta)
        INTO vId
        FROM DUAL;
    ELSE
        SELECT
            (SELECT idRespuestaEncuestaPlanta FROM T_GEND_RESP_ENCUESTA_PLANTA WHERE idControlEncuesta = piIdControlEncuesta AND idCampanaEncuesta = piIdCampanaEncuesta)
        INTO vId
        FROM DUAL;
    END IF;    
  
    IF vId IS NULL THEN
      vId := SQ_GEND_RESP_ENCUESTA_PLANTA.NEXTVAL();
      INSERT INTO T_GEND_RESP_ENCUESTA_PLANTA
      (idRespuestaEncuestaPlanta, idControlEncuesta, idCampanaEncuesta, idRespuestaEncuesta, respuesta, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piIdControlEncuesta, piIdCampanaEncuesta, piIdRespuestaEncuesta, piRespuesta, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      IF piIdRespuestaEncuesta > 0 THEN
        UPDATE T_GEND_RESP_ENCUESTA_PLANTA SET
          respuesta = piRespuesta,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idControlEncuesta = piIdControlEncuesta AND idCampanaEncuesta = piIdCampanaEncuesta AND idRespuestaEncuesta = piIdRespuestaEncuesta;
      ELSE
        UPDATE T_GEND_RESP_ENCUESTA_PLANTA SET
          respuesta = piRespuesta,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idControlEncuesta = piIdControlEncuesta AND idCampanaEncuesta = piIdCampanaEncuesta;
      END IF;
      
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_RESP_ENC_PLAN;

  PROCEDURE USP_PRC_GUARDAR_RESP_ENC_TAB(
    piIdControlEncuesta NUMBER,
    piFilaTabla NUMBER,
    piIdEncabezadoSecundario NUMBER,
    piIdParametro NUMBER,
    piRespuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdParametro > 0 THEN
        SELECT
            (SELECT idRespuestaEncuestaTabla FROM T_GEND_RESP_ENCUESTA_TABLA WHERE idControlEncuesta = piIdControlEncuesta AND filaTabla = piFilaTabla AND idEncabezadoSecundario = piIdEncabezadoSecundario AND idParametro = piIdParametro)
        INTO vId
        FROM DUAL;
    ELSE
        SELECT
            (SELECT idRespuestaEncuestaTabla FROM T_GEND_RESP_ENCUESTA_TABLA WHERE idControlEncuesta = piIdControlEncuesta AND filaTabla = piFilaTabla AND idEncabezadoSecundario = piIdEncabezadoSecundario)
        INTO vId
        FROM DUAL;
    END IF;    
  
    IF vId IS NULL THEN
      vId := SQ_GEND_RESP_ENCUESTA_TABLA.NEXTVAL();
      INSERT INTO T_GEND_RESP_ENCUESTA_TABLA
      (idRespuestaEncuestaTabla, idControlEncuesta, filaTabla, idEncabezadoSecundario, idParametro, respuesta, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piIdControlEncuesta, piFilaTabla, piIdEncabezadoSecundario, piIdParametro, piRespuesta, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      IF piIdParametro > 0 THEN
        UPDATE T_GEND_RESP_ENCUESTA_TABLA SET
          respuesta = piRespuesta,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idControlEncuesta = piIdControlEncuesta AND filaTabla = piFilaTabla AND idEncabezadoSecundario = piIdEncabezadoSecundario AND idParametro = piIdParametro;
      ELSE
        UPDATE T_GEND_RESP_ENCUESTA_TABLA SET
          respuesta = piRespuesta,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idControlEncuesta = piIdControlEncuesta AND filaTabla = piFilaTabla AND idEncabezadoSecundario = piIdEncabezadoSecundario;
      END IF;
      
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_RESP_ENC_TAB;
  
  PROCEDURE USP_SEL_PREGUNTA_PLANTA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    nvl(MAX(cem.numeroOrdenPregunta), 0) numeroOrdenPregunta
    FROM    T_GEND_RESP_ENCUESTA_PLANTA rep
    INNER JOIN T_GENM_CAMPANA_ENCUESTA cem ON rep.idCampanaEncuesta = cem.idCampanaEncuesta AND cem.idEstado = '1'
    WHERE   idControlEncuesta = piIdControlEncuesta AND cem.idEstado = '1';
  END USP_SEL_PREGUNTA_PLANTA;
  
  PROCEDURE USP_SEL_PREGUNTA_TABLA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    nvl(MAX(cem.numeroOrdenPregunta), 0) numeroOrdenPregunta
    FROM    T_GEND_RESP_ENCUESTA_TABLA ret
    INNER JOIN T_GEND_ENCABEZADO_SECUNDARIO ens ON ret.idEncabezadoSecundario = ens.idEncabezadoSecundario AND ens.idEstado = '1'
    INNER JOIN T_GEND_ENCABEZADO_PRINCIPAL enp ON ens.idEncabezadoPrincipal = enp.idEncabezadoPrincipal AND enp.idEstado = '1'
    INNER JOIN T_GENM_TABLA_MAESTRA tma ON enp.idTablaMaestra = tma.idTablaMaestra AND tma.idEstado = '1'
    INNER JOIN T_GENM_CAMPANA_ENCUESTA cem ON tma.idTablaMaestra = cem.idParametroTabla AND cem.idEstado = '1'
    WHERE   idControlEncuesta = piIdControlEncuesta AND ret.idEstado = '1';
  END USP_SEL_PREGUNTA_TABLA;

END PKG_SISCEUSI_ENCUESTA;

/
