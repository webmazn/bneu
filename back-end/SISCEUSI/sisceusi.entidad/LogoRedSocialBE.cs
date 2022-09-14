using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class LogoRedSocialBE : BaseBE
    {
        public int idLogoRedSocial { get; set; }
        public string nombreArchivoLogoWeb { get; set; }
        public string nombreArchivoGeneradoLogoWeb { get; set; }
        public bool archivoNuevoLogoWeb { get; set; }
        public byte[] archivoContenidoLogoWeb { get; set; }
        public string nombreArchivoLogoDgee { get; set; }
        public string nombreArchivoGeneradoLogoDgee { get; set; }
        public bool archivoNuevoLogoDgee { get; set; }
        public byte[] archivoContenidoLogoDgee { get; set; }
        public string enlaceFacebook { get; set; }
        public string enlaceTwiter { get; set; }
        public string enlaceInstangram { get; set; }
        public string enlaceYoutube { get; set; }
        public string enlaceWhatsApp { get; set; }
        public string enlaceLinkedin { get; set; }
        public string idEstado { get; set; }
    }
}
