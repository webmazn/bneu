--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_DISTRITO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_DISTRITO" AS

  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_MAE_DISTRITO
    WHERE idEstado = '1';
  END USP_SEL_LISTA;

END PKG_SISCEUSI_DISTRITO;

/