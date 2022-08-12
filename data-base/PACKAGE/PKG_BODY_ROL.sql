--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_ROL
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_ROL" AS

  PROCEDURE USP_SEL_OBJECT(
    piIdRol NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_MAE_ROL
    WHERE idRol = piIdRol;
  END USP_SEL_OBJECT;

  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_MAE_ROL
    WHERE idEstado = '1'; 
  END USP_SEL_LISTA;

END PKG_SISCEUSI_ROL;

/
