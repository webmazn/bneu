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
    public class EmpresaGasLN : BaseLN
    {
        EmpresaGasDA datos = new EmpresaGasDA();

        public List<EmpresaGasBE> obtenerListaEmpresaGas()
        {
            List<EmpresaGasBE> lista = new List<EmpresaGasBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaEmpresaGas(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
