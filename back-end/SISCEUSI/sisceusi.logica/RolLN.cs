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
    public class RolLN : BaseLN
    {
        RolDA datos = new RolDA();

        public bool grabarRol(RolBE rol)
        {
            bool seGuardo = false;

            try
            {
                cn.Open();
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    seGuardo = datos.GrabarRol(rol, cn);

                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }

            return seGuardo;
        }

        public RolBE obtenerRol(RolBE rol)
        {
            RolBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerRol(rol, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public List<RolBE> obtenerListaRol()
        {
            List<RolBE> lista = new List<RolBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaRol(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
