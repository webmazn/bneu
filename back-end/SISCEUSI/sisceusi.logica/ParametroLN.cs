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
    public class ParametroLN : BaseLN
    {
        ParametroDA datos = new ParametroDA();

        public List<ParametroBE> filtroGeneral(ParametroBE entidad)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<ParametroBE> filtroAvanzado(ParametroBE entidad)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<ParametroBE> exportarGeneral(ParametroBE entidad)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<ParametroBE> exportarAvanzado(ParametroBE entidad)
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarParametro(ParametroBE entidad)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarParametro(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public ParametroBE obtenerParametro(ParametroBE entidad)
        {
            ParametroBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerParametro(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool eliminar(ParametroBE entidad)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminar(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

        public List<ParametroBE> obtenerListaParametro()
        {
            List<ParametroBE> lista = new List<ParametroBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaParametro(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
