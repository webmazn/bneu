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
        public int idRevisor { get; set; }
        public string idEstado { get; set; }

        public CampanaBE campana { get; set; }
        public EmpresaIndustriaBE empresaIndustria { get; set; }
        public UsuarioBE revisor { get; set; }
    }
}
