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
    public class GiroLN : BaseLN
    {
        GiroDA datos = new GiroDA();

        public List<GiroBE> obtenerListaGiro()
        {
            List<GiroBE> lista = new List<GiroBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaGiro(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
