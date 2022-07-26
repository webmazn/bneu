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
    public class DistritoDA : BaseDA
    {
        public List<DistritoBE> obtenerListaDistrito(OracleConnection db)
        {
            List<DistritoBE> lista = new List<DistritoBE>();
            try
            {
                string sp = $"{Package.Distrito}USP_SEL_LISTA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<DistritoBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
