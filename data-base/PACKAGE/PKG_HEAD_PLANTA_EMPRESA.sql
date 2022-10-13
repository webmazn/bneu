--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_PLANTA_EMPRESA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_PLANTA_EMPRESA" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piIdEmpresa NUMBER,
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piIdEmpresa NUMBER,
    piDireccion VARCHAR2,
    piIdCiuu NUMBER,
    piTelefono VARCHAR2,
    piIdDepartamento VARCHAR2,
    piIdProvincia VARCHAR2,
    piIdDistrito VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EXPORTAR_GENERAL(
    piIdEmpresa NUMBER,
    piBuscar VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EXPORTAR_AVANZADO(
    piIdEmpresa NUMBER,
    piDireccion VARCHAR2,
    piIdCiuu NUMBER,
    piTelefono VARCHAR2,
    piIdDepartamento VARCHAR2,
    piIdProvincia VARCHAR2,
    piIdDistrito VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_PRC_GUARDAR(
    piIdPlantaEmpresa NUMBER,
    piIdEmpresaIndustria NUMBER,
    piIdGiro NUMBER,
    piIdCiuu NUMBER,
    piIdDepartamento VARCHAR2,
    piIdProvincia VARCHAR2,
    piIdDistrito VARCHAR2,
    piIdZona NUMBER,
    piDenominacion VARCHAR2,
    piDireccion VARCHAR2,
    piTelefono VARCHAR2,    
    piLatitud VARCHAR2,
    piLongitud VARCHAR2,
    piIdEmpresaGas NUMBER,
    piNumeroSuministroGas VARCHAR2,
    piIdEmpresaLuz NUMBER,
    piNumeroSuministroAlumbrado VARCHAR2,
    piNombreArchivo VARCHAR2,
    piNombreArchivoGenerado VARCHAR2,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdPlantaEmpresa NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_OBJECT(
    piIdPlantaEmpresa NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_VERIFICADOR_DATOS(
    piDenominacion VARCHAR2,
    piDireccion VARCHAR2,   
    piLatitud VARCHAR2,
    piLongitud VARCHAR2,
    piNumeroSuministroGas VARCHAR2,
    piNumeroSuministroAlumbrado VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_PLANTA_EMPRESA;

/
