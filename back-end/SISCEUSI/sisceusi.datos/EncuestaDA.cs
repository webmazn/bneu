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

        public List<RespuestaEncuestaPlantaBE> obtenerListaRespuestaEncuestaPlanta(int idControlEncuesta, int idCampanaEncuesta, OracleConnection db)
        {
            List<RespuestaEncuestaPlantaBE> lista = new List<RespuestaEncuestaPlantaBE>();
            try
            {
                string sp = $"{Package.Encuesta}USP_SEL_LIST_RESP_ENC_PLANTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", idControlEncuesta);
                p.Add("piIdCampanaEncuesta", idCampanaEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<RespuestaEncuestaPlantaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<RespuestaEncuestaTablaBE> obtenerListaRespuestaEncuestaTabla(int idControlEncuesta, int idEncabezadoSecundario, OracleConnection db)
        {
            List<RespuestaEncuestaTablaBE> lista = new List<RespuestaEncuestaTablaBE>();
            try
            {
                string sp = $"{Package.Encuesta}USP_SEL_LIST_RESP_ENC_TABLA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", idControlEncuesta);
                p.Add("piIdEncabezadoSecundario", idEncabezadoSecundario);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<RespuestaEncuestaTablaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarFaseEncuesta(ControlEncuestaBE controlEncuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Encuesta}USP_UPD_FASE_CONTROL_ENCUESTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", controlEncuesta.idControlEncuesta);
                p.Add("piIdFase", controlEncuesta.idFase);
                p.Add("piIdUsuarioCreacion", controlEncuesta.idUsuarioCreacion);
                p.Add("piIpCreacion", controlEncuesta.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool grabarEncuestaComentario(EncuestaComentarioBE encuestaComentario, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Encuesta}USP_PRC_ENCUESTA_COMENTARIO";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", encuestaComentario.idControlEncuesta);
                p.Add("piIdCampanaEncuesta", encuestaComentario.idCampanaEncuesta);
                p.Add("piComentario", encuestaComentario.comentario);
                p.Add("piIdUsuarioCreacion", encuestaComentario.idUsuarioCreacion);
                p.Add("piIpCreacion", encuestaComentario.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public EncuestaComentarioBE obtenerEncuestaComentario(EncuestaComentarioBE entidad, OracleConnection db)
        {
            EncuestaComentarioBE item = null;
            try
            {
                string sp = $"{Package.Encuesta}USP_SEL_ENCUESTA_COMENTARIO";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", entidad.idControlEncuesta);
                p.Add("piIdCampanaEncuesta", entidad.idCampanaEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.Query<EncuestaComentarioBE>(sp, p, commandType: CommandType.StoredProcedure).FirstOrDefault();
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public List<EncuestaComentarioBE> obtenerListaEncuestaComentario(EncuestaComentarioBE entidad, OracleConnection db)
        {
            List<EncuestaComentarioBE> lista = new List<EncuestaComentarioBE>();
            try
            {
                string sp = $"{Package.Encuesta}USP_SEL_LISTA_ENCUESTA_COMEN";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", entidad.idControlEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<EncuestaComentarioBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
