using Oracle.DataAccess.Client;
using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class EncuestaLN : BaseLN
    {
        EncuestaDA datos = new EncuestaDA();

        public bool grabarEncuesta(EncuestaBE encuesta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    if (encuesta.listaRespuestaEncuestaPlanta != null)
                    {
                        foreach (var item in encuesta.listaRespuestaEncuestaPlanta)
                        {
                            item.ipCreacion = encuesta.ipCreacion;
                            //item.idUsuarioCreacion = encuesta.idUsuarioCreacion;
                            seGuardo = datos.grabarRespuestaEncuestaPlanta(item, cn);
                            if (!seGuardo) break;
                        }
                    }
                    else
                    {
                        seGuardo = true;
                    }

                    if (seGuardo)
                    {
                        if (encuesta.listaRespuestaEncuestaTabla != null)
                        {
                            foreach (var item in encuesta.listaRespuestaEncuestaTabla)
                            {
                                item.ipCreacion = encuesta.ipCreacion;
                                //item.idUsuarioCreacion = encuesta.idUsuarioCreacion;
                                seGuardo = datos.grabarRespuestaEncuestaTabla(item, cn);
                                if (!seGuardo) break;
                            }
                        }
                    }

                    if (seGuardo && encuesta.idRolLogin == 3 && encuesta.esUltimaPregunta)
                    {
                        seGuardo = datos.grabarFaseEncuesta(new ControlEncuestaBE { idControlEncuesta = encuesta.idControlEncuesta, idFase = encuesta.idFase, idUsuarioCreacion = encuesta.idUsuarioCreacion, ipCreacion = encuesta.ipCreacion }, cn);
                    }
                    else if (seGuardo && encuesta.idRolLogin == 2)
                    {
                        EncuestaComentarioBE encuestaComentario = encuesta.encuestaComentario;
                        encuestaComentario.ipCreacion = encuesta.ipCreacion;
                        encuestaComentario.idUsuarioCreacion = encuesta.idUsuarioCreacion;
                        seGuardo = datos.grabarEncuestaComentario(encuestaComentario, cn);
                    }

                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }
            }
            catch (Exception ex) { Log.Error(ex); }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public List<RespuestaEncuestaPlantaBE> obtenerListaRespuestaPlanta(int idControlEncuesta, int idCampanaEncuesta)
        {
            List<RespuestaEncuestaPlantaBE> lista = new List<RespuestaEncuestaPlantaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaRespuestaEncuestaPlanta(idControlEncuesta, idCampanaEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<RespuestaEncuestaTablaBE> obtenerListaRespuestaTabla(int idControlEncuesta, int idCEncabezadoSecundario)
        {
            List<RespuestaEncuestaTablaBE> lista = new List<RespuestaEncuestaTablaBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaRespuestaEncuestaTabla(idControlEncuesta, idCEncabezadoSecundario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public int obtenerUltimaPregunta(ControlEncuestaBE control)
        {
            int pregunta = 0;
            try
            {
                cn.Open();
                int preguntaPlanta = datos.obtenerPreguntaPlanta(control, cn);
                int preguntaTabla = datos.obtenerPreguntaTabla(control, cn);
                if (preguntaPlanta > 0 || preguntaTabla > 0)
                {
                    pregunta = preguntaPlanta > preguntaTabla ? preguntaPlanta : preguntaTabla;
                    pregunta++;
                }                
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return pregunta;
        }

        public EncuestaComentarioBE obtenerEncuestaComentario(EncuestaComentarioBE encuestaComentario)
        {
            EncuestaComentarioBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerEncuestaComentario(encuestaComentario, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }
    }
}
