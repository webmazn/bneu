using OfficeOpenXml;
using sisceusi.entidad;
using sisceusi.logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class ParametroController : BaseController
    {
        // GET: Parametro
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult NuevoParametro(int? id)
        {
            ViewData["idParametro"] = id;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(string buscar, int registros, int pagina, string columna, string orden)
        {
            ParametroLN logica = new ParametroLN();
            List<ParametroBE> lista = logica.filtroGeneral(new ParametroBE
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
        public JsonResult filtroAvanzado(string parentParametro, string parametro, int idTipoParametro, DateTime? fechaInicio, DateTime? fechaFin, string estado, int registros, int pagina, string columna, string orden)
        {
            ParametroLN logica = new ParametroLN();
            List<ParametroBE> lista = logica.filtroAvanzado(new ParametroBE
            {
                parentParametro = parentParametro,
                parametro = parametro,
                idTipoParametro = idTipoParametro,
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
            ParametroLN logica = new ParametroLN();
            List<ParametroBE> lista = logica.exportarGeneral(new ParametroBE
            {
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Parámetro", 8);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "NOM. PARÁMETRO", "PARENT PARÁMETROS", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_PARAMETRO_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        public void exportarAvanzado(string parentParametro, string parametro, int idTipoParametro, DateTime? fechaInicio, DateTime? fechaFin, string estado, string columna, string orden)
        {
            ParametroLN logica = new ParametroLN();
            List<ParametroBE> lista = logica.exportarAvanzado(new ParametroBE
            {
                parentParametro = parentParametro,
                parametro = parametro,
                idTipoParametro = idTipoParametro,
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
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Parámetro", 8);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "NOM. PARÁMETRO", "PARENT PARÁMETROS", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_PARAMETRO_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpPost]
        public JsonResult grabarParametro(ParametroBE entidad)
        {
            ParametroLN logica = new ParametroLN();
            entidad.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarParametro(entidad);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerParametro(int idParametro)
        {
            ParametroLN logica = new ParametroLN();
            ParametroBE entidad = logica.obtenerParametro(new ParametroBE { idParametro = idParametro });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", entidad == null ? false : true);
            response.Add("object", entidad);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idParametro)
        {
            ParametroLN logica = new ParametroLN();
            bool seElimino = logica.eliminar(new ParametroBE { idParametro = idParametro });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }        

        [HttpGet]
        public JsonResult obtenerListaParametro()
        {
            ParametroLN logica = new ParametroLN();
            List<ParametroBE> lista = logica.obtenerListaParametro();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<ParametroBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    String.Concat("PAR", c.idParametro.ToString("D4")),
                    c.parametro,
                    c.parentParametro,
                    c.txtFechaCreacion,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado" });
                i++;
            });
            return listas;
        }

    }
}