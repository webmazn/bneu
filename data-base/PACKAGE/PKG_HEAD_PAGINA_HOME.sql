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

END PKG_SISCEUSI_PAGINA_HOME;

/
