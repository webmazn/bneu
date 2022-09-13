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
    public class PaginaHomeLN : BaseLN
    {
        PaginaHomeDA datos = new PaginaHomeDA();

        public bool grabarBanner(BannerBE entidad)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    try
                    {
                        entidad.nombreArchivoGeneradoBanner = entidad.archivoNuevoBanner ? Guid.NewGuid().ToString() : entidad.nombreArchivoGeneradoBanner;
                        seGuardo = datos.grabarBanner(entidad, cn);
                        if (seGuardo && entidad.archivoNuevoBanner)
                        {
                            string ruta = ConfigurationManager.AppSettings.Get("rutaImagenBanner");
                            string nombre = String.Concat(entidad.nombreArchivoGeneradoBanner, "_", entidad.nombreArchivoBanner);
                            string pathFile = Path.Combine(ruta, nombre);
                            if (!Directory.Exists(ruta)) Directory.CreateDirectory(ruta);
                            File.WriteAllBytes(pathFile, entidad.archivoContenidoBanner);
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

        public List<BannerBE> mostrarListaBanner(BannerBE entidad)
        {
            List<BannerBE> lista = new List<BannerBE>();
            try
            {
                cn.Open();
                lista = datos.mostrarListaBanner(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public BannerBE obtenerBanner(BannerBE entidad)
        {
            BannerBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerBanner(entidad, cn);
                if (item != null)
                {
                    string ruta = ConfigurationManager.AppSettings.Get("rutaImagenBanner");
                    string nombre = String.Concat(item.nombreArchivoGeneradoBanner, "_", item.nombreArchivoBanner);
                    string pathFile = Path.Combine(ruta, nombre);
                    pathFile = !File.Exists(pathFile) ? null : pathFile;
                    item.archivoContenidoBanner = pathFile == null ? null : File.ReadAllBytes(pathFile);
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool eliminarBanner(BannerBE entidad)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminarBanner(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

        public bool grabarPublicacion(PublicacionBE entidad)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    try
                    {
                        entidad.nombreArchivoGeneradoPubli = entidad.archivoNuevoPublicacion ? Guid.NewGuid().ToString() : entidad.nombreArchivoGeneradoPubli;
                        seGuardo = datos.grabarPublicacion(entidad, cn);
                        if (seGuardo && entidad.archivoNuevoPublicacion)
                        {
                            string ruta = ConfigurationManager.AppSettings.Get("rutaImagenPublicacion");
                            string nombre = String.Concat(entidad.nombreArchivoGeneradoPubli, "_", entidad.nombreArchivoPublicacion);
                            string pathFile = Path.Combine(ruta, nombre);
                            if (!Directory.Exists(ruta)) Directory.CreateDirectory(ruta);
                            File.WriteAllBytes(pathFile, entidad.archivoContenidoPublicacion);
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

        public List<PublicacionBE> mostrarListaPublicacion(PublicacionBE entidad)
        {
            List<PublicacionBE> lista = new List<PublicacionBE>();
            try
            {
                cn.Open();
                lista = datos.mostrarListaPublicacion(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public PublicacionBE obtenerPublicacion(PublicacionBE entidad)
        {
            PublicacionBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerPublicacion(entidad, cn);
                if (item != null)
                {
                    string ruta = ConfigurationManager.AppSettings.Get("rutaImagenPublicacion");
                    string nombre = String.Concat(item.nombreArchivoGeneradoPubli, "_", item.nombreArchivoPublicacion);
                    string pathFile = Path.Combine(ruta, nombre);
                    pathFile = !File.Exists(pathFile) ? null : pathFile;
                    item.archivoContenidoPublicacion = pathFile == null ? null : File.ReadAllBytes(pathFile);
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool eliminarPublicacion(PublicacionBE entidad)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminarPublicacion(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

    }
}
