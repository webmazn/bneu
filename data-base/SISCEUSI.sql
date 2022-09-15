CREATE SEQUENCE SISCEUSI.SQ_GENM_INTENCION_PARTICIPAR MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_EMPRESA_INDUSTRIA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 12 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_PLANTA_EMPRESA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_USUARIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_CAMPANA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_CAMPANA_EMPRESA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_CONTROL_ENCUESTA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 6 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_CAMPANA_ENCUESTA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 27 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_RESPUESTA_ENCUESTA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 21 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_RESP_ENCUESTA_PLANTA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_TABLA_MAESTRA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 21 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_ENCABEZADO_PRINCIPAL MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 87 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_ENCABEZADO_SECUNDARIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 223 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_RESP_ENCUESTA_TABLA MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_PARAMETRO MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 92 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GEND_ENCUESTA_COMENTARIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_BANNER MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_PUBLICACION MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_ENLACE MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SISCEUSI.SQ_GENM_LOGO_RED_SOCIAL MINVALUE 1 MAXVALUE 9999999999999999999999999999 START WITH 1 INCREMENT BY 1;
------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SISCEUSI.T_MAE_ROL(
idRol number,
rol varchar2(100),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint rol_pk primary key(idRol)
);

CREATE TABLE SISCEUSI.T_MAE_DEPARTAMENTO (
idDepartamento VARCHAR2(2),
departamento VARCHAR2(100),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint departamento_pk primary key(idDepartamento)
);

CREATE TABLE SISCEUSI.T_MAE_PROVINCIA (
idProvincia VARCHAR2(5),
provincia VARCHAR2(100),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint provincia_pk primary key(idProvincia)
);

CREATE TABLE SISCEUSI.T_MAE_DISTRITO (
idDistrito VARCHAR2(8),
distrito VARCHAR2(100),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint distrito_pk primary key(idDistrito)
);

CREATE TABLE SISCEUSI.T_MAE_ZONA(
idZona NUMBER,
zona VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT zona_pk PRIMARY KEY(idZona)
);

CREATE TABLE SISCEUSI.T_MAE_GIRO(
idGiro NUMBER,
giro VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT giro_pk PRIMARY KEY(idGiro)
);

CREATE TABLE SISCEUSI.T_MAE_GRUPO_EMPRESA(
idGrupoEmpresa NUMBER,
grupoEmpresa VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT grupo_empresa_pk PRIMARY KEY(idGrupoEmpresa)
);

CREATE TABLE SISCEUSI.T_MAE_CIUU(
idCiuu NUMBER,
ciuu VARCHAR2(400),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT ciuu_pk PRIMARY KEY(idCiuu)
);

CREATE TABLE SISCEUSI.T_MAE_EMPRESA_GAS(
idEmpresaGas NUMBER,
empresaGas VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT empresa_gas_pk PRIMARY KEY(idEmpresaGas)
);

CREATE TABLE SISCEUSI.T_MAE_EMPRESA_LUZ(
idEmpresaLuz NUMBER,
empresaLuz VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT empresa_luz_pk PRIMARY KEY(idEmpresaLuz)
);

CREATE TABLE SISCEUSI.T_MAE_TIPO_ENCUESTA(
idTipoEncuesta NUMBER,
tipoEncuesta VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT tipo_encuesta_pk PRIMARY KEY(idTipoEncuesta)
);

CREATE TABLE SISCEUSI.T_MAE_ETAPA(
idEtapa NUMBER,
etapa VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT etapa_pk PRIMARY KEY(idEtapa)
);

CREATE TABLE SISCEUSI.T_MAE_FASE(
idFase NUMBER,
fase VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT fase_pk PRIMARY KEY(idFase)
);

CREATE TABLE SISCEUSI.T_MAE_TIPO_DATO(
idTipoDato NUMBER,
tipoDato VARCHAR2(200),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT tipo_dato_pk PRIMARY KEY(idTipoDato)
);

CREATE TABLE SISCEUSI.T_GENM_INTENCION_PARTICIPAR(
idIntencionParticipar number,
ruc varchar2(11),
nombreEmpresa varchar2(200),
correoElectronico varchar2(100),
representanteLegal varchar2(100),
dni varchar2(8),
telefono varchar2(20),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint intencion_participar_pk primary key(idIntencionParticipar)
);

CREATE TABLE SISCEUSI.T_GENM_EMPRESA_INDUSTRIA(
idEmpresaIndustria NUMBER,
ruc VARCHAR2(11),
nombreEmpresa VARCHAR2(200),
nombreComercial VARCHAR2(200),
correoElectronico VARCHAR2(100), 
direccionFiscal varchar2(200),
representanteLegal VARCHAR2(100),
dni VARCHAR2(8),
telefono VARCHAR2(20),
idGiro NUMBER,
idGrupoEmpresa NUMBER,
idCiuu NUMBER,
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT empresa_pk PRIMARY KEY(idEmpresaIndustria),
CONSTRAINT giro_from_empresa_fk FOREIGN KEY (idGiro) REFERENCES T_MAE_GIRO(idGiro),
CONSTRAINT grupo_empresa_from_empresa_fk FOREIGN KEY (idGrupoEmpresa) REFERENCES T_MAE_GRUPO_EMPRESA(idGrupoEmpresa),
CONSTRAINT ciuu_from_empresa_fk FOREIGN KEY (idCiuu) REFERENCES T_MAE_CIUU(idCiuu)
);

CREATE TABLE SISCEUSI.T_GENM_PLANTA_EMPRESA(
idPlantaEmpresa NUMBER,
idEmpresaIndustria NUMBER,
idGiro NUMBER,
idCiuu NUMBER,
idDepartamento VARCHAR2(2),
idProvincia VARCHAR2(5), 
idDistrito VARCHAR2(8),
idZona NUMBER,
denominacion VARCHAR2(200),
direccion VARCHAR2(150),
telefono VARCHAR2(20),
latitud VARCHAR2(25),
longitud VARCHAR2(25),
numeroSuministroGas VARCHAR2(30),
numeroSuministroAlumbrado VARCHAR2(30),
idEmpresaGas NUMBER,
idEmpresaLuz NUMBER,
nombreArchivo VARCHAR2(200),
nombreArchivoGenerado VARCHAR2(50),
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT planta_empresa_pk PRIMARY KEY(idPlantaEmpresa),
CONSTRAINT empresa_from_planta_fk FOREIGN KEY (idEmpresaIndustria) REFERENCES T_GENM_EMPRESA_INDUSTRIA(idEmpresaIndustria),
CONSTRAINT departamento_from_planta_fk FOREIGN KEY (idDepartamento) REFERENCES T_MAE_DEPARTAMENTO(idDepartamento),
CONSTRAINT provincia_from_planta_fk FOREIGN KEY (idProvincia) REFERENCES T_MAE_PROVINCIA(idProvincia),
CONSTRAINT distrito_from_planta_fk FOREIGN KEY (idDistrito) REFERENCES T_MAE_DISTRITO(idDistrito),
CONSTRAINT giro_from_planta_fk FOREIGN KEY (idGiro) REFERENCES T_MAE_GIRO(idGiro),
CONSTRAINT ciuu_from_planta_fk FOREIGN KEY (idCiuu) REFERENCES T_MAE_CIUU(idCiuu)
);

CREATE TABLE SISCEUSI.T_GENM_USUARIO(
idUsuario number,
idEmpresaIndustria number,
idPlantaEmpresa number default 0,
idRol number,
nombres varchar2(100),
dni varchar2(8) unique,
telefono varchar2(20),
correoElectronico varchar2(100) unique,
password varchar2(100),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint usuario_pk primary key(idUsuario),
CONSTRAINT empresa_from_usuario_fk FOREIGN KEY (idEmpresaIndustria) REFERENCES T_GENM_EMPRESA_INDUSTRIA(idEmpresaIndustria),
CONSTRAINT rol_from_usuario_fk FOREIGN KEY (idRol) REFERENCES T_MAE_ROL(idRol)
);

CREATE TABLE SISCEUSI.T_GENM_CAMPANA(
idCampana NUMBER,
denominacion VARCHAR2(250),
fechaInicioPiloto DATE,
fechaFinPiloto DATE,
fechaInicioEncuesta DATE,
fechaFinEncuesta DATE,
observaciones VARCHAR2(2000),
idGiroPiloto NUMBER,
idCiuuPiloto NUMBER,
idGiroOficial NUMBER,
idCiuuOficial NUMBER,
idEtapaPiloto NUMBER,
idEtapaOficial NUMBER,
idSubSector NUMBER default 0,
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint campana_pk primary key(idCampana)
);

CREATE TABLE SISCEUSI.T_GEND_CAMPANA_EMPRESA(
idCampanaEmpresa NUMBER,
idCampana NUMBER,
idEmpresaIndustria NUMBER,
participarEnPiloto VARCHAR2(1),
participarEnOficial VARCHAR2(1),
idSupervisorPiloto NUMBER,
idSupervisorOficial NUMBER,
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint campana_empresa_pk primary key(idCampanaEmpresa)
);

CREATE TABLE SISCEUSI.T_GEND_CONTROL_ENCUESTA(
idControlEncuesta NUMBER,
idCampanaEmpresa NUMBER,
idPlantaEmpresa NUMBER,
idTipoEncuesta NUMBER,
idSupervisor NUMBER,
aceptaLLenarEncuesta VARCHAR2(1) DEFAULT '',
aceptaTratamientoDatos VARCHAR2(1) DEFAULT '',
aceptaFirmarEncuesta VARCHAR2(1) DEFAULT '',
idUsuarioResponde NUMBER,
fechaHoraLlenado DATE,
fechaObservacion DATE,
fechaRevision DATE,
idEtapa NUMBER,
idFase NUMBER DEFAULT 0,
idMetodoVerificacion NUMBER DEFAULT 0,
idValidezEntrevista NUMBER DEFAULT 0,
resultadoValidezEntrevista VARCHAR2(200),
numeroCuestionario NUMBER DEFAULT 0,
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint control_encuesta_pk primary key (idControlEncuesta),
constraint control_enc_camp_emp_fk FOREIGN KEY (idCampanaEmpresa) REFERENCES T_GEND_CAMPANA_EMPRESA (idCampanaEmpresa),
constraint control_enc_planta_fk FOREIGN KEY (idPlantaEmpresa) REFERENCES T_GENM_PLANTA_EMPRESA (idPlantaEmpresa),
constraint control_enc_tipo_enc_fk FOREIGN KEY (idTipoEncuesta) REFERENCES T_MAE_TIPO_ENCUESTA (idTipoEncuesta),
constraint control_enc_etapa_fk FOREIGN KEY (idEtapa) REFERENCES T_MAE_ETAPA (idEtapa)
);

CREATE TABLE SISCEUSI.T_GENM_CAMPANA_ENCUESTA(
idCampanaEncuesta NUMBER,
idCampana NUMBER,
pregunta VARCHAR2(500),
numeroOrdenPregunta NUMBER,
tituloSeccion VARCHAR2(300) default '',
titulo VARCHAR2(1) default '0',
separador VARCHAR2(1) default '0',
idTipoControl NUMBER,
idParametroTabla NUMBER,
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint campana_encuesta_pk primary key(idCampanaEncuesta),
CONSTRAINT camp_enc_from_campana_fk FOREIGN KEY (idCampana) REFERENCES T_GENM_CAMPANA(idCampana)
);

CREATE TABLE SISCEUSI.T_GEND_RESPUESTA_ENCUESTA(
idRespuestaEncuesta NUMBER,
idCampanaEncuesta NUMBER,
respuesta VARCHAR2(200),
numeroOrdenRespuesta NUMBER,
idValorRespuesta VARCHAR2(1),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint resp_enc_pk primary key(idRespuestaEncuesta),
CONSTRAINT resp_enc_from_camp_enc_fk FOREIGN KEY (idCampanaEncuesta) REFERENCES T_GENM_CAMPANA_ENCUESTA(idCampanaEncuesta)
);

CREATE TABLE SISCEUSI.T_GEND_RESP_ENCUESTA_PLANTA(
idRespuestaEncuestaPlanta NUMBER,
idControlEncuesta NUMBER,
idCampanaEncuesta NUMBER,
idRespuestaEncuesta NUMBER,
respuesta VARCHAR2(1000),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint resp_enc_planta_pk primary key (idRespuestaEncuestaPlanta),
constraint resp_enc_planta_ce_fk FOREIGN KEY (idControlEncuesta) REFERENCES T_GEND_CONTROL_ENCUESTA (idControlEncuesta),
constraint resp_enc_planta_camp_enc_fk FOREIGN KEY (idCampanaEncuesta) REFERENCES T_GENM_CAMPANA_ENCUESTA (idCampanaEncuesta)
);

CREATE TABLE SISCEUSI.T_GENM_TABLA_MAESTRA(
idTablaMaestra NUMBER,
subtitulo VARCHAR2(200),
descripcionIconoAyuda VARCHAR2(250),
preguntaInicial VARCHAR2(200),
preguntaCierre VARCHAR2(200),
idEstiloTabla NUMBER,
cantidadFilas NUMBER default 0,
agregarFilas VARCHAR2(1) default '0',
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint tabla_maestra_pk primary key(idTablaMaestra)
);

CREATE TABLE SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL(
idEncabezadoPrincipal NUMBER,
idTablaMaestra NUMBER,
tituloEncabezado VARCHAR2(200),
abreviacion VARCHAR2(20),
usarAbreviado VARCHAR2(1),
posicion NUMBER,
descripcionIconoAyuda VARCHAR2(250),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint encabezado_principal_pk primary key(idEncabezadoPrincipal),
CONSTRAINT encab_princ_from_tab_maest_fk FOREIGN KEY (idTablaMaestra) REFERENCES T_GENM_TABLA_MAESTRA(idTablaMaestra)
);

CREATE TABLE SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO(
idEncabezadoSecundario NUMBER,
idEncabezadoPrincipal NUMBER,
tituloEncabezado VARCHAR2(200),
abreviacion VARCHAR2(20),
usarAbreviado VARCHAR2(1),
posicion NUMBER,
idOrientacion NUMBER,
descripcionIconoAyuda VARCHAR2(250),
idTipoControl NUMBER,
idTipoDato NUMBER,
idParametro NUMBER,
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint encabezado_secundario_pk primary key(idEncabezadoSecundario),
CONSTRAINT encab_secun_from_enc_princ_fk FOREIGN KEY (idEncabezadoPrincipal) REFERENCES T_GEND_ENCABEZADO_PRINCIPAL(idEncabezadoPrincipal)
);

CREATE TABLE SISCEUSI.T_GEND_RESP_ENCUESTA_TABLA(
idRespuestaEncuestaTabla NUMBER,
idControlEncuesta NUMBER,
idEncabezadoSecundario NUMBER,
idParametro NUMBER,
filaTabla NUMBER,
respuesta VARCHAR2(1000),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint resp_enc_tabla_pk primary key (idRespuestaEncuestaTabla),
constraint resp_enc_tabla_ce_fk FOREIGN KEY (idControlEncuesta) REFERENCES T_GEND_CONTROL_ENCUESTA (idControlEncuesta),
constraint resp_enc_tabla_es_fk FOREIGN KEY (idEncabezadoSecundario) REFERENCES T_GEND_ENCABEZADO_SECUNDARIO (idEncabezadoSecundario)
);

