--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_PLANTA_EMPRESA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_PLANTA_EMPRESA" AS

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piIdEmpresa NUMBER,
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
                    FROM T_GENM_PLANTA_EMPRESA pem
                    inner join T_MAE_CIUU ciu on pem.idCiuu = ciu.idCiuu and ciu.idEstado = ''1''
                    inner join T_MAE_DEPARTAMENTO dep on pem.idDepartamento = dep.idDepartamento and dep.idEstado = ''1''
                    inner join T_MAE_PROVINCIA pro on pem.idProvincia = pro.idProvincia and pro.idEstado = ''1''
                    inner join T_MAE_DISTRITO dis on pem.idDistrito = dis.idDistrito and dis.idEstado = ''1''
                    WHERE 
                    pem.idEmpresaIndustria = '|| piIdEmpresa ||' AND
                    (
                    LOWER(TRANSLATE(pem.direccion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(ciu.ciuu,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(pem.telefono,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(dep.departamento,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(pro.provincia,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(dis.distrito,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
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
                        SELECT  pem.idPlantaEmpresa,
                                pem.idEmpresaIndustria,
                                pem.direccion,
                                ciu.ciuu,
                                pem.telefono,
                                pem.latitud,
                                pem.longitud,
                                dep.departamento,
                                pro.provincia,
                                dis.distrito,
                                pem.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_PLANTA_EMPRESA pem
                        inner join T_MAE_CIUU ciu on pem.idCiuu = ciu.idCiuu and ciu.idEstado = ''1''
                        inner join T_MAE_DEPARTAMENTO dep on pem.idDepartamento = dep.idDepartamento and dep.idEstado = ''1''
                        inner join T_MAE_PROVINCIA pro on pem.idProvincia = pro.idProvincia and pro.idEstado = ''1''
                        inner join T_MAE_DISTRITO dis on pem.idDistrito = dis.idDistrito and dis.idEstado = ''1''
                        WHERE
                        pem.idEmpresaIndustria = '|| piIdEmpresa ||' AND
                        (
                        LOWER(TRANSLATE(pem.direccion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ciu.ciuu,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(pem.telefono,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(dep.departamento,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(pro.provincia,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(dis.distrito,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%''
                        )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_BUSQUEDA_GENERAL;
  
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
  )AS
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
                    FROM T_GENM_PLANTA_EMPRESA pem
                    inner join T_MAE_CIUU ciu on pem.idCiuu = ciu.idCiuu and ciu.idEstado = ''1''
                    inner join T_MAE_DEPARTAMENTO dep on pem.idDepartamento = dep.idDepartamento and dep.idEstado = ''1''
                    inner join T_MAE_PROVINCIA pro on pem.idProvincia = pro.idProvincia and pro.idEstado = ''1''
                    inner join T_MAE_DISTRITO dis on pem.idDistrito = dis.idDistrito and dis.idEstado = ''1''
                    WHERE 
                    pem.idEmpresaIndustria = '|| piIdEmpresa ||' AND (
                    '||
                    case
                        when piDireccion is null then ''
                        else ' LOWER(TRANSLATE(pem.direccion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDireccion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'        
                    '||
                    case
                        when piIdCiuu = 0 then ''
                        else ' ciu.idCiuu = '|| piIdCiuu ||' AND '
                    end    
                    ||'
                    '||
                    case
                        when piTelefono is null then ''
                        else ' LOWER(TRANSLATE(pem.telefono,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piTelefono ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdDepartamento = '0' then ''
                        else ' dep.idDepartamento = '|| piIdDepartamento ||' AND '
                    end    
                    ||'
                    '||
                    case
                        when piIdProvincia = '0' then ''
                        else ' pro.idProvincia = '|| piIdProvincia ||' AND '
                    end    
                    ||'               
                    '||
                    case
                        when piIdDistrito = '0' then ''
                        else ' dis.idDistrito = '|| piIdDistrito ||' AND '
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
                        SELECT  pem.idPlantaEmpresa,
                                pem.idEmpresaIndustria,
                                pem.direccion,
                                ciu.ciuu,
                                pem.telefono,
                                pem.latitud,
                                pem.longitud,
                                dep.departamento,
                                pro.provincia,
                                dis.distrito,
                                pem.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_PLANTA_EMPRESA pem
                        inner join T_MAE_CIUU ciu on pem.idCiuu = ciu.idCiuu and ciu.idEstado = ''1''
                        inner join T_MAE_DEPARTAMENTO dep on pem.idDepartamento = dep.idDepartamento and dep.idEstado = ''1''
                        inner join T_MAE_PROVINCIA pro on pem.idProvincia = pro.idProvincia and pro.idEstado = ''1''
                        inner join T_MAE_DISTRITO dis on pem.idDistrito = dis.idDistrito and dis.idEstado = ''1''
                        WHERE 
                        pem.idEmpresaIndustria = '|| piIdEmpresa ||' AND (
                        '||
                        case
                            when piDireccion is null then ''
                            else ' LOWER(TRANSLATE(pem.direccion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDireccion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piIdCiuu = 0 then ''
                            else ' ciu.idCiuu = '|| piIdCiuu ||' AND '
                        end    
                        ||'
                        '||
                        case
                            when piTelefono is null then ''
                            else ' LOWER(TRANSLATE(pem.telefono,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piTelefono ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdDepartamento = '0' then ''
                            else ' dep.idDepartamento = '|| piIdDepartamento ||' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdProvincia = '0' then ''
                            else ' pro.idProvincia = '|| piIdProvincia ||' AND '
                        end    
                        ||'               
                        '||
                        case
                            when piIdDistrito = '0' then ''
                            else ' dis.idDistrito = '|| piIdDistrito ||' AND '
                        end    
                        ||'
                        1 = 1)
                    )    
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_AVANZADO;
  
  PROCEDURE USP_SEL_EXPORTAR_GENERAL(
    piIdEmpresa NUMBER,
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
                        SELECT  pem.idPlantaEmpresa,
                                pem.idEmpresaIndustria,
                                pem.direccion,
                                ciu.ciuu,
                                pem.telefono,
                                pem.latitud,
                                pem.longitud,
                                dep.departamento,
                                pro.provincia,
                                dis.distrito,
                                pem.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_PLANTA_EMPRESA pem
                        inner join T_MAE_CIUU ciu on pem.idCiuu = ciu.idCiuu and ciu.idEstado = ''1''
                        inner join T_MAE_DEPARTAMENTO dep on pem.idDepartamento = dep.idDepartamento and dep.idEstado = ''1''
                        inner join T_MAE_PROVINCIA pro on pem.idProvincia = pro.idProvincia and pro.idEstado = ''1''
                        inner join T_MAE_DISTRITO dis on pem.idDistrito = dis.idDistrito and dis.idEstado = ''1''
                        WHERE
                        pem.idEmpresaIndustria = '|| piIdEmpresa ||' AND
                        (
                        LOWER(TRANSLATE(pem.direccion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(ciu.ciuu,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(pem.telefono,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(dep.departamento,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(pro.provincia,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(dis.distrito,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%''
                        )
                        )';

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_EXPORTAR_GENERAL;
  
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
  )AS
    vQuerySelect VARCHAR2(10000) := '';
    vExtension VARCHAR(10);
    vColumna VARCHAR2(50);
  BEGIN
    vExtension := SUBSTR(piColumna,1,3);
    vColumna := SUBSTR(piColumna,5,LENGTH(piColumna)-4);
    vColumna := vExtension || '.' || vColumna;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  pem.idPlantaEmpresa,
                                pem.idEmpresaIndustria,
                                pem.direccion,
                                ciu.ciuu,
                                pem.telefono,
                                pem.latitud,
                                pem.longitud,
                                dep.departamento,
                                pro.provincia,
                                dis.distrito,
                                pem.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_PLANTA_EMPRESA pem
                        inner join T_MAE_CIUU ciu on pem.idCiuu = ciu.idCiuu and ciu.idEstado = ''1''
                        inner join T_MAE_DEPARTAMENTO dep on pem.idDepartamento = dep.idDepartamento and dep.idEstado = ''1''
                        inner join T_MAE_PROVINCIA pro on pem.idProvincia = pro.idProvincia and pro.idEstado = ''1''
                        inner join T_MAE_DISTRITO dis on pem.idDistrito = dis.idDistrito and dis.idEstado = ''1''
                        WHERE 
                        pem.idEmpresaIndustria = '|| piIdEmpresa ||' AND (
                        '||
                        case
                            when piDireccion is null then ''
                            else ' LOWER(TRANSLATE(pem.direccion,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piDireccion ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'        
                        '||
                        case
                            when piIdCiuu = 0 then ''
                            else ' ciu.idCiuu = '|| piIdCiuu ||' AND '
                        end    
                        ||'
                        '||
                        case
                            when piTelefono is null then ''
                            else ' LOWER(TRANSLATE(pem.telefono,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piTelefono ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdDepartamento = '0' then ''
                            else ' dep.idDepartamento = '|| piIdDepartamento ||' AND '
                        end    
                        ||'
                        '||
                        case
                            when piIdProvincia = '0' then ''
                            else ' pro.idProvincia = '|| piIdProvincia ||' AND '
                        end    
                        ||'               
                        '||
                        case
                            when piIdDistrito = '0' then ''
                            else ' dis.idDistrito = '|| piIdDistrito ||' AND '
                        end    
                        ||'
                        1 = 1)
                    )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_AVANZADO;
  
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
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdPlantaEmpresa = -1 THEN
      vId := SQ_GENM_PLANTA_EMPRESA.NEXTVAL();
      INSERT INTO T_GENM_PLANTA_EMPRESA
      (IdPlantaEmpresa, idEmpresaIndustria, idGiro, idCiuu, idDepartamento, idProvincia, idDistrito, idZona, denominacion, direccion, telefono, latitud, longitud, 
      idEmpresaGas, numeroSuministroGas, idEmpresaLuz, numeroSuministroAlumbrado, nombreArchivo, nombreArchivoGenerado, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piIdEmpresaIndustria, piIdGiro, piIdCiuu, piIdDepartamento, piIdProvincia, piIdDistrito, piIdZona, piDenominacion, piDireccion, piTelefono, piLatitud, piLongitud, 
      piIdEmpresaGas, piNumeroSuministroGas, piIdEmpresaLuz, piNumeroSuministroAlumbrado, piNombreArchivo, piNombreArchivoGenerado, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
      UPDATE T_GENM_PLANTA_EMPRESA pe SET
      pe.idEmpresaIndustria = piIdEmpresaIndustria,
      pe.idGiro = piIdGiro,
      pe.idCiuu = piIdCiuu,
      pe.idDepartamento = piIdDepartamento,
      pe.idProvincia = piIdProvincia,
      pe.idDistrito = piIdDistrito,
      pe.idZona = piIdZona,
      pe.denominacion = piDenominacion,
      pe.direccion = piDireccion,
      pe.telefono = piTelefono,
      pe.latitud = piLatitud,
      pe.longitud = piLongitud,
      pe.idEmpresaGas = piIdEmpresaGas,
      pe.numeroSuministroGas = piNumeroSuministroGas,
      pe.idEmpresaLuz = piIdEmpresaLuz,
      pe.numeroSuministroAlumbrado = piNumeroSuministroAlumbrado,
      pe.nombreArchivo = piNombreArchivo,
      pe.nombreArchivoGenerado = piNombreArchivoGenerado,
      pe.idEstado = piIdEstado,
      pe.idUsuarioModificacion = piIdUsuarioCreacion,
      pe.fechaModificacion = SYSDATE,
      pe.ipModificacion = piIpCreacion
      WHERE pe.IdPlantaEmpresa = piIdPlantaEmpresa;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR;
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdPlantaEmpresa NUMBER,
    poRowAffected OUT NUMBER
  )AS
  BEGIN
    UPDATE T_GENM_PLANTA_EMPRESA SET
    idEstado = '0'
    WHERE idPlantaEmpresa = piIdPlantaEmpresa;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR;
  
  PROCEDURE USP_SEL_OBJECT(
    piIdPlantaEmpresa NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_PLANTA_EMPRESA	 
    WHERE   idPlantaEmpresa = piIdPlantaEmpresa;
  END USP_SEL_OBJECT;
  
  PROCEDURE USP_SEL_LISTA(
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  pe.*, ei.nombreEmpresa, d.departamento, p.provincia, di.distrito
    FROM  T_GENM_PLANTA_EMPRESA pe
    inner join T_GENM_EMPRESA_INDUSTRIA ei ON pe.idEmpresaIndustria = ei.idEmpresaIndustria
    inner join T_MAE_DEPARTAMENTO d ON pe.idDepartamento = d.idDepartamento
    inner join T_MAE_PROVINCIA p ON pe.idProvincia = p.idProvincia
    inner join T_MAE_DISTRITO di ON pe.idDistrito = di.idDistrito
    WHERE pe.idEstado = '1';
  END USP_SEL_LISTA;

END PKG_SISCEUSI_PLANTA_EMPRESA;

/
