using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class LoginLN : BaseLN
    {
        LoginDA datos = new LoginDA();

        public bool validarUsuario(UsuarioBE usuario, out UsuarioBE outUsuario)
        {
            outUsuario = null;
            bool esValido = false;
            try
            {
                cn.Open();
                outUsuario = datos.obtenerUsuarioPorCorreo(usuario, cn);
                esValido = outUsuario != null;
                if (esValido) esValido = Seguridad.CompararHashSal(usuario.password, outUsuario.password);
            }
            catch (Exception ex) { Log.Error(ex); }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }

            return esValido;
        }
    }
}
