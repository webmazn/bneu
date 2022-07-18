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
    public class GrupoEmpresaDA : BaseDA
    {
        public List<GrupoEmpresaBE> obtenerListaGrupoEmpresa(OracleConnection db)
        {
            List<GrupoEmpresaBE> lista = new List<GrupoEmpresaBE>();
            try
            {
                string sp = $"{Package.GrupoEmpresa}USP_SEL_LISTA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<GrupoEmpresaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
