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

END PKG_SISCEUSI_REPORTE;

/
