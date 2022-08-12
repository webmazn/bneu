--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_SISCEUSI_EXTERNO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SISCEUSI"."PKG_SISCEUSI_EXTERNO" AS 

  PROCEDURE USP_REG_INTENC_PARTICIPAR(
    pi_ruc IN VARCHAR2,
    pi_nombreEmpresa IN VARCHAR2,
    pi_correoElectronico IN VARCHAR2,
    pi_representanteLegal IN VARCHAR2,
    pi_dni IN VARCHAR2,
    pi_telefono IN VARCHAR2,
    pi_ip IN VARCHAR2,    
    po_rowaffected OUT NUMBER
  );

END PKG_SISCEUSI_EXTERNO;

/
