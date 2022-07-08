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
    public class RolDA : BaseDA
    {
        public RolBE obtenerRol(RolBE entidad, OracleConnection db)
        {
            RolBE item = null;
            try
            {
                string sp = $"{Package.Mantenimiento}USP_SEL_GET_ROL";
                var p = new OracleDynamicParameters();
                p.Add("pi_idRol", entidad.idRol);
                p.Add("po_ref", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.Query<RolBE>(sp, p, commandType: CommandType.StoredProcedure).FirstOrDefault();
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }
    }
}
