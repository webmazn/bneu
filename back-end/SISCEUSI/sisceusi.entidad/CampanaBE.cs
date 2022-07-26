using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CampanaBE : BaseBE
    {
        public int idCampana { get; set; }
        public string denominacion { get; set; }
        public DateTime fechaInicioPiloto { get; set; }
        public DateTime fechaFinPiloto { get; set; }
        public DateTime fechaInicioEncuesta { get; set; }
        public DateTime fechaFinEncuesta { get; set; }
        public string observaciones { get; set; }
        public string idEstado { get;set; }
    }
}
