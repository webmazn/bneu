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
    public class ParametroDA : BaseDA
    {

        public List<ParametroBE> filtroGeneral(ParametroBE entidad, OracleConnection db)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                string sp = $"{Package.Parametro}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", entidad.buscar);
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("piColumna", entidad.columna);
                p.Add("piOrden", entidad.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new ParametroBE
                {
                    idParametro = (int)x.IDPARAMETRO,
                    parametro = (string)x.PARAMETRO,
                    parentParametro = x.PARENTPARAMETRO == null ? "" : (string)x.PARENTPARAMETRO,
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

        public List<ParametroBE> filtroAvanzado(ParametroBE entidad, OracleConnection db)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                string sp = $"{Package.Parametro}USP_SEL_BUSQUEDA_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piParentParametro", entidad.parentParametro);
                p.Add("piParametro", entidad.parametro);
                p.Add("piIdTipoParametro", entidad.idTipoParametro);
                p.Add("piFechaInicio", entidad.fechaInicio);
                p.Add("piFechaFin", entidad.fechaFin);
                p.Add("piIdEstado", entidad.idEstado);
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("piColumna", entidad.columna);
                p.Add("piOrden", entidad.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new ParametroBE
                {
                    idParametro = (int)x.IDPARAMETRO,
                    parametro = (string)x.PARAMETRO,
                    parentParametro = x.PARENTPARAMETRO == null ? "" : (string)x.PARENTPARAMETRO,
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

        public List<ParametroBE> exportarGeneral(ParametroBE entidad, OracleConnection db)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                string sp = $"{Package.Parametro}USP_SEL_EXPORTAR_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", entidad.buscar);
                p.Add("piColumna", entidad.columna);
                p.Add("piOrden", entidad.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new ParametroBE
                {
                    idParametro = (int)x.IDPARAMETRO,
                    parametro = (string)x.PARAMETRO,
                    parentParametro = x.PARENTPARAMETRO == null ? "" : (string)x.PARENTPARAMETRO,
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<ParametroBE> exportarAvanzado(ParametroBE entidad, OracleConnection db)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                string sp = $"{Package.Parametro}USP_SEL_EXPORTAR_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piParentParametro", entidad.parentParametro);
                p.Add("piParametro", entidad.parametro);
                p.Add("piIdTipoParametro", entidad.idTipoParametro);
                p.Add("piFechaInicio", entidad.fechaInicio);
                p.Add("piFechaFin", entidad.fechaFin);
                p.Add("piIdEstado", entidad.idEstado);
                p.Add("piColumna", entidad.columna);
                p.Add("piOrden", entidad.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new ParametroBE
                {
                    idParametro = (int)x.IDPARAMETRO,
                    parametro = (string)x.PARAMETRO,
                    parentParametro = x.PARENTPARAMETRO == null ? "" : (string)x.PARENTPARAMETRO,
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarParametro(ParametroBE parametro, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Parametro}USP_PRC_GUARDAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdParametro", parametro.idParametro);
                p.Add("piParametro", parametro.parametro);
                p.Add("piIdParentParametro", parametro.idParentParametro);
                p.Add("piIdTipoParametro", parametro.idTipoParametro);
                p.Add("piIdEstado", parametro.idEstado);
                p.Add("piIdUsuarioCreacion", parametro.idUsuarioCreacion);
                p.Add("piIpCreacion", parametro.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public ParametroBE obtenerParametro(ParametroBE entidad, OracleConnection db)
        {
            ParametroBE item = null;
            try
            {
                string sp = $"{Package.Parametro}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdParametro", entidad.idParametro);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<ParametroBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool eliminar(ParametroBE empresa, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.Parametro}USP_UPD_DESHABILITAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdParametro", empresa.idParametro);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }               

        public List<ParametroBE> obtenerListaParametro(OracleConnection db)
        {
            List<ParametroBE> lista = new List<ParametroBE>();

            try
            {
                string sp = $"{Package.Parametro}USP_SEL_LISTA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<ParametroBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }

            return lista;
        }
    }
}
