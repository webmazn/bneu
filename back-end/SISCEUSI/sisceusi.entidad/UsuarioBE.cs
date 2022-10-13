using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class UsuarioBE : BaseBE
    {
        public int idUsuario { get; set; }
        public int idEmpresaIndustria { get; set; }
        public int idPlantaEmpresa { get; set; }
        public int idRol { get; set; }
        public string nombres { get; set; }
        public string correoElectronico { get; set; }
        public string password { get; set; }
        public string dni { get; set; }
        public string telefono { get; set; }
        public string visualizar { get; set; }
        public string idEstado { get; set; }

        public UsuarioBE() { }

        public UsuarioBE(string correoElectronico, string password)
        {
            this.correoElectronico = correoElectronico;
            this.password = password;
        }

        /*
         * Entidades Asociadas
         */

        public EmpresaIndustriaBE empresaIndustria { get; set; }
        public RolBE rol { get; set; }
    }
}