CREATE TABLE SISCEUSI.T_GENM_PARAMETRO(
idParametro NUMBER,
parametro VARCHAR2(200),
idParentParametro NUMBER,
idTipoParametro NUMBER,
idEstado VARCHAR2(1) DEFAULT '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
CONSTRAINT parametro_pk PRIMARY KEY(idParametro)
);

CREATE TABLE SISCEUSI.T_GEND_ENCUESTA_COMENTARIO(
idEncuestaComentario NUMBER,
idControlEncuesta NUMBER,
idCampanaEncuesta NUMBER,
comentario VARCHAR2(4000),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint encuesta_coment_pk primary key (idEncuestaComentario)
);

CREATE TABLE SISCEUSI.T_GENM_BANNER(
idBanner NUMBER,
tituloBanner VARCHAR2(400),
descripcionBanner VARCHAR2(4000),
descripcionFija VARCHAR2(4000),
tituloBoton VARCHAR2(400),
enlaceBoton VARCHAR2(4000),
nombreArchivoBanner VARCHAR2(400),
nombreArchivoGeneradoBanner VARCHAR2(400),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint banner_coment_pk primary key (idBanner)
);

CREATE TABLE SISCEUSI.T_GENM_PUBLICACION(
idPublicacion NUMBER,
tituloPublicacion VARCHAR2(400),
descripcionPublicacion VARCHAR2(4000),
nombreArchivoPublicacion VARCHAR2(400),
nombreArchivoGeneradoPubli VARCHAR2(400),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint publicacion_pk primary key (idPublicacion)
);

CREATE TABLE SISCEUSI.T_GENM_ENLACE(
idEnlace NUMBER,
tituloEnlace VARCHAR2(400),
descripcionEnlace VARCHAR2(4000),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint enlace_pk primary key (idEnlace)
);

CREATE TABLE SISCEUSI.T_GENM_LOGO_RED_SOCIAL(
idLogoRedSocial NUMBER,
nombreArchivoLogoWeb VARCHAR2(400),
nombreArchivoGeneradoLogoWeb VARCHAR2(400),
nombreArchivoLogoDgee VARCHAR2(400),
nombreArchivoGeneradoLogoDgee VARCHAR2(400),
enlaceFacebook VARCHAR2(4000),
enlaceTwiter VARCHAR2(4000),
enlaceInstangram VARCHAR2(4000),
enlaceYoutube VARCHAR2(4000),
enlaceWhatsApp VARCHAR2(4000),
enlaceLinkedin VARCHAR2(4000),
idEstado varchar2(1) default '1',
idUsuarioCreacion number,
fechaCreacion date default sysdate,
ipCreacion varchar2(50),
idUsuarioModificacion number,
fechaModificacion date,
ipModificacion varchar2(50),
constraint logo_red_social_pk primary key (idLogoRedSocial)
);
------------------------------------------------------------------------------------------------------------------------------
--T_MAE_GIRO
INSERT INTO SISCEUSI.T_MAE_GIRO (idGiro, giro, idEstado) VALUES (1, 'Giro 1', '1');
INSERT INTO SISCEUSI.T_MAE_GIRO (idGiro, giro, idEstado) VALUES (2, 'Giro 2', '1');
INSERT INTO SISCEUSI.T_MAE_GIRO (idGiro, giro, idEstado) VALUES (3, 'Giro 3', '1');

--T_MAE_GRUPO_EMPRESA
INSERT INTO SISCEUSI.T_MAE_GRUPO_EMPRESA (idGrupoEmpresa, grupoEmpresa, idEstado) VALUES (1, 'Grupo 1', '1');
INSERT INTO SISCEUSI.T_MAE_GRUPO_EMPRESA (idGrupoEmpresa, grupoEmpresa, idEstado) VALUES (2, 'Grupo 2', '1');
INSERT INTO SISCEUSI.T_MAE_GRUPO_EMPRESA (idGrupoEmpresa, grupoEmpresa, idEstado) VALUES (3, 'Grupo 3', '1');

--T_MAE_CIUU
INSERT INTO SISCEUSI.T_MAE_CIUU (idCiuu, ciuu, idEstado) VALUES (1, 'Ciuu 1', '1');
INSERT INTO SISCEUSI.T_MAE_CIUU (idCiuu, ciuu, idEstado) VALUES (2, 'Ciuu 2', '1');
INSERT INTO SISCEUSI.T_MAE_CIUU (idCiuu, ciuu, idEstado) VALUES (3, 'Ciuu 3', '1');

--TABLA T_MAE_ROL
INSERT INTO SISCEUSI.T_MAE_ROL (idRol, rol, idEstado) VALUES (1, 'Administrador', '1');
INSERT INTO SISCEUSI.T_MAE_ROL (idRol, rol, idEstado) VALUES (2, 'Revisor', '1');
INSERT INTO SISCEUSI.T_MAE_ROL (idRol, rol, idEstado) VALUES (3, 'Encuestado', '1');

--T_MAE_ZONA
INSERT INTO SISCEUSI.T_MAE_ZONA (idZona, zona, idEstado) VALUES (1, 'Urbana', '1');
INSERT INTO SISCEUSI.T_MAE_ZONA (idZona, zona, idEstado) VALUES (2, 'Rural', '1');

--T_MAE_EMPRESA_GAS
INSERT INTO SISCEUSI.T_MAE_EMPRESA_GAS (idEmpresaGas, empresaGas, idEstado) VALUES (1, 'Cálidda', '1');
INSERT INTO SISCEUSI.T_MAE_EMPRESA_GAS (idEmpresaGas, empresaGas, idEstado) VALUES (2, 'Otros', '1');

--T_MAE_EMPRESA_LUZ
INSERT INTO SISCEUSI.T_MAE_EMPRESA_LUZ (idEmpresaLuz, empresaLuz, idEstado) VALUES (1, 'Luz del Sur', '1');
INSERT INTO SISCEUSI.T_MAE_EMPRESA_LUZ (idEmpresaLuz, empresaLuz, idEstado) VALUES (2, 'Edelnor', '1');
INSERT INTO SISCEUSI.T_MAE_EMPRESA_LUZ (idEmpresaLuz, empresaLuz, idEstado) VALUES (3, 'Electrocentro', '1');

--T_MAE__ETAPA
INSERT INTO SISCEUSI.T_MAE_ETAPA (idEtapa, etapa, idEstado) VALUES (1, 'Sin iniciar', '1');
INSERT INTO SISCEUSI.T_MAE_ETAPA (idEtapa, etapa, idEstado) VALUES (2, 'Iniciado', '1');
INSERT INTO SISCEUSI.T_MAE_ETAPA (idEtapa, etapa, idEstado) VALUES (3, 'Finalizado', '1');

--T_MAE_FASE
INSERT INTO SISCEUSI.T_MAE_FASE (idFase, fase, idEstado) VALUES (0, 'En espera', '1');
INSERT INTO SISCEUSI.T_MAE_FASE (idFase, fase, idEstado) VALUES (1, 'En progreso', '1');
INSERT INTO SISCEUSI.T_MAE_FASE (idFase, fase, idEstado) VALUES (2, 'Enviado', '1');
INSERT INTO SISCEUSI.T_MAE_FASE (idFase, fase, idEstado) VALUES (3, 'Observado', '1');
INSERT INTO SISCEUSI.T_MAE_FASE (idFase, fase, idEstado) VALUES (4, 'Subsanación enviada', '1');
INSERT INTO SISCEUSI.T_MAE_FASE (idFase, fase, idEstado) VALUES (5, 'Revisado', '1');

--T_MAE_EMPRESA_TIPO_ENCUESTA
INSERT INTO SISCEUSI.T_MAE_TIPO_ENCUESTA (idTipoEncuesta, tipoEncuesta, idEstado) VALUES (1, 'Piloto', '1');
INSERT INTO SISCEUSI.T_MAE_TIPO_ENCUESTA (idTipoEncuesta, tipoEncuesta, idEstado) VALUES (2, 'Oficial', '1');

--T_MAE_TIPO_DATO
INSERT INTO SISCEUSI.T_MAE_TIPO_DATO (idTipoDato, tipoDato, idEstado) VALUES (1, 'Number', '1');
INSERT INTO SISCEUSI.T_MAE_TIPO_DATO (idTipoDato, tipoDato, idEstado) VALUES (2, 'Float', '1');
INSERT INTO SISCEUSI.T_MAE_TIPO_DATO (idTipoDato, tipoDato, idEstado) VALUES (3, 'String', '1');
--
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (1, 1, 1, 1, '20999999999', 'Ministerio de Energías y Minas', 'minem@gmail.com', 'Av Javier Prado 2563', 'Jhon Matos Guerra', '78958749', '959365203', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (2, 2, 2, 2, '20888888888', 'Repsol S.A.', 'repsol@gmail.com', 'Av Argentina 2563', 'Mario Gonzales Paredes', '42567415', '987512369', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (3, 1, 2, 3, '20777777777', 'Petro Perú S.A.', 'petroperu@gmail.com', 'Av México 1256', 'Jesus Perez Cuellar', '38741258', '996548523', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (4, 2, 1, 1, '20666666666', 'Altaminas S.A.', 'altaminas@gmail.com', 'Av Manco Capac 3247', 'Isabel Lima Torres', '54782498', '998567855', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (5, 3, 1, 2, '20555555555', 'Primax S.A.', 'primax@gmail.com', 'Av Abancay 3485', 'Pedro Martinez Hidalgo', '44256851', '912378854', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (6, 2, 3, 3, '20444444444', 'Cementos Andina S.A.', 'cementoandina@gmail.com', 'Av Arequipa 4253', 'Ana Jara Nolasco', '67852413', '998775620', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (7, 1, 1, 2, '20333333333', 'Cementos Sol S.A.', 'cementosol@gmail.com', 'Av Wilson 2752', 'Victor Mendoza Nieto', '31027855', '945669774', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (8, 1, 1, 2, '20222222222', 'Pirámide S.A.', 'piramide@gmail.com', 'Av Arenales 1985', 'Raul Gomez Aranda', '63675622', '932155631', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (9, 1, 1, 2, '20111111111', 'Metro S.A.', 'metro@gmail.com', 'Av Arenales 3584', 'Susana Velez Blanco', '29645218', '954388746', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (10, 1, 1, 2, '20000000000', 'Plaza Vea S.A.', 'plazavea@gmail.com', 'Av Canadá 4896', 'David Paredes Lopez', '34487965', '978426371', '1');
INSERT INTO SISCEUSI.T_GENM_EMPRESA_INDUSTRIA (idEmpresaIndustria, idGiro, idGrupoEmpresa, idCiuu, ruc, nombreEmpresa, correoElectronico, direccionFiscal, representanteLegal, dni, telefono, idEstado)
VALUES (11, 1, 1, 2, '20911111111', 'Tottus S.A.', 'tottus@gmail.com', 'Av Bolivia 145', 'Jorge Quispe Espinoza', '55697412', '965742855', '1');

--TABLA T_GENM_USUARIO
INSERT INTO SISCEUSI.T_GENM_USUARIO (idUsuario, idEmpresaIndustria, idRol, nombres, dni, correoElectronico, password, idEstado)
VALUES (1, 1, 1, 'Carlos Galdos', '80706050', 'carlos@gmail.com', 'AKmJ0HcmIkZrojOXM1ABOtqfi9hhaf/tUBCTT+R4LAlKf76X0QxqmOhAVMDwoUCSiQ==', '1');

--T_MAE_DEPARTAMENTO
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('01', 'AMAZONAS');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('02', 'ANCASH');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('03', 'APURIMAC');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('04', 'AREQUIPA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('05', 'AYACUCHO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('06', 'CAJAMARCA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('07', 'CALLAO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('08', 'CUSCO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('09', 'HUANCAVELICA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('10', 'HUANUCO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('11', 'ICA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('12', 'JUNIN');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('13', 'LA LIBERTAD');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('14', 'LAMBAYEQUE');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('15', 'LIMA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('16', 'LORETO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('17', 'MADRE DE DIOS');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('18', 'MOQUEGUA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('19', 'PASCO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('20', 'PIURA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('21', 'PUNO');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('22', 'SAN MARTIN');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('23', 'TACNA');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('24', 'TUMBES');
INSERT INTO SISCEUSI.T_MAE_DEPARTAMENTO (idDepartamento, departamento) VALUES ('25', 'UCAYALI');

--T_MAE_PROVINCIA 
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0101', 'CHACHAPOYAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0102', 'BAGUA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0103', 'BONGARA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0104', 'CONDORCANQUI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0105', 'LUYA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0106', 'RODRIGUEZ DE MENDOZA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0107', 'UTCUBAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0201', 'HUARAZ');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0202', 'AIJA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0203', 'ANTONIO RAYMONDI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0204', 'ASUNCION');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0205', 'BOLOGNESI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0206', 'CARHUAZ');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0207', 'CARLOS F.FITZCARRALD');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0208', 'CASMA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0209', 'CORONGO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0210', 'HUARI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0211', 'HUARMEY');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0212', 'HUAYLAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0213', 'MARISCAL LUZURIAGA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0214', 'OCROS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0215', 'PALLASCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0216', 'POMABAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0217', 'RECUAY');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0218', 'SANTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0219', 'SIHUAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0220', 'YUNGAY');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0301', 'ABANCAY');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0302', 'ANDAHUAYLAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0303', 'ANTABAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0304', 'AYMARAES');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0305', 'COTABAMBAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0306', 'CHINCHEROS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0307', 'GRAU');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0401', 'AREQUIPA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0402', 'CAMANA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0403', 'CARAVELI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0404', 'CASTILLA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0405', 'CAYLLOMA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0406', 'CONDESUYOS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0407', 'ISLAY');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0408', 'LA UNION');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0501', 'HUAMANGA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0502', 'CANGALLO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0503', 'HUANCA SANCOS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0504', 'HUANTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0505', 'LA MAR');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0506', 'LUCANAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0507', 'PARINACOCHAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0508', 'PAUCAR DEL SARA SARA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0509', 'SUCRE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0510', 'VICTOR FAJARDO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0511', 'VILCAS HUAMAN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0601', 'CAJAMARCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0602', 'CAJABAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0603', 'CELENDIN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0604', 'CHOTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0605', 'CONTUMAZA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0606', 'CUTERVO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0607', 'HUALGAYOC');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0608', 'JAEN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0609', 'SAN IGNACIO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0610', 'SAN MARCOS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0611', 'SAN MIGUEL');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0612', 'SAN PABLO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0613', 'SANTA CRUZ');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0701', 'CALLAO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0801', 'CUSCO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0802', 'ACOMAYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0803', 'ANTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0804', 'CALCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0805', 'CANAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0806', 'CANCHIS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0807', 'CHUMBIVILCAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0808', 'ESPINAR');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0809', 'LA CONVENCION');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0810', 'PARURO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0811', 'PAUCARTAMBO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0812', 'QUISPICANCHI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0813', 'URUBAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0901', 'HUANCAVELICA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0902', 'ACOBAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0903', 'ANGARAES');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0904', 'CASTROVIRREYNA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0905', 'CHURCAMPA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0906', 'HUAYTARA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('0907', 'TAYACAJA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1001', 'HUANUCO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1002', 'AMBO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1003', 'DOS DE MAYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1004', 'HUACAYBAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1005', 'HUAMALIES');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1006', 'LEONCIO PRADO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1007', 'MARAON');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1008', 'PACHITEA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1009', 'PUERTO INCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1010', 'LAURICOCHA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1011', 'YAROWILCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1101', 'ICA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1102', 'CHINCHA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1103', 'NAZCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1104', 'PALPA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1105', 'PISCO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1201', 'HUANCAYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1202', 'CONCEPCION');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1203', 'CHANCHAMAYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1204', 'JAUJA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1205', 'JUNIN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1206', 'SATIPO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1207', 'TARMA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1208', 'YAULI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1209', 'CHUPACA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1301', 'TRUJILLO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1302', 'ASCOPE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1303', 'BOLIVAR');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1304', 'CHEPEN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1305', 'JULCAN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1306', 'OTUZCO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1307', 'PACASMAYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1308', 'PATAZ');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1309', 'SANCHEZ CARRION');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1310', 'SANTIAGO DE CHUCO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1311', 'GRAN CHIMU');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1312', 'VIRU');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1401', 'CHICLAYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1402', 'FERREAFE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1403', 'LAMBAYEQUE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1501', 'LIMA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1502', 'BARRANCA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1503', 'CAJATAMBO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1504', 'CANTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1505', 'CAÑETE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1506', 'HUARAL');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1507', 'HUAROCHIRI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1508', 'HUAURA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1509', 'OYON');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1510', 'YAUYOS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1601', 'MAYNAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1602', 'ALTO AMAZONAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1603', 'LORETO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1604', 'MARISCAL RAMON CASTILLA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1605', 'REQUENA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1606', 'UCAYALI');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1701', 'TAMBOPATA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1702', 'MANU');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1703', 'TAHUAMANU');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1801', 'MARISCAL NIETO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1802', 'GRAL.SANCHEZ CERRO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1803', 'ILO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1901', 'PASCO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1902', 'DANIEL ALCIDES CARRION');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('1903', 'OXAPAMPA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2001', 'PIURA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2002', 'AYABACA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2003', 'HUANCABAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2004', 'MORROPON');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2005', 'PAITA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2006', 'SULLANA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2007', 'TALARA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2008', 'SECHURA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2101', 'PUNO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2102', 'AZANGARO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2103', 'CARABAYA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2104', 'CHUCUITO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2105', 'EL COLLAO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2106', 'HUANCANE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2107', 'LAMPA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2108', 'MELGAR');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2109', 'MOHO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2110', 'SAN ANTONIO DE PUTINA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2111', 'SAN ROMAN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2112', 'SANDIA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2113', 'YUNGUYO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2201', 'MOYOBAMBA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2202', 'BELLAVISTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2203', 'EL DORADO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2204', 'HUALLAGA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2205', 'LAMAS');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2206', 'MARISCAL CACERES');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2207', 'PICOTA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2208', 'RIOJA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2209', 'SAN MARTIN');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2210', 'TOCACHE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2301', 'TACNA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2302', 'CANDARAVE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2303', 'JORGE BASADRE');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2304', 'TARATA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2401', 'TUMBES');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2402', 'CONTRALMIRANTE VILLAR');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2403', 'ZARUMILLA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2501', 'CORONEL PORTILLO');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2502', 'ATALAYA');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2503', 'PADRE ABAD');
INSERT INTO SISCEUSI.T_MAE_PROVINCIA (idProvincia, provincia) VALUES ('2504', 'PURUS');

