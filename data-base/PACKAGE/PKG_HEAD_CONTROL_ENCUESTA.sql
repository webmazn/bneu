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
    piIdPlantaEmpresa NUMBER,
    piIdEmpresaGas NUMBER,
    piNumeroSuministroGas VARCHAR2,
    piIdEmpresaLuz NUMBER,
    piNumeroSuministroAlumbrado VARCHAR2,
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
  
  PROCEDURE USP_SEL_RESPUESTA_ENCUESTA(
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_ENC_SECUNDARIO(
    piIdParametroTabla NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_PARAMETRO(
    piIdParametro NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_OBSERVACION_ENCUESTA(
    piIdControlEncuesta NUMBER,
    piIdFase NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
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
  );

END PKG_SISCEUSI_CONTROL_ENCUESTA;

/
