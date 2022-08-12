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
    public class TablaMaestraLN : BaseLN
    {
        TablaMaestraDA datos = new TablaMaestraDA();

        public List<TablaMaestraBE> filtroGeneral(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<TablaMaestraBE> filtroAvanzado(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<TablaMaestraBE> exportarGeneral(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<TablaMaestraBE> exportarAvanzado(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EncabezadoPrincipalBE> mostrarListaEncabezadoPrincipal(EncabezadoPrincipalBE entidad)
        {
            List<EncabezadoPrincipalBE> lista = new List<EncabezadoPrincipalBE>();
            try
            {
                cn.Open();
                lista = datos.mostrarListaEncabezadoPrincipal(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarTablaMaestra(TablaMaestraBE tablaMaestra, out int idTablaMaestra)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarTablaMaestra(tablaMaestra, out idTablaMaestra, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool grabarEncabezadoPrincipal(EncabezadoPrincipalBE encabezado)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarEncabezadoPrincipal(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool grabarEncabezadoSecundario(EncabezadoSecundarioBE encabezado)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarEncabezadoSecundario(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }
    }
}
