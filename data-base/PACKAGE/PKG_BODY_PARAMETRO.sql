--------------------------------------------------------
-- Archivo creado  - domingo-agosto-14-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_PARAMETRO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_PARAMETRO" AS

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
                    FROM T_GENM_PARAMETRO par
                    LEFT JOIN T_GENM_PARAMETRO ppa ON par.idParentParametro = ppa.idParametro AND ppa.idEstado = ''1''
                    WHERE 
                    (
                    LOWER(TRANSLATE(par.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(ppa.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
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
                        SELECT  par.idParametro,
                                par.Parametro,
                                ppa.Parametro parentParametro,
                                par.fechaCreacion,
                                par.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_PARAMETRO par
                        LEFT JOIN T_GENM_PARAMETRO ppa ON par.idParentParametro = ppa.idParametro AND ppa.idEstado = ''1''
                        WHERE 
                        (
                        LOWER(TRANSLATE(par.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ppa.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_GENERAL;
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piParentParametro VARCHAR2,
    piParametro VARCHAR2,    
    piIdTipoParametro NUMBER,
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
    vQueryCount := 'SELECT  COUNT(1)
                    FROM T_GENM_PARAMETRO par
                    LEFT JOIN T_GENM_PARAMETRO ppa ON par.idParentParametro = ppa.idParametro AND ppa.idEstado = ''1''
                    WHERE (
                    '||
                    case
                        when piParentParametro is null then ''
                        else ' LOWER(TRANSLATE(ppa.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piParentParametro ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piParametro is null then ''
                        else ' LOWER(TRANSLATE(par.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piParametro ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdTipoParametro = 0 then ''
                        else ' par.idTipoParametro = '|| piIdTipoParametro ||' AND '
                    end    
                    ||'
                    '||
                    case
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(par.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                        when piFechaFin is null then ' TO_DATE(par.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                        else ' (TO_DATE(par.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(par.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                    end
                    ||'                    
                    '||
                    case
                        when piIdEstado = '-1' then ''
                        else ' par.idEstado = '''|| piIdEstado ||''' AND '
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
                        SELECT  par.idParametro,
                                par.Parametro,
                                ppa.Parametro parentParametro,
                                par.fechaCreacion,
                                par.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_PARAMETRO par
                        LEFT JOIN T_GENM_PARAMETRO ppa ON par.idParentParametro = ppa.idParametro AND ppa.idEstado = ''1''
                        WHERE (
                        '||
                        case
                            when piParentParametro is null then ''
                            else ' LOWER(TRANSLATE(ppa.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piParentParametro ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piParametro is null then ''
                            else ' LOWER(TRANSLATE(par.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piParametro ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdTipoParametro = 0 then ''
                            else ' par.idTipoParametro = '|| piIdTipoParametro ||' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(par.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(par.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(par.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(par.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'     
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' par.idEstado = '''|| piIdEstado ||''' AND '
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
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);  
  BEGIN
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  par.idParametro,
                                par.Parametro,
                                ppa.Parametro parentParametro,
                                par.fechaCreacion,
                                par.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_PARAMETRO par
                        LEFT JOIN T_GENM_PARAMETRO ppa ON par.idParentParametro = ppa.idParametro AND ppa.idEstado = ''1''
                        WHERE 
                        (
                        LOWER(TRANSLATE(par.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ppa.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_GENERAL;
  
  PROCEDURE USP_SEL_EXPORTAR_AVANZADO(
    piParentParametro VARCHAR2,
    piParametro VARCHAR2,    
    piIdTipoParametro NUMBER,
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
                        SELECT  par.idParametro,
                                par.Parametro,
                                ppa.Parametro parentParametro,
                                par.fechaCreacion,
                                par.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_PARAMETRO par
                        LEFT JOIN T_GENM_PARAMETRO ppa ON par.idParentParametro = ppa.idParametro AND ppa.idEstado = ''1''
                        WHERE (
                        '||
                        case
                            when piParentParametro is null then ''
                            else ' LOWER(TRANSLATE(ppa.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piParentParametro ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piParametro is null then ''
                            else ' LOWER(TRANSLATE(par.parametro,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piParametro ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdTipoParametro = 0 then ''
                            else ' par.idTipoParametro = '|| piIdTipoParametro ||' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(par.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(par.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(par.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(par.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'     
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' par.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        1 = 1)
                    )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_AVANZADO;

  PROCEDURE USP_PRC_GUARDAR(
    piIdParametro NUMBER,
    piParametro VARCHAR2,
    piIdParentParametro NUMBER,
    piIdTipoParametro NUMBER,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdParametro = -1 THEN
      vId := SQ_GENM_PARAMETRO.NEXTVAL();
      INSERT INTO T_GENM_PARAMETRO
      (idParametro, parametro, idParentParametro, idTipoParametro, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piParametro, piIdParentParametro, piIdTipoParametro, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      UPDATE T_GENM_PARAMETRO SET
      parametro = piParametro,
      idParentParametro = piIdParentParametro,
      idTipoParametro = piIdTipoParametro,
      idEstado = piIdEstado,
      idUsuarioModificacion = piIdUsuarioCreacion,
      fechaModificacion = SYSDATE,
      ipModificacion = piIpCreacion
      WHERE idParametro = piIdParametro;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR;
  
  PROCEDURE USP_SEL_OBJECT(
    piIdParametro NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_PARAMETRO	 
    WHERE   idParametro = piIdParametro;
  END USP_SEL_OBJECT;
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdParametro NUMBER,
    poRowAffected OUT NUMBER
  )AS
  BEGIN
    UPDATE T_GENM_PARAMETRO SET
    idEstado = '0'
    WHERE idParametro = piIdParametro;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR;
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_PARAMETRO
    WHERE idEstado = '1'; 
  END USP_SEL_LISTA;

END PKG_SISCEUSI_PARAMETRO;

/
