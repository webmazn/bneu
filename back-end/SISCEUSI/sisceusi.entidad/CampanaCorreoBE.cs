using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CampanaCorreoBE
    {
        public string nombres { get; set; }
        public string correoElectronico { get; set; }
        public string rol { get; set; }
        public string nombreEmpresa { get; set; }
        public string nombreComercial { get; set; }
        public string revisor { get; set; }
        public string correoRevisor { get; set; }
        public string admin { get; set; }
        public string correoAdmin { get; set; }
        public string denominacion { get; set; }
        public int idTipoEncuesta { get; set; }
        public int idFase { get; set; }
        public DateTime fechaFinPiloto { get; set; }
        public DateTime fechaFinOficial { get; set; }
        public string txtfechaFinPiloto
        {
            get
            {
                return fechaFinPiloto.ToString("dd/MM/yyyy");
            }
        }
        public string txtfechaFinOficial
        {
            get
            {
                return fechaFinOficial.ToString("dd/MM/yyyy");
            }
        }
    }
}
