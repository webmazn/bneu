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
    public class EmpresaLuzLN : BaseLN
    {
        EmpresaLuzDA datos = new EmpresaLuzDA();

        public List<EmpresaLuzBE> obtenerListaEmpresaLuz()
        {
            List<EmpresaLuzBE> lista = new List<EmpresaLuzBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaEmpresaLuz(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
