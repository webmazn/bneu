using Oracle.DataAccess.Client;
using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class UsuarioLN : BaseLN
    {
        UsuarioDA datos = new UsuarioDA();

        public List<UsuarioBE> filtroGeneral(UsuarioBE usuario)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<UsuarioBE> filtroAvanzado(UsuarioBE usuario)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarUsuario(UsuarioBE usuario)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    if (usuario.idUsuario == -1)
                        usuario.password = string.IsNullOrEmpty(usuario.password) ? null : Seguridad.hashSal(usuario.password);
                    else if (!usuario.password.Equals(ConfigurationManager.AppSettings["pswd"]))
                    {
                        usuario.editarPassword = true;
                        usuario.password = string.IsNullOrEmpty(usuario.password) ? null : Seguridad.hashSal(usuario.password);
                    }
                    else
                        usuario.editarPassword = false;

                    seGuardo = datos.grabarUsuario(usuario, cn);

                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }
            }
            catch (Exception ex) { Log.Error(ex); }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public UsuarioBE obtenerUsuario(UsuarioBE usuario)
        {
            UsuarioBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerUsuario(usuario, cn);
                if (item != null) item.password = ConfigurationManager.AppSettings["pswd"];
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public List<UsuarioBE> obtenerListaRolEspecifico(UsuarioBE usuario)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaRolEspecifico(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public UsuarioBE obtenerUsuarioPorCorreo(UsuarioBE usuario)
        {
            UsuarioBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerUsuarioPorCorreo(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public UsuarioBE obtenerUsuarioPorDni(UsuarioBE usuario)
        {
            UsuarioBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerUsuarioPorDni(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public List<UsuarioBE> exportarGeneral(UsuarioBE usuario)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<UsuarioBE> exportarAvanzado(UsuarioBE usuario)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(usuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }

}
