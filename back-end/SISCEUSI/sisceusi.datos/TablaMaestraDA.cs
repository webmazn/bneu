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
                    tituloPrincipal = (string)x.TITULOPRINCIPAL,
                    subtitulo = (string)x.SUBTITULO,
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
                p.Add("piTituloPrincipal", empresa.tituloPrincipal);
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
                    tituloPrincipal = (string)x.TITULOPRINCIPAL,
                    subtitulo = (string)x.SUBTITULO,
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
                    tituloPrincipal = (string)x.TITULOPRINCIPAL,
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
                p.Add("piTituloPrincipal", empresa.tituloPrincipal);
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
                    tituloPrincipal = (string)x.TITULOPRINCIPAL,
                    subtitulo = (string)x.SUBTITULO,
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
                    tituloEncabezado = (string)x.TITULOENCABEZADO,
                    abreviacion = (string)x.ABREVIACION,
                    usarAbreviado = (string)x.USARABREVIADO,
                    descripcionIconoAyuda = (string)x.DESCRIPCIONICONOAYUDA,
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
                p.Add("piTituloPrincipal", tablaMaestra.tituloPrincipal);
                p.Add("piSubtitulo", tablaMaestra.subtitulo);
                p.Add("piDescripcionIconoAyuda", tablaMaestra.descripcionIconoAyuda);
                p.Add("piPreguntaInicial", tablaMaestra.preguntaInicial);
                p.Add("piPreguntaCierre", tablaMaestra.preguntaCierre);
                p.Add("piIdEstiloTabla", tablaMaestra.idEstiloTabla);
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
                p.Add("piDescripcionIconoAyuda", encabezado.descripcionIconoAyuda);
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
                p.Add("piDescripcionIconoAyuda", encabezado.descripcionIconoAyuda);
                p.Add("piIdOrientacion", encabezado.idOrientacion);
                p.Add("piIdTipoControl", encabezado.idTipoControl);
                p.Add("piIdTipoDato", encabezado.idTipoDato);
                p.Add("piIdParametro", encabezado.idParametro);
                p.Add("piCantidadFilas", encabezado.cantidadFilas);
                p.Add("piAgregarFilas", encabezado.agregarFilas);
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
    }
}
