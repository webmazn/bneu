using Dapper;
using Oracle.DataAccess.Client;
using sisceusi.Datos;
using sisceusi.entidad;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.datos
{
    public class EncuestaDA : BaseDA
    {
        public bool grabarRespuestaEncuestaPlanta(RespuestaEncuestaPlantaBE encuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Encuesta}USP_PRC_GUARDAR_RESP_ENC_PLAN";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", encuesta.idControlEncuesta);
                p.Add("piIdCampanaEncuesta", encuesta.idCampanaEncuesta);
                p.Add("piIdRespuestaEncuesta", encuesta.idRespuestaEncuesta);
                p.Add("piRespuesta", encuesta.respuesta);
                p.Add("piIdUsuarioCreacion", encuesta.idUsuarioCreacion);
                p.Add("piIpCreacion", encuesta.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool grabarRespuestaEncuestaTabla(RespuestaEncuestaTablaBE encuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Encuesta}USP_PRC_GUARDAR_RESP_ENC_TAB";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", encuesta.idControlEncuesta);
                p.Add("piFilaTabla", encuesta.filaTabla);
                p.Add("piIdEncabezadoSecundario", encuesta.idEncabezadoSecundario);
                p.Add("piIdParametro", encuesta.idParametro);
                p.Add("piRespuesta", encuesta.respuesta);
                p.Add("piIdUsuarioCreacion", encuesta.idUsuarioCreacion);
                p.Add("piIpCreacion", encuesta.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public int obtenerPreguntaPlanta(ControlEncuestaBE control, OracleConnection db)
        {
            int pregunta = 0;
            try
            {
                string sp = $"{Package.Encuesta}USP_SEL_PREGUNTA_PLANTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", control.idControlEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                var item = db.QueryFirstOrDefault<CampanaEncuestaBE>(sp, p, commandType: CommandType.StoredProcedure);
                pregunta = item.numeroOrdenPregunta;
            }
            catch (Exception ex) { Log.Error(ex); }
            return pregunta;
        }

        public int obtenerPreguntaTabla(ControlEncuestaBE control, OracleConnection db)
        {
            int pregunta = 0;
            try
            {
                string sp = $"{Package.Encuesta}USP_SEL_PREGUNTA_TABLA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", control.idControlEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                var item = db.QueryFirstOrDefault<CampanaEncuestaBE>(sp, p, commandType: CommandType.StoredProcedure);
                pregunta = item.numeroOrdenPregunta;
            }
            catch (Exception ex) { Log.Error(ex); }
            return pregunta;
        }
    }
}
