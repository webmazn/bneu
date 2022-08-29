using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class RespuestaEncuestaParametroBE : BaseBE
    {
        public int idRespuestaEncuestaParametro { get; set; }
        public int idControlEncuesta { get; set; }
        public int idEncabezadoSecundario { get; set; }
        public int idParametro { get; set; }
        public int filaTabla { get; set; }
        public string respuesta { get; set; }
        public string idEstado { get; set; }

        public ControlEncuestaBE controlEncuesta { get; set; }
        public EncabezadoSecundarioBE encabezadoSecundario { get; set; }
        public ParametroBE parametro { get; set; }
    }
}
