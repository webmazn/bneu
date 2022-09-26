--------------------------------------------------------
-- Archivo creado  - sábado-septiembre-24-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_INDICADOR
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_INDICADOR" AS 

  PROCEDURE USP_SEL_BUSQ_GEN_INDICADOR(
    piIdCampana NUMBER,
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_PRC_GUARDAR(
    piIdIndicador NUMBER,
    piNombreIndicador VARCHAR2,
    piIdCampana NUMBER,
    piIdCampanaEncuesta NUMBER,
    piIdEncabezadoPrincipal NUMBER,
    piIdEncabezadoSecundario NUMBER,
    piIdMetodoCalculo NUMBER,
    piIdTipoControl NUMBER,
    --piIdEstado NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_OBJECT(
    piIdIndicador NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdIndicador NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_LISTA_INDICADOR(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_INDICADOR_ENC_SECUN(
    piIdCampana NUMBER,
    piIdEncabezadoSecundario NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
END PKG_SISCEUSI_INDICADOR;

/
