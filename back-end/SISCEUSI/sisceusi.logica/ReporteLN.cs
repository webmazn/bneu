using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class ReporteLN : BaseLN
    {
        ReporteDA datos = new ReporteDA();

        public List<ControlEncuestaBE> obtenerListaControlEncuesta(CampanaBE campana)
        {
            List<ControlEncuestaBE> lista = new List<ControlEncuestaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaControlEncuesta(new CampanaBE { idCampana = campana.idCampana }, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
