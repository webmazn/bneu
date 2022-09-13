using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class EncuestaComentarioBE : BaseBE
    {
        public int idEncuestaComentario { get; set; }
        public int idControlEncuesta { get; set; }
        public int idCampanaEncuesta { get; set; }
        public string comentario { get; set; }
        public string idEstado { get; set; }

    }
}
