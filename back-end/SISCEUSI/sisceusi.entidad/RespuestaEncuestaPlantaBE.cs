using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class RespuestaEncuestaPlantaBE : BaseBE
    {
        public int idRespuestaEncuestaPlanta { get; set; }
        public int idControlEncuesta { get; set; }
        public int idCampanaEncuesta { get; set; }
        public int idRespuestaEncuesta { get; set; }
        public string respuesta { get; set; }
        public string idEstado { get; set; }

        public ControlEncuestaBE controlEncuesta { get; set; }
        public RespuestaEncuestaBE respuestaEncuesta { get; set; }
    }
}
