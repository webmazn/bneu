using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class ParametroBE : BaseBE
    {
        public int idParametro { get; set; }
        public string parametro { get; set; }
        public int idParentParametro { get; set; }
        public int idTipoParametro { get; set; }
        public string idEstado { get; set; }

        public string parentParametro { get; set; }
    }
}
