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

        public List<EmpresaIndustriaBE> filtroGeneral(EmpresaIndustriaBE empresa)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EmpresaIndustriaBE> filtroAvanzado(EmpresaIndustriaBE empresa)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EmpresaIndustriaBE> exportarGeneral(EmpresaIndustriaBE empresa)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EmpresaIndustriaBE> exportarAvanzado(EmpresaIndustriaBE empresa)
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarEmpresaIndustria(EmpresaIndustriaBE empresa)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarEmpresaIndustria(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool eliminar(EmpresaIndustriaBE empresa)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminar(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

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

        public List<EmpresaIndustriaBE>  obtenerListaEmpresa()
        {
            List<EmpresaIndustriaBE> lista = new List<EmpresaIndustriaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaEmpresa(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
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
