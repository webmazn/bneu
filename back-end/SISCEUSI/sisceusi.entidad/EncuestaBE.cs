using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class EncuestaBE : BaseBE
    {
        public int idControlEncuesta { get; set; }
        public int idFase { get; set; } 
        public bool esUltimaPregunta { get; set; }
        public EncuestaComentarioBE encuestaComentario { get; set; }
        public List<RespuestaEncuestaPlantaBE> listaRespuestaEncuestaPlanta { get; set; }
        public List<RespuestaEncuestaTablaBE> listaRespuestaEncuestaTabla { get; set; }
    }
}
