using Oracle.DataAccess.Client;
using Dapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using sisceusi.Datos;
using sisceusi.entidad;
using System.Data;
using sres.ut;

namespace sisceusi.datos
{
    public class UsuarioDA : BaseDA
    {
        public UsuarioBE obtenerUsuario(int idusuario, OracleConnection db)
        {
            UsuarioBE item = null;
            try
            {
                string sp = $"{Package.Mantenimiento}USP_SEL_GET_USUARIO";
                var p = new OracleDynamicParameters();
                p.Add("pi_idUsuario", idusuario);
                p.Add("po_ref", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<UsuarioBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }
    }
}
