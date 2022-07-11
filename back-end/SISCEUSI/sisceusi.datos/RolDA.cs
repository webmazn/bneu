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
        public bool GrabarRol(RolBE rol, OracleConnection db)
        {
            bool seGuardo = false;
            try
            {
                string sp = $"{Package.Mantenimiento}USP_UPD_ROL";
                var p = new OracleDynamicParameters();
                p.Add("PI_ID_EQUIPO", rol.idRol);
                p.Add("PI_EQUIPO", rol.rol);
                p.Add("PI_UPD_USUARIO", 0);
                p.Add("pi_ipMoficacion", "");
                p.Add("PO_ROWAFFECTED", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("PO_ROWAFFECTED").Value;
                seGuardo = filasAfectadas > 0;
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }

            return seGuardo;
        }

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
