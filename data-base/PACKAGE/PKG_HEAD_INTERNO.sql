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
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piIdUsuario NUMBER,
    piIdRol NUMBER,
    piDenominacion VARCHAR2,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piIdDepartamento VARCHAR2,
    piIdProvincia VARCHAR2,
    piIdDistrito VARCHAR2,
    piIdZona NUMBER,
    piIdSubSector NUMBER,
    piIdCiuu NUMBER,
    piIdSupervisor NUMBER,
    piIdTipoEncuesta NUMBER,
    piIdEtapa NUMBER,
    piFechaInicio DATE,
    piFechaFin DATE,    
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_INTERNO;

/
