using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class TablaMaestraBE : BaseBE
    {
        public int idTablaMaestra { get; set; }
        public string tituloPrincipal { get; set; }
        public string subtitulo { get; set; }
        public string descripcionIconoAyuda { get; set; }
        public string preguntaInicial { get; set; }
        public string preguntaCierre { get; set; }
        public int idEstiloTabla { get; set; }
        public int cantidadFilas { get; set; }
        public string agregarFilas { get; set; }
        public string idEstado { get; set; }

        public EstiloTablaBE estiloTabla { get; set; }
    }
}
