--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_DEPARTAMENTO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_DEPARTAMENTO" AS

  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_MAE_DEPARTAMENTO
    WHERE idEstado = '1'
    ORDER BY departamento ASC;
  END USP_SEL_LISTA;

END PKG_SISCEUSI_DEPARTAMENTO;

/
