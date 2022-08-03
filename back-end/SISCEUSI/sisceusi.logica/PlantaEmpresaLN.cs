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
    public class PlantaEmpresaLN : BaseLN
    {
        PlantaEmpresaDA datos = new PlantaEmpresaDA();

        public List<PlantaEmpresaBE> filtroGeneral(PlantaEmpresaBE planta)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<PlantaEmpresaBE> filtroAvanzado(PlantaEmpresaBE planta)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<PlantaEmpresaBE> exportarGeneral(PlantaEmpresaBE planta)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<PlantaEmpresaBE> exportarAvanzado(PlantaEmpresaBE planta)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarPlantaEmpresa(PlantaEmpresaBE planta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarPlantaEmpresa(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool eliminar(PlantaEmpresaBE planta)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminar(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

        public PlantaEmpresaBE obtenerPlantaEmpresa(PlantaEmpresaBE planta)
        {
            PlantaEmpresaBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerPlantaEmpresa(planta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }
    }
}
