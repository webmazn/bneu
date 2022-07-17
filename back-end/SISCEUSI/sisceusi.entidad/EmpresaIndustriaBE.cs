using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class EmpresaIndustriaBE : BaseBE
    {
        public int idEmpresaIndustria { get; set; }
        public string ruc { get; set; }
        public string nombreEmpresa { get; set; }
        public string direccionFiscal { get; set; }
        public string correoElectronico { get; set; }
        public string representanteLegal { get; set; }
        public string dni { get; set; }
        public string telefono { get; set; }
        public string idEstado { get; set; }
    }
}
