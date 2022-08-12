--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_INTERNO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_INTERNO" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piIdUsuario NUMBER,
    piIdRol NUMBER,
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_INTERNO;

/
