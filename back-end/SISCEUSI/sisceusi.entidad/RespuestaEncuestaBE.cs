using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class RespuestaEncuestaBE : BaseBE
    {
        public int idRespuestaEncuesta { get; set; }
        public int idCampanaEncuesta { get; set; }
        public string respuesta { get; set; }
        public int numeroOrdenRespuesta { get; set; }
        public string idValorRespuesta { get; set; }
        public string idEstado { get; set; }
    }
}
