using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class CampanaBE : BaseBE
    {
        public int idCampana { get; set; }
        public string denominacion { get; set; }
        public DateTime fechaInicioPiloto { get; set; }
        public DateTime fechaFinPiloto { get; set; }
        public DateTime fechaInicioEncuesta { get; set; }
        public DateTime fechaFinEncuesta { get; set; }
        public string observaciones { get; set; }
        public int idGiroPiloto { get; set; }
        public int idCiuuPiloto { get; set; }
        public int idGiroOficial { get; set; }
        public int idCiuuOficial { get; set; }
        public int idEtapaPiloto { get; set; }
        public int idEtapaOficial { get; set; }
        public int idSubSector { get; set; }
        public List<CampanaEmpresaBE> listaCampanaEmpresa { get; set; }
        public List<CampanaEncuestaBE> listaPregunta { get; set; }
        public string idEstado { get; set; }

        public string txtFechaInicioPiloto
        {
            get
            {
                return fechaInicioPiloto.ToString("yyyy-MM-dd");
            }
        }

        public string txtFechaFinPiloto
        {
            get
            {
                return fechaFinPiloto.ToString("yyyy-MM-dd");
            }
        }

        public string txtFechaInicioEncuesta
        {
            get
            {
                return fechaInicioEncuesta.ToString("yyyy-MM-dd");
            }
        }

        public string txtFechaFinEncuesta
        {
            get
            {
                return fechaFinEncuesta.ToString("yyyy-MM-dd");
            }
        }
    }
}
