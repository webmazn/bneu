using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CampanaEmpresaBE : BaseBE
    {
        public int idCampanaEmpresa { get; set; }
        public int idCampana { get; set; }
        public int idEmpresaIndustria { get; set; }
        public string participarEnPiloto { get; set; }
        public string participarEnOficial { get; set; }
        public int idSupervisorPiloto { get; set; }
        public int idSupervisorOficial { get; set; }
        public string idEstado { get; set; }

        public EmpresaIndustriaBE empresaIndustria { get; set; }
    }
}
