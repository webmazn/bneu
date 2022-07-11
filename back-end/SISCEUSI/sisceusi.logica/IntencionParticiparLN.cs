using Oracle.DataAccess.Client;
using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class IntencionParticiparLN : BaseLN
    {
        IntencionParticiparDA datos = new IntencionParticiparDA();

        public bool grabarIntencionParticipar(IntencionParticiparBE intencionParticipar)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    seGuardo = datos.GrabarIntencionParticipar(intencionParticipar, cn);
                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }
    }
}
