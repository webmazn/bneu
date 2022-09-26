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
        public string tituloSeccion { get; set; }
        public string titulo { get; set; }
        public string separador { get; set; }
        public int idTipoControl { get; set; }
        public int idParametroTabla { get; set; }
        public List<RespuestaEncuestaBE> listaRespuesta { get; set; }
        public string idEstado { get; set; }

        public int idControlEncuesta { get; set; }
        public EncuestaComentarioBE encuestaComentario { get; set; }
        public List<EncabezadoSecundarioBE> listaEncabezadoSecundario { get; set; }
        public List<RespuestaEncuestaPlantaBE> listaRespuestaEncuestaPlanta { get; set; }
        public TablaMaestraBE tablaMaestra { get; set; }
    }
}
