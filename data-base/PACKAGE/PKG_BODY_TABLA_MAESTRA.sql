--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_TABLA_MAESTRA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_TABLA_MAESTRA" AS

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
                    FROM T_GENM_TABLA_MAESTRA tma
                    inner join T_GENM_USUARIO usu on tma.idUsuarioCreacion = usu.idUsuario
                    WHERE 
                    (
                    LOWER(TRANSLATE(tma.tituloPrincipal,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(tma.subtitulo,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(usu.nombres,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' 
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
                        SELECT  tma.idTablaMaestra,
                                tma.tituloPrincipal,
                                tma.subtitulo,
                                usu.nombres,
                                tma.fechaCreacion,
                                tma.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_TABLA_MAESTRA tma
                        INNER JOIN T_GENM_USUARIO usu on tma.idUsuarioCreacion = usu.idUsuario
                        WHERE 
                        (
                        LOWER(TRANSLATE(tma.tituloPrincipal,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(tma.subtitulo,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(usu.nombres,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_GENERAL;
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piTituloPrincipal VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piNombres VARCHAR2,
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
                    FROM T_GENM_TABLA_MAESTRA tma
                    INNER JOIN T_GENM_USUARIO usu on tma.idUsuarioCreacion = usu.idUsuario
                    WHERE (
                    '||
                    case
                        when piTituloPrincipal is null then ''
                        else ' LOWER(TRANSLATE(tma.tituloPrincipal,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piTituloPrincipal ||''',''����������'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||' 
                    '||
                    case
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(tma.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                        when piFechaFin is null then ' TO_DATE(tma.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                        else ' (TO_DATE(tma.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(tma.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                    end
                    ||'
                    '||
                    case
                        when piNombres is null then ''
                        else ' LOWER(TRANSLATE(usu.nombres,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombres ||''',''����������'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdEstado = '-1' then ''
                        else ' tma.idEstado = '''|| piIdEstado ||''' AND '
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
                        SELECT  tma.idTablaMaestra,
                                tma.tituloPrincipal,
                                tma.subtitulo,
                                usu.nombres,
                                tma.fechaCreacion,
                                tma.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_TABLA_MAESTRA tma
                        INNER JOIN T_GENM_USUARIO usu on tma.idUsuarioCreacion = usu.idUsuario
                        WHERE (
                        '||
                        case
                            when piTituloPrincipal is null then ''
                            else ' LOWER(TRANSLATE(tma.tituloPrincipal,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piTituloPrincipal ||''',''����������'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||' 
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(tma.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(tma.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(tma.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(tma.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'
                        '||
                        case
                            when piNombres is null then ''
                            else ' LOWER(TRANSLATE(usu.nombres,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombres ||''',''����������'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' tma.idEstado = '''|| piIdEstado ||''' AND '
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
                        SELECT  tma.idTablaMaestra,
                                tma.tituloPrincipal,
                                tma.subtitulo,
                                usu.nombres,
                                tma.fechaCreacion,
                                tma.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_TABLA_MAESTRA tma
                        INNER JOIN T_GENM_USUARIO usu on tma.idUsuarioCreacion = usu.idUsuario
                        WHERE 
                        (
                        LOWER(TRANSLATE(tma.tituloPrincipal,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(tma.subtitulo,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(usu.nombres,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''����������'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_GENERAL;
  
  PROCEDURE USP_SEL_EXPORTAR_AVANZADO(
    piTituloPrincipal VARCHAR2,
    piFechaInicio DATE,
    piFechaFin DATE,
    piNombres VARCHAR2,
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
                        SELECT  tma.idTablaMaestra,
                                tma.tituloPrincipal,
                                tma.subtitulo,
                                usu.nombres,
                                tma.fechaCreacion,
                                tma.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_TABLA_MAESTRA tma
                        INNER JOIN T_GENM_USUARIO usu on tma.idUsuarioCreacion = usu.idUsuario
                        WHERE (
                        '||
                        case
                            when piTituloPrincipal is null then ''
                            else ' LOWER(TRANSLATE(tma.tituloPrincipal,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piTituloPrincipal ||''',''����������'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||' 
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(tma.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(tma.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(tma.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(tma.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'
                        '||
                        case
                            when piNombres is null then ''
                            else ' LOWER(TRANSLATE(usu.nombres,''����������'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombres ||''',''����������'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' tma.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        1 = 1)
                    )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_AVANZADO;
  
  PROCEDURE USP_SEL_BUSQ_GEN_ENC_PRINC(
    piIdTablaMaestra NUMBER,
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
                    FROM T_GEND_ENCABEZADO_PRINCIPAL enp
                    WHERE 
                    enp.idEstado = ''1'' AND enp.idTablaMaestra = '|| piIdTablaMaestra;
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
                        SELECT  enp.idEncabezadoPrincipal,
                                enp.tituloEncabezado,
                                enp.abreviacion,
                                enp.usarAbreviado,
                                enp.descripcionIconoAyuda,
                                ROW_NUMBER() OVER (ORDER BY enp.idTablaMaestra ASC) AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GEND_ENCABEZADO_PRINCIPAL enp
                        WHERE 
                        enp.idEstado = ''1'' AND enp.idTablaMaestra = '|| piIdTablaMaestra ||'
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQ_GEN_ENC_PRINC;

  PROCEDURE USP_PRC_GUARDAR_TABLA_MAESTRA(
    piIdTablaMaestra NUMBER,
    piTituloPrincipal VARCHAR2,
    piSubtitulo VARCHAR2,
    piDescripcionIconoAyuda VARCHAR2,
    piPreguntaInicial VARCHAR2,
    piPreguntaCierre VARCHAR2,
    piIdEstiloTabla NUMBER,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poIdTablaMaestra OUT NUMBER,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    IF piIdTablaMaestra = -1 THEN
      poIdTablaMaestra := SQ_GENM_TABLA_MAESTRA.NEXTVAL();
      INSERT INTO T_GENM_TABLA_MAESTRA
      (idTablaMaestra, tituloPrincipal, subtitulo, descripcionIconoAyuda, preguntaInicial, preguntaCierre, idEstiloTabla, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (poIdTablaMaestra, piTituloPrincipal, piSubtitulo, piDescripcionIconoAyuda, piPreguntaInicial, piPreguntaCierre, piIdEstiloTabla, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      poIdTablaMaestra := piIdTablaMaestra;
      UPDATE T_GENM_TABLA_MAESTRA SET
      tituloPrincipal = piTituloPrincipal,
      subtitulo = piSubtitulo,
      descripcionIconoAyuda = piDescripcionIconoAyuda,
      preguntaInicial = piPreguntaInicial,
      preguntaCierre = piPreguntaCierre,
      idEstiloTabla = piIdEstiloTabla,
      idUsuarioModificacion = piIdUsuarioCreacion,
      fechaModificacion = SYSDATE,
      ipModificacion = piIpCreacion
      WHERE idTablaMaestra = piIdTablaMaestra;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_TABLA_MAESTRA;
  
  PROCEDURE USP_PRC_GUARDAR_ENC_PRINCIPAL(
    piIdEncabezadoPrincipal NUMBER,
    piIdTablaMaestra NUMBER,
    piTituloEncabezado VARCHAR2,
    piAbreviacion VARCHAR2,
    piUsarAbreviado VARCHAR2,
    piDescripcionIconoAyuda VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  )AS
    vId NUMBER;
  BEGIN
    IF piIdEncabezadoPrincipal = -1 THEN
      vId := SQ_GEND_ENCABEZADO_PRINCIPAL.NEXTVAL();
      INSERT INTO T_GEND_ENCABEZADO_PRINCIPAL
      (idEncabezadoPrincipal, idTablaMaestra, tituloEncabezado, abreviacion, usarAbreviado, descripcionIconoAyuda, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piIdTablaMaestra, piTituloEncabezado, piAbreviacion, piUsarAbreviado, piDescripcionIconoAyuda, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      UPDATE T_GEND_ENCABEZADO_PRINCIPAL SET
      tituloEncabezado = piTituloEncabezado,
      abreviacion = piAbreviacion,
      usarAbreviado = piUsarAbreviado,
      descripcionIconoAyuda = piDescripcionIconoAyuda,
      idUsuarioModificacion = piIdUsuarioCreacion,
      fechaModificacion = SYSDATE,
      ipModificacion = piIpCreacion
      WHERE idEncabezadoPrincipal = piIdEncabezadoPrincipal;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_ENC_PRINCIPAL;
  
  PROCEDURE USP_PRC_GUARDAR_ENC_SECUNDARIO(
    piIdEncabezadoSecundario NUMBER,
    piIdEncabezadoPrincipal NUMBER,
    piTituloEncabezado VARCHAR2,
    piAbreviacion VARCHAR2,
    piUsarAbreviado VARCHAR2,
    piDescripcionIconoAyuda VARCHAR2,
    piIdOrientacion NUMBER,
    piIdTipoControl NUMBER,
    piIdTipoDato NUMBER,
    piIdParametro NUMBER,
    piCantidadFilas NUMBER,
    piAgregarFilas VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdEncabezadoSecundario = -1 THEN
      vId := SQ_GEND_ENCABEZADO_SECUNDARIO.NEXTVAL();
      INSERT INTO T_GEND_ENCABEZADO_SECUNDARIO
      (idEncabezadoSecundario, idEncabezadoPrincipal, tituloEncabezado, abreviacion, usarAbreviado, descripcionIconoAyuda, idOrientacion, idTipoControl, idTipoDato, idParametro, cantidadFilas, agregarFilas, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piIdEncabezadoPrincipal, piTituloEncabezado, piAbreviacion, piUsarAbreviado, piDescripcionIconoAyuda, piIdOrientacion, piIdTipoControl, piIdTipoDato, piIdParametro, piCantidadFilas, piAgregarFilas, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      UPDATE T_GEND_ENCABEZADO_SECUNDARIO SET
      idEncabezadoPrincipal = piIdEncabezadoPrincipal,
      tituloEncabezado = piTituloEncabezado,
      abreviacion = piAbreviacion,
      usarAbreviado = piUsarAbreviado,
      descripcionIconoAyuda = piDescripcionIconoAyuda,
      idOrientacion = piIdOrientacion,
      idTipoControl = piIdTipoControl,
      idTipoDato = piIdTipoDato,
      idParametro = piIdParametro,
      cantidadFilas = piCantidadFilas,
      agregarFilas = piAgregarFilas,      
      idUsuarioModificacion = piIdUsuarioCreacion,
      fechaModificacion = SYSDATE,
      ipModificacion = piIpCreacion
      WHERE idEncabezadoSecundario = piIdEncabezadoSecundario;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR_ENC_SECUNDARIO;

END PKG_SISCEUSI_TABLA_MAESTRA;

/
