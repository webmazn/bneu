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

        public List<CampanaEncuestaBE> obtenerListaCampanaEncuesta(CampanaBE entidad)
        {
            List<CampanaEncuestaBE> lista = new List<CampanaEncuestaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaCampanaEncuesta(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<RespuestaEncuestaPlantaBE> obtenerListaRespuestaPlanta(int idCampanaEncuesta)
        {
            List<RespuestaEncuestaPlantaBE> lista = new List<RespuestaEncuestaPlantaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaRespuestaEncuestaPlanta(idCampanaEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EncabezadoSecundarioBE> obtenerTablaMaestraEncabezados(CampanaEncuestaBE campanaEncuesta)
        {
            List<EncabezadoSecundarioBE> lista = new List<EncabezadoSecundarioBE>();
            try
            {
                cn.Open();
                ControlEncuestaDA datos = new ControlEncuestaDA();
                lista = datos.obtenerTablaMaestraEncabezados(campanaEncuesta, cn);
                if (lista.Count > 0)
                {
                    lista.ForEach(x =>
                    {
                        if (x.idParametro > 0)
                        {
                            x.listaParametro = datos.obtenerListaParametro(new ParametroBE { idParametro = x.idParametro }, cn);
                        }
                        EncuestaDA datosEncuesta = new EncuestaDA();
                        x.listaRespuestaEncuestaTabla = datosEncuesta.obtenerListaRespuestaEncuestaTabla(campanaEncuesta.idControlEncuesta, x.idEncabezadoSecundario, cn);
                    });
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
