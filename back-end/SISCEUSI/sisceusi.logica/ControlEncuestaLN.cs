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
    public class ControlEncuestaLN : BaseLN
    {
        ControlEncuestaDA datos = new ControlEncuestaDA();

        public ControlEncuestaBE obtenerControlEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerControlEncuesta(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool participarTratamientoDatos(ControlEncuestaBE controlEncuesta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.participarTratamientoDatos(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool firmarEncuesta(ControlEncuestaBE controlEncuesta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.firmarEncuesta(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool formularioEncuesta(ControlEncuestaBE controlEncuesta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.formularioEncuesta(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }
        public List<CampanaEncuestaBE> obtenerListaCampanaEncuesta(ControlEncuestaBE controlEncuesta)
        {
            List<CampanaEncuestaBE> lista = new List<CampanaEncuestaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaCampanaEncuesta(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<RespuestaEncuestaBE> obtenerListaRespuestaEncuesta(CampanaEncuestaBE campanaEncuesta)
        {
            List<RespuestaEncuestaBE> lista = new List<RespuestaEncuestaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaRespuestaEncuesta(campanaEncuesta, cn);
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
