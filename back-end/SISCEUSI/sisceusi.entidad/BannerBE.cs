using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class BannerBE : BaseBE
    {
        public int idBanner { get; set; }
        public string tituloBanner { get; set; }
        public string descripcionBanner { get; set; }
        public string descripcionFija { get; set; }
        public string tituloBoton { get; set; }
        public string enlaceBoton { get; set; }
        public string nombreArchivoBanner { get; set; }
        public string nombreArchivoGeneradoBanner { get; set; }
        public bool archivoNuevoBanner { get; set; }
        public byte[] archivoContenidoBanner { get; set; }
        public string idEstado { get; set; }
    }
}
