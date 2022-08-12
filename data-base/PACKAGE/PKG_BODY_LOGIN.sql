--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_LOGIN
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_LOGIN" AS

  PROCEDURE USP_SEL_USUARIO_CORREO(
    pi_correo  IN VARCHAR2,
    po_ref  OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN po_ref FOR
      SELECT
      *
      FROM T_GENM_USUARIO
      WHERE 
      LOWER(TRANSLATE(correoElectronico,'¡…Õ”⁄·ÈÌÛ˙','AEIOUaeiou')) = LOWER(TRANSLATE(pi_correo,'¡…Õ”⁄·ÈÌÛ˙','AEIOUaeiou'))
      AND idEstado = '1';
  END USP_SEL_USUARIO_CORREO;

END PKG_SISCEUSI_LOGIN;

/
