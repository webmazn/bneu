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
                    fechaHoraLlenado = x.FECHAHORALLENADO == null ? x.FECHAHORALLENADO : (DateTime)x.FECHAHORALLENADO,
                    plantaEmpresa = new PlantaEmpresaBE {
                        idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                        denominacion = (string)x.PLANTA,
                        direccion = x.DIRECCION == null ? "" : (string)x.DIRECCION,
                        idEmpresaGas = (int)x.IDEMPRESAGAS,
                        numeroSuministroGas = (string)x.NUMEROSUMINISTROGAS,
                        idEmpresaLuz = (int)x.IDEMPRESALUZ,
                        numeroSuministroAlumbrado = (string)x.NUMEROSUMINISTROALUMBRADO,
                        departamento = new DepartamentoBE { departamento = (string)x.DEPARTAMENTO },
                        provincia = new ProvinciaBE { provincia = (string)x.PROVINCIA },
                        distrito = new DistritoBE { distrito = (string)x.DISTRITO },
                        zona = new ZonaBE { zona = (string)x.ZONA },
                        empresaGas = new EmpresaGasBE { empresaGas = x.EMPRESAGAS == null ? "" : (string)x.EMPRESAGAS},
                        empresaLuz = new EmpresaLuzBE { empresaLuz = x.EMPRESALUZ == null ? "" : (string)x.EMPRESALUZ }
                    },
                    campanaEmpresa = new CampanaEmpresaBE {
                        empresaIndustria = new EmpresaIndustriaBE {
                            idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                            nombreEmpresa = (string)x.NOMBREEMPRESA,
                            nombreComercial = (string)x.NOMBRECOMERCIAL,
                            ruc = (string)x.RUC
                        },
                        campana = new CampanaBE {
                            idCampana = (int)x.IDCAMPANA,
                            denominacion = (string)x.DENOMINACION
                        }
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

        public bool formularioEncuesta(ControlEncuestaBE controlEncuesta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.ControlEncuesta}USP_UPD_FORM_ENCUESTA";
                var p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", controlEncuesta.idControlEncuesta);
                p.Add("piFechaHoraLlenado", controlEncuesta.fechaHoraLlenado);
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

        public List<CampanaEncuestaBE> obtenerListaCampanaEncuesta(ControlEncuestaBE controlEncuesta, OracleConnection db)
        {
            List<CampanaEncuestaBE> lista = new List<CampanaEncuestaBE>();
            try
            {
                string sp = $"{Package.ControlEncuesta}USP_SEL_PREGUNTA_ENCUESTA";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("piIdControlEncuesta", controlEncuesta.idControlEncuesta);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<CampanaEncuestaBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<EncabezadoSecundarioBE> obtenerListaCampanaEncuesta(CampanaEncuestaBE campanaEncuesta, OracleConnection db)
        {
            List<EncabezadoSecundarioBE> lista = new List<EncabezadoSecundarioBE>();
            try
            {
                string sp = $"{Package.ControlEncuesta}USP_SEL_LIST_ENC_SECUNDARIO";
                OracleDynamicParameters p = new OracleDynamicParameters();
                p.Add("piIdParametroTabla", campanaEncuesta.idParametroTabla);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                //lista = db.Query<EncabezadoSecundarioBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new EncabezadoSecundarioBE
                {
                    idEncabezadoSecundario = (int)x.IDENCABEZADOSECUNDARIO,
                    tituloEncabezado = x.TITULOENCABEZADO == null ? "" : (string)x.TITULOENCABEZADO,
                    abreviacion = x.ABREVIACION == null ? "" : (string)x.ABREVIACION,
                    usarAbreviado = x.USARABREVIADO == null ? "" : (string)x.USARABREVIADO,
                    posicion = x.POSICION == null ? 0 : (int)x.POSICION,
                    encabezadoPrincipal = new EncabezadoPrincipalBE {
                        tituloEncabezado = x.ENCABEZADOPRINCIPAL == null ? "" : (string)x.ENCABEZADOPRINCIPAL
                    },
                    descripcionIconoAyuda = x.DESCRIPCIONICONOAYUDA == null ? "" : (string)x.DESCRIPCIONICONOAYUDA,
                    tipoDato = new TipoDatoBE { tipoDato = x.TIPODATO == null ? "" : (string)x.TIPODATO },
                    parametro = new ParametroBE { parametro = x.PARAMETRO == null ? "" : (string)x.PARAMETRO }
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
