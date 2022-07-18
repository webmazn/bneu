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
    public class GrupoEmpresaLN : BaseLN
    {
        GrupoEmpresaDA datos = new GrupoEmpresaDA();

        public List<GrupoEmpresaBE> obtenerListaGrupoEmpresa()
        {
            List<GrupoEmpresaBE> lista = new List<GrupoEmpresaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaGrupoEmpresa(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
