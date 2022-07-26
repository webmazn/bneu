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
    public class DistritoLN : BaseLN
    {
        DistritoDA datos = new DistritoDA();

        public List<DistritoBE> obtenerListaDistrito()
        {
            List<DistritoBE> lista = new List<DistritoBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaDistrito(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
