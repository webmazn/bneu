using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CampanaEncuestaBE : BaseBE
    {
        public int idCampanaEncuesta { get; set; }
        public int idCampana { get; set; }
        public string pregunta { get; set; }
        public int numeroOrdenPregunta { get; set; }
        public int idTipoControl { get; set; }
        public int idParametroTabla { get; set; }
        public List<RespuestaEncuestaBE> listaRespuesta { get; set; }
        public string idEstado { get; set; }
    }
}
