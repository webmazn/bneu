--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_TABLA_MAESTRA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_TABLA_MAESTRA" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piSubtitulo VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piNombres VARCHAR2,
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
    piSubtitulo VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piNombres VARCHAR2,
    piIdEstado VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQ_GEN_ENC_PRINC(
    piIdTablaMaestra NUMBER,
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQ_GEN_ENC_SECUN(
    piIdTablaMaestra NUMBER,
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  );

  PROCEDURE USP_PRC_GUARDAR_TABLA_MAESTRA(
    piIdTablaMaestra NUMBER,
    piSubtitulo VARCHAR2,
    piDescripcionIconoAyuda VARCHAR2,
    piPreguntaInicial VARCHAR2,
    piPreguntaCierre VARCHAR2,
    piIdEstiloTabla NUMBER,
    piCantidadFilas NUMBER,
    piAgregarFilas VARCHAR2,
    piIdEstado NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poIdTablaMaestra OUT NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_GUARDAR_ENC_PRINCIPAL(
    piIdEncabezadoPrincipal NUMBER,
    piIdTablaMaestra NUMBER,
    piTituloEncabezado VARCHAR2,
    piAbreviacion VARCHAR2,
    piUsarAbreviado VARCHAR2,
    piPosicion NUMBER,
    piDescripcionIconoAyuda VARCHAR2,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_GUARDAR_ENC_SECUNDARIO(
    piIdEncabezadoSecundario NUMBER,
    piIdEncabezadoPrincipal NUMBER,
    piTituloEncabezado VARCHAR2,
    piAbreviacion VARCHAR2,
    piUsarAbreviado VARCHAR2,
    piPosicion NUMBER,
    piDescripcionIconoAyuda VARCHAR2,
    piIdOrientacion NUMBER,
    piIdTipoControl NUMBER,
    piIdTipoDato NUMBER,
    piIdParametro NUMBER,   
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LIST_PRINCIPAL(
    piIdTablaMaestra NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_OBJECT(
    piIdTablaMaestra NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_OBJECT_PRINCIPAL(
    piIdEncabezadoPrincipal NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_OBJECT_SECUNDARIO(
    piIdEncabezadoSecundario NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdTablaMaestra NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_DESHABILITAR_PRINC(
    piIdEncabezadoPrincipal NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_DESHABILITAR_SECUN(
    piIdEncabezadoSecundario NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_TABLA_MAESTRA;

/
