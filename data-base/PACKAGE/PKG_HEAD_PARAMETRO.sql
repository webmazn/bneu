--------------------------------------------------------
-- Archivo creado  - domingo-agosto-14-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_PARAMETRO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_PARAMETRO" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piParentParametro VARCHAR2,
    piParametro VARCHAR2,    
    piIdTipoParametro NUMBER,
    piFechaInicio DATE,
    piFechaFin DATE,
    piIdEstado VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EXPORTAR_GENERAL(
    piBuscar VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EXPORTAR_AVANZADO(
    piParentParametro VARCHAR2,
    piParametro VARCHAR2,    
    piIdTipoParametro NUMBER,
    piFechaInicio DATE,
    piFechaFin DATE,
    piIdEstado VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );

  PROCEDURE USP_PRC_GUARDAR(
    piIdParametro NUMBER,
    piParametro VARCHAR2,
    piIdParentParametro NUMBER,
    piIdTipoParametro NUMBER,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_OBJECT(
    piIdParametro NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdParametro NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_PARAMETRO(
    piIdParametro NUMBER,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_PARAMETRO;

/
