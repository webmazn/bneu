using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class InternoBE : BaseBE
    {
        public int idUsuario { get; set; }
        public int idRol { get; set; }

        public CampanaBE campana { get; set; }
        public EmpresaIndustriaBE empresa { get; set; }
        public PlantaEmpresaBE planta { get; set; }
        public ControlEncuestaBE controlEncuesta { get; set; }
        public TipoEncuestaBE tipoEncuesta { get; set; }
        public EtapaBE etapa { get; set; }
        public FaseBE fase { get; set; }
        public string txtFechaHoraLlenado { get; set; }
    }
}
