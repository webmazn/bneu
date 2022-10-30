--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_CAMPANA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_CAMPANA" AS

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
    vTotalRegistros INTEGER;
    vTotalPaginas INTEGER;
    vPaginaActual INTEGER := piPagina;
    vPaginaInicial INTEGER := 0;
    vQueryCount VARCHAR2(10000) := '';
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vQueryCount := 'SELECT  COUNT(1)
                    FROM T_GENM_CAMPANA cam
                    WHERE (
                    LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                    )';
    EXECUTE IMMEDIATE vQueryCount INTO vTotalRegistros;

    vTotalPaginas := CEIL(TO_NUMBER(vTotalRegistros) / TO_NUMBER(piRegistros));
    IF vPaginaActual = 0 THEN
      vPaginaActual := 1;
    END IF;
    IF vPaginaActual > vTotalPaginas THEN
      vPaginaActual := vTotalPaginas;
    END IF;
    
    vPaginaInicial := vPaginaActual - 1;
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  cam.idCampana,
                                cam.denominacion,
                                cam.fechaCreacion,
                                cam.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_CAMPANA cam
                        WHERE (
                        LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_BUSQUEDA_GENERAL;
  
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
  ) AS
    vTotalRegistros INTEGER;
    vTotalPaginas INTEGER;
    vPaginaActual INTEGER := piPagina;
    vPaginaInicial INTEGER := 0;
    vQueryCount VARCHAR2(10000) := '';
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vQueryCount := 'SELECT   COUNT(DISTINCT cam.idCampana)
                    FROM T_GENM_CAMPANA cam
                    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cam.idCampana = cem.idCampana AND cem.idestado = ''1''
                    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                    WHERE (
                    '||
                    case
                        when piDenominacion is null then ''
                        else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piRuc is null then ''
                        else ' emp.ruc = '''|| piRuc ||''' AND '
                    end    
                    ||'        
                    '||
                    case
                        when piNombreEmpresa is null then ''
                        else ' LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                        when piFechaFin is null then ' TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                        else ' (TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                    end
                    ||'                
                    '||
                    case
                        when piIdEstado = '-1' then ''
                        else ' cam.idEstado = '''|| piIdEstado ||''' AND '
                    end
                    ||'
                    1 = 1)';
    EXECUTE IMMEDIATE vQueryCount INTO vTotalRegistros;

    vTotalPaginas := CEIL(TO_NUMBER(vTotalRegistros) / TO_NUMBER(piRegistros));
    IF vPaginaActual = 0 THEN
      vPaginaActual := 1;
    END IF;
    IF vPaginaActual > vTotalPaginas THEN
      vPaginaActual := vTotalPaginas;
    END IF;

    vPaginaInicial := vPaginaActual - 1;
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  cam.idCampana,
                                cam.denominacion,
                                cam.fechaCreacion,
                                cam.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_CAMPANA cam
                        INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cam.idCampana = cem.idCampana AND cem.idestado = ''1''
                        INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                        WHERE (
                        '||
                        case
                            when piDenominacion is null then ''
                            else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piRuc is null then ''
                            else ' emp.ruc = '''|| piRuc ||''' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piNombreEmpresa is null then ''
                            else ' LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'                
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' cam.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        1 = 1)
                        GROUP BY cam.idCampana, cam.denominacion, cam.fechaCreacion, cam.idEstado
                    )    
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_AVANZADO;
  
  PROCEDURE USP_SEL_EXPORTAR_GENERAL(
    piBuscar VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  cam.idCampana,
                                cam.denominacion,
                                cam.fechaInicioPiloto,
                                cam.fechaFinPiloto,
                                etp.etapa etapaPiloto,
                                cam.fechaInicioEncuesta,
                                cam.fechaFinEncuesta,
                                eto.etapa etapaOficial,
                                sub.parametro subsector,
                                cam.observaciones,
                                cam.fechaCreacion,
                                cam.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_CAMPANA cam
                        left join T_MAE_ETAPA etp ON cam.idEtapaPiloto = etp.idEtapa
                        left join T_MAE_ETAPA eto ON cam.idEtapaOficial = eto.idEtapa
                        left join T_GENM_PARAMETRO sub ON cam.idSubSector = sub.idParametro
                        WHERE (
                        LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_GENERAL;
  
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
  ) AS
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  cam.idCampana,
                                cam.denominacion,
                                cam.fechaInicioPiloto,
                                cam.fechaFinPiloto,
                                etp.etapa etapaPiloto,
                                cam.fechaInicioEncuesta,
                                cam.fechaFinEncuesta,
                                eto.etapa etapaOficial,
                                sub.parametro subsector,
                                cam.observaciones,
                                cam.fechaCreacion,
                                cam.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_CAMPANA cam
                        INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cam.idCampana = cem.idCampana AND cem.idestado = ''1''
                        INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                        left join T_MAE_ETAPA etp ON cam.idEtapaPiloto = etp.idEtapa
                        left join T_MAE_ETAPA eto ON cam.idEtapaOficial = eto.idEtapa
                        left join T_GENM_PARAMETRO sub ON cam.idSubSector = sub.idParametro
                        WHERE (
                        '||
                        case
                            when piDenominacion is null then ''
                            else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piRuc is null then ''
                            else ' emp.ruc = '''|| piRuc ||''' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piNombreEmpresa is null then ''
                            else ' LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'                
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' cam.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        1 = 1)
                        GROUP BY cam.idCampana, cam.denominacion, cam.fechaInicioPiloto, cam.fechaFinPiloto, etp.etapa, cam.fechaInicioEncuesta, cam.fechaFinEncuesta, eto.etapa, sub.parametro, cam.observaciones, cam.fechaCreacion, cam.idEstado
                    )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_AVANZADO;

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
  ) AS
  BEGIN
    IF piIdCampana = -1 THEN
      poIdCampana := SQ_GENM_CAMPANA.NEXTVAL();
      INSERT INTO T_GENM_CAMPANA
      (idCampana, denominacion, fechaInicioPiloto, fechaFinPiloto, fechaInicioEncuesta, fechaFinEncuesta, observaciones, idGiroPiloto, idCiuuPiloto, idGiroOficial, idCiuuOficial, idEtapaPiloto, idEtapaOficial, idSubSector, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (poIdCampana, piDenominacion, piFechaInicioPiloto, piFechaFinPiloto, piFechaInicioEncuesta, piFechaFinEncuesta, piObservaciones, piIdGiroPiloto, piIdCiuuPiloto, piIdGiroOficial, piIdCiuuOficial, piIdEtapaPiloto, piIdEtapaOficial, piIdSubSector, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      poIdCampana := piIdCampana;
      UPDATE T_GENM_CAMPANA c SET
      c.denominacion = piDenominacion,
      c.fechaInicioPiloto = piFechaInicioPiloto,
      c.fechaFinPiloto = piFechaFinPiloto,
      c.fechaInicioEncuesta = piFechaInicioEncuesta,
      c.fechaFinEncuesta = piFechaFinEncuesta,
      c.observaciones = piObservaciones,
      c.idGiroPiloto = piIdGiroPiloto,
      c.idCiuuPiloto = piIdCiuuPiloto,
      c.idGiroOficial = piIdGiroOficial,
      c.idCiuuOficial = piIdCiuuOficial,
      c.idEtapaPiloto = piIdEtapaPiloto,
      c.idEtapaOficial = piIdEtapaOficial,
      c.idSubSector = piIdSubSector,
      c.idEstado = piIdEstado,
      c.idUsuarioModificacion = piIdUsuarioCreacion,
      c.fechaModificacion = SYSDATE,
      c.ipModificacion = piIpCreacion
      WHERE c.idCampana = piIdCampana;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_CAMPANA;
  
  PROCEDURE USP_UPD_CAMPANA_EMP_ESTADO(
    piIdCampana NUMBER
  )AS
  BEGIN
    UPDATE T_GEND_CAMPANA_EMPRESA SET
    idEstado = '0'
    WHERE idCampana = piIdCampana;
  
    UPDATE (
    SELECT  cc.idEstado as estado
    FROM    T_GEND_CONTROL_ENCUESTA cc
    INNER JOIN T_GEND_CAMPANA_EMPRESA ce ON cc.idCampanaEmpresa = ce.idCampanaEmpresa
    WHERE ce.idCampana = piIdCampana
    )
    SET estado = '0';
  END USP_UPD_CAMPANA_EMP_ESTADO;
  
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
  ) AS
    vId NUMBER;
  BEGIN
    SELECT
    (SELECT idCampanaEmpresa FROM T_GEND_CAMPANA_EMPRESA WHERE idCampana = piIdCampana AND idEmpresaIndustria = piIdEmpresaIndustria)
    INTO vId
    FROM DUAL;
    IF vId IS NULL THEN
        vId := SQ_GEND_CAMPANA_EMPRESA.NEXTVAL();
        poIdCampanaEmpresa := vId;
        INSERT INTO T_GEND_CAMPANA_EMPRESA 
        (idCampanaEmpresa, idCampana, idEmpresaIndustria, participarEnPiloto, participarEnOficial, idSupervisorPiloto, idSupervisorOficial, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
        VALUES
        (vId, piIdCampana, piIdEmpresaIndustria, piParticiparEnPiloto, piParticiparEnOficial, piIdSupervisorPiloto, piIdSupervisorOficial, '1', piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
        poIdCampanaEmpresa := vId;
        UPDATE T_GEND_CAMPANA_EMPRESA SET
        participarEnPiloto = piParticiparEnPiloto,
        participarEnOficial = piParticiparEnOficial,
        idSupervisorPiloto = piIdSupervisorPiloto,
        idSupervisorOficial = piIdSupervisorOficial,
        idEstado = '1',
        idUsuarioModificacion = piIdUsuarioCreacion,
        fechaModificacion = SYSDATE,
        ipModificacion = piIpCreacion
        WHERE idCampanaEmpresa = vId;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_CAMPANA_EMP;
  
  PROCEDURE USP_SEL_LIST_PLANTA_EMPRESA(
    piIdEmpresaIndustria NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_PLANTA_EMPRESA
    WHERE idEmpresaIndustria = piIdEmpresaIndustria AND idEstado = '1';
  END USP_SEL_LIST_PLANTA_EMPRESA;
  
  PROCEDURE USP_PRC_GUARDAR_CONTROL_ENC(
    piIdCampanaEmpresa NUMBER,
    piIdPlantaEmpresa NUMBER,
    piIdTipoEncuesta NUMBER,
    piIdSupervisor NUMBER,
    piIdEtapa NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
    vIdPlanta NUMBER;
  BEGIN
    SELECT
    (SELECT idControlEncuesta FROM T_GEND_CONTROL_ENCUESTA WHERE idCampanaEmpresa = piIdCampanaEmpresa AND idPlantaEmpresa = piIdPlantaEmpresa AND idTipoEncuesta = piIdTipoEncuesta)
    INTO vId
    FROM DUAL;
    IF vId IS NULL THEN
        vId := SQ_GEND_CONTROL_ENCUESTA.NEXTVAL();        
                
        INSERT INTO T_GEND_CONTROL_ENCUESTA
        (idControlEncuesta, idCampanaEmpresa, idPlantaEmpresa, idTipoEncuesta, idSupervisor, idEtapa, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
        VALUES
        (vId, piIdCampanaEmpresa, piIdPlantaEmpresa, piIdTipoEncuesta, piIdSupervisor, piIdEtapa, '1', piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
        UPDATE T_GEND_CONTROL_ENCUESTA SET
        idCampanaEmpresa = piIdCampanaEmpresa,
        idPlantaEmpresa = piIdPlantaEmpresa,
        idTipoEncuesta = piIdTipoEncuesta,
        idSupervisor = piIdSupervisor,
        idEtapa = piIdEtapa,
        idEstado = '1',
        idUsuarioModificacion = piIdUsuarioCreacion,
        fechaModificacion = SYSDATE,
        ipModificacion = piIpCreacion
        WHERE idControlEncuesta = vId;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_CONTROL_ENC;
  
  PROCEDURE USP_UPD_CAMPANA_ENC_ESTADO(
    piIdCampana NUMBER
  )AS
  BEGIN
    UPDATE T_GENM_CAMPANA_ENCUESTA SET
    idEstado = '0'
    WHERE idCampana = piIdCampana;
  END USP_UPD_CAMPANA_ENC_ESTADO;
  
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
  ) AS
  BEGIN
    IF piIdCampanaEncuesta = -1 THEN
        poIdCampanaEncuesta := SQ_GENM_CAMPANA_ENCUESTA.NEXTVAL();
        INSERT INTO T_GENM_CAMPANA_ENCUESTA
        (idCampanaEncuesta, idCampana, pregunta, numeroOrdenPregunta, tituloSeccion, titulo, separador, idTipoControl, idParametroTabla, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
        VALUES
        (poIdCampanaEncuesta, piIdCampana, piPregunta, piNumeroOrdenPregunta, piTituloSeccion, piTitulo, piSeparador, piIdTipoControl, piIdParametroTabla, '1', piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
        poIdCampanaEncuesta := piIdCampanaEncuesta;
        UPDATE T_GENM_CAMPANA_ENCUESTA SET
        pregunta = piPregunta,
        numeroOrdenPregunta = piNumeroOrdenPregunta,
        tituloSeccion = piTituloSeccion,
        titulo = piTitulo,
        separador = piSeparador,
        idTipoControl = piIdTipoControl,
        idParametroTabla = piIdParametroTabla,
        idEstado = '1',
        idUsuarioModificacion = piIdUsuarioCreacion,
        fechaModificacion = SYSDATE,
        ipModificacion = piIpCreacion
        WHERE idCampanaEncuesta = piIdCampanaEncuesta;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_CAMPANA_ENC;
  
  PROCEDURE USP_UPD_RESPUESTA_ENC_ESTADO(
    piIdCampanaEncuesta NUMBER
  )AS
  BEGIN
    UPDATE T_GEND_RESPUESTA_ENCUESTA SET
    idEstado = '0'
    WHERE idCampanaEncuesta = piIdCampanaEncuesta;
  END USP_UPD_RESPUESTA_ENC_ESTADO;
  
  PROCEDURE USP_PRC_GUARDAR_RESP_ENC(
    piIdRespuestaEncuesta NUMBER, 
    piIdCampanaEncuesta NUMBER,       
    piRespuesta VARCHAR2,
    piNumeroOrdenRespuesta NUMBER,
    piIdValorRespuesta VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  )AS
    vId NUMBER;
  BEGIN
    IF piIdRespuestaEncuesta = -1 THEN
        vId := SQ_GEND_RESPUESTA_ENCUESTA.NEXTVAL();
        INSERT INTO T_GEND_RESPUESTA_ENCUESTA
        (IdRespuestaEncuesta, IdCampanaEncuesta, respuesta, numeroOrdenRespuesta, idValorRespuesta, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
        VALUES
        (vId, piIdCampanaEncuesta, piRespuesta, piNumeroOrdenRespuesta, piIdValorRespuesta, '1', piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
        UPDATE T_GEND_RESPUESTA_ENCUESTA SET
        respuesta = piRespuesta,
        numeroOrdenRespuesta = piNumeroOrdenRespuesta,
        idValorRespuesta = piIdValorRespuesta,
        idEstado = '1',
        idUsuarioModificacion = piIdUsuarioCreacion,
        fechaModificacion = SYSDATE,
        ipModificacion = piIpCreacion
        WHERE IdRespuestaEncuesta = piIdRespuestaEncuesta;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_RESP_ENC;
  
  PROCEDURE USP_SEL_CAMPANA(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_CAMPANA
    WHERE idCampana = piIdCampana;
  END USP_SEL_CAMPANA;
  
  PROCEDURE USP_SEL_LIST_CAMPANA_EMP(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  ce.*,--ce.idCampanaEmpresa, ce.idCampana, ce.idEmpresaIndustria, ce.par,
            ei.idGiro, ei.idCiuu, ei.nombreEmpresa
    FROM  T_GEND_CAMPANA_EMPRESA ce
    inner join T_GENM_EMPRESA_INDUSTRIA ei ON ce.idEmpresaIndustria = ei.idEmpresaIndustria
    WHERE ce.idCampana = piIdCampana AND ce.idEstado = '1';
  END USP_SEL_LIST_CAMPANA_EMP;
  
  PROCEDURE USP_SEL_LIST_CAMPANA_ENC(
    piIdCampana NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_CAMPANA_ENCUESTA
    WHERE idCampana = piIdCampana AND idEstado = '1'
    ORDER BY numeroOrdenPregunta ASC;
  END USP_SEL_LIST_CAMPANA_ENC;
  
  PROCEDURE USP_SEL_LIST_RESPUESTA_ENC(
    piIdCampanaEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GEND_RESPUESTA_ENCUESTA
    WHERE idCampanaEncuesta = piIdCampanaEncuesta AND idEstado = '1'
    ORDER BY numeroOrdenRespuesta ASC;
  END USP_SEL_LIST_RESPUESTA_ENC;
  
  PROCEDURE USP_SEL_BUSQ_GENERAL_SUBSECTOR(
    piIdSubSector NUMBER,
    piBuscar VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
    vTotalRegistros INTEGER;
    vTotalPaginas INTEGER;
    vPaginaActual INTEGER := piPagina;
    vPaginaInicial INTEGER := 0;
    vQueryCount VARCHAR2(10000) := '';
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vQueryCount := 'SELECT  COUNT(1)
                    FROM T_GENM_CAMPANA cam
                    LEFT JOIN T_GENM_PARAMETRO par ON cam.idSubsector = par.idParametro
                    INNER JOIN T_MAE_ETAPA eta ON cam.idEtapaOficial = eta.idEtapa
                    WHERE (
                    LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                    ) AND 
                    --cam.idEtapaOficial = 3 AND 
                    cam.idSubSector = '|| piIdSubSector;
    EXECUTE IMMEDIATE vQueryCount INTO vTotalRegistros;

    vTotalPaginas := CEIL(TO_NUMBER(vTotalRegistros) / TO_NUMBER(piRegistros));
    IF vPaginaActual = 0 THEN
      vPaginaActual := 1;
    END IF;
    IF vPaginaActual > vTotalPaginas THEN
      vPaginaActual := vTotalPaginas;
    END IF;
    
    vPaginaInicial := vPaginaActual - 1;
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  cam.idCampana,
                                cam.denominacion,
                                cam.idSubSector,
                                par.parametro subsector,
                                cam.fechaCreacion,
                                eta.etapa,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_CAMPANA cam
                        LEFT JOIN T_GENM_PARAMETRO par ON cam.idSubsector = par.idParametro
                        INNER JOIN T_MAE_ETAPA eta ON cam.idEtapaOficial = eta.idEtapa
                        WHERE (
                        LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                        ) AND 
                        --cam.idEtapaOficial = 3 AND 
                        cam.idSubSector = '|| piIdSubSector || '
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQ_GENERAL_SUBSECTOR;
  
  PROCEDURE USP_SEL_BUSQ_AVANZ_SUBSECTOR(
    piIdSubSector NUMBER,
    piDenominacion VARCHAR2,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
    vTotalRegistros INTEGER;
    vTotalPaginas INTEGER;
    vPaginaActual INTEGER := piPagina;
    vPaginaInicial INTEGER := 0;
    vQueryCount VARCHAR2(10000) := '';
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vQueryCount := 'SELECT   COUNT(DISTINCT cam.idCampana)
                    FROM T_GENM_CAMPANA cam
                    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cam.idCampana = cem.idCampana AND cem.idestado = ''1''
                    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                    LEFT JOIN T_GENM_PARAMETRO par ON cam.idSubsector = par.idParametro
                    INNER JOIN T_MAE_ETAPA eta ON cam.idEtapaOficial = eta.idEtapa
                    WHERE 
                    --cam.idEtapaOficial = 3 AND 
                    cam.idSubSector = '|| piIdSubSector || ' AND (
                    '||
                    case
                        when piDenominacion is null then ''
                        else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piRuc is null then ''
                        else ' emp.ruc = '''|| piRuc ||''' AND '
                    end    
                    ||'        
                    '||
                    case
                        when piNombreEmpresa is null then ''
                        else ' LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                        when piFechaFin is null then ' TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                        else ' (TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                    end
                    ||'
                    1 = 1)';
    EXECUTE IMMEDIATE vQueryCount INTO vTotalRegistros;

    vTotalPaginas := CEIL(TO_NUMBER(vTotalRegistros) / TO_NUMBER(piRegistros));
    IF vPaginaActual = 0 THEN
      vPaginaActual := 1;
    END IF;
    IF vPaginaActual > vTotalPaginas THEN
      vPaginaActual := vTotalPaginas;
    END IF;

    vPaginaInicial := vPaginaActual - 1;
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  cam.idCampana,
                                cam.denominacion,
                                cam.idSubSector,
                                par.parametro subsector,
                                cam.fechaCreacion,
                                eta.etapa,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_CAMPANA cam
                        INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cam.idCampana = cem.idCampana AND cem.idestado = ''1''
                        INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                        LEFT JOIN T_GENM_PARAMETRO par ON cam.idSubsector = par.idParametro
                        INNER JOIN T_MAE_ETAPA eta ON cam.idEtapaOficial = eta.idEtapa
                        WHERE 
                        --cam.idEtapaOficial = 3 AND 
                        cam.idSubSector = '|| piIdSubSector || ' AND (
                        '||
                        case
                            when piDenominacion is null then ''
                            else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piRuc is null then ''
                            else ' emp.ruc = '''|| piRuc ||''' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piNombreEmpresa is null then ''
                            else ' LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(cam.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(cam.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'   
                        1 = 1)
                        GROUP BY cam.idCampana, cam.denominacion, sub.subsector, cam.fechaCreacion, eta.etapa
                    )    
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQ_AVANZ_SUBSECTOR;
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdCampana NUMBER,
    poRowAffected OUT NUMBER
  )AS
  BEGIN
    UPDATE T_GENM_CAMPANA SET
    idEstado = '0'
    WHERE idCampana = piIdCampana;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR;
  
  PROCEDURE USP_SEL_LIST_CAMPANA(
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT
    *
    FROM T_GENM_CAMPANA
    WHERE 
    --idEtapaOficial = 3 AND 
    idEstado = '1';
  END USP_SEL_LIST_CAMPANA;
  
  PROCEDURE USP_SEL_LIST_CORREO_CAMPANA(
    piIdCampana NUMBER,
    piIdTipoEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT
    usu.nombres, usu.correoElectronico, rol.rol, emp.nombreEmpresa, emp.nombreComercial, ure.nombres revisor, ure.correoElectronico correoRevisor, cam.denominacion, cam.fechafinpiloto, cam.fechafinencuesta, cen.idTipoEncuesta, cen.idFase,
    (SELECT nombres FROM (SELECT nombres FROM T_GENM_USUARIO WHERE idRol = 1 AND idEstado = '1' ORDER BY idUsuario DESC) WHERE ROWNUM = 1) admin,
    (SELECT correoElectronico FROM (SELECT correoElectronico FROM T_GENM_USUARIO WHERE idRol = 1 AND idEstado = '1' ORDER BY idUsuario DESC) WHERE ROWNUM = 1) correoAdmin
    FROM T_GENM_USUARIO usu
    INNER JOIN T_MAE_ROL rol ON usu.idRol = rol.idRol
    INNER JOIN T_GENM_PLANTA_EMPRESA pem ON usu.idPlantaEmpresa = pem.idPlantaEmpresa
    INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON pem.idPlantaEmpresa = cen.idPlantaEmpresa AND cen.idEstado = '1'
    INNER JOIN T_GENM_USUARIO ure ON cen.idSupervisor = ure.idUsuario
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa
    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria
    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana
    WHERE cen.idTipoEncuesta = piIdTipoEncuesta AND cam.idCampana = piIdCampana AND usu.idEstado = '1';
  END USP_SEL_LIST_CORREO_CAMPANA;
  
  PROCEDURE USP_SEL_CORREO_CAMPANA(
    piIdControlEncuesta NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT
    usu.nombres, usu.correoElectronico, rol.rol, emp.nombreEmpresa, emp.nombreComercial, ure.nombres revisor, ure.correoElectronico correoRevisor, cam.denominacion, cam.fechafinpiloto, cam.fechafinencuesta, cen.idTipoEncuesta, cen.idFase,
    (SELECT nombres FROM (SELECT nombres FROM T_GENM_USUARIO WHERE idRol = 1 AND idEstado = '1' ORDER BY idUsuario DESC) WHERE ROWNUM = 1) admin,
    (SELECT correoElectronico FROM (SELECT correoElectronico FROM T_GENM_USUARIO WHERE idRol = 1 AND idEstado = '1' ORDER BY idUsuario DESC) WHERE ROWNUM = 1) correoAdmin
    FROM T_GENM_USUARIO usu
    INNER JOIN T_MAE_ROL rol ON usu.idRol = rol.idRol
    INNER JOIN T_GENM_PLANTA_EMPRESA pem ON usu.idPlantaEmpresa = pem.idPlantaEmpresa
    INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON pem.idPlantaEmpresa = cen.idPlantaEmpresa AND cen.idEstado = '1'
    INNER JOIN T_GENM_USUARIO ure ON cen.idSupervisor = ure.idUsuario
    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa
    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON cem.idEmpresaIndustria = emp.idEmpresaIndustria
    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana
    WHERE cen.idControlEncuesta = piIdControlEncuesta AND usu.idEstado = '1';
  END USP_SEL_CORREO_CAMPANA;

END PKG_SISCEUSI_CAMPANA;

/
