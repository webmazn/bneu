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
    public class ReporteDA : BaseDA
    {
        public List<ControlEncuestaBE> obtenerListaControlEncuesta(CampanaBE entidad, OracleConnection db)
        {
            List<ControlEncuestaBE> lista = new List<ControlEncuestaBE>();
            try
            {
                string sp = $"{Package.Reporte}USP_SEL_LIST_CONTROL_ENC";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new ControlEncuestaBE
                {
                    idControlEncuesta = (int)x.IDCONTROLENCUESTA,
                    numeroCuestionario = x.NUMEROCUESTIONARIO == null ? 0 : (int)x.NUMEROCUESTIONARIO,
                    idSupervisor = x.IDSUPERVISOR == null ? 0 : (int)x.IDSUPERVISOR,
                    plantaEmpresa = new PlantaEmpresaBE
                    {
                        idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                        denominacion = (string)x.PLANTA,
                        empresa = new EmpresaIndustriaBE
                        {
                            nombreEmpresa = x.NOMBREEMPRESA == null ? "" : (string)x.NOMBREEMPRESA
                        },
                        direccion = x.DIRECCION == null ? "" : (string)x.DIRECCION,
                        latitud = x.LATITUD == null ? "" : (string)x.LATITUD,
                        longitud = x.LONGITUD == null ? "" : (string)x.LONGITUD,
                        departamento = new DepartamentoBE { idDepartamento = x.IDDEPARTAMENTO == null ? "" : (string)x.IDDEPARTAMENTO, departamento = (string)x.DEPARTAMENTO },
                        provincia = new ProvinciaBE { idProvincia = x.IDPROVINCIA == null ? "" : (string)x.IDPROVINCIA, provincia = (string)x.PROVINCIA },
                        distrito = new DistritoBE { idDistrito = x.IDDISTRITO == null ? "" : (string)x.IDDISTRITO, distrito = (string)x.DISTRITO },
                        zona = new ZonaBE { zona = (string)x.ZONA }
                    }
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<RespuestaEncuestaTablaBE> obtenerListaRespuestaEncuestaTabla(int idCampana, int idEncabezadoSecundario, OracleConnection db)
        {
            List<RespuestaEncuestaTablaBE> lista = new List<RespuestaEncuestaTablaBE>();
            try
            {
                string sp = $"{Package.Reporte}USP_SEL_LIST_RESP_ENC_TABLA";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", idCampana);
                p.Add("piIdEncabezadoSecundario", idEncabezadoSecundario);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<RespuestaEncuestaTablaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<CampanaEncuestaBE> obtenerListaCampanaEncuesta(CampanaBE entidad, OracleConnection db)
        {
            List<CampanaEncuestaBE> lista = new List<CampanaEncuestaBE>();
            try
            {
                string sp = $"{Package.Reporte}USP_SEL_PREGUNTA_ENCUESTA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<CampanaEncuestaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<RespuestaEncuestaPlantaBE> obtenerListaRespuestaEncuestaPlanta(int idCampanaEncuesta, OracleConnection db)
        {
            List<RespuestaEncuestaPlantaBE> lista = new List<RespuestaEncuestaPlantaBE>();
            try
            {
                string sp = $"{Package.Reporte}USP_SEL_LIST_RESP_ENC_PLANTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampanaEncuesta", idCampanaEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<RespuestaEncuestaPlantaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<ReporteBE> obtenerListaCampanaPlantaReporte(CampanaBE entidad, OracleConnection db)
        {
            List<ReporteBE> lista = new List<ReporteBE>();
            try
            {
                string sp = $"{Package.Reporte}USP_SEL_LIST_EMP_PLA_REPORT";                
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<ReporteBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }

            return lista;
        }

        public List<CampanaTablaMaestraBE> obtenerListaCampanaTablaMaestra(CampanaBE entidad, OracleConnection db)
        {
            List<CampanaTablaMaestraBE> lista = new List<CampanaTablaMaestraBE>();
            try
            {
                string sp = $"{Package.Reporte}USP_SEL_LIST_CAMP_TAB_MAESTRA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<CampanaTablaMaestraBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
