using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class BaseBE
    {
        //Auditoria
        public int idUsuarioCreacion { get; set; }
        public string ipCreacion { get; set; }
        //Seguridad
        public string token { get; set; }
    }
}
