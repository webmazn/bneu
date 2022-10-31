--------------------------------------------------------
-- Archivo creado  - lunes-agosto-29-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_ENCUESTA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_ENCUESTA" AS 

  PROCEDURE USP_PRC_GUARDAR_RESP_ENC_PLAN(
    piIdControlEncuesta NUMBER,
    piIdCampanaEncuesta NUMBER,
    piIdRespuestaEncuesta NUMBER,
    piRespuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_GUARDAR_RESP_ENC_TAB(
    piIdControlEncuesta NUMBER,
    piFilaTabla NUMBER,
    piIdEncabezadoSecundario NUMBER,
    piIdParametro NUMBER,
    piRespuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_PREGUNTA_PLANTA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_PREGUNTA_TABLA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_RESP_ENC_PLANTA(
    piIdControlEncuesta NUMBER,
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_RESP_ENC_TABLA(
    piIdControlEncuesta NUMBER,
    piIdEncabezadoSecundario NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_FASE_CONTROL_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piIdFase NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_ENCUESTA_COMENTARIO(
    piIdControlEncuesta NUMBER,
    piIdCampanaEncuesta NUMBER,
    piComentario VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_ENCUESTA_COMENTARIO(
    piIdControlEncuesta NUMBER,
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LISTA_ENCUESTA_COMEN(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_ENCUESTA;

/
