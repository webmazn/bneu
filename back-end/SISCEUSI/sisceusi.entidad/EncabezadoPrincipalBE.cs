using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class EncabezadoPrincipalBE : BaseBE
    {
        public int idEncabezadoPrincipal { get; set; }
        public int idTablaMaestra { get; set; }
        public string tituloEncabezado { get; set; }
        public string abreviacion { get; set; }
        public string usarAbreviado { get; set; }
        public string descripcionIconoAyuda { get; set; }
        public string idEstado { get; set; }

        public TablaMaestraBE tablaMaestra { get; set; }
    }
}
