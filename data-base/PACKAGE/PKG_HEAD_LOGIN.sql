--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_LOGIN" AS 

  PROCEDURE USP_SEL_USUARIO_CORREO(
    pi_correo  IN VARCHAR2,
    po_ref  OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_LOGIN;

/
