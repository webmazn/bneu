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
    }
}
