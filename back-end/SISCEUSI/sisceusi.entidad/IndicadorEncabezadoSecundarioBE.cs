using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class IndicadorEncabezadoSecundarioBE
    {
        public CampanaEmpresaBE campanaEmpresa { get; set; }
        public ControlEncuestaBE controlEncuesta { get; set; }
        public ParametroBE parametro { get; set; }
        public int filaTabla { get; set; }
        public string etiqueta { get; set; }
        public decimal valor { get; set; }
    }
}
