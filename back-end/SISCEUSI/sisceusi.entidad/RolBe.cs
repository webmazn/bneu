using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class RolBE
    {
        public int idRol { get; set; }
        public string rol { get; set; }
        public string idEstado { get; set; }

        public RolBE() { }

        public RolBE(int idRol)
        {
            this.idRol = idRol;
        }
    }
}
