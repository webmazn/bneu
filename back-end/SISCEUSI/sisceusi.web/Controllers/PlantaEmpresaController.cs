using OfficeOpenXml;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    [LoginRequiredAttribute]
    [RoutePrefix("PlantaEmpresa")]
    public class PlantaEmpresaController : BaseController
    {
        // GET: PlantaEmpresa
        public ActionResult Index(int id)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            ViewData["empresa"] = logica.obtenerEmpresa(new EmpresaIndustriaBE() { idEmpresaIndustria = id });
            return View();
        }

        public ActionResult NuevaPlanta(int? id, int? idTwo)
        {
            ViewData["idEmpresaIndustria"] = id;
            ViewData["idPlantaEmpresa"] = idTwo;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(int idEmpresa, string buscar, int registros, int pagina, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.filtroGeneral(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                buscar = buscar,
                registros = registros,
                pagina = pagina,
                columna = columna,
                orden = orden
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult filtroAvanzado(int idEmpresa, string direccion, int idCiuu, string telefono, string idDepartamento, string idProvincia, string idDistrito, int registros, int pagina, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.filtroAvanzado(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                direccion = direccion,
                idCiuu = idCiuu,
                telefono = telefono,
                idDepartamento = idDepartamento,
                idProvincia = idProvincia,
                idDistrito = idDistrito,
                registros = registros,
                pagina = pagina,
                columna = columna,
                orden = orden
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public void exportarGeneral(int idEmpresa, string buscar, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.exportarGeneral(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Planta Empresa", 8);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "DIRECCIÓN", "CIUU", "TELÉFONO", "UBICACIÓN", "DEPARTAMENTO", "PROVINCIA", "DISTRITO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_PLANTA_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        public void exportarAvanzado(int idEmpresa, string direccion, int idCiuu, string telefono, string idDepartamento, string idProvincia, string idDistrito, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.exportarAvanzado(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                direccion = direccion,
                idCiuu = idCiuu,
                telefono = telefono,
                idDepartamento = idDepartamento,
                idProvincia = idProvincia,
                idDistrito = idDistrito,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Planta Empresa", 8);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "DIRECCIÓN", "CIUU", "TELÉFONO", "UBICACIÓN", "DEPARTAMENTO", "PROVINCIA", "DISTRITO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_PLANTA_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [Route("grabarPlanta")]
        [HttpPost]
        public JsonResult grabarPlantaEmpresa(PlantaEmpresaBE planta)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            planta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarPlantaEmpresa(planta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idPlantaEmpresa)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            bool seElimino = logica.eliminar(new PlantaEmpresaBE { idPlantaEmpresa = idPlantaEmpresa });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerPlantaEmpresa(int idPlantaEmpresa)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            PlantaEmpresaBE empresa = logica.obtenerPlantaEmpresa(new PlantaEmpresaBE { idPlantaEmpresa = idPlantaEmpresa });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<PlantaEmpresaBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    c.direccion,
                    c.ciuu.ciuu,
                    c.telefono,
                    String.Concat(c.latitud, ", ",c.longitud),
                    c.departamento.departamento,
                    c.provincia.provincia,
                    c.distrito.distrito });
                i++;
            });
            return listas;
        }
    }
}