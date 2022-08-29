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
                    foreach (var item in encuesta.listaRespuestaEncuestaPlanta)
                    {
                        item.ipCreacion = encuesta.ipCreacion;
                        item.idUsuarioCreacion = encuesta.idUsuarioCreacion;
                        seGuardo = datos.grabarRespuestaEncuestaPlanta(item, cn);
                        if (!seGuardo) break;
                    }

                    if (seGuardo)
                    {
                        foreach (var item in encuesta.listaRespuestaEncuestaTabla)
                        {
                            item.ipCreacion = encuesta.ipCreacion;
                            item.idUsuarioCreacion = encuesta.idUsuarioCreacion;
                            seGuardo = datos.grabarRespuestaEncuestaTabla(item, cn);
                            if (!seGuardo) break;
                        }
                    }
                    
                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }
            }
            catch (Exception ex) { Log.Error(ex); }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public int obtenerUltimaPregunta(ControlEncuestaBE control)
        {
            int pregunta = 0;
            try
            {
                cn.Open();
                int preguntaPlanta = datos.obtenerPreguntaPlanta(control, cn);
                int preguntaTabla = datos.obtenerPreguntaPlanta(control, cn);
                if (preguntaPlanta > 0 || preguntaTabla > 0)
                {
                    pregunta = preguntaPlanta > preguntaTabla ? preguntaPlanta : preguntaTabla;
                    pregunta++;
                }                
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return pregunta;
        }
    }
}
