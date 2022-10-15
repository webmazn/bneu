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
    public class TablaMaestraDA : BaseDA
    {
        public List<TablaMaestraBE> filtroGeneral(TablaMaestraBE empresa, OracleConnection db)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", empresa.buscar);
                p.Add("piRegistros", empresa.registros);
                p.Add("piPagina", empresa.pagina);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new TablaMaestraBE
                {
                    idTablaMaestra = (int)x.IDTABLAMAESTRA,
                    //tituloPrincipal = x.TITULOPRINCIPAL == null ? "" : (string)x.TITULOPRINCIPAL,
                    subtitulo = x.SUBTITULO == null ? "" : (string)x.SUBTITULO,
                    usuarioRegistro = new UsuarioBE { nombres = (string)x.NOMBRES },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
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

        public List<TablaMaestraBE> filtroAvanzado(TablaMaestraBE empresa, OracleConnection db)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_BUSQUEDA_AVANZADO";
                var p = new OracleDynamicParameters();
                //p.Add("piTituloPrincipal", empresa.tituloPrincipal);
                p.Add("piSubtitulo", empresa.subtitulo);
                p.Add("piFechaInicio", empresa.fechaInicio);
                p.Add("piFechaFin", empresa.fechaFin);
                p.Add("piNombres", empresa.usuarioRegistro.nombres);
                p.Add("piIdEstado", empresa.idEstado);
                p.Add("piRegistros", empresa.registros);
                p.Add("piPagina", empresa.pagina);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new TablaMaestraBE
                {
                    idTablaMaestra = (int)x.IDTABLAMAESTRA,
                    //tituloPrincipal = x.TITULOPRINCIPAL == null ? "" : (string)x.TITULOPRINCIPAL,
                    subtitulo = x.SUBTITULO == null ? "" : (string)x.SUBTITULO,
                    usuarioRegistro = new UsuarioBE { nombres = (string)x.NOMBRES },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
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

        public List<TablaMaestraBE> exportarGeneral(TablaMaestraBE empresa, OracleConnection db)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_EXPORTAR_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", empresa.buscar);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new TablaMaestraBE
                {
                    idTablaMaestra = (int)x.IDTABLAMAESTRA,
                    //tituloPrincipal = x.TITULOPRINCIPAL == null ? "" : (string)x.TITULOPRINCIPAL,
                    subtitulo = (string)x.SUBTITULO,
                    usuarioRegistro = new UsuarioBE { nombres = (string)x.NOMBRES },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<TablaMaestraBE> exportarAvanzado(TablaMaestraBE empresa, OracleConnection db)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_EXPORTAR_AVANZADO";
                var p = new OracleDynamicParameters();
                //p.Add("piTituloPrincipal", empresa.tituloPrincipal);
                p.Add("piSubtitulo", empresa.subtitulo);
                p.Add("piFechaInicio", empresa.fechaInicio);
                p.Add("piFechaFin", empresa.fechaFin);
                p.Add("piNombres", empresa.usuarioRegistro.nombres);
                p.Add("piIdEstado", empresa.idEstado);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new TablaMaestraBE
                {
                    idTablaMaestra = (int)x.IDTABLAMAESTRA,
                    //tituloPrincipal = x.TITULOPRINCIPAL == null ? "" : (string)x.TITULOPRINCIPAL,
                    subtitulo = x.SUBTITULO == null ? "" : (string)x.SUBTITULO,
                    usuarioRegistro = new UsuarioBE { nombres = (string)x.NOMBRES },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<EncabezadoPrincipalBE> mostrarListaEncabezadoPrincipal(EncabezadoPrincipalBE entidad, OracleConnection db)
        {
            List<EncabezadoPrincipalBE> lista = new List<EncabezadoPrincipalBE>();
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_BUSQ_GEN_ENC_PRINC";
                var p = new OracleDynamicParameters();
                p.Add("piIdTablaMaestra", entidad.idTablaMaestra);
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EncabezadoPrincipalBE
                {
                    idEncabezadoPrincipal = (int)x.IDENCABEZADOPRINCIPAL,
                    tituloEncabezado = x.TITULOENCABEZADO == null ? "" : (string)x.TITULOENCABEZADO,
                    abreviacion = x.ABREVIACION == null ? "" : (string)x.ABREVIACION,
                    usarAbreviado = x.USARABREVIADO == null ? "" : (string)x.USARABREVIADO,
                    posicion = x.POSICION == null ? 0 : (int)x.POSICION,
                    descripcionIconoAyuda = x.DESCRIPCIONICONOAYUDA == null ? "" : (string)x.DESCRIPCIONICONOAYUDA,
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

        public List<EncabezadoSecundarioBE> mostrarListaEncabezadoSecundario(EncabezadoSecundarioBE entidad, OracleConnection db)
        {
            List<EncabezadoSecundarioBE> lista = new List<EncabezadoSecundarioBE>();
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_BUSQ_GEN_ENC_SECUN";
                var p = new OracleDynamicParameters();
                p.Add("piIdTablaMaestra", entidad.encabezadoPrincipal.idTablaMaestra);
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EncabezadoSecundarioBE
                {
                    idEncabezadoSecundario = (int)x.IDENCABEZADOSECUNDARIO,
                    tituloEncabezado = x.TITULOENCABEZADO == null ? "" : (string)x.TITULOENCABEZADO,
                    abreviacion = x.ABREVIACION == null ? "" : (string)x.ABREVIACION,
                    usarAbreviado = x.USARABREVIADO == null ? "" : (string)x.USARABREVIADO,
                    posicion = x.POSICION == null ? 0 : (int)x.POSICION,
                    encabezadoPrincipal = new EncabezadoPrincipalBE { tituloEncabezado = x.ENCABEZADOPRINCIPAL == null ? "" : (string)x.ENCABEZADOPRINCIPAL },
                    descripcionIconoAyuda = x.DESCRIPCIONICONOAYUDA == null ? "" : (string)x.DESCRIPCIONICONOAYUDA,
                    tipoDato = new TipoDatoBE { tipoDato = x.TIPODATO == null ? "" :(string)x.TIPODATO },
                    parametro = new ParametroBE { parametro = x.PARAMETRO == null ? "" : (string)x.PARAMETRO },
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

        public bool grabarTablaMaestra(TablaMaestraBE tablaMaestra, out int idTablaMaestra, OracleConnection db)
        {
            idTablaMaestra = -1;
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_PRC_GUARDAR_TABLA_MAESTRA";
                var p = new OracleDynamicParameters();
                p.Add("piIdTablaMaestra", tablaMaestra.idTablaMaestra);
                //p.Add("piTituloPrincipal", tablaMaestra.tituloPrincipal);
                p.Add("piSubtitulo", tablaMaestra.subtitulo);
                p.Add("piDescripcionIconoAyuda", tablaMaestra.descripcionIconoAyuda);
                p.Add("piPreguntaInicial", tablaMaestra.preguntaInicial);
                p.Add("piPreguntaCierre", tablaMaestra.preguntaCierre);
                p.Add("piIdEstiloTabla", tablaMaestra.idEstiloTabla);
                p.Add("piCantidadFilas", tablaMaestra.cantidadFilas);
                p.Add("piAgregarFilas", tablaMaestra.agregarFilas);
                p.Add("piIdEstado", tablaMaestra.idEstado);
                p.Add("piIdUsuarioCreacion", tablaMaestra.idUsuarioCreacion);
                p.Add("piIpCreacion", tablaMaestra.ipCreacion);
                p.Add("poIdTablaMaestra", -1, OracleDbType.Int32, ParameterDirection.Output);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                idTablaMaestra = (int)p.Get<dynamic>("poIdTablaMaestra").Value;
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool grabarEncabezadoPrincipal(EncabezadoPrincipalBE encabezado, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_PRC_GUARDAR_ENC_PRINCIPAL";
                var p = new OracleDynamicParameters();
                p.Add("piIdEncabezadoPrincipal", encabezado.idEncabezadoPrincipal);
                p.Add("piIdTablaMaestra", encabezado.idTablaMaestra);
                p.Add("piTituloEncabezado", encabezado.tituloEncabezado);
                p.Add("piAbreviacion", encabezado.abreviacion);
                p.Add("piUsarAbreviado", encabezado.usarAbreviado);
                p.Add("piPosicion", encabezado.posicion);
                p.Add("piDescripcionIconoAyuda", encabezado.descripcionIconoAyuda);
                p.Add("piIdEstado", encabezado.idEstado);
                p.Add("piIdUsuarioCreacion", encabezado.idUsuarioCreacion);
                p.Add("piIpCreacion", encabezado.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool grabarEncabezadoSecundario(EncabezadoSecundarioBE encabezado, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_PRC_GUARDAR_ENC_SECUNDARIO";
                var p = new OracleDynamicParameters();
                p.Add("piIdEncabezadoSecundario", encabezado.idEncabezadoSecundario);
                p.Add("piIdEncabezadoPrincipal", encabezado.idEncabezadoPrincipal);                
                p.Add("piTituloEncabezado", encabezado.tituloEncabezado);
                p.Add("piAbreviacion", encabezado.abreviacion);
                p.Add("piUsarAbreviado", encabezado.usarAbreviado);
                p.Add("piPosicion", encabezado.posicion);
                p.Add("piDescripcionIconoAyuda", encabezado.descripcionIconoAyuda);
                p.Add("piIdOrientacion", encabezado.idOrientacion);
                p.Add("piIdTipoControl", encabezado.idTipoControl);
                p.Add("piIdTipoDato", encabezado.idTipoDato);
                p.Add("piIdParametro", encabezado.idParametro);
                p.Add("piIdEstado", encabezado.idEstado);
                p.Add("piIdUsuarioCreacion", encabezado.idUsuarioCreacion);
                p.Add("piIpCreacion", encabezado.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public List<EncabezadoPrincipalBE> obtenerListaEncabezadoPrincipal(EncabezadoPrincipalBE encabezado, OracleConnection db)
        {
            List<EncabezadoPrincipalBE> lista = new List<EncabezadoPrincipalBE>();

            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_LIST_PRINCIPAL";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("piIdTablaMaestra", encabezado.idTablaMaestra);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<EncabezadoPrincipalBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }

            return lista;
        }

        public TablaMaestraBE obtenerTablaMaestra(TablaMaestraBE encabezado, OracleConnection db)
        {
            TablaMaestraBE item = null;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdTablaMaestra", encabezado.idTablaMaestra);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<TablaMaestraBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public EncabezadoPrincipalBE obtenerEncabezadoPrincipal(EncabezadoPrincipalBE encabezado, OracleConnection db)
        {
            EncabezadoPrincipalBE item = null;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_OBJECT_PRINCIPAL";
                var p = new OracleDynamicParameters();
                p.Add("piIdEncabezadoPrincipal", encabezado.idEncabezadoPrincipal);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<EncabezadoPrincipalBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public EncabezadoSecundarioBE obtenerEncabezadoSecundario(EncabezadoSecundarioBE encabezado, OracleConnection db)
        {
            EncabezadoSecundarioBE item = null;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_OBJECT_SECUNDARIO";
                var p = new OracleDynamicParameters();
                p.Add("piIdEncabezadoSecundario", encabezado.idEncabezadoSecundario);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<EncabezadoSecundarioBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool eliminar(TablaMaestraBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_UPD_DESHABILITAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdTablaMaestra", entidad.idTablaMaestra);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public bool eliminarPrincipal(EncabezadoPrincipalBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_UPD_DESHABILITAR_PRINC";
                var p = new OracleDynamicParameters();
                p.Add("piIdEncabezadoPrincipal", entidad.idEncabezadoPrincipal);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public bool eliminarSecundario(EncabezadoSecundarioBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.TablaMaestra}USP_UPD_DESHABILITAR_SECUN";
                var p = new OracleDynamicParameters();
                p.Add("piIdEncabezadoSecundario", entidad.idEncabezadoSecundario);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }


        public List<TablaMaestraBE> obtenerListaTablaMaestra(OracleConnection db)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();

            try
            {
                string sp = $"{Package.TablaMaestra}USP_SEL_LISTA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<TablaMaestraBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }

            return lista;
        }
    }
}
