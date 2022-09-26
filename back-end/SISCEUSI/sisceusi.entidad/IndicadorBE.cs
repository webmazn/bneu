using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class IndicadorBE : BaseBE
    {
        public int idIndicador { get; set; }
        public string nombreIndicador { get; set; }
        public int idCampana { get; set; }
        public int idCampanaEncuesta { get; set; }
        public int idEncabezadoPrincipal { get; set; }
        public int idEncabezadoSecundario { get; set; }
        public int idMetodoCalculo { get; set; }
        public int idTipoControl { get; set; }
        public string idEstado { get; set; }

        public CampanaBE campana { get; set; }
        public CampanaEncuestaBE campanaEncuesta { get; set; }
        public EncabezadoSecundarioBE encabezadoSecundario { get; set; }
        public MetodoCalculoBE metodoCalculo { get; set; }
        public List<IndicadorEncabezadoSecundarioBE> indicadorTablaMaestra { get; set; }
    }
}
