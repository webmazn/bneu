using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class ControlEncuestaBE : BaseBE
    {
        public int idControlEncuesta { get; set; }
        public int idCampanaEmpresa { get; set; }
        public int idPlantaEmpresa { get; set; }
        public int idTipoEncuesta { get; set; }
        public int idSupervisor { get; set; }
        public string aceptaLLenarEncuesta { get; set; }
        public string aceptaTratamientoDatos { get; set; }
        public string aceptaFirmarEncuesta { get; set; }
        public int idUsuarioResponde { get; set; }
        public DateTime fechaHoraLlenado { get; set; }
        public int numeroCuestionario { get; set; }
        public int idEtapa { get; set; }
        public string idEstado { get; set; }

        public CampanaEmpresaBE campanaEmpresa { get; set; }
        public PlantaEmpresaBE plantaEmpresa { get; set; }
        public UsuarioBE revisor { get; set; }
    }
}
