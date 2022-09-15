--------------------------------------------------------
-- Archivo creado  - martes-septiembre-13-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_PAGINA_HOME
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_PAGINA_HOME" AS 

  PROCEDURE USP_PRC_BANNER(
    piIdBanner NUMBER,
    piTituloBanner VARCHAR2,
    piDescripcionBanner VARCHAR2,
    piDescripcionFija VARCHAR2,
    piTituloBoton VARCHAR2,
    piEnlaceBoton VARCHAR2,
    piNombreArchivoBanner VARCHAR2,
    piNombreArchivoGeneradoBanner VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LIST_BANNER(
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BANNER(
    piIdBanner NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_DESHABILITAR_BANNER(
    piIdBanner NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_PUBLICACION(
    piIdPublicacion NUMBER,
    piTituloPublicacion VARCHAR2,
    piDescripcionPublicacion VARCHAR2,
    piNombreArchivoPublicacion VARCHAR2,
    piNombreArchivoGeneradoPubli VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LIST_PUBLICACION(
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_PUBLICACION(
    piIdPublicacion NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_DESHABILITAR_PUBLI(
    piIdPublicacion NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_ENLACE(
    piIdEnlace NUMBER,
    piTituloEnlace VARCHAR2,
    piDescripcionEnlace VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LIST_ENLACE(
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_ENLACE(
    piIdEnlace NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_DESHABILITAR_ENLACE(
    piIdEnlace NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_PRC_LOGO_RED_SOCIAL(
    piIdLogoRedSocial NUMBER,
    piNombreArchivoLogoWeb VARCHAR2,
    piNombreArchivoGeneradoLogoWeb VARCHAR2,
    piNombreArchivoLogoDgee VARCHAR2,
    piNombreArchivoGeneradoLogoD VARCHAR2,
    piEnlaceFacebook VARCHAR2,
    piEnlaceTwiter VARCHAR2,
    piEnlaceInstangram VARCHAR2,
    piEnlaceYoutube VARCHAR2,
    piEnlaceWhatsApp VARCHAR2,
    piEnlaceLinkedin VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LOGO_RED_SOCIAL(
    --piIdLogoRedSocial NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_ALL_BANNER(
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_ALL_PUBLICACION(
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LIST_ALL_ENLACE(
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_PAGINA_HOME;

/
