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
    public class InternoLN : BaseLN
    {
        InternoDA datos = new InternoDA();

        public List<InternoBE> filtroGeneral(InternoBE interno)
        {
            List<InternoBE> lista = new List<InternoBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(interno, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
