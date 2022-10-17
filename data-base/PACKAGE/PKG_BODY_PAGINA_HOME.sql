--------------------------------------------------------
-- Archivo creado  - martes-septiembre-13-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_SISCEUSI_PAGINA_HOME
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SISCEUSI"."PKG_SISCEUSI_PAGINA_HOME" AS

  PROCEDURE USP_PRC_BANNER(
    piIdBanner NUMBER,
    piTituloBanner VARCHAR2,
    piDescripcionBanner VARCHAR2,
    piDescripcionFija VARCHAR2,
    piTituloBoton VARCHAR2,
    piEnlaceBoton VARCHAR2,
    piNombreArchivoBanner VARCHAR2,
    piNombreArchivoGeneradoBanner VARCHAR2,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdBanner = -1 THEN
          vId := SQ_GENM_BANNER.NEXTVAL();
          INSERT INTO T_GENM_BANNER
          (idBanner, tituloBanner, descripcionBanner, descripcionFija, tituloBoton, enlaceBoton, nombreArchivoBanner, nombreArchivoGeneradoBanner, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
          VALUES 
          (vId, piTituloBanner, piDescripcionBanner, piDescripcionFija, piTituloBoton, piEnlaceBoton, piNombreArchivoBanner, piNombreArchivoGeneradoBanner, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
          UPDATE T_GENM_BANNER SET
          tituloBanner = piTituloBanner,
          descripcionBanner = piDescripcionBanner,
          descripcionFija = piDescripcionFija,
          tituloBoton = piTituloBoton,
          enlaceBoton = piEnlaceBoton,
          nombreArchivoBanner = piNombreArchivoBanner,
          nombreArchivoGeneradoBanner = piNombreArchivoGeneradoBanner,
          idEstado = piIdEstado,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idBanner = piIdBanner;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_BANNER;
  
  PROCEDURE USP_SEL_LIST_BANNER(
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
                    FROM T_GENM_BANNER ban
                    --WHERE 
                    --ban.idEstado = ''1'' 
                    ';
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
                        SELECT  ban.idBanner,
                                ban.tituloBanner,
                                ban.descripcionBanner,
                                ban.descripcionFija,
                                ban.tituloBoton,
                                ban.enlaceBoton,
                                ban.nombreArchivoBanner,
                                ban.idEstado,
                                ROW_NUMBER() OVER (ORDER BY ban.idBanner ASC) AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_BANNER ban
                        --WHERE 
                        --ban.idEstado = ''1''
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_LIST_BANNER;
  
  PROCEDURE USP_SEL_BANNER(
    piIdBanner NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_BANNER	 
    WHERE   idBanner = piIdBanner;
  END USP_SEL_BANNER;
  
  PROCEDURE USP_UPD_DESHABILITAR_BANNER(
    piIdBanner NUMBER,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GENM_BANNER SET
    idEstado = '0'
    WHERE idBanner = piIdBanner;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR_BANNER;
  
  PROCEDURE USP_PRC_PUBLICACION(
    piIdPublicacion NUMBER,
    piTituloPublicacion VARCHAR2,
    piDescripcionPublicacion VARCHAR2,
    piNombreArchivoPublicacion VARCHAR2,
    piNombreArchivoGeneradoPubli VARCHAR2,
    piLimiteCaracter NUMBER,
    piTextoEnlacePublicacion VARCHAR2,
    piEnlacePublicacion VARCHAR2,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdPublicacion = -1 THEN
          vId := SQ_GENM_PUBLICACION.NEXTVAL();
          INSERT INTO T_GENM_PUBLICACION
          (idPublicacion, tituloPublicacion, descripcionPublicacion, nombreArchivoPublicacion, nombreArchivoGeneradoPubli, limiteCaracter, textoEnlacePublicacion, enlacePublicacion, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
          VALUES 
          (vId, piTituloPublicacion, piDescripcionPublicacion, piNombreArchivoPublicacion, piNombreArchivoGeneradoPubli, piLimiteCaracter, piTextoEnlacePublicacion, piEnlacePublicacion, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
          UPDATE T_GENM_PUBLICACION SET
          tituloPublicacion = piTituloPublicacion,
          descripcionPublicacion = piDescripcionPublicacion,
          nombreArchivoPublicacion = piNombreArchivoPublicacion,
          nombreArchivoGeneradoPubli = piNombreArchivoGeneradoPubli,
          limiteCaracter = piLimiteCaracter,
          textoEnlacePublicacion = piTextoEnlacePublicacion,
          enlacePublicacion = piEnlacePublicacion,
          idEstado = piIdEstado,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idPublicacion = piIdPublicacion;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_PUBLICACION;
  
  PROCEDURE USP_SEL_LIST_PUBLICACION(
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
                    FROM T_GENM_PUBLICACION pub
                    --WHERE 
                    --pub.idEstado = ''1'' 
                    ';
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
                        SELECT  pub.idPublicacion,
                                pub.tituloPublicacion,
                                pub.descripcionPublicacion,
                                pub.nombreArchivoPublicacion,
                                pub.enlacePublicacion,
                                pub.idEstado,
                                ROW_NUMBER() OVER (ORDER BY pub.idPublicacion ASC) AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_PUBLICACION pub
                        --WHERE 
                        --pub.idEstado = ''1''
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_LIST_PUBLICACION;
  
  PROCEDURE USP_SEL_PUBLICACION(
    piIdPublicacion NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_PUBLICACION	 
    WHERE   idPublicacion = piIdPublicacion;
  END USP_SEL_PUBLICACION;
  
  PROCEDURE USP_UPD_DESHABILITAR_PUBLI(
    piIdPublicacion NUMBER,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GENM_PUBLICACION SET
    idEstado = '0'
    WHERE idPublicacion = piIdPublicacion;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR_PUBLI;
  
  PROCEDURE USP_PRC_ENLACE(
    piIdEnlace NUMBER,
    piTituloEnlace VARCHAR2,
    piDescripcionEnlace VARCHAR2,
    piIdEstado VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdEnlace = -1 THEN
          vId := SQ_GENM_ENLACE.NEXTVAL();
          INSERT INTO T_GENM_ENLACE
          (idEnlace, tituloEnlace, descripcionEnlace, idEstado, idUsuarioCreacion, fechaCreacion, ipCreacion)
          VALUES 
          (vId, piTituloEnlace, piDescripcionEnlace, piIdEstado, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
          UPDATE T_GENM_ENLACE SET
          tituloEnlace = piTituloEnlace,
          descripcionEnlace = piDescripcionEnlace,
          idEstado = piIdEstado,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idEnlace = piIdEnlace;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_ENLACE;
  
  PROCEDURE USP_SEL_LIST_ENLACE(
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
                    FROM T_GENM_ENLACE enl
                    --WHERE 
                    --enl.idEstado = ''1'' 
                    ';
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
                        SELECT  enl.idEnlace,
                                enl.tituloEnlace,
                                enl.descripcionEnlace,
                                enl.idEstado,
                                ROW_NUMBER() OVER (ORDER BY enl.idEnlace ASC) AS fila,'
                                || vTotalPaginas || ' AS totalPaginas,'
                                || vPaginaActual || ' AS pagina,'
                                || piRegistros || ' AS registros,'
                                || vTotalRegistros || ' AS totalRegistros
                        FROM T_GENM_ENLACE enl
                        --WHERE 
                        --enl.idEstado = ''1''
                        )
                    WHERE  fila BETWEEN ' || TO_CHAR(piRegistros * vPaginaInicial + 1) || ' AND ' || TO_CHAR(piRegistros * (vPaginaInicial + 1));

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_LIST_ENLACE;
  
  PROCEDURE USP_SEL_ENLACE(
    piIdEnlace NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_ENLACE
    WHERE   idEnlace = piIdEnlace;
  END USP_SEL_ENLACE;
  
  PROCEDURE USP_UPD_DESHABILITAR_ENLACE(
    piIdEnlace NUMBER,
    poRowAffected OUT NUMBER
  ) AS
  BEGIN
    UPDATE T_GENM_ENLACE SET
    idEstado = '0'
    WHERE idEnlace = piIdEnlace;
    poRowAffected := SQL%ROWCOUNT;
  END USP_UPD_DESHABILITAR_ENLACE;
  
  PROCEDURE USP_PRC_LOGO_RED_SOCIAL(
    piIdLogoRedSocial NUMBER,
    piNombreArchivoLogoWeb VARCHAR2,
    piNombreArchivoGeneradoLogoWeb VARCHAR2,
    piNombreArchivoLogoDgee VARCHAR2,
    piNombreArchivoGeneradoLogoD VARCHAR2,
    piEnlaceFacebook VARCHAR2,
    piEnlaceTwiter VARCHAR2,
    piEnlaceInstangram VARCHAR2,
    piEnlaceYoutube VARCHAR2,
    piEnlaceWhatsApp VARCHAR2,
    piEnlaceLinkedin VARCHAR2,
    piTituloNavegador VARCHAR2,
    piChatbot VARCHAR2,
    piIdUsuarioCreacion NUMBER,
    piIpCreacion VARCHAR2,
    poRowAffected OUT NUMBER
  ) AS
    vId NUMBER;
  BEGIN
    IF piIdLogoRedSocial = -1 THEN
          vId := SQ_GENM_LOGO_RED_SOCIAL.NEXTVAL();
          INSERT INTO T_GENM_LOGO_RED_SOCIAL
          (idLogoRedSocial, nombreArchivoLogoWeb, nombreArchivoGeneradoLogoWeb, nombreArchivoLogoDgee, nombreArchivoGeneradoLogoDgee, enlaceFacebook, enlaceTwiter, enlaceInstangram, enlaceYoutube, enlaceWhatsApp, enlaceLinkedin, tituloNavegador, chatbot, idUsuarioCreacion, fechaCreacion, ipCreacion)
          VALUES 
          (vId, piNombreArchivoLogoWeb, piNombreArchivoGeneradoLogoWeb, piNombreArchivoLogoDgee, piNombreArchivoGeneradoLogoD, piEnlaceFacebook, piEnlaceTwiter, piEnlaceInstangram, piEnlaceYoutube, piEnlaceWhatsApp, piEnlaceLinkedin, piTituloNavegador, piChatbot, piIdUsuarioCreacion, SYSDATE, piIpCreacion);
    ELSE
          UPDATE T_GENM_LOGO_RED_SOCIAL SET
          nombreArchivoLogoWeb = piNombreArchivoLogoWeb,
          nombreArchivoGeneradoLogoWeb = piNombreArchivoGeneradoLogoWeb,
          nombreArchivoLogoDgee = piNombreArchivoLogoDgee,
          nombreArchivoGeneradoLogoDgee = piNombreArchivoGeneradoLogoD,
          enlaceFacebook = piEnlaceFacebook,
          enlaceTwiter = piEnlaceTwiter,
          enlaceInstangram = piEnlaceInstangram,
          enlaceYoutube = piEnlaceYoutube,
          enlaceWhatsApp = piEnlaceWhatsApp,
          enlaceLinkedin = piEnlaceLinkedin,
          tituloNavegador = piTituloNavegador,
          chatbot = piChatbot,
          idUsuarioModificacion = piIdUsuarioCreacion,
          fechaModificacion = SYSDATE,
          ipModificacion = piIpCreacion
          WHERE idLogoRedSocial = piIdLogoRedSocial;
    END IF;
    poRowAffected := SQL%ROWCOUNT;
  END USP_PRC_LOGO_RED_SOCIAL;
  
  PROCEDURE USP_SEL_LOGO_RED_SOCIAL(
    --piIdLogoRedSocial NUMBER,
    poRef OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN poRef FOR
    SELECT *
    FROM T_GENM_LOGO_RED_SOCIAL;
    --WHERE   idLogoRedSocial = piIdLogoRedSocial;
  END USP_SEL_LOGO_RED_SOCIAL;
  
  PROCEDURE USP_SEL_LIST_ALL_BANNER(
    poRef OUT SYS_REFCURSOR
  ) AS
    vQuerySelect VARCHAR2(10000) := '';
  BEGIN
    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  ban.idBanner,
                                ban.tituloBanner,
                                ban.descripcionBanner,
                                ban.descripcionFija,
                                ban.tituloBoton,
                                ban.enlaceBoton,
                                ban.nombreArchivoBanner,
                                ban.nombreArchivoGeneradoBanner,
                                ROW_NUMBER() OVER (ORDER BY ban.idBanner ASC) AS fila
                        FROM T_GENM_BANNER ban
                        WHERE 
                        ban.idEstado = ''1''
                        )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_LIST_ALL_BANNER;
  
  PROCEDURE USP_SEL_LIST_ALL_PUBLICACION(
    poRef OUT SYS_REFCURSOR
  ) AS
    vQuerySelect VARCHAR2(10000) := '';
  BEGIN
    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  pub.idPublicacion,
                                pub.tituloPublicacion,
                                pub.descripcionPublicacion,
                                pub.nombreArchivoPublicacion,
                                pub.nombreArchivoGeneradoPubli,
                                pub.limiteCaracter,
                                pub.textoEnlacePublicacion,
                                pub.enlacePublicacion,
                                ROW_NUMBER() OVER (ORDER BY pub.idPublicacion ASC) AS fila
                        FROM T_GENM_PUBLICACION pub
                        WHERE 
                        pub.idEstado = ''1''
                        )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_LIST_ALL_PUBLICACION;
  
  PROCEDURE USP_SEL_LIST_ALL_ENLACE(
    poRef OUT SYS_REFCURSOR
  ) AS
    vQuerySelect VARCHAR2(10000) := '';
  BEGIN
    vQuerySelect :=  'SELECT * FROM
                        (
                        SELECT  enl.idEnlace,
                                enl.tituloEnlace,
                                enl.descripcionEnlace,
                                ROW_NUMBER() OVER (ORDER BY enl.idEnlace ASC) AS fila
                        FROM T_GENM_ENLACE enl
                        WHERE 
                        enl.idEstado = ''1''
                        )';

    OPEN poRef FOR vQuerySelect;
  END USP_SEL_LIST_ALL_ENLACE;

END PKG_SISCEUSI_PAGINA_HOME;

/
