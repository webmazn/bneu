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
    public class ZonaLN : BaseLN
    {
        ZonaDA datos = new ZonaDA();

        public List<ZonaBE> obtenerListaZona()
        {
            List<ZonaBE> lista = new List<ZonaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaZona(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
