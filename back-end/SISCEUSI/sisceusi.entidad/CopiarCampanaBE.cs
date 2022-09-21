using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CopiarCampanaBE: BaseBE
    {
        public int idCampana { get; set; }
        public bool copiarEmpresa { get; set; }
        public bool copiarPregunta { get; set; }
        public bool copiarIndicador { get; set; }
        public bool copiarSupervisor { get; set; }
        public string nombreCampana { get; set; }
        public DateTime fechaInicial { get; set; }
        public DateTime fechaFinalizacion { get; set; }
    }
}
