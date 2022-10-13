--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_USUARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_USUARIO" AS 

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piIdPlantaEmpresa NUMBER,
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piIdPlantaEmpresa NUMBER,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piIdRol NUMBER,
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
  
  PROCEDURE USP_PRC_GUARDAR(
    piIdUsuario NUMBER,
    piIdEmpresaIndustria NUMBER,
    piIdPlantaEmpresa NUMBER,
    piIdRol NUMBER,
    piDni VARCHAR2,
    piTelefono VARCHAR2,
    piNombres VARCHAR2,
    piCorreo VARCHAR2,
    piPassword VARCHAR2,
    piVisualizar VARCHAR2,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    piEditarPassword BOOLEAN,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdUsuario NUMBER,
    poRowAffected OUT NUMBER
  );
  
  PROCEDURE USP_SEL_OBJECT(
    piIdUsuario NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_LISTA_ROL(
    piIdRol NUMBER,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_POR_CORREO(
    piIdUsuario NUMBER,
    piCorreo VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_POR_DNI(
    piIdUsuario NUMBER,
    piDni VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EXPORTAR_GENERAL(
    piIdPlantaEmpresa NUMBER,
    piBuscar VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EXPORTAR_AVANZADO(
    piIdPlantaEmpresa NUMBER,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piIdRol NUMBER,
    piFechaInicio DATE,
    piFechaFin DATE,
    piNombres VARCHAR2,
    piIdEstado VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_REVISOR_VISUALIZAR(
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_EMPRESA_USUARIO(
    piIdUsuario NUMBER,
    piCorreoElectronico VARCHAR2,
    poRef OUT SYS_REFCURSOR
  );
  
  PROCEDURE USP_SEL_ADMINISTRADOR(
    poRef OUT SYS_REFCURSOR
  );

END PKG_SISCEUSI_USUARIO;

/
