using Oracle.DataAccess.Client;
using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
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
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    try
                    {
                        planta.nombreArchivoGenerado = planta.archivoNuevo ? Guid.NewGuid().ToString() : planta.nombreArchivoGenerado;
                        seGuardo = datos.grabarPlantaEmpresa(planta, cn);
                        if (seGuardo && planta.archivoNuevo)
                        {
                            string ruta = ConfigurationManager.AppSettings.Get("rutaArchivo");
                            string nombre = String.Concat(planta.nombreArchivoGenerado, "_", planta.nombreArchivo);
                            string pathFile = Path.Combine(ruta, nombre);
                            if (!Directory.Exists(ruta)) Directory.CreateDirectory(ruta);
                            File.WriteAllBytes(pathFile, planta.archivoContenido);
                        }                        
                    }
                    catch (Exception ex)
                    {
                        seGuardo = false;
                        Log.Error(ex);
                    }

                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }                    
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
                if (item != null)
                {
                    string ruta = ConfigurationManager.AppSettings.Get("rutaArchivo");
                    string nombre = String.Concat(item.nombreArchivoGenerado, "_", item.nombreArchivo);
                    string pathFile = Path.Combine(ruta, nombre);
                    pathFile = !File.Exists(pathFile) ? null : pathFile;
                    item.archivoContenido = pathFile == null ? null : File.ReadAllBytes(pathFile);
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public List<PlantaEmpresaBE> obtenerListaPlantaEmpresa()
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaPlantaEmpresa(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public PlantaEmpresaBE verificarDatosPlanta(PlantaEmpresaBE empresa)
        {
            PlantaEmpresaBE item = null;
            try
            {
                cn.Open();
                item = datos.verificarDatosPlanta(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }
    }
}
