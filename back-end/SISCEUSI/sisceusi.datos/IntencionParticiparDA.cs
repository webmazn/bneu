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
    public class IntencionParticiparDA : BaseDA
    {
        public bool GrabarIntencionParticipar(IntencionParticiparBE intencionParticipar, OracleConnection db)
        {
            bool seGuardo = false;
            try
            {
                string sp = $"{Package.Externo}USP_REG_INTENC_PARTICIPAR";
                var p = new OracleDynamicParameters();
                p.Add("pi_ruc", intencionParticipar.ruc);
                p.Add("pi_nombreEmpresa", intencionParticipar.nombreEmpresa);
                p.Add("pi_correoElectronico", intencionParticipar.correoElectronico);
                p.Add("pi_representanteLegal", intencionParticipar.representanteLegal);
                p.Add("pi_dni", intencionParticipar.dni);
                p.Add("pi_telefono", intencionParticipar.telefono);
                p.Add("pi_ip", intencionParticipar.ipCreacion);
                p.Add("po_rowaffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("po_rowaffected").Value;
                seGuardo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGuardo;
        }
    }
}
