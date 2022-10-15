using Dapper;
using Oracle.DataAccess.Client;
using sisceusi.Datos;
using sisceusi.entidad;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.datos
{
    public class PaginaHomeDA : BaseDA
    {
        public bool grabarBanner(BannerBE entidad, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_PRC_BANNER";
                var p = new OracleDynamicParameters();
                p.Add("piIdBanner", entidad.idBanner);
                p.Add("piTituloBanner", entidad.tituloBanner);
                p.Add("piDescripcionBanner", entidad.descripcionBanner);
                p.Add("piDescripcionFija", entidad.descripcionFija);
                p.Add("piTituloBoton", entidad.tituloBoton);
                p.Add("piEnlaceBoton", entidad.enlaceBoton);
                p.Add("piNombreArchivoBanner", entidad.nombreArchivoBanner);
                p.Add("piNombreArchivoGeneradoBanner", entidad.nombreArchivoGeneradoBanner);
                p.Add("piIdEstado", entidad.idEstado);
                p.Add("piIdUsuarioCreacion", entidad.idUsuarioCreacion);
                p.Add("piIpCreacion", entidad.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public List<BannerBE> mostrarListaBanner(BannerBE entidad, OracleConnection db)
        {
            List<BannerBE> lista = new List<BannerBE>();
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LIST_BANNER";
                var p = new OracleDynamicParameters();
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new BannerBE
                {
                    idBanner = (int)x.IDBANNER,
                    tituloBanner = x.TITULOBANNER == null ? "" : (string)x.TITULOBANNER,
                    descripcionBanner = x.DESCRIPCIONBANNER == null ? "" : (string)x.DESCRIPCIONBANNER,
                    descripcionFija = x.DESCRIPCIONFIJA == null ? "" : (string)x.DESCRIPCIONFIJA,
                    tituloBoton = x.TITULOBOTON == null ? "" : (string)x.TITULOBOTON,
                    enlaceBoton = x.ENLACEBOTON == null ? "" : (string)x.ENLACEBOTON,
                    nombreArchivoBanner = x.NOMBREARCHIVOBANNER == null ? "" : (string)x.NOMBREARCHIVOBANNER,
                    idEstado = x.IDESTADO == null ? "0" : (string)x.IDESTADO,
                    fila = (int)x.FILA,
                    totalPaginas = (int)x.TOTALPAGINAS,
                    pagina = (int)x.PAGINA,
                    registros = (int)x.REGISTROS,
                    totalRegistros = (int)x.TOTALREGISTROS
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public BannerBE obtenerBanner(BannerBE empresa, OracleConnection db)
        {
            BannerBE item = null;
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_BANNER";
                var p = new OracleDynamicParameters();
                p.Add("piIdBanner", empresa.idBanner);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<BannerBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool eliminarBanner(BannerBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_UPD_DESHABILITAR_BANNER";
                var p = new OracleDynamicParameters();
                p.Add("piIdBanner", entidad.idBanner);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public bool grabarPublicacion(PublicacionBE entidad, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_PRC_PUBLICACION";
                var p = new OracleDynamicParameters();
                p.Add("piIdPublicacion", entidad.idPublicacion);
                p.Add("piTituloPublicacion", entidad.tituloPublicacion);
                p.Add("piDescripcionPublicacion", entidad.descripcionPublicacion);
                p.Add("piNombreArchivoPublicacion", entidad.nombreArchivoPublicacion);
                p.Add("piNombreArchivoGeneradoPubli", entidad.nombreArchivoGeneradoPubli);
                p.Add("piIdEstado", entidad.idEstado);
                p.Add("piIdUsuarioCreacion", entidad.idUsuarioCreacion);
                p.Add("piIpCreacion", entidad.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public List<PublicacionBE> mostrarListaPublicacion(PublicacionBE entidad, OracleConnection db)
        {
            List<PublicacionBE> lista = new List<PublicacionBE>();
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LIST_PUBLICACION";
                var p = new OracleDynamicParameters();
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PublicacionBE
                {
                    idPublicacion = (int)x.IDPUBLICACION,
                    tituloPublicacion = x.TITULOPUBLICACION == null ? "" : (string)x.TITULOPUBLICACION,
                    descripcionPublicacion = x.DESCRIPCIONPUBLICACION == null ? "" : (string)x.DESCRIPCIONPUBLICACION,
                    nombreArchivoPublicacion = x.NOMBREARCHIVOPUBLICACION == null ? "" : (string)x.NOMBREARCHIVOPUBLICACION,
                    idEstado = x.IDESTADO == null ? "0" : (string)x.IDESTADO,
                    fila = (int)x.FILA,
                    totalPaginas = (int)x.TOTALPAGINAS,
                    pagina = (int)x.PAGINA,
                    registros = (int)x.REGISTROS,
                    totalRegistros = (int)x.TOTALREGISTROS
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public PublicacionBE obtenerPublicacion(PublicacionBE entidad, OracleConnection db)
        {
            PublicacionBE item = null;
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_PUBLICACION";
                var p = new OracleDynamicParameters();
                p.Add("piIdPublicacion", entidad.idPublicacion);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<PublicacionBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool eliminarPublicacion(PublicacionBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_UPD_DESHABILITAR_PUBLI";
                var p = new OracleDynamicParameters();
                p.Add("piIdPublicacion", entidad.idPublicacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public bool grabarEnlace(EnlaceBE entidad, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_PRC_ENLACE";
                var p = new OracleDynamicParameters();
                p.Add("piIdEnlace", entidad.idEnlace);
                p.Add("piTituloEnlace", entidad.tituloEnlace);
                p.Add("piDescripcionEnlace", entidad.descripcionEnlace);
                p.Add("piIdEstado", entidad.idEstado);
                p.Add("piIdUsuarioCreacion", entidad.idUsuarioCreacion);
                p.Add("piIpCreacion", entidad.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public List<EnlaceBE> mostrarListaEnlace(EnlaceBE entidad, OracleConnection db)
        {
            List<EnlaceBE> lista = new List<EnlaceBE>();
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LIST_ENLACE";
                var p = new OracleDynamicParameters();
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EnlaceBE
                {
                    idEnlace = (int)x.IDENLACE,
                    tituloEnlace = x.TITULOENLACE == null ? "" : (string)x.TITULOENLACE,
                    descripcionEnlace = x.DESCRIPCIONENLACE == null ? "" : (string)x.DESCRIPCIONENLACE,
                    idEstado = x.IDESTADO == null ? "0" : (string)x.IDESTADO,
                    fila = (int)x.FILA,
                    totalPaginas = (int)x.TOTALPAGINAS,
                    pagina = (int)x.PAGINA,
                    registros = (int)x.REGISTROS,
                    totalRegistros = (int)x.TOTALREGISTROS
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public EnlaceBE obtenerEnlace(EnlaceBE entidad, OracleConnection db)
        {
            EnlaceBE item = null;
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_ENLACE";
                var p = new OracleDynamicParameters();
                p.Add("piIdEnlace", entidad.idEnlace);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<EnlaceBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool eliminarEnlace(EnlaceBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_UPD_DESHABILITAR_ENLACE";
                var p = new OracleDynamicParameters();
                p.Add("piIdEnlace", entidad.idEnlace);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public bool grabarLogoRedSocial(LogoRedSocialBE entidad, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.PaginaHome}USP_PRC_LOGO_RED_SOCIAL";
                var p = new OracleDynamicParameters();
                p.Add("piIdLogoRedSocial", entidad.idLogoRedSocial);
                p.Add("piNombreArchivoLogoWeb", entidad.nombreArchivoLogoWeb);
                p.Add("piNombreArchivoGeneradoLogoWeb", entidad.nombreArchivoGeneradoLogoWeb);
                p.Add("piNombreArchivoLogoDgee", entidad.nombreArchivoLogoDgee);
                p.Add("piNombreArchivoGeneradoLogoD", entidad.nombreArchivoGeneradoLogoDgee);
                p.Add("piEnlaceFacebook", entidad.enlaceFacebook);
                p.Add("piEnlaceTwiter", entidad.enlaceTwiter);
                p.Add("piEnlaceInstangram", entidad.enlaceInstangram);
                p.Add("piEnlaceYoutube", entidad.enlaceYoutube);
                p.Add("piEnlaceWhatsApp", entidad.enlaceWhatsApp);
                p.Add("piEnlaceLinkedin", entidad.enlaceLinkedin);
                p.Add("piTituloNavegador", entidad.tituloNavegador);
                p.Add("piChatbot", entidad.chatbot);
                p.Add("piIdUsuarioCreacion", entidad.idUsuarioCreacion);
                p.Add("piIpCreacion", entidad.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public LogoRedSocialBE obtenerLogoRedSocial(LogoRedSocialBE entidad, OracleConnection db)
        {
            LogoRedSocialBE item = null;
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LOGO_RED_SOCIAL";
                var p = new OracleDynamicParameters();
                //p.Add("piIdLogoRedSocial", entidad.idLogoRedSocial);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<LogoRedSocialBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public List<BannerBE> mostrarListaBannerAll(OracleConnection db)
        {
            List<BannerBE> lista = new List<BannerBE>();
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LIST_ALL_BANNER";
                var p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new BannerBE
                {
                    idBanner = (int)x.IDBANNER,
                    tituloBanner = x.TITULOBANNER == null ? "" : (string)x.TITULOBANNER,
                    descripcionBanner = x.DESCRIPCIONBANNER == null ? "" : (string)x.DESCRIPCIONBANNER,
                    descripcionFija = x.DESCRIPCIONFIJA == null ? "" : (string)x.DESCRIPCIONFIJA,
                    tituloBoton = x.TITULOBOTON == null ? "" : (string)x.TITULOBOTON,
                    enlaceBoton = x.ENLACEBOTON == null ? "" : (string)x.ENLACEBOTON,
                    nombreArchivoBanner = x.NOMBREARCHIVOBANNER == null ? "" : (string)x.NOMBREARCHIVOBANNER,
                    nombreArchivoGeneradoBanner = x.NOMBREARCHIVOGENERADOBANNER == null ? "" : (string)x.NOMBREARCHIVOGENERADOBANNER,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<PublicacionBE> mostrarListaPublicacionAll(OracleConnection db)
        {
            List<PublicacionBE> lista = new List<PublicacionBE>();
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LIST_ALL_PUBLICACION";
                var p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PublicacionBE
                {
                    idPublicacion = (int)x.IDPUBLICACION,
                    tituloPublicacion = x.TITULOPUBLICACION == null ? "" : (string)x.TITULOPUBLICACION,
                    descripcionPublicacion = x.DESCRIPCIONPUBLICACION == null ? "" : (string)x.DESCRIPCIONPUBLICACION,
                    nombreArchivoPublicacion = x.NOMBREARCHIVOPUBLICACION == null ? "" : (string)x.NOMBREARCHIVOPUBLICACION,
                    nombreArchivoGeneradoPubli = x.NOMBREARCHIVOGENERADOPUBLI == null ? "" : (string)x.NOMBREARCHIVOGENERADOPUBLI,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<EnlaceBE> mostrarListaEnlaceAll(OracleConnection db)
        {
            List<EnlaceBE> lista = new List<EnlaceBE>();
            try
            {
                string sp = $"{Package.PaginaHome}USP_SEL_LIST_ALL_ENLACE";
                var p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EnlaceBE
                {
                    idEnlace = (int)x.IDENLACE,
                    tituloEnlace = x.TITULOENLACE == null ? "" : (string)x.TITULOENLACE,
                    descripcionEnlace = x.DESCRIPCIONENLACE == null ? "" : (string)x.DESCRIPCIONENLACE,
                    fila = (int)x.FILA,
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
