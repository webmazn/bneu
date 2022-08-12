--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_EXTERNO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_EXTERNO" AS

  PROCEDURE USP_REG_INTENC_PARTICIPAR(
    pi_ruc IN VARCHAR2,
    pi_nombreEmpresa IN VARCHAR2,
    pi_correoElectronico IN VARCHAR2,
    pi_representanteLegal IN VARCHAR2,
    pi_dni IN VARCHAR2,
    pi_telefono IN VARCHAR2,
    pi_ip IN VARCHAR2,    
    po_rowaffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    vId := SQ_GENM_INTENCION_PARTICIPAR.NEXTVAL();
    
    INSERT INTO t_genm_intencion_participar (idIntencionParticipar, ruc, nombreEmpresa, correoElectronico, representanteLegal, dni, telefono, ipCreacion)
    VALUES (vId, pi_ruc, pi_nombreEmpresa, pi_correoElectronico, pi_representanteLegal,pi_dni, pi_telefono, pi_ip);
    
    po_rowaffected := SQL%ROWCOUNT;
  END USP_REG_INTENC_PARTICIPAR;

END PKG_SISCEUSI_EXTERNO;

/
