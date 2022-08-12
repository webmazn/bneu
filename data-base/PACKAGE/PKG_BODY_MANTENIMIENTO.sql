--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_MANTENIMIENTO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_MANTENIMIENTO" AS

  PROCEDURE USP_SEL_GET_USUARIO(
    pi_idUsuario IN NUMBER,
    po_ref OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN po_Ref FOR
    SELECT *
    FROM T_GENM_USUARIO	 
    WHERE   idUsuario = pi_idUsuario;
  END USP_SEL_GET_USUARIO;
  
  
  PROCEDURE USP_SEL_GET_ROL(
    pi_idRol NUMBER,
    po_ref OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN po_ref FOR
    SELECT  *
    FROM  T_MAE_ROL
    WHERE idRol = pi_idRol; 
  END USP_SEL_GET_ROL;

END PKG_SISCEUSI_MANTENIMIENTO;

/
