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
