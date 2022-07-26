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
    public class ProvinciaLN : BaseLN
    {
        ProvinciaDA datos = new ProvinciaDA();

        public List<ProvinciaBE> obtenerListaProvincia()
        {
            List<ProvinciaBE> lista = new List<ProvinciaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaProvincia(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
