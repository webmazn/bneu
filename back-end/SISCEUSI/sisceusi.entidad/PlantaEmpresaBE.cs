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
        public int idGiro { get; set; }
        public int idCiuu { get; set; }
        public string idDepartamento { get; set; }
        public string idProvincia { get; set; }
        public string idDistrito { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }
        public string latitud { get; set; }
        public string longitud { get; set; }
        public int idZona { get; set; }
        public string numeroSuministroGas { get; set; }
        public string numeroSuministroAlumbrado { get; set; }
        public int idEmpresaGas { get; set; }
        public int idEmpresaLuz { get; set; }
        public string nombreArchivo { get; set; }
        public string nombreArchivoGenerado { get; set; }
        public bool archivoNuevo { get; set; }
        public byte[] archivoContenido { get; set; }
        public string idEstado { get; set; }

        public EmpresaIndustriaBE empresa { get; set;}
        public GiroBE giro { get; set; }
        public CiuuBE ciuu { get; set; }
        public DepartamentoBE departamento { get; set; }
        public ProvinciaBE provincia { get; set; }
        public DistritoBE distrito { get; set; }
    }
}
