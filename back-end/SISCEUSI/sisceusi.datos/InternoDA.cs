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
                        aceptaFirmarEncuesta = x.ACEPTAFIRMARENCUESTA == null ? "" :(string)x.ACEPTAFIRMARENCUESTA },
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
