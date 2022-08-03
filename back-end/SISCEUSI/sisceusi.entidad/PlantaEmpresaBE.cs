using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class PlantaEmpresaBE : BaseBE
    {
        public int idPlantaEmpresa { get; set; }
        public int idEmpresaIndustria { get; set; }
        public int idCiuu { get; set; }
        public string idDepartamento { get; set; }
        public string idProvincia { get; set; }
        public string idDistrito { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }
        public string latitud { get; set; }
        public string longitud { get; set; }
        public string idEstado { get; set; }

        public CiuuBE ciuu { get; set; }
        public DepartamentoBE departamento { get; set; }
        public ProvinciaBE provincia { get; set; }
        public DistritoBE distrito { get; set; }
    }
}
