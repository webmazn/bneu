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
    public class LoginDA : BaseDA
    {
        public UsuarioBE obtenerUsuarioPorCorreo(UsuarioBE usuario, OracleConnection db)
        {
            UsuarioBE item = null;
            try
            {
                string sp = $"{Package.Login}USP_SEL_USUARIO_CORREO";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("pi_correo", dbType: OracleDbType.Varchar2, direction: ParameterDirection.Input, value: usuario.correoElectronico);
                p.Add("po_ref", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<UsuarioBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }
    }
}
