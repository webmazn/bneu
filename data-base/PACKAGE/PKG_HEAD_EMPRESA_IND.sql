--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_EMPRESA_IND
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_EMPRESA_IND" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,    
    piRepresentanteLegal VARCHAR2,
    piCorreo VARCHAR2,
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
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piRepresentanteLegal VARCHAR2,
    piCorreo VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piIdEstado VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_PRC_GUARDAR(
    piIdEmpresaIndustria NUMBER,
    piNombreEmpresa VARCHAR2,
    piNombreComercial VARCHAR2,
    piRuc VARCHAR2,
    piIdGiro NUMBER,
    piIdGrupoEmpresa NUMBER,
    piIdCiuu NUMBER,
    piDireccionFiscal VARCHAR2,
    piCorreo VARCHAR2,
    piRepresentanteLegal VARCHAR2,
    piDni VARCHAR2,     
    piIdEstado VARCHAR2,
    piObservacionUno VARCHAR2,
    piObservacionDos VARCHAR2,
    piObservacionTres VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdEmpresa NUMBER,
    poRowAffected OUT NUMBER
  );

  PROCEDURE USP_SEL_OBJECT(
    piIdEmpresa NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_POR_RUC(
    piRuc VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_EMPRESA_IND;

/
