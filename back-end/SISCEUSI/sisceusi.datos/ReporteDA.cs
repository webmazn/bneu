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
    }
}
