--------------------------------------------------------
-- Archivo creado  - viernes-agosto-12-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_USUARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_USUARIO" AS

  PROCEDURE USP_SEL_BUSQUEDA_GENERAL(
    piIdPlantaEmpresa NUMBER,
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
                    FROM T_GENM_USUARIO u
                    inner join T_MAE_ROL r on u.idRol = r.idRol
                    WHERE
                    '||
                    case
                        when piIdPlantaEmpresa = 0 then ' u.idRol in (1,2) AND '
                        else ' u.idPlantaEmpresa = '|| piIdPlantaEmpresa ||' AND '
                    end    
                    ||'
                    (
                    LOWER(TRANSLATE(u.nombres,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(u.correoElectronico,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                    LOWER(TRANSLATE(r.rol,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' 
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
    IF piColumna = 'rol' THEN
      vColumna := 'r.rol';
    ELSE
      vColumna := 'u.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  u.idUsuario,
                                u.nombres,
                                u.correoElectronico,
                                r.rol,
                                u.fechaCreacion,
                                u.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_USUARIO U
                        inner join T_MAE_ROL r on u.idRol = r.idRol and r.idEstado = ''1''
                        WHERE 
                        '||
                        case
                            when piIdPlantaEmpresa = 0 then ' u.idRol in (1,2) AND '
                            else ' u.idPlantaEmpresa = '|| piIdPlantaEmpresa ||' AND '
                        end    
                        ||'
                        (
                        LOWER(TRANSLATE(u.nombres,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(u.correoElectronico,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(r.rol,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' )
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_BUSQUEDA_GENERAL;
  
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
                    FROM T_GENM_USUARIO u
                    inner join T_MAE_ROL r on u.idRol = r.idRol
                    inner join T_GENM_EMPRESA_INDUSTRIA ei on u.idEmpresaIndustria = ei.idEmpresaIndustria and ei.idEstado = ''1''
                    WHERE 
                    '||
                    case
                        when piIdPlantaEmpresa = 0 then ' u.idRol in (1,2) AND '
                        else ' u.idPlantaEmpresa = '|| piIdPlantaEmpresa ||' AND '
                    end    
                    ||'
                    (
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
                        when piFechaInicio is null and piFechaFin is null then ''
                        when piFechaInicio is null then ' TO_DATE(u.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                        when piFechaFin is null then ' TO_DATE(u.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                        else ' (TO_DATE(u.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(u.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                    end
                    ||'
                    '||
                    case
                        when piIdRol = 0 then ''
                        else ' u.idRol = '|| piIdRol ||' AND '
                    end    
                    ||'                   
                    '||
                    case
                        when piIdEstado = '-1' then ''
                        else ' u.idEstado = '''|| piIdEstado ||''' AND '
                    end
                    ||'
                    '||
                    case
                        when piNombres is null then ''
                        else ' LOWER(TRANSLATE(u.nombres,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombres ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
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
    IF piColumna = 'rol' THEN
      vColumna := 'r.rol';
    ELSE
      vColumna := 'u.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  u.idUsuario,
                                u.nombres,
                                u.correoElectronico,
                                r.rol,
                                u.fechaCreacion,
                                u.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_USUARIO U
                        inner join T_MAE_ROL r on u.idRol = r.idRol
                        inner join T_GENM_EMPRESA_INDUSTRIA ei on u.idEmpresaIndustria = ei.idEmpresaIndustria and ei.idEstado = ''1''
                        WHERE 
                        '||
                        case
                            when piIdPlantaEmpresa = 0 then ' u.idRol in (1,2) AND '
                            else ' u.idPlantaEmpresa = '|| piIdPlantaEmpresa ||' AND '
                        end    
                        ||'
                        (
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
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(u.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(u.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(u.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(u.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'
                        '||
                        case
                            when piIdRol = 0 then ''
                            else ' u.idRol = '|| piIdRol ||' AND '
                        end    
                        ||'                   
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' u.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        '||
                        case
                            when piNombres is null then ''
                            else ' LOWER(TRANSLATE(u.nombres,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombres ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end
                        ||'
                        1 = 1)
                    )    
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_BUSQUEDA_AVANZADO;
  
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
    piEditarPassword VARCHAR2,
    poRowAffected OUT NUMBER
  )AS
    vId NUMBER;
    vPassword VARCHAR2(400);
  BEGIN
    IF piIdUsuario = -1 THEN
      vId := SQ_GENM_USUARIO.NEXTVAL();
      INSERT INTO T_GENM_USUARIO
      (idUsuario, idEmpresaIndustria, idPlantaEmpresa, idRol, nombres, dni, telefono, correoElectronico, password, visualizar, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
      VALUES 
      (vId, piIdEmpresaIndustria, piIdPlantaEmpresa, piIdRol, piNombres, piDni, piTelefono, piCorreo, piPassword, piVisualizar, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
     IF piEditarPassword = '0' THEN
        SELECT password INTO vPassword FROM T_GENM_USUARIO WHERE idUsuario = piIdUsuario;
     ELSE
        vPassword := piPassword;
     END IF;
      UPDATE T_GENM_USUARIO u SET
      u.idEmpresaIndustria = piIdEmpresaIndustria,
      u.idPlantaEmpresa = piIdPlantaEmpresa,
      u.idRol = piIdRol,
      u.dni = piDni,
      u.telefono = piTelefono,
      u.nombres = piNombres,
      u.correoElectronico = piCorreo,
      u.password = vPassword,
      u.visualizar = piVisualizar,
      u.idEstado = piIdEstado,
      u.idUsuarioModificacion = piIdUsuarioCreacion,
      u.fechaModificacion = SYSDATE,
      u.ipModificacion = piIpCreacion
      WHERE u.idUsuario = piIdUsuario;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_GUARDAR;
  
  PROCEDURE USP_UPD_DESHABILITAR(
    piIdUsuario NUMBER,
    poRowAffected OUT NUMBER
  )AS
  BEGIN
    UPDATE T_GENM_USUARIO SET
    idEstado = '0'
    WHERE idUsuario = piIdUsuario;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR;
  
  PROCEDURE USP_SEL_OBJECT(
    piIdUsuario NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_USUARIO
    WHERE idUsuario = piIdUsuario;
  END USP_SEL_OBJECT;
  
  PROCEDURE USP_SEL_LISTA_ROL(
    piIdRol NUMBER,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_USUARIO
    WHERE idRol = piIdRol
    AND idEstado = '1';
  END USP_SEL_LISTA_ROL;
  
  PROCEDURE USP_SEL_POR_CORREO(
    piIdUsuario NUMBER,
    piCorreo VARCHAR2,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_USUARIO
    WHERE LOWER(TRANSLATE(correoElectronico,'¡…Õ”⁄·ÈÌÛ˙','AEIOUaeiou')) = LOWER(TRANSLATE(piCorreo,'¡…Õ”⁄·ÈÌÛ˙','AEIOUaeiou'))
    AND idUsuario <> piIdUsuario;
  END USP_SEL_POR_CORREO;
  
  PROCEDURE USP_SEL_POR_DNI(
    piIdUsuario NUMBER,
    piDni VARCHAR2,
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT  *
    FROM  T_GENM_USUARIO
    WHERE dni = piDni
    AND idUsuario <> piIdUsuario;
  END USP_SEL_POR_DNI;
  
  PROCEDURE USP_SEL_EXPORTAR_GENERAL(
    piIdPlantaEmpresa NUMBER,
    piBuscar VARCHAR2,
    piColumna VARCHAR2,
    piOrden VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
    vQuerySelect VARCHAR2(10000) := '';
    vColumna VARCHAR2(50);
  BEGIN    
    IF piColumna = 'rol' THEN
      vColumna := 'r.rol';
    ELSE
      vColumna := 'u.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  u.idUsuario,
                                u.nombres,
                                u.correoElectronico,
                                r.rol,
                                u.fechaCreacion,
                                u.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_USUARIO U
                        inner join T_MAE_ROL r on u.idRol = r.idRol and r.idEstado = ''1''
                        WHERE 
                        '||
                        case
                            when piIdPlantaEmpresa = 0 then ' u.idRol in (1,2) AND '
                            else ' u.idPlantaEmpresa = '|| piIdPlantaEmpresa ||' AND '
                        end    
                        ||'
                        (
                        LOWER(TRANSLATE(u.nombres,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(u.correoElectronico,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' OR
                        LOWER(TRANSLATE(r.rol,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piBuscar ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' )
                        )';

    OPEN poRef FOR vQuerySelect;
    
  END USP_SEL_EXPORTAR_GENERAL;
  
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
  )AS
    vQuerySelect VARCHAR2(10000) := '';
    vColumna VARCHAR2(50);
  BEGIN
    IF piColumna = 'rol' THEN
      vColumna := 'r.rol';
    ELSE
      vColumna := 'u.' || piColumna;
    END IF;

    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  u.idUsuario,
                                u.nombres,
                                u.correoElectronico,
                                r.rol,
                                u.fechaCreacion,
                                u.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ' || vColumna || ' ' || piOrden ||') AS fila
                        FROM T_GENM_USUARIO U
                        inner join T_MAE_ROL r on u.idRol = r.idRol
                        inner join T_GENM_EMPRESA_INDUSTRIA ei on u.idEmpresaIndustria = ei.idEmpresaIndustria and ei.idEstado = ''1''
                        WHERE 
                        '||
                        case
                            when piIdPlantaEmpresa = 0 then ' u.idRol in (1,2) AND '
                            else ' u.idPlantaEmpresa = '|| piIdPlantaEmpresa ||' AND '
                        end    
                        ||'
                        (
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
                            when piFechaInicio is null and piFechaFin is null then ''
                            when piFechaInicio is null then ' TO_DATE(u.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''') AND '
                            when piFechaFin is null then ' TO_DATE(u.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') || ''') AND '
                            else ' (TO_DATE(u.fechaCreacion) >= TO_DATE('''|| TO_CHAR(piFechaInicio,'dd/MM/yy') ||''') AND TO_DATE(u.fechaCreacion) <= TO_DATE('''|| TO_CHAR(piFechaFin,'dd/MM/yy') || ''')) AND '  
                        end
                        ||'
                        '||
                        case
                            when piIdRol = 0 then ''
                            else ' u.idRol = '|| piIdRol ||' AND '
                        end    
                        ||'                   
                        '||
                        case
                            when piIdEstado = '-1' then ''
                            else ' u.idEstado = '''|| piIdEstado ||''' AND '
                        end
                        ||'
                        '||
                        case
                            when piNombres is null then ''
                            else ' LOWER(TRANSLATE(u.nombres,''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) like ''%''|| LOWER(TRANSLATE('''|| piNombres ||''',''¡…Õ”⁄·ÈÌÛ˙'',''AEIOUaeiou'')) ||''%'' AND '
                        end
                        ||'
                        1 = 1)
                    )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_EXPORTAR_AVANZADO;
  
  PROCEDURE USP_SEL_REVISOR_VISUALIZAR(
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT * FROM T_GENM_USUARIO
    WHERE nvl(visualizar,'0') = '1' AND idRol = 2 AND idEstado = '1';
  END USP_SEL_REVISOR_VISUALIZAR;
  
  PROCEDURE USP_SEL_EMPRESA_USUARIO(
    piIdUsuario NUMBER,
    piCorreoElectronico VARCHAR2,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT usu.nombres, usu.correoElectronico, rol.rol, emp.nombreEmpresa, emp.nombreComercial
    FROM T_GENM_USUARIO usu
    INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON usu.idEmpresaIndustria = emp.idEmpresaIndustria
    INNER JOIN T_MAE_ROL rol ON usu.idRol = rol.idRol
    WHERE LOWER(TRANSLATE(usu.correoElectronico,'¡…Õ”⁄·ÈÌÛ˙','AEIOUaeiou')) = LOWER(TRANSLATE(piCorreoElectronico,'¡…Õ”⁄·ÈÌÛ˙','AEIOUaeiou')) OR usu.idUsuario = piIdUsuario;
  END USP_SEL_EMPRESA_USUARIO;
  
  PROCEDURE USP_SEL_ADMINISTRADOR(
    poRef OUT SYS_REFCURSOR
  )AS
  BEGIN
    OPEN poRef FOR
    SELECT nombres, correoElectronico, nombreEmpresa, nombreComercial
    FROM 
        (SELECT usu.nombres, usu.correoElectronico, emp.nombreEmpresa, emp.nombreComercial
        FROM T_GENM_USUARIO usu
        INNER JOIN T_GENM_EMPRESA_INDUSTRIA emp ON usu.idEmpresaIndustria = emp.idEmpresaIndustria
        WHERE usu.idRol = 1 AND usu.idEstado = '1' ORDER BY usu.idUsuario DESC) 
    WHERE ROWNUM = 1;
  END USP_SEL_ADMINISTRADOR;

END PKG_SISCEUSI_USUARIO;

/