--T_MAE_DISTRITO
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020902', 'ACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020901', 'CORONGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020907', 'YUPAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020906', 'YANAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020905', 'LA PAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131203', 'GUADALUPITO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021601', 'POMABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021302', 'CASCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021209', 'SANTO TORIBIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021301', 'PISCOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021208', 'SANTA CRUZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021308', 'MUSGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021204', 'HUAYLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021602', 'HUAYLLAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021305', 'LLAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022008', 'YANAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021307', 'LUCMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021205', 'MATO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021306', 'LLUMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020703', 'YAUYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021201', 'CARAZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021808', 'SANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020701', 'SAN LUIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021806', 'NEPEA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021203', 'HUATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022001', 'YUNGAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021809', 'NUEVO CHIMBOTE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021803', 'COISHCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020305', 'MIRGAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020402', 'ACOCHACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021207', 'PUEBLO LIBRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020609', 'SHILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022004', 'MATACOTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020401', 'CHACAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022006', 'RANRAHIRCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022003', 'MANCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021016', 'UCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020302', 'ACZO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021003', 'CAJAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020306', 'SAN JUAN DE RONTOY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021001', 'HUARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021807', 'SAMANCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022007', 'SHUPLUY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020603', 'AMASHCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020601', 'CARHUAZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020801', 'CASMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022002', 'CASCAPARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('022005', 'QUILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020605', 'ATAQUERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020606', 'MARCARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020610', 'TINCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020802', 'BUENA VISTA ALTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020602', 'ACOPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021009', 'MASIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020608', 'SAN MIGUEL DE ACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020604', 'ANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021012', 'RAHUAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021007', 'HUACHIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020607', 'PARIAHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020803', 'COMANDANTE NOEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020112', 'TARICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020611', 'YUNGAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020105', 'INDEPENDENCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020106', 'JANGAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020102', 'COCHABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021202', 'HUALLANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020111', 'PIRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020110', 'PARIACOTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020804', 'YAUTAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021802', 'CACERES DEL PERU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021206', 'PAMPAROMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021910', 'SICSIBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020904', 'CUSCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021908', 'RAGASH');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021906', 'HUAYLLABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021909', 'SAN JUAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021008', 'HUANTAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020101', 'HUARAZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021004', 'CHAVIN DE HUANTAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020108', 'OLLEROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020204', 'LA MERCED');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021710', 'TICAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021701', 'RECUAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020104', 'HUANCHAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021103', 'CULEBRAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020202', 'CORIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100321', 'SHUNQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020201', 'AIJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020203', 'HUACLLAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020205', 'SUCCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021101', 'HUARMEY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021104', 'HUAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021703', 'COTAPARACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021105', 'MALVAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100110', 'YARUMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021102', 'COCHAPETI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021709', 'TAPACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100111', 'PILLCO MARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100108', 'SAN PEDRO DE CHAULAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100107', 'SAN FRANCISCO DE CAYRAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021708', 'PARARIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021707', 'PAMPAS CHICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100205', 'HUACAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101004', 'QUEROPALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100202', 'CAYNA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020505', 'CAJACAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020503', 'ANTONIO RAYMONDI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020515', 'TICLLOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020513', 'PACLLON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020514', 'SAN MIGUEL DE CORPANQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100206', 'SAN FRANCISCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021403', 'CAJAMARQUILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020511', 'LA PRIMAVERA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020512', 'MANGAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150302', 'COPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190204', 'PAUCAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020506', 'CANIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190206', 'SANTA ANA DE TUSI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150202', 'PARAMONGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021407', 'LLIPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021408', 'SAN CRISTOBAL DE RAJAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190207', 'TAPUC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190106', 'PALLANCHACRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190205', 'SAN PEDRO DE PILLAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021410', 'SANTIAGO DE CHILCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190103', 'HUARIACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021402', 'ACAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190201', 'YANAHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150901', 'OYON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021404', 'CARHUAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190108', 'SAN FRANCISCO DE ASIS DE YARUSYACAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150304', 'HUANCAPON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190208', 'VILCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190113', 'YANACANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150203', 'PATIVILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021405', 'COCHAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150305', 'MANAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150303', 'GORGOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190109', 'SIMON BOLIVAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150802', 'AMBAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190105', 'NINACACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190107', 'PAUCARTAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120108', 'CHONGOS ALTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151013', 'HUAMPARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120105', 'CHACAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120120', 'HUASICANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120104', 'CARHUACALLANGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090703', 'ACRAQUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151001', 'YAUYOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090107', 'HUAYLLAHUARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151016', 'HUANTAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090115', 'PILCHACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090112', 'MOYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151022', 'OMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090105', 'CUENCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090411', 'SANTA ANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151005', 'AZANGARO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110209', 'SAN PEDRO DE HUACARPANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150507', 'IMPERIAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110203', 'CHAVIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090402', 'ARMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150514', 'SAN LUIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090408', 'HUAMATAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090412', 'TANTARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150501', 'SAN VICENTE DE CAETE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110208', 'SAN JUAN DE YANAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090407', 'HUACHOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090714', 'SALCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090709', 'HUARIBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090713', 'QUISHUAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090502', 'ANCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090507', 'PAUCARBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090202', 'ANDABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090206', 'PAUCARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090504', 'EL CARMEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090506', 'LOCROJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090208', 'ROSARIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090117', 'YAULI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090201', 'ACOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120432', 'TUNAN MARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150716', 'SAN ANTONIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150719', 'SAN JUAN DE IRIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150722', 'SAN MATEO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120429', 'SAN PEDRO DE CHUNAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150701', 'MATUCANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120406', 'CURICACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120424', 'PANCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120415', 'MARCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150724', 'SAN PEDRO DE CASTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120412', 'JULCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120417', 'MASMA CHICCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120411', 'JANJAILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030212', 'SAN ANTONIO DE CACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050302', 'CARAPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110109', 'SAN JOSE DE LOS MOLINOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051006', 'CAYARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090611', 'SAN FRANCISCO DE SANGAYAICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110505', 'PARACAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050902', 'BELEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051102', 'ACCOMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050301', 'SANCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030415', 'TINTAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030405', 'COLCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110114', 'YAUCA DEL ROSARIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180302', 'EL ALGARROBAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180301', 'ILO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230408', 'TICACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081306', 'OLLANTAYTAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110113', 'TATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110111', 'SANTIAGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021210', 'YURACMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120701', 'TARMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040118', 'SAN JUAN DE SIGUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050605', 'CHAVIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050109', 'SAN JOSE DE TICLLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050111', 'SANTIAGO DE PISCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060108', 'LOS BAOS DEL INCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030403', 'CARAYBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160114', 'TENIENTE MANUEL CLAVERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160109', 'PUTUMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200101', 'PIURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200104', 'CASTILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200105', 'CATACAOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200110', 'LA UNION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200109', 'LA ARENA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200107', 'CURA MORI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200108', 'EL TALLAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200803', 'BERNAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200401', 'CHULUCANAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090601', 'HUAYTARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090615', 'SANTO DOMINGO DE CAPILLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090604', 'HUAYACUNDO ARMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110504', 'INDEPENDENCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030401', 'CHALHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090614', 'SANTIAGO DE QUIRAHUARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090608', 'QUERCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090603', 'CORDOVA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110403', 'RIO GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050612', 'OCAA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050613', 'OTOCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050609', 'LEONCIO PRADO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050701', 'CORACORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210710', 'VILAVILA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050706', 'PUYUSCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080802', 'CONDOROMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210606', 'ROSASPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040803', 'CHARCANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040406', 'CHOCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040311', 'LOMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210202', 'ACHAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040302', 'ACARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210903', 'HUAYRAPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210704', 'NICASIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210701', 'LAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050807', 'PARARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060306', 'JOSE GALVEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060305', 'JORGE CHAVEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220708', 'SHAMBOYACU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060310', 'SUCRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220706', 'SAN CRISTOBAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160602', 'INAHUAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220404', 'PISCOYACU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130305', 'UCHUMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060308', 'OXAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130304', 'LONGOTEA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220203', 'BAJO BIAVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061007', 'JOSE SABOGAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130809', 'PATAZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240103', 'LA CRUZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240104', 'PAMPAS DE HOSPITAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240106', 'SAN JUAN DE LA VIRGEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240201', 'ZORRITOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200705', 'LOS ORGANOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200706', 'MANCORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200702', 'EL ALTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200704', 'LOBITOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200701', 'PARIAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200703', 'LA BREA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200507', 'VICHAYAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200503', 'ARENAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200502', 'AMOTAPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010607', 'MARISCAL BENAVIDES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010312', 'YAMBRASBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010304', 'COROSHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080902', 'ECHARATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021801', 'CHIMBOTE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080906', 'QUELLOUNO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150106', 'CARABAYLLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150132', 'SAN JUAN DE LURIGANCHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150137', 'SANTA ANITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150505', 'CHILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150730', 'SANTIAGO DE TUNA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150109', 'CIENEGUILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110303', 'EL INGENIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110302', 'CHANGUILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210207', 'JOSE DOMINGO CHOQUEHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040517', 'TISCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100603', 'HERMILIO VALDIZAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100505', 'JIRCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100507', 'MONZON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100605', 'LUYANDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100602', 'DANIEL ALOMIAS ROBLES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100510', 'SINGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100511', 'TANTAMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100606', 'MARIANO DAMASO BERAUN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100902', 'CODO DEL POZUZO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100109', 'SANTA MARIA DEL VALLE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100804', 'UMARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100801', 'PANAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090607', 'PILPICHACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050110', 'SAN JUAN BAUTISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050104', 'CARMEN ALTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050105', 'CHIARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050205', 'PARAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050202', 'CHUSCHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050203', 'LOS MOROCHUCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051108', 'VISCHONGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030601', 'CHINCHEROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051104', 'CONCEPCION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030602', 'ANCO_HUALLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050204', 'MARIA PARADO DE BELLIDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160110', 'TORRES CAUSANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160107', 'NAPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160303', 'TIGRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160304', 'TROMPETEROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160106', 'MAZAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160102', 'ALTO NANAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160209', 'PASTAZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160208', 'MORONA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160402', 'PEBAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060903', 'HUARANGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060906', 'SAN JOSE DE LOURDES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211209', 'ALTO INAMBARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211208', 'YANAHUAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081203', 'CAMANTI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081101', 'PAUCARTAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081205', 'CCATCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081210', 'OCONGATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081212', 'QUIQUIJANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210305', 'CORANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080204', 'MOSOC LLACTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030506', 'CHALLHUAHUACHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030706', 'MICAELA BASTIDAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030712', 'VILCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080508', 'TUPAC AMARU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030104', 'CURAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021901', 'SIHUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040208', 'SAMUEL PASTOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211005', 'SINA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150713', 'MARIATANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021705', 'LLACLLIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160403', 'YAVARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040603', 'CAYARANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090119', 'HUANDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090111', 'MARISCAL CACERES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090103', 'ACORIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080701', 'SANTO TOMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190202', 'CHACAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050303', 'SACSAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040505', 'CAYLLOMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090405', 'CHUPAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060307', 'MIGUEL IGLESIAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040125', 'VITOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060410', 'LAJAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090118', 'ASCENSION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090102', 'ACOBAMBILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060804', 'COLASAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060805', 'HUABAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060806', 'LAS PIRIAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060801', 'JAEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090701', 'PAMPAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150201', 'BARRANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190101', 'CHAUPIMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150204', 'SUPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021706', 'MARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021704', 'HUAYLLAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020109', 'PAMPAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020103', 'COLCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021702', 'CATAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020504', 'AQUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020501', 'CHIQUIAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020507', 'COLQUIOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230404', 'ESTIQUE-PAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230109', 'SAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021401', 'OCROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021409', 'SAN PEDRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100317', 'RIPAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190203', 'GOYLLARISQUIZGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150301', 'CAJATAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020502', 'ABELARDO PARDO LEZAMETA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190111', 'TINYAHUARCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190104', 'HUAYLLAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150905', 'NAVAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150906', 'PACHANGARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150904', 'COCHAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150205', 'SUPE PUERTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190112', 'VICCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120502', 'CARHUAMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150804', 'CHECRAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150809', 'SANTA LEONOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150812', 'VEGUETA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150808', 'PACCHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150806', 'HUAURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120503', 'ONDORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120501', 'JUNIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120708', 'SAN PEDRO DE CAJAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150807', 'LEONCIO PRADO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150608', 'PACARAOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150612', 'VEINTISIETE DE NOVIEMBRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150610', 'STA.CRUZ DE ANDAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120807', 'SANTA BARBARA DE CARHUACAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150803', 'CALETA DE CARQUIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150606', 'IHUARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150607', 'LAMPIAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120707', 'PALCAMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150602', 'ATAVILLOS ALTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120804', 'MARCAPOMACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150601', 'HUARAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150609', 'SAN MIGUEL DE ACOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150603', 'ATAVILLOS BAJO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150404', 'HUAROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150611', 'SUMBILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120806', 'PACCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061001', 'PEDRO GALVEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061006', 'JOSE MANUEL QUIROZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250101', 'CALLERIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061005', 'ICHOCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061002', 'CHANCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061003', 'EDUARDO VILLANUEVA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130302', 'BAMBAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060203', 'CONDEBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160603', 'PADRE MARQUEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150127', 'PUNTA NEGRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150126', 'PUNTA HERMOSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150119', 'LURIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050616', 'SAN JUAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050615', 'SAN CRISTOBAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050621', 'SANTA LUCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110301', 'NAZCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050708', 'UPAHUACHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050617', 'SAN PEDRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050614', 'SAISA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110305', 'VISTA ALEGRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050704', 'PACAPAUSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050707', 'SAN FRANCISCO DE RAVACAYCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210603', 'HUATASANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050808', 'SAN JAVIER DE ALPABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120607', 'RIO NEGRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120601', 'SATIPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120604', 'MAZAMARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170302', 'IBERIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120602', 'COVIRIALI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170202', 'FITZCARRALD');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120606', 'PANGOA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170303', 'TAHUAMANU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120603', 'LLAYLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170103', 'LAS PIEDRAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170201', 'MANU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170203', 'MADRE DE DIOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050402', 'AYAHUANCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130503', 'CARABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130611', 'SALPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130606', 'LA CUESTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130610', 'PARANDAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131201', 'VIRU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130109', 'SALAVERRY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130106', 'LAREDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130102', 'EL PORVENIR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130105', 'LA ESPERANZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130104', 'HUANCHACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130101', 'TRUJILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130107', 'MOCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150406', 'SAN BUENAVENTURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150605', 'CHANCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120805', 'MOROCOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150401', 'CANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120403', 'APATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120418', 'MOLINOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120703', 'HUARICOLCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120427', 'RICRAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120801', 'LA OROYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150712', 'LARAOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150708', 'HUANZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120808', 'SANTA ROSA DE SACCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150405', 'LACHAQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120426', 'POMACANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120209', 'MARISCAL CASTILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120205', 'COCHAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150704', 'CARAMPOMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150705', 'CHICLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120402', 'ACOLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120810', 'YAULI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150402', 'ARAHUAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120433', 'YAULI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150707', 'HUACHUPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120422', 'PACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120803', 'HUAY-HUAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120802', 'CHACAPALPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101107', 'PAMPAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101002', 'BAOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101106', 'OBAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120705', 'LA UNION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120702', 'ACOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120709', 'TAPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150811', 'SAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150810', 'SANTA MARIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150801', 'HUACHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100322', 'SILLAPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100301', 'LA UNION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100307', 'CHUQUIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100323', 'YANAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101102', 'CAHUAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021903', 'ALFONSO UGARTE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021603', 'PAROBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021604', 'QUINUABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021304', 'FIDEL OLIVAS ESCUDERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021303', 'ELEAZAR GUZMAN BARRON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020702', 'SAN NICOLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020303', 'CHACCHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021006', 'HUACCHIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021013', 'RAPAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021002', 'ANRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021005', 'HUACACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021011', 'PONTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021015', 'SAN PEDRO DE CHANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021014', 'SAN MARCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101101', 'CHAVINILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021907', 'QUICHES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101105', 'JACAS CHICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100106', 'QUISQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100101', 'HUANUCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100102', 'AMARILIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100204', 'CONCHAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100208', 'TOMAY KICHWA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100201', 'AMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100207', 'SAN RAFAEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190110', 'TICLACAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190102', 'HUACHON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190302', 'CHONTABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120504', 'ULCUMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120206', 'COMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061111', 'SAN SILVESTRE DE COCHAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061101', 'SAN MIGUEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061105', 'EL PRADO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061113', 'UNION AGUA BLANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060103', 'CHETILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061203', 'SAN LUIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061202', 'SAN BERNARDINO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060109', 'MAGDALENA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060507', 'TANTARICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060502', 'CHILETE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060112', 'SAN JUAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060506', 'SANTA CRUZ DE TOLED');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060504', 'GUZMANGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060107', 'LLACANORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060102', 'ASUNCION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020301', 'LLAMELLIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021010', 'PAUCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020508', 'HUALLANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100316', 'QUIVILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101104', 'APARICIO POMARES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100311', 'MARIAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120301', 'CHANCHAMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120704', 'HUASAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120419', 'MONOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061102', 'BOLIVAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131005', 'MOLLEPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021506', 'LACABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021905', 'CHINGALPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021501', 'CABANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120410', 'HUERTAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120405', 'CANCHAYLLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120408', 'HUAMALI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120416', 'MASMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120809', 'SUITUCANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120401', 'JAUJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150728', 'SANTA EULALIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150723', 'SAN MATEO DE OTAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120414', 'LLOCLLAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120434', 'YAUYOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150703', 'CALLAHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120404', 'ATAURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120425', 'PARCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120430', 'SAUSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150732', 'SURCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120428', 'SAN LORENZO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120407', 'EL MANTARO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120122', 'INGENIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120409', 'HUARIPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120421', 'MUQUIYAUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120127', 'QUICHUAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120207', 'HEROINAS TOLEDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120420', 'MUQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120128', 'QUILCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120423', 'PACCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120413', 'LEONOR ORDOEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150718', 'SAN DAMIAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120215', 'SANTA ROSA DE OCOPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120210', 'MATAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150717', 'SAN BARTOLOME');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120431', 'SINCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120114', 'EL TAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120212', 'NUEVE DE JULIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150709', 'HUAROCHIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120201', 'CONCEPCION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150720', 'SAN JUAN DE TANTARANCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150110', 'COMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120130', 'SAN JERONIMO DE TUNAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150727', 'STA.CRUZ DE COCACHACRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120211', 'MITO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120101', 'HUANCAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150714', 'RICARDO PALMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021505', 'HUANDOVAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150721', 'SAN LORENZO DE QUINTI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150117', 'LOS OLIVOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120202', 'ACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150715', 'SAN ANDRES DE TUPICOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120132', 'SAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120204', 'CHAMBARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120213', 'ORCOTUNA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120117', 'HUALHUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120129', 'SAN AGUSTIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150112', 'INDEPENDENCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120208', 'MANZANARES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150729', 'SANTIAGO DE ANCHUCAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120134', 'SICAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151028', 'TANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151014', 'HUANCAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150128', 'RIMAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120214', 'SAN JOSE DE QUERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120904', 'HUACHAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120125', 'PILCOMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('070103', 'CARMEN DE LA LEGUA REYNOSO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151030', 'TOMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150725', 'SAN PEDRO DE HUANCAYRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120902', 'AHUAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120907', 'SAN JUAN DE JARPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120133', 'SAPALLANGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160105', 'LAS AMAZONAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010403', 'RIO SANTIAGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160108', 'PUNCHANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010402', 'EL CENEPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160104', 'INDIANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160305', 'URARINAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160206', 'LAGUNAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160301', 'NAUTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160302', 'PARINARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160203', 'BARRANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160207', 'MANSERICHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160507', 'SAQUENA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010205', 'IMAZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060702', 'CHUGUR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061306', 'NINABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061302', 'ANDABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061311', 'YAUYUCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220913', 'SAUCE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060703', 'HUALGAYOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061308', 'SAUCEPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061307', 'PULAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060304', 'HUASMIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010103', 'BALSAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060601', 'CUTERVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060407', 'COCHABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100503', 'CHAVIN DE PARIARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100506', 'MIRAFLORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060303', 'CORTEGANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100905', 'YUYAPICHIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100508', 'PUNCHAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100103', 'CHINCHAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250204', 'YURUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250401', 'PURUS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100509', 'PUOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100504', 'JACAS GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100501', 'LLATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100104', 'CHURUBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250203', 'TAHUANIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100802', 'CHAGLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080405', 'PISAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211203', 'LIMBANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080402', 'COYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210309', 'SAN GABAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080407', 'TARAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080406', 'SAN SALVADOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081204', 'CCARHUAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081105', 'HUANCARANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081102', 'CAICAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081211', 'OROPESA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081208', 'LUCRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081202', 'ANDAHUAYLILLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210308', 'OLLACHEA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030502', 'COTABAMBAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030107', 'PICHIRHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030106', 'LAMBRAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030501', 'TAMBOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030703', 'GAMARRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081003', 'CCAPI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030503', 'COYLLURQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030103', 'CIRCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081004', 'COLCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080203', 'ACOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030702', 'CURPAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030102', 'CHACOCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030704', 'HUAYLLATI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080504', 'LANGUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030301', 'ANTABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080708', 'VELILLE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210211', 'SAN ANTON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080502', 'CHECCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080503', 'KUNTURKANKI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210808', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080505', 'LAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210208', 'MUANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080803', 'COPORAQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210212', 'SAN JOSE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210204', 'ASILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210805', 'MACARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130502', 'CALAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131006', 'QUIRUVILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130504', 'HUASO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131202', 'CHAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131001', 'SANTIAGO DE CHUCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131003', 'CACHICADAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131007', 'SANTA CRUZ DE CHUCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131004', 'MOLLEBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131002', 'ANGASMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130601', 'OTUZCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130602', 'AGALLPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130608', 'MACHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120901', 'CHUPACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120107', 'CHILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150105', 'BREÑA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120905', 'HUAMANCACA CHICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150710', 'LAHUAYTAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150121', 'MAGDALENA VIEJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151033', 'VITIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150116', 'LINCE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120906', 'SAN JUAN DE YSCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150130', 'SAN BORJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120119', 'HUANCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120908', 'TRES DE DICIEMBRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120909', 'YANACANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120126', 'PUCARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150141', 'SURQUILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150706', 'CUENCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151021', 'MIRAFLORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120903', 'CHONGOS BAJO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120121', 'HUAYUCACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150104', 'BARRANCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150726', 'SANGALLAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120136', 'VIQUES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120111', 'CHUPURO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120116', 'HUACRAPUQUIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090711', 'PAZOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120113', 'CULLHUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151026', 'SAN JOAQUIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151017', 'HUAEC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151002', 'ALIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120112', 'COLCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151024', 'QUINCHES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151025', 'QUINOCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151004', 'AYAVIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150711', 'LANGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120106', 'CHICCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151010', 'COCHAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090610', 'SAN ANTONIO DE CUSICANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110205', 'EL CARMEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110210', 'SUNAMPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110211', 'TAMBO DE MORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110204', 'CHINCHA BAJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090609', 'QUITO-ARMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090616', 'TAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150503', 'CALANGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151011', 'COLONIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151003', 'AYAUCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090114', 'PALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090702', 'ACOSTAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090403', 'AURAHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051010', 'HUAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110108', 'SALAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030409', 'LUCRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030411', 'SAN JUAN DE CHACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050903', 'CHALCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030203', 'CHIARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030217', 'TUMAY HUARACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051106', 'INDEPENDENCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050904', 'CHILCAYOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050901', 'QUEROBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050909', 'SAN SALVADOR DE QUIJE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051005', 'CANARIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130306', 'UCUNCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160601', 'CONTAMANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061004', 'GREGORIO PITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150142', 'VILLA EL SALVADOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150122', 'MIRAFLORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150131', 'SAN ISIDRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150120', 'MAGDALENA DEL MAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150136', 'SAN MIGUEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('070104', 'LA PERLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('070105', 'LA PUNTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150604', 'AUCALLAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090710', 'AHUIMPUQUIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151007', 'CARANIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151018', 'LARAOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090116', 'VILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151027', 'SAN PEDRO DE PILAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150515', 'STA.CRUZ DE FLORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090104', 'CONAYCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090109', 'LARIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090110', 'MANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151029', 'TAURIPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150506', 'COAYLLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150513', 'SAN ANTONIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150509', 'MALA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151023', 'PUTINZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151006', 'CACRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151008', 'CATAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150502', 'ASIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151012', 'HONGOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090101', 'HUANCAVELICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151019', 'LINCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150512', 'QUILMANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150510', 'NUEVO IMPERIAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151009', 'CHOCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151032', 'VIAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151020', 'MADEAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090401', 'CASTROVIRREYNA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150504', 'CERRO AZUL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151015', 'HUANGASCAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150508', 'LUNAHUANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110207', 'PUEBLO NUEVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090409', 'MOLLEPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090410', 'SAN JUAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110206', 'GROCIO PRADO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090406', 'COCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110201', 'CHINCHA ALTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090404', 'CAPILLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110202', 'ALTO LARAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090413', 'TICRAPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110502', 'HUANCANO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090113', 'NUEVO OCCORO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090108', 'IZCUCHACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030408', 'JUSTO APU SAHUARAURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051004', 'ASQUIPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050910', 'SANTIAGO DE PAUCARAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110405', 'TIBILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110103', 'LOS AQUIJES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110101', 'ICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110106', 'PARCONA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030211', 'POMACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050610', 'LLAUTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030402', 'CAPAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050608', 'LARAMATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050607', 'HUAC-HUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050911', 'SORAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060811', 'SAN JOSE DEL ALTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090705', 'COLCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160205', 'JEBEROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160202', 'BALSAPUERTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160112', 'BELEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160101', 'IQUITOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160113', 'SAN JUAN BAUTISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160103', 'FERNANDO LORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160511', 'YAQUERANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160404', 'SAN PABLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060802', 'BELLAVISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200802', 'BELLAVISTA DE LA UNION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200804', 'CRISTO NOS VALGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200806', 'RINCONADA LLICUAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200114', 'TAMBO GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110507', 'SAN CLEMENTE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090613', 'SANTIAGO DE CHOCORVOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110503', 'HUMAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090602', 'AYAVI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110501', 'PISCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110508', 'TUPAC AMARU INCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110506', 'SAN ANDRES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030218', 'TURPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030404', 'CHAPIMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030214', 'SAN MIGUEL DE CHACCRAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090612', 'SAN ISIDRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030206', 'HUAYANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050907', 'PAICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110110', 'SAN JUAN BAUTISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030416', 'TORAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110102', 'LA TINGUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051003', 'APONGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110112', 'SUBTANJALLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050906', 'MORCOLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030414', 'TAPAIRIHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030407', 'HUAYLLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030210', 'PAMPACHIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110105', 'PACHACUTEC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030413', 'SORAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030412', 'SAAYCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050905', 'HUACAA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050908', 'SAN PEDRO DE LARCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030410', 'POCOHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050618', 'SAN PEDRO DE PALCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030417', 'YANACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050620', 'SANTA ANA DE HUAYCAHUACHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050603', 'CABANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050611', 'LUCANAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110104', 'OCUCAJE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050606', 'CHIPAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110404', 'SANTA CRUZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050604', 'CARMEN SALCEDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110107', 'PUEBLO NUEVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140306', 'MORROPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200801', 'SECHURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220604', 'PACHIZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061108', 'NANCHOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061110', 'SAN GREGORIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010117', 'QUINJALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010102', 'ASUNCION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040117', 'SACHACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040123', 'TIABAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040101', 'AREQUIPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040102', 'ALTO SELVA ALEGRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040126', 'YANAHUARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040128', 'YURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010504', 'COLCAMAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010121', 'SONCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010114', 'MOLINOPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010101', 'CHACHAPOYAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010118', 'SAN FRANCISCO DE DAGUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010703', 'CUMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220105', 'SORITOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220510', 'TABALOSOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220503', 'BARRANQUITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220504', 'CAYNARACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010515', 'PROVIDENCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060415', 'QUEROCOTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060615', 'TORIBIO CASANOVA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080307', 'MOLLEPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220603', 'HUICUNGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120304', 'SAN LUIS DE SHUARO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190307', 'VILLA RICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100403', 'COCHABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160201', 'YURIMAGUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220601', 'JUANJUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021904', 'CASHAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050619', 'SANCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040205', 'NICOLAS DE PIEROLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211207', 'SAN JUAN DEL ORO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210214', 'SANTIAGO DE PUPUJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110304', 'MARCONA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050702', 'CHUMPI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210705', 'OCUVIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050802', 'COLTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210206', 'CHUPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050805', 'MARCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050804', 'LAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210608', 'VILQUE CHICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210601', 'HUANCANE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040305', 'BELLA UNION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040515', 'SIBAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210210', 'SAMAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210706', 'PALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050809', 'SAN JOSE DE USHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040607', 'SALAMANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210205', 'CAMINACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050801', 'PAUSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210901', 'MOHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050810', 'SARA SARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050803', 'CORCULLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040811', 'TORO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040807', 'QUECHUALLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210607', 'TARACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040504', 'CALLALLI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040405', 'CHILCAYMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210703', 'CALAPUJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040808', 'SAYLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040310', 'JAQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040809', 'TAURIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210707', 'PARATIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210709', 'SANTA LUCIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040312', 'QUICACHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040306', 'CAHUACHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040402', 'ANDAGUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040309', 'HUANUHUANU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040604', 'CHICHAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210902', 'CONIMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210904', 'TILALI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040513', 'MADRIGAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210702', 'CABANILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050601', 'PUQUIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040518', 'TUTI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110401', 'PALPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('110402', 'LLIPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211101', 'JULIACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210605', 'PUSI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040802', 'ALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040810', 'TOMEPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040801', 'COTAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040516', 'TAPAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040510', 'LARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050705', 'PULLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210105', 'CAPACHICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040304', 'ATIQUIPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040313', 'YAUCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040408', 'MACHAGUAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040608', 'YANAQUIHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040509', 'ICHUPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040506', 'COPORAQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040501', 'CHIVAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040403', 'AYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040602', 'ANDARAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040414', 'VIRACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040410', 'PAMPACOLCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040308', 'CHAPARRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210108', 'HUATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040503', 'CABANACONDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040514', 'SAN ANTONIO DE CHUCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040507', 'HUAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040601', 'CHUQUIBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040519', 'YANQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210104', 'ATUNCOLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210103', 'AMANTANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040512', 'MACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040412', 'UON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210110', 'PAUCARCOLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040502', 'ACHOMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040307', 'CHALA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040301', 'CARAVELI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040606', 'RIO GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210115', 'VILQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040411', 'TIPAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040511', 'LLUTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040303', 'ATICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210114', 'TIQUILLACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210101', 'PUNO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040401', 'APLAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040605', 'IRAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040407', 'HUANCARQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040203', 'MARIANO NICOLAS VALCARCEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040508', 'HUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210102', 'ACORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210501', 'ILAVE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210111', 'PICHACANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180210', 'UBINAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210113', 'SAN ANTONIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210503', 'PILCUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040206', 'OCOA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040413', 'URACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040120', 'SANTA ISABEL DE SIGUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180211', 'YUNGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210401', 'JULI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160401', 'RAMON CASTILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211306', 'TINICACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211305', 'OLLARAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211301', 'YUNGUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211307', 'UNICACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180206', 'LLOQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211302', 'ANAPIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040106', 'CHIGUATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210406', 'POMATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211304', 'CUTURAPI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040110', 'MIRAFLORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040204', 'MARISCAL CACERES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180202', 'CHOJATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040109', 'MARIANO MELGAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211303', 'COPANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210407', 'ZEPITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180207', 'MATALAQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040112', 'PAUCARPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040108', 'LA JOYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040105', 'CHARACATO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040129', 'JOSE LUIS BUSTAMANTE Y RIVERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210109', 'MAAZO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040121', 'SANTA RITA DE SIGUAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210112', 'PLATERIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211102', 'CABANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040124', 'UCHUMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040520', 'MAJES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040119', 'SAN JUAN DE TARUCANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210505', 'CONDURIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040116', 'SABANDIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040107', 'JACOBO HUNTER');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040113', 'POCSI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040122', 'SOCABAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210403', 'HUACULLANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180203', 'COALAQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180208', 'PUQUINA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180102', 'CARUMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040207', 'QUILCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040111', 'MOLLEBAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040114', 'POLOBAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040127', 'YARABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210504', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180201', 'OMATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040115', 'QUEQUEA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210402', 'DESAGUADERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180105', 'SAN CRISTOBAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210404', 'KELLUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180209', 'QUINISTAQUILLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040201', 'CAMANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180205', 'LA CAPILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040701', 'MOLLENDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040702', 'COCACHACRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210405', 'PISACOMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180103', 'CUCHUMBAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180101', 'MOQUEGUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180106', 'TORATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040704', 'ISLAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230201', 'CANDARAVE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210502', 'CAPAZO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040705', 'MEJIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230203', 'CAMILACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040703', 'DEAN VALDIVIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230406', 'SUSAPAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230202', 'CAIRANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040706', 'PUNTA DE BOMBON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180104', 'SAMEGUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230302', 'ILABAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230205', 'HUANUARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180303', 'PACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230206', 'QUILAHUANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230204', 'CURIBAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230405', 'SITAJARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230104', 'CIUDAD NUEVA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210107', 'COATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061103', 'CALQUIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061112', 'TONGOD');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061104', 'CATILLUC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061107', 'LLAPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060105', 'ENCAADA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060111', 'NAMORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060106', 'JESUS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040202', 'JOSE MARIA QUIMPER');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130903', 'COCHORCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130902', 'CHUGAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131008', 'SITABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021509', 'PAMPAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021503', 'CONCHUCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021902', 'ACOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060110', 'MATARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120124', 'PARIAHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090716', 'SAN MARCOS DE ROCCHAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090717', 'SURCUBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090715', 'SALCAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090203', 'ANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090508', 'SAN MIGUEL DE MAYOCC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090204', 'CAJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090207', 'POMACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090302', 'ANCHONGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090303', 'CALLANMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090304', 'CCOCHACCASA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090308', 'HUAYLLAY GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090307', 'HUANCA-HUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090306', 'CONGALLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090106', 'HUACHOCOLPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090301', 'LIRCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090309', 'JULCAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090312', 'SECCLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050101', 'AYACUCHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050115', 'JESUS NAZARENO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050113', 'TAMBILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030608', 'RANRACANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050206', 'TOTOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050201', 'CANGALLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030207', 'KISHUARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030603', 'COCHARCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051012', 'VILCANCHOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051101', 'VILCAS HUAMAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051011', 'SARHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030607', 'URANMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030215', 'SANTA MARIA DE CHICMO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030201', 'ANDAHUAYLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030213', 'SAN JERONIMO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051002', 'ALCAMENCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051008', 'HUAMANQUIQUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051001', 'HUANCAPI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051107', 'SAURAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051007', 'COLCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051009', 'HUANCARAYLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051105', 'HUAMBALPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050112', 'SOCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050114', 'VINCHOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090310', 'SAN ANTONIO DE ANTAPARCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090311', 'SANTO TOMAS DE PATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030209', 'PACUCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030216', 'TALAVERA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090706', 'DANIEL HERNANDEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130908', 'SARTIMBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030205', 'HUANCARAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050304', 'SANTIAGO DE LUCANAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('051103', 'CARHUANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120203', 'ANDAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120135', 'SANTO DOMINGO DE ACOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090707', 'HUACHOCOLPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090718', 'TINTAY PUNCU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090503', 'CHINCHIHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090510', 'PACHAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090509', 'SAN PEDRO DE CORIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090501', 'CHURCAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090505', 'LA MERCED');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090205', 'MARCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050107', 'PACAYCASA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050108', 'QUINUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050103', 'ACOS VINCHOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050102', 'ACOCRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050106', 'OCROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030604', 'HUACCANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030606', 'ONGOY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030219', 'KAQUIABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030208', 'PACOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160510', 'JENARO HERRERA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160204', 'CAHUAPANAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160501', 'REQUENA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060901', 'SAN IGNACIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160506', 'PUINAHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160503', 'CAPELO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010202', 'ARAMANGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060902', 'CHIRINOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060812', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010702', 'CAJARURO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220101', 'MOYOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220805', 'PARDO MIGUEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160210', 'SANTA CRUZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160504', 'EMILIO SAN MARTIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160505', 'MAQUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010203', 'COPALLIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160508', 'SOPLIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160509', 'TAPICHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090305', 'CHINCHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060803', 'CHONTALI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060904', 'LA COIPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010401', 'NIEVA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010204', 'EL PARCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010701', 'BAGUA GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220802', 'AWAJUN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160211', 'TENIENTE CESAR LOPEZ ROJAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010306', 'FLORIDA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220807', 'SAN FERNANDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220804', 'NUEVA CAJAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010705', 'JAMALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010301', 'JUMBILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010302', 'CHISQUILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010310', 'SHIPASBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010305', 'CUISPES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160605', 'SARAYACU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220809', 'YURACYACU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010308', 'RECTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010518', 'SAN JERONIMO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010307', 'JAZAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220106', 'YANTALO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010707', 'YAMON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220806', 'POSIC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010116', 'OLLEROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160502', 'ALTO TAPICHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010309', 'SAN CARLOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010706', 'LONYA GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220803', 'ELIAS SOPLIN VARGAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220102', 'CALZADA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060606', 'PIMPINGOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220801', 'RIOJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010303', 'CHURUJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060613', 'SANTO TOMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010105', 'CHILIQUIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010612', 'VISTA ALEGRE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220911', 'PAPAPLAYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220506', 'PINTO RECODO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010520', 'SANTA CATALINA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220508', 'SAN ROQUE DE CUMBAZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060602', 'CALLAYUC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010505', 'CONILA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060611', 'SANTA CRUZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010311', 'VALERA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010510', 'LUYA VIEJO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010107', 'GRANADA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010516', 'SAN CRISTOBAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220104', 'JEPELACIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220103', 'HABANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010501', 'LAMUD');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060604', 'CUJILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010502', 'CAMPORREDONDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060414', 'PION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220808', 'YORONGOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220906', 'EL PORVENIR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010509', 'LUYA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010108', 'HUANCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060609', 'SAN JUAN DE CUTERVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010512', 'OCALLI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010523', 'TRITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060608', 'SAN ANDRES DE CUTERVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220502', 'ALONSO DE ALVARADO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010508', 'LONYA CHICO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060605', 'LA RAMADA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010506', 'INGUILPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060614', 'SOCOTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060610', 'SAN LUIS DE LUCMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060405', 'CHIMBAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010120', 'SOLOCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010104', 'CHETO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010513', 'OCUMAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060406', 'CHOROPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010111', 'LEVANTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060402', 'ANGUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010119', 'SAN ISIDRO DE MAINO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220905', 'CHIPURANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010609', 'OMIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010522', 'TINGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220402', 'ALTO SAPOSOA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220907', 'HUIMBAYOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060409', 'HUAMBOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060417', 'TACABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060416', 'SAN JUAN DE LICUPIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010507', 'LONGUITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010514', 'PISUQUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060404', 'CHIGUIRIP');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060403', 'CHADIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010605', 'LIMABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060408', 'CONCHAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010519', 'SN J.DE LOPECANCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010511', 'MARIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010109', 'LA JALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220910', 'MORALES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060419', 'CHALAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060401', 'CHOTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220904', 'CHAZUTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060413', 'PACCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061304', 'CHANCAYBAOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061309', 'SEXI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010503', 'COCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060701', 'BAMBAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061305', 'LA ESPERANZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061310', 'UTICYACU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061301', 'SANTA CRUZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060301', 'CELENDIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060312', 'LA LIBERTAD DE PALLAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010603', 'COCHAMAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220912', 'SAN ANTONIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220509', 'SHANAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220903', 'CACATACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010610', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010608', 'MILPUC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220305', 'SHATOJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010611', 'TOTORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220914', 'SHAPAJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220301', 'SAN JOSE DE SISA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010115', 'MONTEVIDEO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220304', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220302', 'AGUA BLANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220902', 'ALBERTO LEVEAU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010110', 'LEIMEBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220710', 'TRES UNIDOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220507', 'RUMISAPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010113', 'MARISCAL CASTILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220303', 'SAN MARTIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220501', 'LAMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010112', 'MAGDALENA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010602', 'CHIRIMOTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010517', 'SAN FRANCISCO DEL YESO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220909', 'LA BANDA DE SHILCAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220901', 'TARAPOTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220511', 'ZAPATERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220505', 'CUUMBUQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220702', 'BUENOS AIRES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160606', 'VARGAS GUERRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060311', 'UTCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060309', 'SOROCHUCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220701', 'PICOTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('221003', 'POLVORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130806', 'HUAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250106', 'NUEVA REQUENA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130807', 'ONGON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130803', 'CHILLIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130802', 'BULDIBUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250105', 'YARINACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130805', 'HUAYLILLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130801', 'TAYABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130812', 'TAURIJA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250303', 'CURIMANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250102', 'CAMPOVERDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130813', 'URPAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('221002', 'NUEVO PROGRESO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100604', 'JOSE CRESPO Y CASTILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250104', 'MASISEA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130804', 'HUANCASPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130811', 'SANTIAGO DE CHALLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100702', 'CHOLON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250301', 'PADRE ABAD');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100701', 'HUACRACHUCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250302', 'IRAZOLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100903', 'HONORIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100703', 'SAN BUENAVENTURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100402', 'CANCHABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250103', 'IPARIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100904', 'TOURNAVISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100401', 'HUACAYBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100404', 'PINRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130810', 'PIAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220704', 'PILLUANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220205', 'SAN PABLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220705', 'PUCACACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220707', 'SAN HILARION');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220709', 'TINGO DE PONASA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220703', 'CASPISAPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010106', 'CHUQUIBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220201', 'BELLAVISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220403', 'EL ESLABON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220206', 'SAN RAFAEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220405', 'SACANCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130301', 'BOLIVAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220204', 'HUALLAGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130303', 'CONDORMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220401', 'SAPOSOA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('160604', 'PAMPA HERMOSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060204', 'SITACOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220202', 'ALTO BIAVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('221001', 'TOCACHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('221005', 'UCHIZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('221004', 'SHUNTE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220406', 'TINGO DE SAPOSOA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220605', 'PAJARILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220602', 'CAMPANILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100901', 'PUERTO INCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100601', 'RUPA-RUPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190304', 'PALCAZU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100803', 'MOLINO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170301', 'IAPARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190305', 'POZUZO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250201', 'RAYMONDI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190303', 'HUANCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190301', 'OXAPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120303', 'PICHANAQUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('250202', 'SEPAHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120608', 'RIO TAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080910', 'PICHARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050408', 'LLOCHEGUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080907', 'KIMBIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050407', 'SIVIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080408', 'YANATILE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050503', 'AYNA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050406', 'SANTILLANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050507', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080905', 'OCOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050401', 'HUANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080901', 'SANTA ANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050501', 'SAN MIGUEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050405', 'LURICOCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170204', 'HUEPETUHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050502', 'ANCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050508', 'TAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080904', 'MARANURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080909', 'VILCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050403', 'HUAMANGUILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080404', 'LARES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050404', 'IGUAIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081103', 'CHALLABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080903', 'HUAYOPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120305', 'SAN RAMON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120306', 'VITOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120605', 'PAMPA HERMOSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('190306', 'PUERTO BERMUDEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120302', 'PERENE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100502', 'ARANCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081106', 'KOSIPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050505', 'CHUNGUI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050504', 'CHILCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170101', 'TAMBOPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210303', 'AYAPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050506', 'LUIS CARRANZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080401', 'CALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210304', 'COASA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081104', 'COLQUEPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080403', 'LAMAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081201', 'URCOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210307', 'ITUATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081207', 'HUARO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081206', 'CUSIPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211205', 'PHARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210310', 'USICAYOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210302', 'AJOYANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211204', 'PATAMBUCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210306', 'CRUCERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211202', 'CUYOCUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060612', 'SANTO DOMINGO DE LA CAPILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081305', 'MARAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080305', 'HUAROCONDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080302', 'ANCAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080301', 'ANTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080309', 'ZURITE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080303', 'CACHIMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080308', 'PUCYURA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080103', 'POROY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080304', 'CHINCHAYPUJIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080108', 'WANCHAQ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080106', 'SANTIAGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080102', 'CCORCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030101', 'ABANCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030204', 'HUANCARAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081005', 'HUANOQUITE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030505', 'MARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081002', 'ACCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081008', 'PILLPINTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080702', 'CAPACMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080205', 'POMACANCHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030701', 'CHUQUIBAMBILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080202', 'ACOPIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030708', 'PROGRESO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030714', 'CURASCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080603', 'COMBAPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081006', 'OMACHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030109', 'TAMBURCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080908', 'SANTA TERESA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081007', 'PACCARITAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211201', 'SANDIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211206', 'QUIACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030710', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080704', 'COLQUEMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080506', 'PAMPAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080608', 'TINTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030302', 'EL ORO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030504', 'HAQUIRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080705', 'LIVITACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080607', 'SAN PEDRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030306', 'PACHACONAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030707', 'PATAYPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030709', 'SAN ANTONIO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080703', 'CHAMACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030711', 'TURPAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080601', 'SICUANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030705', 'MAMARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080501', 'YANAOCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030305', 'OROPESA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030713', 'VIRUNDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080707', 'QUIOTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030303', 'HUAQUIRCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080604', 'MARANGANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080507', 'QUEHUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080706', 'LLUSCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210807', 'ORURILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080806', 'PICHIGUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050703', 'CORONEL CASTAEDA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080808', 'ALTO PICHIGUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040806', 'PUYCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210801', 'AYAVIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211004', 'QUILCAPUNCU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080801', 'ESPINAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210201', 'AZANGARO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080805', 'PALLPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210809', 'UMACHIRI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210602', 'COJATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210803', 'CUPI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050806', 'OYOLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210215', 'TIRAPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040404', 'CHACHAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080807', 'SUYCKUTAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040409', 'ORCOPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210804', 'LLALLI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210708', 'PUCARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210604', 'INCHUPALLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080804', 'OCORURO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211003', 'PEDRO VILCA APAZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210213', 'SAN JUAN DE SALINAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210203', 'ARAPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081301', 'URUBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081307', 'YUCAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081303', 'HUAYLLABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080101', 'CUSCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080105', 'SAN SEBASTIAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080107', 'SAYLLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080104', 'SAN JERONIMO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081001', 'PARURO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080206', 'RONDOCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080201', 'ACOMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080207', 'SANGARARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080606', 'SAN PABLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210806', 'NUOA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030307', 'SABAINO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030304', 'JUAN ESPINOZA MEDRANO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040804', 'HUAYNACOTAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040805', 'PAMPAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210301', 'MACUSANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080605', 'PITUMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210802', 'ANTAUTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210209', 'POTONI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211001', 'PUTINA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211002', 'ANANEA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030105', 'HUANIPACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081302', 'CHINCHERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081304', 'MACHUPICCHU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030406', 'COTARUSE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021504', 'HUACASCHUQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130808', 'PARCOY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('151031', 'TUPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150511', 'PACARAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150516', 'ZUIGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('210106', 'CHUCUITO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010521', 'SANTO TOMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020107', 'LA LIBERTAD');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080306', 'LIMATAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020304', 'CHINGAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021805', 'MORO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010704', 'EL MILAGRO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010201', 'LA PECA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030605', 'OCOBAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030202', 'ANDARAPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090606', 'OCOYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090605', 'LARAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('090704', 'AHUAYCHA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081009', 'YAURISQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020509', 'HUASTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020510', 'HUAYLLACAYAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021406', 'CONGAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('030108', 'SAN PEDRO DE CACHORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211104', 'CARACOTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('050602', 'AUCARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150805', 'HUALMAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100313', 'PACHAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('120706', 'PALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060603', 'CHOROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('081209', 'MARCAPATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('080602', 'CHECACUPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('220908', 'JUAN GUERRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061204', 'TUMBADEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061201', 'SAN PABLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060101', 'CAJAMARCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101001', 'JESUS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100203', 'COLPAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101007', 'SAN MIGUEL DE CAURI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101003', 'JIVIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101006', 'SAN FRANCISCO DE ASIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('100105', 'MARGOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101108', 'CHORAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101103', 'CHACABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('101005', 'RONDOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150403', 'HUAMANTANGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150407', 'STA.ROSA DE QUIVES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170104', 'LABERINTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('170102', 'INAMBARI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130103', 'FLORENCIA DE MORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('020903', 'BAMBAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021804', 'MACATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021507', 'LLAPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021510', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021511', 'TAUCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021508', 'PALLASCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060201', 'CAJABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130905', 'MARCABAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130904', 'CURGOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130907', 'SARIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130901', 'HUAMACHUCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130906', 'SANAGORAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130614', 'USQUIL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130604', 'CHARAT');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130501', 'JULCAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130111', 'VICTOR LARCO HERRERA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130207', 'SANTIAGO DE CAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130110', 'SIMBAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130613', 'SINSICAP');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131103', 'COMPIN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131102', 'LUCMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130605', 'HUARANCHAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131104', 'SAYAPULLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060202', 'CACHACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130202', 'CHICAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060503', 'CUPISNIQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130208', 'CASA GRANDE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130201', 'ASCOPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130203', 'CHOCOPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130204', 'MAGDALENA DE CAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130205', 'PAIJAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130206', 'RAZURI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130704', 'PACASMAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130701', 'SAN PEDRO DE LLOC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130705', 'SAN JOSE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130703', 'JEQUETEPEQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130702', 'GUADALUPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060508', 'YONAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130403', 'PUEBLO NUEVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130401', 'CHEPEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240301', 'ZARUMILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240302', 'AGUAS VERDES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240102', 'CORRALES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060905', 'NAMBALLE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240303', 'MATAPALO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240101', 'TUMBES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240304', 'PAPAYAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200506', 'TAMARINDO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200603', 'IGNACIO ESCUDERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200606', 'MIGUEL CHECA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200504', 'COLAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200501', 'PAITA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060302', 'CHUMUCH');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240105', 'SAN JACINTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200602', 'BELLAVISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('240202', 'CASITAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200605', 'MARCAVELICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200604', 'LANCONES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200607', 'QUERECOTILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200608', 'SALITRAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200601', 'SULLANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200210', 'SUYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200203', 'JILILI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200209', 'SICCHEZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200201', 'AYABACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200207', 'PAIMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200205', 'MONTERO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200204', 'LAGUNAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200208', 'SAPILLICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200202', 'FRIAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200206', 'PACAIPAMPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200303', 'EL CARMEN DE LA FRONTERA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200301', 'HUANCABAMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200305', 'LALAQUIZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200302', 'CANCHAQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200111', 'LAS LOMAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200805', 'VICE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200404', 'LA MATANZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200405', 'MORROPON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200409', 'SANTO DOMINGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200402', 'BUENOS AIRES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200408', 'SANTA CATALINA DE MOSSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200403', 'CHALACO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200410', 'YAMANGO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200407', 'SAN JUAN DE BIGOTE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200406', 'SALITRAL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060907', 'TABACONAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200307', 'SONDOR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200308', 'SONDORILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200306', 'SAN MIGUEL DE EL FAIQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060810', 'SAN FELIPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060809', 'SALLIQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140109', 'NUEVA ARICA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140116', 'CAYALTI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060505', 'SAN BENITO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060501', 'CONTUMAZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('131101', 'CASCAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060104', 'COSPAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061109', 'NIEPOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061106', 'LA FLORIDA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('061303', 'CATACHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140110', 'OYOTUN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130402', 'PACANGA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140107', 'LAGUNAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140115', 'SAA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140119', 'PUCALA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140104', 'ETEN PUERTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140103', 'ETEN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140114', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140106', 'LA VICTORIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140108', 'MONSEFU');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140113', 'REQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140118', 'POMALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140120', 'TUMAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140111', 'PICSI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140101', 'CHICLAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140105', 'JOSE LEONARDO ORTIZ');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140112', 'PIMENTEL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140311', 'SAN JOSE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140102', 'CHONGOYAPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060411', 'LLAMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140117', 'PATAPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140204', 'MANUEL ANTONIO MESONES MURO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140201', 'FERREAFE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140206', 'PUEBLO NUEVO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200304', 'HUARMACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140305', 'MOCHUMI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140301', 'LAMBAYEQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140312', 'TUCUME');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140303', 'ILLIMO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140309', 'PACORA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060418', 'TOCMOCHE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140205', 'PITIPO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060412', 'MIRACOSTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060607', 'QUEROCOTILLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060808', 'PUCARA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140202', 'CAARIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140203', 'INCAHUASI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140304', 'JAYANCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140307', 'MOTUPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140302', 'CHOCHOPE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('060807', 'POMAHUACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140310', 'SALAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('140308', 'OLMOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040103', 'CAYMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('040104', 'CERRO COLORADO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010604', 'HUAMBO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010601', 'SAN NICOLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('010606', 'LONGAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150702', 'ANTIOQUIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150114', 'LA MOLINA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150135', 'SAN MARTIN DE PORRES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('070102', 'BELLAVISTA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150113', 'JESUS MARIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150115', 'LA VICTORIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150111', 'EL AGUSTINO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150134', 'SAN LUIS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150101', 'LIMA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150107', 'CHACLACAYO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150103', 'ATE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150118', 'LURIGANCHO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150140', 'SANTIAGO DE SURCO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150133', 'SAN JUAN DE MIRAFLORES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150143', 'VILLA MARIA DEL TRIUNFO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150123', 'PACHACAMAC');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150731', 'STO.DGO.DE LOS OLLEROS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150138', 'SANTA MARIA DEL MAR');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150129', 'SAN BARTOLO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150108', 'CHORRILLOS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('070101', 'CALLAO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150124', 'PUCUSANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150102', 'ANCON');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150139', 'SANTA ROSA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150125', 'PUENTE PIEDRA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('070106', 'VENTANILLA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('130108', 'POROTO');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('200505', 'LA HUACA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150902', 'ANDAJES');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('150903', 'CAUJUL');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230110', 'CORONELGREGORIO ALBARRACIN LANCHIPA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230107', 'PALCA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230108', 'POCOLLAY');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230402', 'CHUCATAMANI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230407', 'TARUCACHI');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230403', 'ESTIQUE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230401', 'TARATA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230103', 'CALANA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230106', 'PACHIA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230303', 'ITE');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230301', 'LOCUMBA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230105', 'INCLAN');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230101', 'TACNA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('230102', 'ALTO DE LA ALIANZA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('180204', 'ICHUA');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('211103', 'CABANILLAS');
INSERT INTO SISCEUSI.T_MAE_DISTRITO (idDistrito, distrito) VALUES ('021502', 'BOLOGNESI');

COMMIT;

--CAMPANA
Insert into SISCEUSI.T_GENM_CAMPANA (IDCAMPANA,DENOMINACION,FECHAINICIOPILOTO,FECHAFINPILOTO,FECHAINICIOENCUESTA,FECHAFINENCUESTA,OBSERVACIONES,IDGIROPILOTO,IDCIUUPILOTO,IDGIROOFICIAL,IDCIUUOFICIAL,IDETAPAPILOTO,IDETAPAOFICIAL,IDESTADO) values ('1','Campaña N°1',to_date('10/08/22','DD/MM/RR'),to_date('27/08/22','DD/MM/RR'),to_date('09/09/22','DD/MM/RR'),to_date('29/09/22','DD/MM/RR'),'ninguna','0','0','1','2','1','1','1');

--CAMPANA EMPRESA
Insert into SISCEUSI.T_GEND_CAMPANA_EMPRESA (IDCAMPANAEMPRESA,IDCAMPANA,IDEMPRESAINDUSTRIA,PARTICIPARENPILOTO,PARTICIPARENOFICIAL,IDSUPERVISORPILOTO,IDSUPERVISOROFICIAL,IDESTADO) values ('1','1','2','1','0','2','0','1');

--CONTROL ENCUESTA
Insert into SISCEUSI.T_GEND_CONTROL_ENCUESTA (IDCONTROLENCUESTA,IDCAMPANAEMPRESA,IDPLANTAEMPRESA,IDTIPOENCUESTA,IDSUPERVISOR,ACEPTALLENARENCUESTA,ACEPTATRATAMIENTODATOS,ACEPTAFIRMARENCUESTA,IDUSUARIORESPONDE,FECHAHORALLENADO,IDETAPA,IDESTADO,NUMEROCUESTIONARIO) values ('1','1','1','1','2','1','0','1',null,to_date('17/08/22','DD/MM/RR'),'1','1','1');
Insert into SISCEUSI.T_GEND_CONTROL_ENCUESTA (IDCONTROLENCUESTA,IDCAMPANAEMPRESA,IDPLANTAEMPRESA,IDTIPOENCUESTA,IDSUPERVISOR,ACEPTALLENARENCUESTA,ACEPTATRATAMIENTODATOS,ACEPTAFIRMARENCUESTA,IDUSUARIORESPONDE,FECHAHORALLENADO,IDETAPA,IDESTADO,NUMEROCUESTIONARIO) values ('2','1','2','1','2',null,null,null,null,null,'1','1','2');
Insert into SISCEUSI.T_GEND_CONTROL_ENCUESTA (IDCONTROLENCUESTA,IDCAMPANAEMPRESA,IDPLANTAEMPRESA,IDTIPOENCUESTA,IDSUPERVISOR,ACEPTALLENARENCUESTA,ACEPTATRATAMIENTODATOS,ACEPTAFIRMARENCUESTA,IDUSUARIORESPONDE,FECHAHORALLENADO,IDETAPA,IDESTADO,NUMEROCUESTIONARIO) values ('3','1','48','1','2',null,null,null,null,null,'1','1','3');
Insert into SISCEUSI.T_GEND_CONTROL_ENCUESTA (IDCONTROLENCUESTA,IDCAMPANAEMPRESA,IDPLANTAEMPRESA,IDTIPOENCUESTA,IDSUPERVISOR,ACEPTALLENARENCUESTA,ACEPTATRATAMIENTODATOS,ACEPTAFIRMARENCUESTA,IDUSUARIORESPONDE,FECHAHORALLENADO,IDETAPA,IDESTADO,NUMEROCUESTIONARIO) values ('4','1','49','1','2',null,null,null,null,null,'1','1','4');
Insert into SISCEUSI.T_GEND_CONTROL_ENCUESTA (IDCONTROLENCUESTA,IDCAMPANAEMPRESA,IDPLANTAEMPRESA,IDTIPOENCUESTA,IDSUPERVISOR,ACEPTALLENARENCUESTA,ACEPTATRATAMIENTODATOS,ACEPTAFIRMARENCUESTA,IDUSUARIORESPONDE,FECHAHORALLENADO,IDETAPA,IDESTADO,NUMEROCUESTIONARIO) values ('5','1','61','1','2',null,null,null,null,null,'1','1','5');
COMMIT;

--PARAMETROS
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('1','Subsector','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('2','Alimentos, bebidas y tabaco','1','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('3','Textil, confecciones, calzado y cuero','1','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('4','Papel, celulosa y gráfica','1','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('5','Maderas y muebles','1','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('6','Química, caucho y plástico','1','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('7','Cemento','1','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('8','Piedras, vidrios y cerámicas','1','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('9','Tipo de combustible','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('10','Diesel B5','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('11','Petróleo Industrial 6','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('12','Petróleo Industrial 500','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('13','Kerosene','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('15','Gasolina de Motor','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('16','Gasohol','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('17','Gas natural (gas por red)','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('18','Gas Natural Vehicular (GNV)','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('19','Gas Licuado de Petróleo (GLP)','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('20','Biogas','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('21','Carbón vegetal','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('22','Carbón Mineral Antracítico','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('23','Carbón Mineral Bituminoso','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('24','Carbón Mineral Hulla','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('25','Coque Bituminoso','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('26','Coque Antracítico','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('27','Briquetas de Carbón','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('28','Bagazo','9','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('29','Leña','9','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('30','Unidad de medida','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('31','(galón/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('32','(galón/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('33','(galón/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('34','(galón/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('35','(galón/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('36','(galón/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('37','(m3/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('38','(m3/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('39','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('40','(m3/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('41','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('42','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('43','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('44','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('45','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('46','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('47','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('48','(t/año)','30','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('49','(t/año)','30','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('50','Mes de consumo','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('51','Enero','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('52','Febrero','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('53','Marzo','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('54','Abril','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('55','Mayo','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('56','Junio','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('57','Julio','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('58','Agosto','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('59','Septiembre','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('60','Octubre','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('61','Noviembre','50','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('62','Diciembre','50','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('63','Equipo','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('64','Motor diésel','63','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('65','Motor a gasolina','63','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('66','Motor a gas','63','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('67','Turbina de gas','63','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('68','Hidroeléctrica','63','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('69','Eólica','63','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('70','Panel fotovoltaico','63','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('71','MEDIDA','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('72','KW','71','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('73','HP','71','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('74','Vehículo','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('75','Automóvil','74','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('76','Combi','74','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('77','SUV','74','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('78','Microbús','74','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('79','Bus','74','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('80','Moto','74','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('81','Otros','74','2','1');

Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('82','Vehículo (E7)','0','1','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('83','Camionetas','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('84','Combi carga','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('85','Camiones < 3.5 t','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('86','Camiones 3.5 a 5 t','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('87','Camiones > 5 a 10 t','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('88','Camiones > 10 a 20 t','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('89','Camiones > 20 a 40 t','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('90','Camiones > 40 t','82','2','1');
Insert into SISCEUSI.T_GENM_PARAMETRO (IDPARAMETRO,PARAMETRO,IDPARENTPARAMETRO,IDTIPOPARAMETRO,IDESTADO) values ('91','Otros','82','2','1');

COMMIT;

--TABLA MAESTRA
Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('1','A3.	¿Cuál es el volumen de producción de la planta o establecimiento?',null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('2','B1.	Combustibles comprados en el año 2019',null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('3',null,null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('4','B2.	Electricidad comprada en el año 2019',null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('5','B3.	Gas natural comprado en el año 2019',null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('6',null,null,null,null,'1','7','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('7',null,null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('8','Uso de calor - Calderos de la planta',null,'¿La planta tiene calderos?','No tiene equipos en la sección “USO CALOR - CALDEROS DE LA PLANTA”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('9','Uso de calor - Horno planta',null,'¿La planta tiene hornos?','No tiene equipos en la sección “USO CALOR - HORNOS, FRAGUAS Y MUFLAS DE LA PLANTA”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('10','Uso de calor - Secadores de la planta',null,'¿La planta tiene secadores?','No tiene equipos en la sección “USO CALOR – SECADORES DE LA PLANTA”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('11','Uso de calor - Otros equipos de uso de calor de la planta',null,'¿La planta tiene otros equipos de uso de calor?','No tiene equipos en la sección “OTROS EQUIPOS DE USO DE CALOR DE LA PLANTA”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('12','Producción de frío industrial',null,'¿La planta tiene equipos de producción de frío industrial?','No tiene equipos en la sección “PRODUCCIÓN DE FRÍO INDUSTRIAL”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('13','Compresores de aire',null,'¿La planta tiene compresores de aire?','No tiene equipos en la sección “COMPRESORES DE AIRE”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('14','Chancadoras y/o trituradoras',null,'¿La planta tiene chancadoras y/o trituradoras?','No tiene equipos en la sección “CHANCADORAS Y/O TRITURADORAS”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('15','Molinos',null,'¿La planta tiene molinos?','No tiene equipos en la sección “MOLINOS”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('16','Fuerza motriz - Motores eléctricos',null,'¿La planta tiene equipos con motores eléctricos?','No tiene equipos en la sección “FUERZA MOTRIZ - MOTORES ELÉCTRICOS”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('17','Fuerza motriz - Otros equipos eléctricos',null,'¿La planta tiene otros equipos con motores eléctricos?','No tiene equipos en la sección “FUERZA MOTRIZ – OTROS EQUIPOS ELÉCTRICOS”','2','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('18',null,null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('19',null,null,null,null,'1','12','0','1','1');

Insert into SISCEUSI.T_GENM_TABLA_MAESTRA (IDTABLAMAESTRA,SUBTITULO,DESCRIPCIONICONOAYUDA,PREGUNTAINICIAL,PREGUNTACIERRE,IDESTILOTABLA,CANTIDADFILAS,AGREGARFILAS,IDESTADO, IDUSUARIOCREACION) values ('20',null,null,null,null,'1','12','0','1','1');

COMMIT;

--ENCABEZADO PRINCIPAL

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('1','1',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('2','1','Cantidad producida',null,'0','2',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('3','2',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('4','2','Combustible comprado',null,'0','2',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('5','3',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('6','3','Otros combustible comprados',null,'0','2',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('7','4',null,null,'0','1',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('8','5',null,null,'0','1',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('9','6',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('10','6','Consumo de combustible',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('11','6','Potencia',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('12','6','Energía producida',null,'0','4',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('13','7',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('14','7','Consumo de combustible',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('15','7','Potencia',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('16','7','Energía producida',null,'0','4',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('17','8',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('18','8','Fuente de energía',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('19','8','Consumo de combustible por hora',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('20','8','Vapor',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('21','8','Destino del vapor',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('22','8','Eficiencia',null,'0','6',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('23','8','Tiempo de operación',null,'0','7',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('24','9',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('25','9','Fuente de energía',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('26','9','Consumo de combustible por hora',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('27','9','Factor de utilización (% sobre capacidad instalada)',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('28','9','Eficiencia',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('29','9','Tiempo de operación',null,'0','6',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('30','10',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('31','10','Fuente de energía',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('32','10','Consumo de combustible por hora',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('33','10','Factor de utilización (% sobre capacidad instalada)',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('34','10','Eficiencia',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('35','10','Tiempo de operación',null,'0','6',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('36','11',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('37','11','Fuente de energía',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('38','11','Consumo de combustible por hora',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('39','11','Factor de utilización (% sobre capacidad instalada)',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('40','11','Eficiencia',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('41','11','Tiempo de operación',null,'0','6',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('42','12',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('43','12','Potencia de placa',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('44','12','Factor de carga',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('45','12','COP',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('46','12','Consumo de electricidad aproximado',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('47','12','Tiempo de operación',null,'0','6',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('48','13',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('49','13','Potencia de placa',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('50','13','Factor de utilización',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('51','13','Eficiencia',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('52','13','Consumo de electricidad aproximado',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('53','13','Tiempo de operación',null,'0','6',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('54','14',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('55','14','Potencia de placa',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('56','14','Factor de utilización',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('57','14','Eficiencia',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('58','14','Consumo de electricidad aproximado',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('59','14','Tiempo de operación',null,'0','6',null,'1');
--MOLINO
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('60','15',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('61','15','Potencia de placa',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('62','15','Factor de utilización',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('63','15','Eficiencia',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('64','15','Consumo de electricidad aproximado',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('65','15','Tiempo de operación',null,'0','6',null,'1');
--MOTORES
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('66','16',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('67','16','Potencia de placa',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('68','16','Factor de utilización',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('69','16','Eficiencia',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('70','16','Consumo de electricidad aproximado',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('71','16','Tiempo de operación',null,'0','6',null,'1');
--OTROS EQUIPOS ELÉCTRICOS
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('72','17',null,null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('73','17','Potencia de placa',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('74','17','Factor de utilización',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('75','17','Eficiencia',null,'0','4',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('76','17','Consumo de electricidad aproximado',null,'0','5',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('77','17','Tiempo de operación',null,'0','6',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('78','18','Tipo vehículo',null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('79','18','Cantidad vehículos',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('80','18','Tipo de combustible',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('81','18','Consumo de combustible',null,'0','4',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('82','19','Tipo vehículo',null,'0','1',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('83','19','Cantidad vehículos',null,'0','2',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('84','19','Tipo de combustible',null,'0','3',null,'1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('85','19','Consumo de combustible',null,'0','4',null,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL (IDENCABEZADOPRINCIPAL,IDTABLAMAESTRA,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,DESCRIPCIONICONOAYUDA,IDESTADO) values ('86','20',null,null,'0','1',null,'1');
COMMIT;

--ENCABEZADO SECUNDARIO
--SECC1
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('1','1','Descripción de la producción',null,'0','1','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('2','2','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('3','2','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
--SECC2
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('4','3','Tipo de combustible',null,'0','1','1',null,'1','0','9','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('5','3','Seleccionar',null,'0','2','1',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('6','4','Cantidad',null,'0','3','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('7','4','Unidad de medida',null,'0','4','1',null,'1','0','30','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('8','4','Cuánto pago',null,'0','5','1',null,'2','2',0,'1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('9','5','Otros tipos de combustibles',null,'0','1','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('10','6','Cantidad',null,'0','2','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('11','6','Unidad de medida',null,'0','3','1',null,'1','0','30','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('12','6','Cuánto pago',null,'0','4','1',null,'2','2',0,'1');
--SECC3
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('13','7','Mes de consumo',null,'0','1','1',null,'1','0','50','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('14','7','Energía activa – Horas punta','(kW.h)','1','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('15','7','Energía activa – Horas fuera de punta','(kW.h)','1','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('16','7','Máxima demanda','(kW)','1','2','1',null,'2','2','0','1');
--SECC4
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('17','8','Mes de consumo',null,'0','1','1',null,'1','0','50','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('18','8','Cantidad','m3','1','2','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('19','9','Equipo',null,'0','1','1',null,'1','0','63','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('20','9','Seleccionar',null,'0','2','1',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('21','9','Cantidad',null,'0','3','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('22','9','Tipo de combustible',null,'0','4','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('23','10','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('24','10','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('25','11','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('26','11','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('27','12','Energía producida','(kwh)','1','2','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('28','13','Otros equipos',null,'0','1','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('29','13','Cantidad',null,'0','2','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('30','13','Tipo de combustible',null,'0','3','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('31','14','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('32','14','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('33','15','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('34','15','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('35','16','Energía producida','(kwh)','1','2','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('36','17','Calderos',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('37','17','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('38','18','Electricidad',null,'0','1','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('39','18','GLP',null,'0','2','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('40','18','Gas natural',null,'0','3','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('41','18','Leña',null,'0','4','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('42','18','Carbón vegetal',null,'0','5','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('43','18','Carbón antracitico',null,'0','6','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('44','18','Carbón bituminoso',null,'0','7','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('45','18','Carbón hulla',null,'0','8','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('46','18','Coque bituminoso',null,'0','9','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('47','18','Petróleo industrial 6',null,'0','10','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('48','18','Petróleo industrial 500',null,'0','11','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('49','18','Diesel',null,'0','12','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('50','18','Gasohol',null,'0','13','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('51','18','Aceite quemado',null,'0','14','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('52','18','Cascarilla de arroz',null,'0','15','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('53','19','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('54','19','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('55','20','Producción media','(BTU/h)','1','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('56','21','% calor',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('57','21','% generación de electricidad',null,'0','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('58','21','% frío',null,'0','3','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('59','22','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('60','23','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('61','23','Días/semana',null,'0','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('62','23','Semanas/año',null,'0','3','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('63','24','Hornos, fraguas y muflas',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('64','24','Producto horneado cocido/hervido/fermentado/ u otros',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('65','25','Electricidad',null,'0','1','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('66','25','GLP',null,'0','2','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('67','25','Gas natural',null,'0','3','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('68','25','Leña',null,'0','4','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('69','25','Carbón vegetal',null,'0','5','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('70','25','Carbón antracitico',null,'0','6','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('71','25','Carbón bituminoso',null,'0','7','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('72','25','Carbón hulla',null,'0','8','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('73','25','Coque bituminoso',null,'0','9','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('74','25','Petróleo industrial 6',null,'0','10','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('75','25','Petróleo industrial 500',null,'0','11','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('76','25','Diesel',null,'0','12','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('77','25','Gasohol',null,'0','13','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('78','25','Aceite quemado',null,'0','14','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('79','25','Cascarilla de arroz',null,'0','15','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('80','26','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('81','26','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('82','27','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('83','28','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('84','29','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('85','29','Días/semana',null,'0','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('86','29','Semanas/año',null,'0','3','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('87','30','Secadores',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('88','30','Producto secado',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('89','31','Electricidad',null,'0','1','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('90','31','GLP',null,'0','2','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('91','31','Gas natural',null,'0','3','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('92','31','Leña',null,'0','4','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('93','31','Carbón vegetal',null,'0','5','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('94','31','Carbón antracitico',null,'0','6','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('95','31','Carbón bituminoso',null,'0','7','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('96','31','Carbón hulla',null,'0','8','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('97','31','Coque bituminoso',null,'0','9','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('98','31','Petróleo industrial 6',null,'0','10','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('99','31','Petróleo industrial 500',null,'0','11','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('100','31','Diesel',null,'0','12','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('101','31','Gasohol',null,'0','13','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('102','31','Aceite quemado',null,'0','14','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('103','31','Cascarilla de arroz',null,'0','15','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('104','32','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('105','32','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('106','33','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('107','34','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('108','35','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('109','35','Días/semana',null,'0','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('110','35','Semanas/año',null,'0','3','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('111','36','Otros equipos',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('112','36','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('113','37','Electricidad',null,'0','1','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('114','37','GLP',null,'0','2','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('115','37','Gas natural',null,'0','3','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('116','37','Leña',null,'0','4','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('117','37','Carbón vegetal',null,'0','5','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('118','37','Carbón antracitico',null,'0','6','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('119','37','Carbón bituminoso',null,'0','7','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('120','37','Carbón hulla',null,'0','8','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('121','37','Coque bituminoso',null,'0','9','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('122','37','Petróleo industrial 6',null,'0','10','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('123','37','Petróleo industrial 500',null,'0','11','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('124','37','Diesel',null,'0','12','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('125','37','Gasohol',null,'0','13','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('126','37','Aceite quemado',null,'0','14','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('127','37','Cascarilla de arroz',null,'0','15','2',null,'6','0','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('128','38','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('129','38','Unidad de medida',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('130','39','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('131','40','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('132','41','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('133','41','Días/semana',null,'0','2','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('134','41','Semanas/año',null,'0','3','1',null,'2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('135','42','Equipo de producción de frío',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('136','42','Tipo de equipo frío',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('137','43','Potencia',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('138','43','Medida',null,'0','2','1',null,'7','0','71','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('139','44','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('140','45','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('141','46','(kW.h/año)',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('142','47','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('143','47','Días/Semana',null,'0','2','1','texto ayuda d. sem.','2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('144','47','Semana/año',null,'0','3','1','texto ayuda año','2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('145','48','Compresores de aire',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('146','48','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('147','49','Potencia',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('148','49','Medida',null,'0','2','1',null,'7','0','71','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('149','50','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('150','51','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('151','52','(kW.h/año)',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('152','53','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('153','53','Días/Semana',null,'0','2','1','texto ayuda d. sem.','2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('154','53','Semana/año',null,'0','3','1','texto ayuda año','2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('155','54','Chancadoras y/o trituradoras',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('156','54','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('157','55','Potencia',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('158','55','Medida',null,'0','2','1',null,'7','0','71','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('159','56','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('160','57','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('161','58','(kW.h/año)',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('162','59','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('163','59','Días/Semana',null,'0','2','1','texto ayuda d. sem.','2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('164','59','Semana/año',null,'0','3','1','texto ayuda año','2','2','0','1');
--MOLINO
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('165','60','Molinos',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('166','60','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('167','61','Potencia',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('168','61','Medida',null,'0','2','1',null,'7','0','71','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('169','62','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('170','63','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('171','64','(kW.h/año)',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('172','65','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('173','65','Días/Semana',null,'0','2','1','texto ayuda d. sem.','2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('174','65','Semana/año',null,'0','3','1','texto ayuda año','2','2','0','1');
--MOTORES
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('175','66','Motores eléctricos',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('176','66','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('177','66','Cantidad',null,'0','3','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('178','67','Potencia',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('179','67','Medida',null,'0','2','1',null,'7','0','71','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('180','68','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('181','69','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('182','70','(kW.h/año)',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('183','71','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('184','71','Días/Semana',null,'0','2','1','texto ayuda d. sem.','2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('185','71','Semana/año',null,'0','3','1','texto ayuda año','2','2','0','1');
--OTROS EQUIPOS ELECTRICOS
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('186','72','Otros equipos eléctricos',null,'0','1','1',null,'1','4','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('187','72','Nombre del equipo',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('188','72','Cantidad',null,'0','3','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('189','73','Potencia',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('190','73','Medida',null,'0','2','1',null,'7','0','71','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('191','74','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('192','75','%',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('193','76','(kW.h/año)',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('194','77','Horas/día',null,'0','1','1',null,'2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('195','77','Días/Semana',null,'0','2','1','texto ayuda d. sem.','2','2','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('196','77','Semana/año',null,'0','3','1','texto ayuda año','2','2','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('197','78','Tipo',null,'0','1','1',null,'5','0','74','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('198','79','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('199','80','Combustible',null,'0','1','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('200','81','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('201','81','Unidad de medida',null,'0','2','1',null,'2','3','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('202','82','Tipo',null,'0','1','1',null,'5','0','82','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('203','83','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('204','84','Combustible',null,'0','1','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('205','85','Cantidad',null,'0','1','1',null,'2','1','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('206','85','Unidad de medida',null,'0','2','1',null,'2','3','0','1');

Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('207','86','Nombres',null,'0','1','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('208','86','Teléfono',null,'0','2','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('209','86','Cargo',null,'0','3','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('210','86','Sección que completo',null,'0','4','1',null,'2','3','0','1');
Insert into SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO (IDENCABEZADOSECUNDARIO,IDENCABEZADOPRINCIPAL,TITULOENCABEZADO,ABREVIACION,USARABREVIADO,POSICION,IDORIENTACION,DESCRIPCIONICONOAYUDA,IDTIPOCONTROL,IDTIPODATO,IDPARAMETRO,IDESTADO) values ('211','86','Comentarios',null,'0','5','1',null,'3','3','0','1');
COMMIT;

--CAMPANA ENCUESTA

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('1','1','A1.	¿Cuál es el subsector industrial de la planta o establecimiento? ','0','2','0','1','SECCIÓN “A” - DATOS DE LA EMPRESA','1','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('2','1',null,'1','5','1','1',null,'0','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('3','1',null,'2','5','2','1','SECCIÓN "B" - TOTAL ENERGÍA COMPRADA','1','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('4','1',null,'3','5','3','1',null,'0','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('5','1',null,'4','5','4','1','SECCIÓN "B" - TOTAL ENERGÍA COMPRADA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('6','1',null,'5','5','5','1','SECCIÓN "B" - TOTAL ENERGÍA COMPRADA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('7','1','C1. La planta ¿dispone de equipos para autogenerar electricidad?','6','4','0','1','SECCIÓN "C" - DATOS DE LA EMPRESA','1','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('8','1','C2. ¿Qué uso le dan a la electricidad autogenerada, para casos de emergencia o programado?','7','4','0','1',null,'0','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('9','1','C3. En la planta, ¿tienen equipos de cogeneración?','8','4','0','1',null,'0','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('10','1',null,'9','5','6','1',null,'0','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('11','1',null,'10','5','7','1',null,'0','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('12','1',null,'11','5','8','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('13','1',null,'12','5','9','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('14','1',null,'13','5','10','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('15','1',null,'14','5','11','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('16','1',null,'15','5','12','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('17','1',null,'16','5','13','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('18','1',null,'17','5','14','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('19','1',null,'18','5','15','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('20','1',null,'19','5','16','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('21','1',null,'20','5','17','1','SECCIÓN "D" - CARACTERÍSTICAS Y CONSUMOS DE LOS PRINCIPALES EQUIPOS DE LA PLANTA','1','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('22','1','E1. La planta o establecimiento ¿cuenta con vehículos para el transporte de trabajadores o clientes?','21','4','0','1','SECCIÓN "E" - DETERMINACIÓN DE LOS USOS DEL TRANSPORTE – TRANSPORTE DE TRABAJADORES / CLIENTES','1','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('23','1',null,'22','5','18','1',null,'0','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('24','1','E6. La planta o establecimiento ¿cuenta con vehículos para el transporte de carga?','23','4','0','1','SECCIÓN "E" - DETERMINACIÓN DE LOS USOS DEL TRANSPORTE – TRANSPORTE DE CARGA','1','0');
Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('25','1',null,'24','5','19','1',null,'0','1');

Insert into SISCEUSI.T_GENM_CAMPANA_ENCUESTA (IDCAMPANAENCUESTA,IDCAMPANA,PREGUNTA,NUMEROORDENPREGUNTA,IDTIPOCONTROL,IDPARAMETROTABLA,IDESTADO,TITULOSECCION,TITULO,SEPARADOR) values ('26','1',null,'25','5','20','1','DATOS DE CONTROL II - INFORMANTE','1','1');
COMMIT;

--RESPUESTA ENCUESTA
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('1','1','Alimentos, bebidas y tabaco','0','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('2','1','Textil, confecciones, calzado y cuero','1','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('3','1','Papel, celulosa y gráfica','2','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('4','1','Maderas y muebles','3','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('5','1','Química, caucho y plástico','4','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('6','1','Cemento','5','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('7','1','Piedras, vidrios y cerámicas','6','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('8','1','Hierro, acero y metales no ferrosos','7','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('9','1','Maquinaria y equipos','8','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('10','1','Otras industrias','9','0','1');

Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('11','7','Si','1','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('12','7','No','2','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('13','8','Si','1','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('14','8','No','2','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('15','9','Si','1','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('16','9','No','2','0','1');

Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('17','22','Si','1','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('18','22','No','2','0','1');

Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('19','24','Si','1','0','1');
Insert into SISCEUSI.T_GEND_RESPUESTA_ENCUESTA (IDRESPUESTAENCUESTA,IDCAMPANAENCUESTA,RESPUESTA,NUMEROORDENRESPUESTA,IDVALORRESPUESTA,IDESTADO) values ('20','24','No','2','0','1');

COMMIT;

--Password = 123456
--AKmJ0HcmIkZrojOXM1ABOtqfi9hhaf/tUBCTT+R4LAlKf76X0QxqmOhAVMDwoUCSiQ==
------------------------------------------------------------------------------------------------------------------------------
/*
DROP SEQUENCE SISCEUSI.SQ_GEND_RESP_ENCUESTA_PLANTA;
DROP SEQUENCE SISCEUSI.SQ_GEND_RESP_ENCUESTA_TABLA;

DROP SEQUENCE SISCEUSI.SQ_GENM_INTENCION_PARTICIPAR;
DROP SEQUENCE SISCEUSI.SQ_GENM_EMPRESA_INDUSTRIA;
DROP SEQUENCE SISCEUSI.SQ_GENM_PLANTA_EMPRESA;
DROP SEQUENCE SISCEUSI.SQ_GENM_USUARIO;
DROP SEQUENCE SISCEUSI.SQ_GEND_CAMPANA_PLANTA;

DROP SEQUENCE SISCEUSI.SQ_GENM_CAMPANA;
DROP SEQUENCE SISCEUSI.SQ_GEND_CAMPANA_EMPRESA;
DROP SEQUENCE SISCEUSI.SQ_GEND_CONTROL_ENCUESTA;
DROP SEQUENCE SISCEUSI.SQ_GENM_CAMPANA_ENCUESTA;
DROP SEQUENCE SISCEUSI.SQ_GEND_RESPUESTA_ENCUESTA;
DROP SEQUENCE SISCEUSI.SQ_GENM_TABLA_MAESTRA;
DROP SEQUENCE SISCEUSI.SQ_GEND_ENCABEZADO_PRINCIPAL;
DROP SEQUENCE SISCEUSI.SQ_GEND_ENCABEZADO_SECUNDARIO;
DROP SEQUENCE SISCEUSI.SQ_GENM_PARAMETRO;

DROP TABLE SISCEUSI.T_MAE_ROL;
DROP TABLE SISCEUSI.T_MAE_DEPARTAMENTO;
DROP TABLE SISCEUSI.T_MAE_PROVINCIA;
DROP TABLE SISCEUSI.T_MAE_DISTRITO;
DROP TABLE SISCEUSI.T_MAE_GIRO;
DROP TABLE SISCEUSI.T_MAE_GRUPO_EMPRESA;
DROP TABLE SISCEUSI.T_MAE_CIUU;
DROP TABLE SISCEUSI.T_GENM_INTENCION_PARTICIPAR;
DROP TABLE SISCEUSI.T_GENM_USUARIO;
DROP TABLE SISCEUSI.T_GENM_PLANTA_EMPRESA;
DROP TABLE SISCEUSI.T_GEND_CAMPANA_EMPRESA;
DROP TABLE SISCEUSI.T_GENM_EMPRESA_INDUSTRIA;

DROP TABLE SISCEUSI.T_GEND_RESP_ENCUESTA_PLANTA;
DROP TABLE SISCEUSI.T_GEND_RESPUESTA_ENCUESTA;
DROP TABLE SISCEUSI.T_GENM_CAMPANA_ENCUESTA;
DROP TABLE SISCEUSI.T_GEND_CONTROL_ENCUESTA;
DROP TABLE SISCEUSI.T_GEND_CAMPANA_EMPRESA;
DROP TABLE SISCEUSI.T_GENM_CAMPANA;

DROP TABLE SISCEUSI.T_GEND_RESP_ENCUESTA_TABLA;
DROP TABLE SISCEUSI.T_GEND_ENCABEZADO_SECUNDARIO;
DROP TABLE SISCEUSI.T_GEND_ENCABEZADO_PRINCIPAL;
DROP TABLE SISCEUSI.T_GENM_TABLA_MAESTRA;

DROP TABLE SISCEUSI.T_GENM_PARAMETRO;

------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM T_GENM_USUARIO;
SELECT * FROM T_GENM_EMPRESA_INDUSTRIA;
SELECT * FROM T_GENM_PLANTA_EMPRESA;
SELECT * FROM T_MAE_GIRO;*/