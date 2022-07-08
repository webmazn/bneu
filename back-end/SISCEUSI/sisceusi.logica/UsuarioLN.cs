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
    public class UsuarioLN : BaseLN
    {
        UsuarioDA datos = new UsuarioDA();

        public UsuarioBE obtenerUsuario(int idUsuario)
        {
            UsuarioBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerUsuario(idUsuario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }
    }
}
