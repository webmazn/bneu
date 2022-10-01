--------------------------------------------------------
-- Archivo creado  - sábado-septiembre-24-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_INDICADOR
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_INDICADOR" AS

  PROCEDURE USP_SEL_BUSQ_GEN_INDICADOR(
    piIdCampana NUMBER,
    piRegistros NUMBER,
    piPagina NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
    vTotalRegistros INTEGER;
    vTotalPaginas INTEGER;
    vPaginaActual INTEGER := piPagina;
    vPaginaInicial INTEGER := 0;
    vQueryCount VARCHAR2(10000) := '';
    vQuerySelect VARCHAR2(10000) := '';
  BEGIN
    vQueryCount := 'SELECT  COUNT(1)
                    FROM T_GENM_INDICADOR ind
                    LEFT JOIN T_GEND_ENCABEZADO_SECUNDARIO esa ON ind.idEncSecundarioAgrupacion = esa.idEncabezadoSecundario AND esa.idEstado = ''1''
                    LEFT JOIN T_GEND_ENCABEZADO_SECUNDARIO esc ON ind.idEncSecundarioCalculo = esc.idEncabezadoSecundario AND esc.idEstado = ''1''
                    INNER JOIN T_MAE_METODO_CALCULO met ON ind.idMetodoCalculo = met.idMetodoCalculo
                    INNER JOIN T_GENM_CAMPANA_ENCUESTA cae ON ind.idCampanaEncuesta = cae.idCampanaEncuesta AND cae.idEstado = ''1''
                    LEFT JOIN T_GENM_TABLA_MAESTRA tma ON cae.idParametroTabla = tma.idTablaMaestra AND tma.idEstado = ''1''
                    WHERE 
                    ind.idEstado = ''1'' AND ind.idCampana = '|| piIdCampana;
    EXECUTE IMMEDIATE vQueryCount INTO vTotalRegistros;

    vTotalPaginas := CEIL(TO_NUMBER(vTotalRegistros) / TO_NUMBER(piRegistros));
    IF vPaginaActual = 0 THEN
      vPaginaActual := 1;
    END IF;
    IF vPaginaActual > vTotalPaginas THEN
      vPaginaActual := vTotalPaginas;
    END IF;
    
    vPaginaInicial := vPaginaActual - 1;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  ind.idIndicador,
                                ind.nombreIndicador,
                                ind.idCampanaEncuesta,
                                cae.pregunta,
                                esa.idEncabezadoSecundario idAgrupacion,
                                esa.tituloEncabezado tituloAgrupacion,
                                esc.idEncabezadoSecundario idCalculo,
                                esc.tituloEncabezado tituloCalculo,
                                met.idMetodoCalculo,
                                met.metodoCalculo,
                                tma.idTablaMaestra,
                                tma.subtitulo,
                                ROW_NUMBER() OVER (ORDER BY ind.idIndicador ASC) AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_INDICADOR ind
                        LEFT JOIN T_GEND_ENCABEZADO_SECUNDARIO esa ON ind.idEncSecundarioAgrupacion = esa.idEncabezadoSecundario AND esa.idEstado = ''1''
                        LEFT JOIN T_GEND_ENCABEZADO_SECUNDARIO esc ON ind.idEncSecundarioCalculo = esc.idEncabezadoSecundario AND esc.idEstado = ''1''
                        INNER JOIN T_MAE_METODO_CALCULO met ON ind.idMetodoCalculo = met.idMetodoCalculo
                        INNER JOIN T_GENM_CAMPANA_ENCUESTA cae ON ind.idCampanaEncuesta = cae.idCampanaEncuesta AND cae.idEstado = ''1''
                        LEFT JOIN T_GENM_TABLA_MAESTRA tma ON cae.idParametroTabla = tma.idTablaMaestra AND tma.idEstado = ''1''
                        WHERE 
                        ind.idEstado = ''1'' AND ind.idCampana = '|| piIdCampana ||'
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQ_GEN_INDICADOR;

  PROCEDURE USP_PRC_GUARDAR(
    piIdIndicador NUMBER,
    piNombreIndicador VARCHAR2,
    piIdCampana NUMBER,
    piIdCampanaEncuesta NUMBER,
    piIdEncSecundarioAgrupacion NUMBER,
    piIdEncSecundarioCalculo NUMBER,
    piIdMetodoCalculo NUMBER,
    piIdTipoControl NUMBER,
    --piIdEstado NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
        vId NUMBER;
  BEGIN
    IF piIdIndicador = -1 THEN
      vId := SQ_GENM_INDICADOR.NEXTVAL();
      INSERT INTO T_GENM_INDICADOR
      (idIndicador, nombreIndicador, idCampana, idCampanaEncuesta, idEncSecundarioAgrupacion, idEncSecundarioCalculo, idMetodoCalculo, idTipoControl, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piNombreIndicador, piIdCampana, piIdCampanaEncuesta, piIdEncSecundarioAgrupacion, piIdEncSecundarioCalculo, piIdMetodoCalculo, piIdTipoControl, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      UPDATE T_GENM_INDICADOR SET
      nombreIndicador = piNombreIndicador,
      idCampana = piIdCampana,
      idCampanaEncuesta = piIdCampanaEncuesta,
      idEncSecundarioAgrupacion = piIdEncSecundarioAgrupacion,
      idEncSecundarioCalculo = piIdEncSecundarioCalculo,
      idMetodoCalculo = piIdMetodoCalculo,
      idTipoControl = piIdTipoControl,
      --idEstado = piIdEstado,
      idUsuarioModificacion = piIdUsuarioCreacion,
      fechaModificacion = SYSDATE,
      ipModificacion = piIpCreacion
      WHERE idIndicador = piIdIndicador;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR;

  PROCEDURE USP_SEL_OBJECT(
    piIdIndicador NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_INDICADOR
    WHERE   idIndicador = piIdIndicador;
  END USP_SEL_OBJECT;

  PROCEDURE USP_UPD_DESHABILITAR(
    piIdIndicador NUMBER,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GENM_INDICADOR SET
    idEstado = '0'
    WHERE idIndicador = piIdIndicador;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR;
  
  PROCEDURE USP_SEL_LISTA_INDICADOR(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_INDICADOR
    WHERE   idCampana = piIdCampana AND idEstado = '1';
  END USP_SEL_LISTA_INDICADOR;
  
  PROCEDURE USP_SEL_INDICADOR_ENC_SECUN(
    piIdCampana NUMBER,
    piIdEncabezadoSecundario NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT
    cem.idCampana,
    cem.idEmpresaIndustria,
    cen.idControlEncuesta,
    cen.idSupervisor,
    cen.idPlantaEmpresa,
    pem.iddepartamento,
    pem.idprovincia,
    pem.iddistrito,
    ret.idParametro,
    par.parametro,
    ret.filaTabla,
    nvl(ret.respuesta, '0') respuesta
    FROM T_GEND_RESP_ENCUESTA_TABLA ret
    INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON ret.idControlEncuesta = cen.idControlEncuesta AND cen.idEstado = '1'
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = '1'
    INNER JOIN T_GENM_PLANTA_EMPRESA pem ON cen.idplantaempresa = pem.idplantaempresa
    LEFT JOIN T_GENM_PARAMETRO par ON ret.idParametro = par.idParametro AND par.idEstado = '1'
    WHERE
    ret.idEncabezadoSecundario = piIdEncabezadoSecundario AND cem.idCampana = piIdCampana AND cen.idTipoEncuesta = 2; --cAMBIAR A TIPOENCUESTA 2
  END USP_SEL_INDICADOR_ENC_SECUN;

END PKG_SISCEUSI_INDICADOR;

/
