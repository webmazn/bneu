using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class ReporteBE
    {
        public int idCampana { get; set; }
        public string campana { get; set; }
        public string subsector { get; set; }
        public DateTime fechaInicioEncuesta { get; set; }
        public DateTime fechaFinEncuesta { get; set; }
        public string idEmpresaIndustria { get; set; }
        public string nombreEmpresa { get; set; }
        public string nombreComercial { get; set; }
        public string ruc { get; set; }
        public string giroEmpresa { get; set; }
        public string grupoEmpresa { get; set; }
        public string ciuuEmpresa { get; set; }
        public string correoEmpresarial { get; set; }
        public string direccionFiscal { get; set; }
        public string representanteLegal { get; set; }
        public string dniRepresentante { get; set; }
        public int idPlantaEmpresa { get; set; }
        public string planta { get; set; }
        public string giroPlanta { get; set; }
        public string ciuuPlanta { get; set; }
        public string departamento { get; set; }
        public string provincia { get; set; }
        public string distrito { get; set; }
        public string zona { get; set; }
        public string direccion { get; set; }
        public string telefonoPlanta { get; set; }
        public string empresaGas { get; set; }
        public string numeroSuministroGas { get; set; }
        public string empresaLuz { get; set; }
        public string numeroSuministroAlumbrado { get; set; }
        public int idControlEncuesta { get; set; }
        public string numeroCuestionario { get; set; }
        public string idUsuarioEncuestado { get; set; }
        public string encuestado { get; set; }
        public string dniEncuestado { get; set; }
        public string correoEncuestado { get; set; }
        public string telefonoEncuestado { get; set; }
        public string idUsuarioRevisor { get; set; }
        public string revisor { get; set; }
        public string dniRevisor { get; set; }
        public string correoRevisor { get; set; }
        public string telefonoRevisor { get; set; }
        public string txtFechaInicioEncuesta
        {
            get
            {
                return fechaInicioEncuesta.ToString("dd/MM/yyyy");
            }
        }
        public string txtFechaFinEncuesta
        {
            get
            {
                return fechaFinEncuesta.ToString("dd/MM/yyyy");
            }
        }
    }

    public class CampanaTablaMaestraBE
    {
        public int idCampana { get; set; }
        public int idTablaMaestra { get; set; }
        public string subtitulo { get; set; }
    }

    public class CabeceraTablaMaestraReporteBE
    {
        public int idTablaMaestra { get; set; }
        public string descripcion { get; set; }
        public int cantidadCeldas { get; set; }
    }

    public class CabeceraPrincipalReporteBE
    {
        public int idEncabezadoPrincipal { get; set; }
        public string descripcion { get; set; }
        public int cantidadCeldas { get; set; }
        public int idTablaMaestra { get; set; }
        public string descripcionTabla { get; set; }
    }

    public class CabeceraSecundariaReporteBE
    {
        public int idEncabezadoSecundaria { get; set; }
        public string descripcion { get; set; }
        public int cantidadCeldas { get; set; }
    }

    public class CuerpoReporteBE
    {
        public string descripcion { get; set; }
        public string celda { get; set; }
        public bool filaSeparador { get; set; }
        public bool columnaSeparador { get; set; }
    }
}
