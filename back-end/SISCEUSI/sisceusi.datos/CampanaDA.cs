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
    public class CampanaDA : BaseDA
    {
        public List<CampanaBE> filtroGeneral(CampanaBE empresa, OracleConnection db)
        {
            List<CampanaBE> lista = new List<CampanaBE>();
            try
            {
                string sp = $"{Package.Campana}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", empresa.buscar);
                p.Add("piRegistros", empresa.registros);
                p.Add("piPagina", empresa.pagina);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new CampanaBE
                {
                    idCampana = (int)x.IDCAMPANA,
                    denominacion = (string)x.DENOMINACION,
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA,
                    totalPaginas = (int)x.TOTALPAGINAS,
                    pagina = (int)x.PAGINA,
                    registros = (int)x.REGISTROS,
                    totalRegistros = (int)x.TOTALREGISTROS
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarCampana(CampanaBE campana,out int idCampana, OracleConnection db)
        {
            idCampana = 0;
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Campana}USP_PRC_GUARDAR_CAMPANA";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campana.idCampana);
                p.Add("piDenominacion", campana.denominacion);
                p.Add("piFechaInicioPiloto", campana.fechaInicioPiloto);
                p.Add("piFechaFinPiloto", campana.fechaFinPiloto);
                p.Add("piFechaInicioEncuesta", campana.fechaInicioEncuesta);
                p.Add("piFechaFinEncuesta", campana.fechaFinEncuesta);
                p.Add("piObservaciones", campana.observaciones);
                p.Add("piIdGiroPiloto", campana.idGiroPiloto);
                p.Add("piIdCiuuPiloto", campana.idCiuuPiloto);
                p.Add("piIdGiroOficial", campana.idGiroOficial);
                p.Add("piIdCiuuOficial", campana.idCiuuOficial);
                p.Add("piIdEstado", campana.idEstado);             
                p.Add("piIdUsuarioCreacion", campana.idUsuarioCreacion);
                p.Add("piIpCreacion", campana.ipCreacion);
                p.Add("poIdCampana", 0, OracleDbType.Int32, ParameterDirection.Output);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                idCampana = (int)p.Get<dynamic>("poIdCampana").Value;
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool actualizarCampanaEmpresaEstado(CampanaBE campana, OracleConnection db)
        {
            bool seGuardo = false;
            try
            {
                string sp = $"{Package.Campana}USP_UPD_CAMPANA_EMP_ESTADO";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campana.idCampana);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                seGuardo = true;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGuardo;
        }

        public bool grabarCampanaEmpresa(CampanaEmpresaBE campanaEmpresa, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Campana}USP_PRC_GUARDAR_CAMPANA_EMP";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campanaEmpresa.idCampana);
                p.Add("piIdEmpresaIndustria", campanaEmpresa.idEmpresaIndustria);
                p.Add("piParticiparEnPiloto", campanaEmpresa.participarEnPiloto);
                p.Add("piParticiparEnOficial", campanaEmpresa.participarEnOficial);
                p.Add("piIdSupervisorPiloto", campanaEmpresa.idSupervisorPiloto);
                p.Add("piIdSupervisorOficial", campanaEmpresa.idSupervisorOficial);
                p.Add("piIdUsuarioCreacion", campanaEmpresa.idUsuarioCreacion);
                p.Add("piIpCreacion", campanaEmpresa.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public List<PlantaEmpresaBE> obtenerListaPlantaEmpesa(PlantaEmpresaBE planta, OracleConnection db)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                string sp = $"{Package.Campana}USP_SEL_LIST_PLANTA_EMPRESA";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresaIndustria", planta.idEmpresaIndustria);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<PlantaEmpresaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarCampanaPlanta(CampanaPlantaBE campanaPlanta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Campana}USP_PRC_GUARDAR_CAMPANA_PLANTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campanaPlanta.idCampana);
                p.Add("piIdPlantaEmpresa", campanaPlanta.idPlantaEmpresa);
                p.Add("piParticiparEnPiloto", campanaPlanta.participarEnPiloto);
                p.Add("piParticiparEnOficial", campanaPlanta.participarEnOficial);
                p.Add("piIdSupervisorPiloto", campanaPlanta.idSupervisorPiloto);
                p.Add("piIdSupervisorOficial", campanaPlanta.idSupervisorOficial);
                p.Add("piIdUsuarioCreacion", campanaPlanta.idUsuarioCreacion);
                p.Add("piIpCreacion", campanaPlanta.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool actualizarCampanaEncuestaEstado(CampanaBE campana, OracleConnection db)
        {
            bool seGuardo = false;
            try
            {
                string sp = $"{Package.Campana}USP_UPD_CAMPANA_ENC_ESTADO";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campana.idCampana);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                seGuardo = true;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGuardo;
        }

        public bool grabarCampanaEncuesta(CampanaEncuestaBE campanaEncuesta, out int idCampanaEncuesta, OracleConnection db)
        {
            idCampanaEncuesta = 0;
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Campana}USP_PRC_GUARDAR_CAMPANA_ENC";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampanaEncuesta", campanaEncuesta.idCampanaEncuesta);
                p.Add("piIdCampana", campanaEncuesta.idCampana);
                p.Add("piPregunta", campanaEncuesta.pregunta);
                p.Add("piNumeroOrdenPregunta", campanaEncuesta.numeroOrdenPregunta);
                p.Add("piIdTipoControl", campanaEncuesta.idTipoControl);
                p.Add("piIdParametroTabla", campanaEncuesta.idParametroTabla);
                p.Add("piIdUsuarioCreacion", campanaEncuesta.idUsuarioCreacion);
                p.Add("piIpCreacion", campanaEncuesta.ipCreacion);
                p.Add("poIdCampanaEncuesta", 0, OracleDbType.Int32, ParameterDirection.Output);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                idCampanaEncuesta = (int)p.Get<dynamic>("poIdCampanaEncuesta").Value;
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool actualizarRespuestaEncuestaEstado(CampanaEncuestaBE campanaEncuesta, OracleConnection db)
        {
            bool seGuardo = false;
            try
            {
                string sp = $"{Package.Campana}USP_UPD_RESPUESTA_ENC_ESTADO";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampanaEncuesta", campanaEncuesta.idCampanaEncuesta);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                seGuardo = true;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGuardo;
        }

        public bool grabarRespuestaEncuesta(RespuestaEncuestaBE respuestaEncuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Campana}USP_PRC_GUARDAR_RESP_ENC";
                var p = new OracleDynamicParameters();
                p.Add("piIdRespuestaEncuesta", respuestaEncuesta.idRespuestaEncuesta);
                p.Add("piIdCampanaEncuesta", respuestaEncuesta.idCampanaEncuesta);
                p.Add("piRespuesta", respuestaEncuesta.respuesta);
                p.Add("piNumeroOrdenRespuesta", respuestaEncuesta.numeroOrdenRespuesta);
                p.Add("piIdValorRespuesta", respuestaEncuesta.idValorRespuesta);
                p.Add("piIdUsuarioCreacion", respuestaEncuesta.idUsuarioCreacion);
                p.Add("piIpCreacion", respuestaEncuesta.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public CampanaBE obtenerCampana(CampanaBE campana, OracleConnection db)
        {
            CampanaBE item = null;
            try
            {
                string sp = $"{Package.Campana}USP_SEL_CAMPANA";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campana.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<CampanaBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public List<CampanaEmpresaBE> obtenerCampanaEmpresa(CampanaEmpresaBE campana, OracleConnection db)
        {
            List<CampanaEmpresaBE> lista = new List<CampanaEmpresaBE>();
            try
            {
                string sp = $"{Package.Campana}USP_SEL_LIST_CAMPANA_EMP";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campana.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new CampanaEmpresaBE
                {
                    idCampanaEmpresa = (int)x.IDCAMPANAEMPRESA,
                    idCampana = (int)x.IDCAMPANA,
                    empresaIndustria = new EmpresaIndustriaBE
                    {
                        idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                        idGiro = (int)x.IDGIRO,
                        idCiuu = (int)x.IDCIUU,
                        nombreEmpresa = (string)x.NOMBREEMPRESA
                    },
                    participarEnPiloto = (string)x.PARTICIPARENPILOTO,
                    participarEnOficial = (string)x.PARTICIPARENOFICIAL,
                    idSupervisorPiloto = (int)x.IDSUPERVISORPILOTO,
                    idSupervisorOficial = (int)x.IDSUPERVISOROFICIAL,
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<CampanaEncuestaBE> obtenerCampanaEncuesta(CampanaEncuestaBE campana, OracleConnection db)
        {
            List<CampanaEncuestaBE> lista = new List<CampanaEncuestaBE>();
            try
            {
                string sp = $"{Package.Campana}USP_SEL_LIST_CAMPANA_ENC";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", campana.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<CampanaEncuestaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<RespuestaEncuestaBE> obtenerRespuestaEncuesta(RespuestaEncuestaBE respuesta, OracleConnection db)
        {
            List<RespuestaEncuestaBE> lista = new List<RespuestaEncuestaBE>();
            try
            {
                string sp = $"{Package.Campana}USP_SEL_LIST_RESPUESTA_ENC";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampanaEncuesta", respuesta.idCampanaEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<RespuestaEncuestaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
