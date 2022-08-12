--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_ROL
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_ROL" AS 

  PROCEDURE USP_SEL_OBJECT(
    piIdRol NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_ROL;

/
