--------------------------------------------------------
-- Archivo creado  - miércoles-septiembre-21-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_REPORTE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_REPORTE" AS 

  PROCEDURE USP_SEL_LIST_CONTROL_ENC(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_PREGUNTA_ENCUESTA(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_RESP_ENC_PLANTA(
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_RESP_ENC_TABLA(
    piIdCampana NUMBER,
    piIdEncabezadoSecundario NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_EMP_PLA_REPORT(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_CAMP_TAB_MAESTRA (
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_REPORTE;

/
