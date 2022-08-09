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
    public class ControlEncuestaDA : BaseDA
    {
        public ControlEncuestaBE obtenerControlEncuesta(ControlEncuestaBE controlEncuesta, OracleConnection db)
        {
            ControlEncuestaBE item = null;
            try
            {
                string sp = $"{Package.ControlEncuesta}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", controlEncuesta.idControlEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new ControlEncuestaBE
                {
                    idControlEncuesta = (int)x.IDCONTROLENCUESTA,
                    aceptaLLenarEncuesta = x.ACEPTALLENARENCUESTA == null ? "" : (string)x.ACEPTALLENARENCUESTA,
                    aceptaTratamientoDatos = x.ACEPTATRATAMIENTODATOS == null ? "" : (string)x.ACEPTATRATAMIENTODATOS,
                    aceptaFirmarEncuesta = x.ACEPTAFIRMARENCUESTA == null ? "" : (string)x.ACEPTAFIRMARENCUESTA,
                    plantaEmpresa = new PlantaEmpresaBE {
                        idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                        denominacion = (string)x.PLANTA,
                        idEmpresaGas = (int)x.IDEMPRESAGAS,
                        numeroSuministroGas = (string)x.NUMEROSUMINISTROGAS,
                        idEmpresaLuz = (int)x.IDEMPRESALUZ,
                        numeroSuministroAlumbrado = (string)x.NUMEROSUMINISTROALUMBRADO },
                    campanaEmpresa = new CampanaEmpresaBE {
                        empresaIndustria = new EmpresaIndustriaBE {
                            idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                            nombreEmpresa = (string)x.NOMBREEMPRESA,
                            nombreComercial = (string)x.NOMBRECOMERCIAL,
                            ruc = (string)x.RUC },
                        campana = new CampanaBE {
                            idCampana = (int)x.IDCAMPANA,
                            denominacion = (string)x.DENOMINACION }
                    }
                }).FirstOrDefault();
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool participarTratamientoDatos(ControlEncuestaBE controlEncuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.ControlEncuesta}USP_UPD_PART_TRAT_DATOS";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", controlEncuesta.idControlEncuesta);
                p.Add("piIdCampana", controlEncuesta.campanaEmpresa.idCampana);
                p.Add("piAceptaLLenarEncuesta", controlEncuesta.aceptaLLenarEncuesta);
                p.Add("piAceptaTratamientoDatos", controlEncuesta.aceptaTratamientoDatos);
                p.Add("piIdUsuarioResponde", controlEncuesta.idUsuarioResponde);
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

        public bool firmarEncuesta(ControlEncuestaBE controlEncuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.ControlEncuesta}USP_UPD_FIRMAR_ENCUESTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", controlEncuesta.idControlEncuesta);
                p.Add("piAceptaFirmarEncuesta", controlEncuesta.aceptaFirmarEncuesta);
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
    }
}
