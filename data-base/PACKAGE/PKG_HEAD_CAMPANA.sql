--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_CAMPANA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_CAMPANA" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piDenominacion VARCHAR2,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
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
    piDenominacion VARCHAR2,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piIdEstado VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );

  PROCEDURE USP_PRC_GUARDAR_CAMPANA(
    piIdCampana NUMBER,
    piDenominacion VARCHAR2,
    piFechaInicioPiloto DATE,
    piFechaFinPiloto DATE,
    piFechaInicioEncuesta DATE,
    piFechaFinEncuesta DATE,
    piObservaciones VARCHAR2,
    piIdGiroPiloto NUMBER,
    piIdCiuuPiloto NUMBER,
    piIdGiroOficial NUMBER,
    piIdCiuuOficial NUMBER,
    piIdEtapaPiloto NUMBER,
    piIdEtapaOficial NUMBER,
    piIdSubSector NUMBER,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poIdCampana OUT NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_CAMPANA_EMP_ESTADO(
    piIdCampana NUMBER
  );
  
  PROCEDURE USP_PRC_GUARDAR_CAMPANA_EMP(
    piIdCampana NUMBER,
    piIdEmpresaIndustria NUMBER,
    piParticiparEnPiloto VARCHAR2,
    piParticiparEnOficial VARCHAR2,
    piIdSupervisorPiloto NUMBER,
    piIdSupervisorOficial NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poIdCampanaEmpresa OUT NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LIST_PLANTA_EMPRESA(
    piIdEmpresaIndustria NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_PRC_GUARDAR_CONTROL_ENC(
    piIdCampanaEmpresa NUMBER,
    piIdPlantaEmpresa NUMBER,
    piIdTipoEncuesta NUMBER,
    piIdSupervisor NUMBER,
    piIdEtapa NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_CAMPANA_ENC_ESTADO(
    piIdCampana NUMBER
  );
  
  PROCEDURE USP_PRC_GUARDAR_CAMPANA_ENC(
    piIdCampanaEncuesta NUMBER,
    piIdCampana NUMBER,    
    piPregunta VARCHAR2,
    piNumeroOrdenPregunta NUMBER,
    piTituloSeccion VARCHAR2,
    piTitulo VARCHAR2,
    piSeparador VARCHAR2,
    piIdTipoControl NUMBER,
    piIdParametroTabla NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poIdCampanaEncuesta OUT NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_RESPUESTA_ENC_ESTADO(
    piIdCampanaEncuesta NUMBER
  );
  
  PROCEDURE USP_PRC_GUARDAR_RESP_ENC(
    piIdRespuestaEncuesta NUMBER, 
    piIdCampanaEncuesta NUMBER,       
    piRespuesta VARCHAR2,
    piNumeroOrdenRespuesta NUMBER,
    piIdValorRespuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_CAMPANA(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_CAMPANA_EMP(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_CAMPANA_ENC(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_RESPUESTA_ENC(
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_CAMPANA;

/
