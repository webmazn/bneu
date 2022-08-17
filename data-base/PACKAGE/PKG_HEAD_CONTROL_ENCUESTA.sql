--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_CONTROL_ENCUESTA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_CONTROL_ENCUESTA" AS 

  PROCEDURE USP_SEL_OBJECT(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_PART_TRAT_DATOS(
    piIdControlEncuesta NUMBER,
    piIdCampana NUMBER,
    piAceptaLLenarEncuesta VARCHAR2,
    piAceptaTratamientoDatos VARCHAR2,
    piIdUsuarioResponde NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_FIRMAR_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piAceptaFirmarEncuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_FORM_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piFechaHoraLlenado DATE,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_PREGUNTA_ENCUESTA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_CONTROL_ENCUESTA;

/
