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
    public class DepartamentoLN : BaseLN
    {
        DepartamentoDA datos = new DepartamentoDA();

        public List<DepartamentoBE> obtenerListaDepartamento()
        {
            List<DepartamentoBE> lista = new List<DepartamentoBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaDepartamento(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
