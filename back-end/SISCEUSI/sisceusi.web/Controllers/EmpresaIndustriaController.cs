using OfficeOpenXml;
using sisceusi.entidad;
using sisceusi.logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class EmpresaIndustriaController : BaseController
    {
        // GET: Empresa
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NuevaEmpresaIndustria(int? id)
        {
            ViewData["idEmpresaIndustria"] = id;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(string buscar, int registros, int pagina, string columna, string orden)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> lista = logica.filtroGeneral(new EmpresaIndustriaBE
            {
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
        public JsonResult filtroAvanzado(string ruc, string empresa, string representanteLegal, string correoElectronico, DateTime? fechaInicio, DateTime? fechaFin, string estado, int registros, int pagina, string columna, string orden)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> lista = logica.filtroAvanzado(new EmpresaIndustriaBE
            {
                ruc = ruc,
                nombreEmpresa = empresa,
                representanteLegal = representanteLegal,
                correoElectronico = correoElectronico,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                idEstado = estado,
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
        public void exportarGeneral(string buscar, string columna, string orden)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> lista = logica.exportarGeneral(new EmpresaIndustriaBE
            {
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Empresa", 8);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "RUC EMPRESA", "RAZÓN SOCIAL", "REP. LEGAL", "GIRO NEGOCIO", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        public void exportarAvanzado(string ruc, string empresa, string representanteLegal, string correoElectronico, DateTime? fechaInicio, DateTime? fechaFin, string estado, string columna, string orden)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> lista = logica.exportarAvanzado(new EmpresaIndustriaBE
            {
                ruc = ruc,
                nombreEmpresa = empresa,
                representanteLegal = representanteLegal,
                correoElectronico = correoElectronico,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                idEstado = estado,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Empresa", 8);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "RUC EMPRESA", "RAZÓN SOCIAL", "REP. LEGAL", "GIRO NEGOCIO", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpPost]
        public JsonResult grabarEmpresaIndustria(EmpresaIndustriaBE empresa)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            empresa.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarEmpresaIndustria(empresa);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idEmpresaIndustria)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            bool seElimino = logica.eliminar(new EmpresaIndustriaBE { idEmpresaIndustria = idEmpresaIndustria });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerEmpresaIndustria(int idEmpresaIndustria)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            EmpresaIndustriaBE empresa = logica.obtenerEmpresa(new EmpresaIndustriaBE { idEmpresaIndustria = idEmpresaIndustria });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerListaEmpresaIndustria()
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> lista = logica.obtenerListaEmpresa();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult verificarRucPorIdEmpresa(int id, string ruc)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            EmpresaIndustriaBE empresa = logica.obtenerEmpresaPorRuc(new EmpresaIndustriaBE { ruc = ruc });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : id == empresa.idEmpresaIndustria ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult verificarRuc(string ruc)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            EmpresaIndustriaBE empresa = logica.obtenerEmpresaPorRuc(new EmpresaIndustriaBE { ruc = ruc });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<EmpresaIndustriaBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    String.Concat("EMP", c.idEmpresaIndustria.ToString("D4")),
                    c.ruc,
                    c.nombreEmpresa,
                    c.representanteLegal,
                    c.giro.giro,
                    c.txtFechaCreacion,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado" });
                i++;
            });
            return listas;
        }
    }
}