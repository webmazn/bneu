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
    public class IndicadorLN : BaseLN
    {
        IndicadorDA datos = new IndicadorDA();

        public List<IndicadorBE> mostrarListaIndicador(IndicadorBE entidad)
        {
            List<IndicadorBE> lista = new List<IndicadorBE>();
            try
            {
                cn.Open();
                lista = datos.mostrarListaIndicador(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabar(IndicadorBE entidad)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabar(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool eliminar(IndicadorBE entidad)
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

        public IndicadorBE obtenerEmpresa(IndicadorBE entidad)
        {
            IndicadorBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerIndicador(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public List<IndicadorBE> obtenerListaIndicador(IndicadorBE entidad)
        {
            List<IndicadorBE> lista = new List<IndicadorBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaIndicador(entidad, cn);
                lista.ForEach(x =>
                {
                    if (x.idTipoControl == 5)
                    {
                        x.indicadorTablaMaestra = datos.obtenerListaIndicadorEncabezadoSecundario(new IndicadorBE { idCampana = entidad.idCampana, idEncabezadoSecundario = x.idEncabezadoSecundario }, cn);
                    }
                    else
                    {

                    }
                });
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

    }
}
