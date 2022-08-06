using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CampanaPlantaBE : BaseBE
    {
        public int idCampanaPlanta { get; set; }
        public int idCampana { get; set; }
        public int idPlantaEmpresa { get; set; }
        public string participarEnPiloto { get; set; }
        public string participarEnOficial { get; set; }
        public int idSupervisorPiloto { get; set; }
        public int idSupervisorOficial { get; set; }
        public string aceptaLLenarEncuesta { get; set; }
        public string aceptaTratamientoDatos { get; set; }
        public string aceptaFirmarEncuesta { get; set; }
        public DateTime fechaHoraLlenado { get; set; }
        public string idEstado { get; set; }

        public CampanaBE campana { get; set; }
        public PlantaEmpresaBE plantaEmpresa { get; set; }
        public UsuarioBE revisor { get; set; }
    }
}
