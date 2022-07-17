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
    public class EmpresaIndustriaLN : BaseLN
    {
        EmpresaIndustriaDA datos = new EmpresaIndustriaDA();

        public EmpresaIndustriaBE obtenerEmpresa(EmpresaIndustriaBE empresa)
        {
            EmpresaIndustriaBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerEmpresa(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public EmpresaIndustriaBE obtenerEmpresaPorRuc(EmpresaIndustriaBE empresa)
        {
            EmpresaIndustriaBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerEmpresaPorRuc(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }
    }
}
