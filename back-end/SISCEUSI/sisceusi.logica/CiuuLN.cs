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
    public class CiuuLN : BaseLN
    {
        CiuuDA datos = new CiuuDA();

        public List<CiuuBE> obtenerListaCiuu()
        {
            List<CiuuBE> lista = new List<CiuuBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaCiuu(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
