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
    public class EmpresaIndustriaDA : BaseDA
    {
        public List<EmpresaIndustriaBE> filtroGeneral(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", empresa.buscar);
                p.Add("piRegistros", empresa.registros);
                p.Add("piPagina", empresa.pagina);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EmpresaIndustriaBE
                {
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ruc = (string)x.RUC,
                    nombreEmpresa = (string)x.NOMBREEMPRESA,
                    representanteLegal = (string)x.REPRESENTANTELEGAL,
                    giro = new GiroBE { giro = (string)x.GIRO },
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

        public List<EmpresaIndustriaBE> filtroAvanzado(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_BUSQUEDA_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piRuc", empresa.ruc);
                p.Add("piNombreEmpresa", empresa.nombreEmpresa);
                p.Add("piRepresentanteLegal", empresa.representanteLegal);
                p.Add("piCorreo", empresa.correoElectronico);
                p.Add("piFechaInicio", empresa.fechaInicio);
                p.Add("piFechaFin", empresa.fechaFin);                
                p.Add("piIdEstado", empresa.idEstado);
                p.Add("piRegistros", empresa.registros);
                p.Add("piPagina", empresa.pagina);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EmpresaIndustriaBE
                {
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ruc = (string)x.RUC,
                    nombreEmpresa = (string)x.NOMBREEMPRESA,
                    representanteLegal = (string)x.REPRESENTANTELEGAL,
                    giro = new GiroBE { giro = (string)x.GIRO },
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

        public List<EmpresaIndustriaBE> exportarGeneral(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_EXPORTAR_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", empresa.buscar);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EmpresaIndustriaBE
                {
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ruc = (string)x.RUC,
                    nombreEmpresa = (string)x.NOMBREEMPRESA,
                    representanteLegal = (string)x.REPRESENTANTELEGAL,
                    giro = new GiroBE { giro = (string)x.GIRO },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<EmpresaIndustriaBE> exportarAvanzado(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_EXPORTAR_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piRuc", empresa.ruc);
                p.Add("piNombreEmpresa", empresa.nombreEmpresa);
                p.Add("piRepresentanteLegal", empresa.representanteLegal);
                p.Add("piCorreo", empresa.correoElectronico);
                p.Add("piFechaInicio", empresa.fechaInicio);
                p.Add("piFechaFin", empresa.fechaFin);
                p.Add("piIdEstado", empresa.idEstado);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EmpresaIndustriaBE
                {
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ruc = (string)x.RUC,
                    nombreEmpresa = (string)x.NOMBREEMPRESA,
                    representanteLegal = (string)x.REPRESENTANTELEGAL,
                    giro = new GiroBE { giro = (string)x.GIRO },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarEmpresaIndustria(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_PRC_GUARDAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresaIndustria", empresa.idEmpresaIndustria);
                p.Add("piNombreEmpresa", empresa.nombreEmpresa);
                p.Add("piNombreComercial", empresa.nombreComercial);
                p.Add("piRuc", empresa.ruc);
                p.Add("piIdGiro", empresa.idGiro);
                p.Add("piIdGrupoEmpresa", empresa.idGrupoEmpresa);
                p.Add("piIdCiuu", empresa.idCiuu);
                p.Add("piDireccionFiscal", empresa.direccionFiscal);
                p.Add("piCorreo", empresa.correoElectronico);
                p.Add("piRepresentanteLegal", empresa.representanteLegal);
                p.Add("piDni", empresa.dni);
                p.Add("piIdEstado", empresa.idEstado);
                p.Add("piIdUsuarioCreacion", empresa.idUsuarioCreacion);
                p.Add("piIpCreacion", empresa.ipCreacion);                
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool eliminar(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_UPD_DESHABILITAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresa", empresa.idEmpresaIndustria);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public EmpresaIndustriaBE obtenerEmpresa(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            EmpresaIndustriaBE item = null;
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresa", empresa.idEmpresaIndustria);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<EmpresaIndustriaBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public List<EmpresaIndustriaBE> obtenerListaEmpresa(OracleConnection db)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_LISTA";
                var p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<EmpresaIndustriaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public EmpresaIndustriaBE obtenerEmpresaPorRuc(EmpresaIndustriaBE empresa, OracleConnection db)
        {
            EmpresaIndustriaBE item = null;
            try
            {
                string sp = $"{Package.EmpresaIndustria}USP_SEL_POR_RUC";
                var p = new OracleDynamicParameters();
                p.Add("piRuc", empresa.ruc);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<EmpresaIndustriaBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }
    }
}
