--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_INTERNO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_INTERNO" AS

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piIdUsuario NUMBER,
    piIdRol NUMBER,
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
    vQueryCount := 'SELECT
                    COUNT(1)
                    '||
                    CASE
                        WHEN piIdRol = 3 THEN 
                            'FROM T_GENM_USUARIO    usu
                            INNER JOIN T_GENM_PLANTA_EMPRESA pem ON usu.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = ''1'''
                        ELSE 
                            'FROM T_GENM_PLANTA_EMPRESA pem'
                    END        
                    ||'
                    INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON pem.idPlantaEmpresa = cen.idPlantaEmpresa AND cen.idEstado = ''1''
                    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = ''1''
                    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = ''1''
                    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                    INNER JOIN T_MAE_TIPO_ENCUESTA ten ON cen.idTipoEncuesta = ten.idTipoEncuesta AND ten.idEstado = ''1''
                    INNER JOIN T_MAE_ETAPA eta ON cen.idEtapa = eta.idEtapa
                    INNER JOIN T_MAE_FASE fas ON cen.idFase = fas.idFase
                    WHERE
                    '||
                    CASE
                        WHEN piIdRol = 1 THEN ''
                        WHEN piIdRol = 2 THEN 
                            'cen.idSupervisor = '|| piIdUsuario ||' AND '
                        ELSE 
                            'usu.idUsuario = '|| piIdUsuario ||' AND '
                    END        
                    ||'
                    cam.idEstado = ''1'' AND
                    (
                    LOWER(TRANSLATE(pem.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(ten.tipoEncuesta,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(eta.etapa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
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
                                emp.nombreEmpresa, 
                                pem.denominacion planta, 
                                ten.tipoEncuesta, 
                                cam.denominacion, 
                                cen.fechaHoraLlenado, 
                                eta.idEtapa,
                                eta.etapa,
                                cen.idControlEncuesta,
                                cen.aceptallenarencuesta,
                                cen.aceptatratamientodatos,
                                cen.aceptafirmarencuesta,
                                cen.idFase,
                                fas.fase,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        '||
                        CASE
                            WHEN piIdRol = 3 THEN 
                                'FROM T_GENM_USUARIO    usu
                                INNER JOIN T_GENM_PLANTA_EMPRESA pem ON usu.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = ''1'''
                            ELSE 
                                'FROM T_GENM_PLANTA_EMPRESA pem'
                        END        
                        ||'
                        INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON pem.idPlantaEmpresa = cen.idPlantaEmpresa AND cen.idEstado = ''1''
                        INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = ''1''
                        INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = ''1''
                        INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                        INNER JOIN T_MAE_TIPO_ENCUESTA ten ON cen.idTipoEncuesta = ten.idTipoEncuesta AND ten.idEstado = ''1''
                        INNER JOIN T_MAE_ETAPA eta ON cen.idEtapa = eta.idEtapa
                        INNER JOIN T_MAE_FASE fas ON cen.idFase = fas.idFase
                        WHERE
                        '||
                        CASE
                            WHEN piIdRol = 1 THEN ''
                            WHEN piIdRol = 2 THEN 
                                'cen.idSupervisor = '|| piIdUsuario ||' AND '
                            ELSE 
                                'usu.idUsuario = '|| piIdUsuario ||' AND '
                        END        
                        ||'
                        cam.idEstado = ''1'' AND
                        (
                        LOWER(TRANSLATE(pem.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(emp.nombreEmpresa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ten.tipoEncuesta,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(eta.etapa,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
                        )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_GENERAL;
  
  PROCEDURE USP_SEL_BUSQUEDA_AVANZADO(
    piIdUsuario NUMBER,
    piIdRol NUMBER,
    piDenominacion VARCHAR2,
    piRuc VARCHAR2,
    piNombreEmpresa VARCHAR2,
    piIdDepartamento VARCHAR2,
    piIdProvincia VARCHAR2,
    piIdDistrito VARCHAR2,
    piIdZona NUMBER,
    piIdSubSector NUMBER,
    piIdCiuu NUMBER,
    piIdSupervisor NUMBER,
    piIdTipoEncuesta NUMBER,
    piIdEtapa NUMBER,
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
    vQueryCount := 'SELECT
                    COUNT(1)
                    '||
                    CASE
                        WHEN piIdRol = 3 THEN 
                            'FROM T_GENM_USUARIO    usu
                            INNER JOIN T_GENM_PLANTA_EMPRESA pem ON usu.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = ''1'''
                        ELSE 
                            'FROM T_GENM_PLANTA_EMPRESA pem'
                    END        
                    ||'
                    INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON pem.idPlantaEmpresa = cen.idPlantaEmpresa AND cen.idEstado = ''1''
                    INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = ''1''
                    INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = ''1''
                    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                    INNER JOIN T_MAE_TIPO_ENCUESTA ten ON cen.idTipoEncuesta = ten.idTipoEncuesta AND ten.idEstado = ''1''
                    INNER JOIN T_MAE_ETAPA eta ON cen.idEtapa = eta.idEtapa
                    INNER JOIN T_MAE_FASE fas ON cen.idFase = fas.idFase
                    WHERE
                    '||
                    CASE
                        WHEN piIdRol = 1 THEN ''
                        WHEN piIdRol = 2 THEN 
                            'cen.idSupervisor = '|| piIdUsuario ||' AND '
                        ELSE 
                            'usu.idUsuario = '|| piIdUsuario ||' AND '
                    END        
                    ||'
                    cam.idEstado = ''1'' AND
                    (
                    '||
                    case
                        when piDenominacion is null then ''
                        else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piRuc is null then ''
                        else ' emp.ruc = ' || piRuc || ' AND '
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
                        when piIdDepartamento = '0' then ''
                        else ' pem.idDepartamento = ' || piIdDepartamento || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdProvincia = '0' then ''
                        else ' pem.idProvincia = ' || piIdProvincia || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdDistrito = '0' then ''
                        else ' pem.idDistrito = ' || piIdDistrito || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdZona = 0 then ''
                        else ' pem.idZona = ' || piIdZona || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdSubSector = 0 then ''
                        else ' cam.idSubSector = ' || piIdSubSector || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdCiuu = 0 then ''
                        else ' pem.idCiuu = ' || piIdCiuu || ' AND '
                    end    
                    ||'
                    '||
                    case piIdRol
                        when 2 then ''
                        else case
                                        when piIdSupervisor = 0 then ''
                                        else ' cen.idSupervisor = ' || piIdSupervisor || ' AND '
                                    end 
                    end    
                    ||'
                    '||
                    case
                        when piIdTipoEncuesta = 0 then ''
                        else ' cen.idTipoEncuesta = ' || piIdTipoEncuesta || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdEtapa = 0 then ''
                        else ' cen.idEtapa = ' || piIdEtapa || ' AND '
                    end    
                    ||'
                    '||
                    case
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/39'')) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')  AND '
                        when piFechaFin is null then ' TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/01'')) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''')  AND '
                        else ' (TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/01'')) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/39'')) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
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
                                emp.nombreEmpresa, 
                                pem.denominacion planta, 
                                ten.tipoEncuesta, 
                                cam.denominacion, 
                                cen.fechaHoraLlenado,
                                eta.idEtapa,
                                eta.etapa,
                                cen.idControlEncuesta,
                                cen.aceptallenarencuesta,
                                cen.aceptatratamientodatos,
                                cen.aceptafirmarencuesta,
                                cen.idFase,
                                fas.fase,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        '||
                        CASE
                            WHEN piIdRol = 3 THEN 
                                'FROM T_GENM_USUARIO    usu
                                INNER JOIN T_GENM_PLANTA_EMPRESA pem ON usu.idPlantaEmpresa = pem.idPlantaEmpresa AND pem.idEstado = ''1'''
                            ELSE 
                                'FROM T_GENM_PLANTA_EMPRESA pem'
                        END        
                        ||'
                        INNER JOIN T_GEND_CONTROL_ENCUESTA cen ON pem.idPlantaEmpresa = cen.idPlantaEmpresa AND cen.idEstado = ''1''
                        INNER JOIN T_GEND_CAMPANA_EMPRESA cem ON cen.idCampanaEmpresa = cem.idCampanaEmpresa AND cem.idEstado = ''1''
                        INNER JOIN T_GENM_CAMPANA cam ON cem.idCampana = cam.idCampana AND cam.idEstado = ''1''
                        INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON pem.idEmpresaIndustria = emp.idEmpresaIndustria AND emp.idEstado = ''1''
                        INNER JOIN T_MAE_TIPO_ENCUESTA ten ON cen.idTipoEncuesta = ten.idTipoEncuesta AND ten.idEstado = ''1''
                        INNER JOIN T_MAE_ETAPA eta ON cen.idEtapa = eta.idEtapa
                        INNER JOIN T_MAE_FASE fas ON cen.idFase = fas.idFase
                        WHERE
                        '||
                        CASE
                            WHEN piIdRol = 1 THEN ''
                            WHEN piIdRol = 2 THEN 
                                'cen.idSupervisor = '|| piIdUsuario ||' AND '
                            ELSE 
                                'usu.idUsuario = '|| piIdUsuario ||' AND '
                        END        
                        ||'
                        cam.idEstado = ''1'' AND
                        (
                        '||
                        case
                            when piDenominacion is null then ''
                            else ' LOWER(TRANSLATE(cam.denominacion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDenominacion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piRuc is null then ''
                            else ' emp.ruc = ' || piRuc || ' AND '
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
                            when piIdDepartamento = '0' then ''
                            else ' pem.idDepartamento = ' || piIdDepartamento || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdProvincia = '0' then ''
                            else ' pem.idProvincia = ' || piIdProvincia || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdDistrito = '0' then ''
                            else ' pem.idDistrito = ' || piIdDistrito || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdZona = 0 then ''
                            else ' pem.idZona = ' || piIdZona || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdSubSector = 0 then ''
                            else ' cam.idSubSector = ' || piIdSubSector || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdCiuu = 0 then ''
                            else ' pem.idCiuu = ' || piIdCiuu || ' AND '
                        end    
                        ||'
                        '||
                        case piIdRol
                            when 2 then ''
                            else case
                                            when piIdSupervisor = 0 then ''
                                            else ' cen.idSupervisor = ' || piIdSupervisor || ' AND '
                                        end 
                        end    
                        ||'
                        '||
                        case
                            when piIdTipoEncuesta = 0 then ''
                            else ' cen.idTipoEncuesta = ' || piIdTipoEncuesta || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdEtapa = 0 then ''
                            else ' cen.idEtapa = ' || piIdEtapa || ' AND '
                        end    
                        ||'
                        '||
                        case
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/39'')) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')  AND '
                            when piFechaFin is null then ' TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/01'')) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''')  AND '
                            else ' (TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/01'')) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(nvl(cen.fechaHoraLlenado,''01/01/39'')) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'  
                        1 = 1)
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_AVANZADO;

END PKG_SISCEUSI_INTERNO;

/
