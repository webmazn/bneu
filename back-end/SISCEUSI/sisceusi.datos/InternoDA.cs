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
    public class InternoDA : BaseDA
    {
        public List<InternoBE> filtroGeneral(InternoBE empresa, OracleConnection db)
        {
            List<InternoBE> lista = new List<InternoBE>();
            try
            {
                string sp = $"{Package.Interno}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piIdUsuario", empresa.idUsuario);
                p.Add("piIdRol", empresa.idRol);
                p.Add("piBuscar", empresa.buscar);
                p.Add("piRegistros", empresa.registros);
                p.Add("piPagina", empresa.pagina);
                p.Add("piColumna", empresa.columna);
                p.Add("piOrden", empresa.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new InternoBE
                {
                    campana = new CampanaBE { idCampana = (int)x.IDCAMPANA, denominacion = (string)x.DENOMINACION },
                    empresa = new EmpresaIndustriaBE { nombreEmpresa = (string)x.NOMBREEMPRESA },
                    planta = new PlantaEmpresaBE { denominacion = (string)x.PLANTA },
                    tipoEncuesta = new TipoEncuestaBE { tipoEncuesta = (string)x.TIPOENCUESTA },
                    txtFechaHoraLlenado = x.FECHAHORALLENADO == null ? "" : ((DateTime)x.FECHAHORALLENADO).ToString("dd/MM/yyyy"),
                    etapa = new EtapaBE { etapa = (string)x.ETAPA },                    
                    controlEncuesta = new ControlEncuestaBE {
                        idControlEncuesta = (int)x.IDCONTROLENCUESTA,
                        aceptaLLenarEncuesta = x.ACEPTALLENARENCUESTA == null ? "" :(string)x.ACEPTALLENARENCUESTA,
                        aceptaTratamientoDatos = x.ACEPTATRATAMIENTODATOS == null ? "" : (string)x.ACEPTATRATAMIENTODATOS,
                        aceptaFirmarEncuesta = x.ACEPTAFIRMARENCUESTA == null ? "" :(string)x.ACEPTAFIRMARENCUESTA,
                        fechaHoraLlenado = x.FECHAHORALLENADO == null ? x.FECHAHORALLENADO : (DateTime)x.FECHAHORALLENADO,
                        fase = new FaseBE { fase = x.FASE == null ? "": (string)x.FASE, idFase = x.IDFASE == null ? 0 : (int)x.IDFASE }
                    },
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

        public List<InternoBE> filtroAvanzado(InternoBE entidad, OracleConnection db)
        {
            List<InternoBE> lista = new List<InternoBE>();
            try
            {
                string sp = $"{Package.Interno}USP_SEL_BUSQUEDA_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piIdUsuario", entidad.idUsuario);
                p.Add("piIdRol", entidad.idRol);
                p.Add("piDenominacion", entidad.campana.denominacion);
                p.Add("piRuc", entidad.empresa.ruc);
                p.Add("piNombreEmpresa", entidad.empresa.nombreEmpresa);
                p.Add("piIdDepartamento", entidad.planta.idDepartamento);
                p.Add("piIdProvincia", entidad.planta.idProvincia);
                p.Add("piIdDistrito", entidad.planta.idDistrito);
                p.Add("piIdZona", entidad.planta.idZona);
                p.Add("piIdSubSector", entidad.campana.idSubSector);
                p.Add("piIdCiuu", entidad.planta.idCiuu);
                p.Add("piIdSupervisor", entidad.controlEncuesta.idSupervisor);
                p.Add("piIdTipoEncuesta", entidad.controlEncuesta.idTipoEncuesta);
                p.Add("piIdEtapa", entidad.controlEncuesta.idEtapa);
                p.Add("piFechaInicio", entidad.fechaInicio);
                p.Add("piFechaFin", entidad.fechaFin);                
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("piColumna", entidad.columna);
                p.Add("piOrden", entidad.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new InternoBE
                {
                    campana = new CampanaBE { idCampana = (int)x.IDCAMPANA, denominacion = (string)x.DENOMINACION },
                    empresa = new EmpresaIndustriaBE { nombreEmpresa = (string)x.NOMBREEMPRESA },
                    planta = new PlantaEmpresaBE { denominacion = (string)x.PLANTA },
                    tipoEncuesta = new TipoEncuestaBE { tipoEncuesta = (string)x.TIPOENCUESTA },
                    txtFechaHoraLlenado = x.FECHAHORALLENADO == null ? "" : ((DateTime)x.FECHAHORALLENADO).ToString("dd/MM/yyyy"),
                    etapa = new EtapaBE { etapa = (string)x.ETAPA },
                    controlEncuesta = new ControlEncuestaBE
                    {
                        idControlEncuesta = (int)x.IDCONTROLENCUESTA,
                        aceptaLLenarEncuesta = x.ACEPTALLENARENCUESTA == null ? "" : (string)x.ACEPTALLENARENCUESTA,
                        aceptaTratamientoDatos = x.ACEPTATRATAMIENTODATOS == null ? "" : (string)x.ACEPTATRATAMIENTODATOS,
                        aceptaFirmarEncuesta = x.ACEPTAFIRMARENCUESTA == null ? "" : (string)x.ACEPTAFIRMARENCUESTA,
                        fechaHoraLlenado = x.FECHAHORALLENADO == null ? x.FECHAHORALLENADO : (DateTime)x.FECHAHORALLENADO,
                        fase = new FaseBE { fase = x.FASE == null ? "" : (string)x.FASE, idFase = x.IDFASE == null ? 0 : (int)x.IDFASE }
                    },
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
    }
}
