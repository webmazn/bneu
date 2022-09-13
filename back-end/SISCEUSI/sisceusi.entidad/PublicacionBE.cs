using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class PublicacionBE : BaseBE
    {
        public int idPublicacion { get; set; }
        public string tituloPublicacion { get; set; }
        public string descripcionPublicacion { get; set; }
        public string nombreArchivoPublicacion { get; set; }
        public string nombreArchivoGeneradoPubli { get; set; }
        public bool archivoNuevoPublicacion { get; set; }
        public byte[] archivoContenidoPublicacion { get; set; }
        public string idEstado { get; set; }
    }
}
