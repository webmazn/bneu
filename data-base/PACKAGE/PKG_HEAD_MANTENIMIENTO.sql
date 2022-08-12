--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_MANTENIMIENTO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_MANTENIMIENTO" AS 

  PROCEDURE USP_SEL_GET_USUARIO(
    pi_idUsuario IN NUMBER,
    po_ref OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_GET_ROL(
    pi_idRol NUMBER,
    po_ref OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_MANTENIMIENTO;

/
