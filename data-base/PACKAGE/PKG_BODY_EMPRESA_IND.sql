--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_EMPRESA_IND
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_EMPRESA_IND" AS

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
    vColumna VARCHAR2(50);
  BEGIN
    vQueryCount := 'SELECT  COUNT(1)
                    FROM T_GENM_EMPRESA_INDUSTRIA ei
                    LEFT join T_GENM_PARAMETRO p on ei.idGiro = p.idParametro and p.idEstado = ''1''
                    WHERE (
                    LOWER(TRANSLATE(ei.ruc,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(ei.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(ei.representanteLegal,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(p.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' )';
    EXECUTE IMMEDIATE vQueryCount INTO vTotalRegistros;

    vTotalPaginas := CEIL(TO_NUMBER(vTotalRegistros) / TO_NUMBER(piRegistros));
    IF vPaginaActual = 0 THEN
      vPaginaActual := 1;
    END IF;
    IF vPaginaActual > vTotalPaginas THEN
      vPaginaActual := vTotalPaginas;
    END IF;
    
    vPaginaInicial := vPaginaActual - 1;
    IF piColumna = 'giro' THEN
      vColumna := 'p.parametro';
    ELSE
      vColumna := 'ei.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  ei.idEmpresaIndustria,
                                ei.ruc,
                                ei.nombreEmpresa,
                                ei.representanteLegal,
                                p.parametro giro,
                                ei.fechaCreacion,
                                ei.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_EMPRESA_INDUSTRIA ei
                        LEFT join T_GENM_PARAMETRO p on ei.idGiro = p.idParametro and p.idEstado = ''1''
                        WHERE (
                        LOWER(TRANSLATE(ei.ruc,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ei.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ei.representanteLegal,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(p.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_BUSQUEDA_GENERAL;    
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piRepresentanteLegal VARCHAR2,
    piCorreo VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piIdEstado VARCHAR2,
    piRegistros NUMBER,
    piPagina NUMBER,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  )AS
    vTotalRegistros INTEGER;
    vTotalPaginas INTEGER;
    vPaginaActual INTEGER := piPagina;
    vPaginaInicial INTEGER := 0;
    vQueryCount VARCHAR2(10000) := '';
    vQuerySelect VARCHAR2(10000) := '';
    vColumna VARCHAR2(50);
  BEGIN
    vQueryCount := 'SELECT  COUNT(1)
                    FROM T_GENM_EMPRESA_INDUSTRIA ei
                    LEFT join T_GENM_PARAMETRO p on ei.idGiro = p.idParametro and p.idEstado = ''1''
                    WHERE (
                    '||
                    case
                        when piRuc is null then ''
                        else ' ei.ruc = '''|| piRuc ||''' AND '
                    end    
                    ||'        
                    '||
                    case
                        when piNombreEmpresa is null then ''
                        else ' LOWER(TRANSLATE(ei.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piRepresentanteLegal is null then ''
                        else ' LOWER(TRANSLATE(ei.representanteLegal,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piRepresentanteLegal ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piCorreo is null then ''
                        else ' LOWER(TRANSLATE(ei.correoElectronico,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piCorreo ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(ei.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                        when piFechaFin is null then ' TO_DATE(ei.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                        else ' (TO_DATE(ei.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(ei.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                    end
                    ||'                
                    '||
                    case
                        when piIdEstado = '-1' then ''
                        else ' ei.idEstado = '''|| piIdEstado ||''' AND '
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
    IF piColumna = 'giro' THEN
      vColumna := 'p.parametro';
    ELSE
      vColumna := 'ei.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  ei.idEmpresaIndustria,
                                ei.ruc,
                                ei.nombreEmpresa,
                                ei.representanteLegal,
                                p.parametro giro,
                                ei.fechaCreacion,
                                ei.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_EMPRESA_INDUSTRIA ei
                        LEFT join T_GENM_PARAMETRO p on ei.idGiro = p.idParametro and p.idEstado = ''1''
                        WHERE (
                        '||
                        case
                            when piRuc is null then ''
                            else ' ei.ruc = '''|| piRuc ||''' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piNombreEmpresa is null then ''
                            else ' LOWER(TRANSLATE(ei.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piRepresentanteLegal is null then ''
                            else ' LOWER(TRANSLATE(ei.representanteLegal,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piRepresentanteLegal ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piCorreo is null then ''
                            else ' LOWER(TRANSLATE(ei.correoElectronico,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piCorreo ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(ei.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(ei.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(ei.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(ei.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'                
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' ei.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        1 = 1)
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
    vColumna VARCHAR2(50);
  BEGIN
    IF piColumna = 'giro' THEN
      vColumna := 'p.parametro';
    ELSE
      vColumna := 'ei.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  ei.idEmpresaIndustria,
                                ei.nombreEmpresa,
                                ei.nombreComercial,
                                ei.ruc,
                                p.parametro giro,
                                ge.parametro grupoEmpresa,
                                ci.parametro ciuu,
                                ei.direccionfiscal,
                                ei.correoElectronico,
                                ei.representanteLegal,
                                ei.dni,
                                ei.observacionUno,
                                ei.observacionDos,
                                ei.observacionTres,
                                ei.fechaCreacion,
                                ei.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_EMPRESA_INDUSTRIA ei
                        LEFT join T_GENM_PARAMETRO p on ei.idGiro = p.idParametro and p.idEstado = ''1''
                        LEFT join T_GENM_PARAMETRO ge on ei.idGrupoEmpresa = ge.idParametro and ge.idEstado = ''1''
                        LEFT join T_GENM_PARAMETRO ci on ei.idCiuu = ci.idParametro and ci.idEstado = ''1''
                        WHERE (
                        LOWER(TRANSLATE(ei.ruc,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ei.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ei.representanteLegal,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(p.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' )
                        )';

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_EXPORTAR_GENERAL; 
  
  PROCEDURE USP_SEL_EXPORTAR_AVANZADO(
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piRepresentanteLegal VARCHAR2,
    piCorreo VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piIdEstado VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  )AS
    vQuerySelect VARCHAR2(10000) := '';
    vColumna VARCHAR2(50);
  BEGIN
    IF piColumna = 'giro' THEN
      vColumna := 'p.parametro';
    ELSE
      vColumna := 'ei.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  ei.idEmpresaIndustria,                                
                                ei.nombreEmpresa,
                                ei.nombreComercial,
                                ei.ruc,
                                p.parametro giro,
                                ge.parametro grupoEmpresa,
                                ci.parametro ciuu,
                                ei.direccionfiscal,
                                ei.correoElectronico,
                                ei.representanteLegal,
                                ei.dni,
                                ei.observacionUno,
                                ei.observacionDos,
                                ei.observacionTres,
                                ei.fechaCreacion,
                                ei.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_EMPRESA_INDUSTRIA ei
                        LEFT join T_GENM_PARAMETRO p on ei.idGiro = p.idParametro and p.idEstado = ''1''
                        LEFT join T_GENM_PARAMETRO ge on ei.idGrupoEmpresa = ge.idParametro and ge.idEstado = ''1''
                        LEFT join T_GENM_PARAMETRO ci on ei.idCiuu = ci.idParametro and ci.idEstado = ''1''
                        WHERE (
                        '||
                        case
                            when piRuc is null then ''
                            else ' ei.ruc = '''|| piRuc ||''' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piNombreEmpresa is null then ''
                            else ' LOWER(TRANSLATE(ei.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombreEmpresa ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piRepresentanteLegal is null then ''
                            else ' LOWER(TRANSLATE(ei.representanteLegal,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piRepresentanteLegal ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piCorreo is null then ''
                            else ' LOWER(TRANSLATE(ei.correoElectronico,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piCorreo ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(ei.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(ei.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(ei.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(ei.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'                
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' ei.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        1 = 1)
                    )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_AVANZADO;
  
  PROCEDURE USP_PRC_GUARDAR(
    piIdEmpresaIndustria NUMBER,
    piNombreEmpresa VARCHAR2,
    piNombreComercial VARCHAR2,
    piRuc VARCHAR2,
    piIdGiro NUMBER,
    piIdGrupoEmpresa NUMBER,
    piIdCiuu NUMBER,
    piDireccionFiscal VARCHAR2,
    piCorreo VARCHAR2,
    piRepresentanteLegal VARCHAR2,
    piDni VARCHAR2, 
    piIdEstado VARCHAR2,
    piObservacionUno VARCHAR2,
    piObservacionDos VARCHAR2,
    piObservacionTres VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  )AS
    vId NUMBER;
  BEGIN
    IF piIdEmpresaIndustria = -1 THEN
      vId := SQ_GENM_EMPRESA_INDUSTRIA.NEXTVAL();
      INSERT INTO T_GENM_EMPRESA_INDUSTRIA
      (idEmpresaIndustria, nombreEmpresa, nombreComercial, ruc, idGiro, idGrupoEmpresa, idCiuu, direccionFiscal, correoElectronico, representanteLegal, dni, idEstado, observacionUno, observacionDos, observacionTres, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piNombreEmpresa, piNombreComercial, piRuc, piIdGiro, piIdGrupoEmpresa, piIdCiuu, piDireccionFiscal, piCorreo, piRepresentanteLegal, piDni, piIdEstado, piObservacionUno, piObservacionDos, piObservacionTres, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      UPDATE T_GENM_EMPRESA_INDUSTRIA ei SET
      ei.nombreEmpresa = piNombreEmpresa,
      ei.nombreComercial = piNombreComercial,
      ei.ruc = piRuc,
      ei.idGiro = piIdGiro,
      ei.idGrupoEmpresa = piIdGrupoEmpresa,
      ei.idCiuu = piIdCiuu,
      ei.direccionFiscal = piDireccionFiscal,
      ei.correoElectronico = piCorreo,
      ei.representanteLegal = piRepresentanteLegal,
      ei.dni = piDni,
      ei.idEstado = piIdEstado,
      ei.observacionUno = piObservacionUno,
      ei.observacionDos = piObservacionDos,
      ei.observacionTres = piObservacionTres,
      ei.idUsuarioModificacion = piIdUsuarioCreacion,
      ei.fechaModificacion = SYSDATE,
      ei.ipModificacion = piIpCreacion
      WHERE ei.idEmpresaIndustria = piIdEmpresaIndustria;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR;
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdEmpresa NUMBER,
    poRowAffected OUT NUMBER
  )AS
  BEGIN
    UPDATE T_GENM_EMPRESA_INDUSTRIA SET
    idEstado = '0'
    WHERE idEmpresaIndustria = piIdEmpresa;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR;

  PROCEDURE USP_SEL_OBJECT(
    piIdEmpresa NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_EMPRESA_INDUSTRIA	 
    WHERE   idEmpresaIndustria = piIdEmpresa;
  END USP_SEL_OBJECT;
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_EMPRESA_INDUSTRIA ei
    WHERE
    (SELECT COUNT(*) FROM T_GENM_PLANTA_EMPRESA WHERE idEmpresaIndustria = ei.idEmpresaIndustria AND idEstado = '1') > 0 AND
    (SELECT COUNT(*) FROM T_GENM_USUARIO WHERE idEstado = '1' AND idPlantaEmpresa in (
        SELECT idPlantaEmpresa FROM T_GENM_PLANTA_EMPRESA WHERE idEmpresaIndustria = ei.idEmpresaIndustria AND idEstado = '1')) > 0 AND
    ei.idEstado = '1';
  END USP_SEL_LISTA;
  
  PROCEDURE USP_SEL_POR_RUC(
    piRuc VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_EMPRESA_INDUSTRIA	 
    WHERE   ruc = piRuc;
  END USP_SEL_POR_RUC;

END PKG_SISCEUSI_EMPRESA_IND;

/
