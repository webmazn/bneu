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
    public class CampanaController : BaseController
    {
        // GET: Campana
        public ActionResult Index()
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaBE> lista = logica.filtroGeneral(new CampanaBE
            {
                buscar = "",
                registros = 10,
                pagina = 1,
                columna = "cam_idCampana",
                orden = "ASC"
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            ViewData["listaCampana"] = response;
            return View();
        }

        public ActionResult NuevaCampana(int? id)
        {
            //Lista Giro
            GiroLN logicaGiro = new GiroLN();
            List<GiroBE> listaGiro = logicaGiro.obtenerListaGiro();
            //Lista Ciuu
            CiuuLN logicaCiuu = new CiuuLN();
            List<CiuuBE> listaCiuu = logicaCiuu.obtenerListaCiuu();
            //Lista Empresa
            EmpresaIndustriaLN logicaEmpresa = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> listaEmpresa = logicaEmpresa.obtenerListaEmpresa();
            //Lista Revisor
            UsuarioLN logicaRevisor = new UsuarioLN();
            List<UsuarioBE> listaRevisor = logicaRevisor.obtenerListaRolEspecifico(new UsuarioBE { idRol = 2 });
            //Lista TablaMaestra
            TablaMaestraLN logicaTablaMaestra = new TablaMaestraLN();
            List<TablaMaestraBE> listaTablaMaestra = logicaTablaMaestra.obtenerListaTablaMaestra();
            //Objeto Campaña
            CampanaBE campana = null;
            if (id != null)
            {
                CampanaLN logica = new CampanaLN();
                campana = logica.obtenerCampana(new CampanaBE { idCampana = id.Value });
            }

            ViewData["idCampana"] = id;
            ViewData["campana"] = campana;
            ViewData["listaGiro"] = listaGiro;
            ViewData["listaCiuu"] = listaCiuu;
            ViewData["listaEmpresa"] = listaEmpresa;
            ViewData["listaRevisor"] = listaRevisor;
            ViewData["listaTablaMaestra"] = listaTablaMaestra;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(string buscar, int registros, int pagina, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaBE> lista = logica.filtroGeneral(new CampanaBE
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
        public JsonResult filtroAvanzado(string denominacion, string ruc, string empresa, DateTime? fechaInicio, DateTime? fechaFin, string estado, int registros, int pagina, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaEmpresaBE> listaCampanaEmpresa = new List<CampanaEmpresaBE>();
            listaCampanaEmpresa.Add(new CampanaEmpresaBE
            {
                empresaIndustria = new EmpresaIndustriaBE
                {
                    ruc = ruc,
                    nombreEmpresa = empresa
                }                
            });
            List<CampanaBE> lista = logica.filtroAvanzado(new CampanaBE
            {
                denominacion = denominacion,
                listaCampanaEmpresa = listaCampanaEmpresa,
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
            CampanaLN logica = new CampanaLN();
            List<CampanaBE> lista = logica.exportarGeneral(new CampanaBE
            {
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Campaña", 4);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "DENOMINACIÓN", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpGet]
        public void exportarAvanzado(string denominacion, string ruc, string empresa, DateTime? fechaInicio, DateTime? fechaFin, string estado, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaEmpresaBE> listaCampanaEmpresa = new List<CampanaEmpresaBE>();
            listaCampanaEmpresa.Add(new CampanaEmpresaBE
            {
                empresaIndustria = new EmpresaIndustriaBE
                {
                    ruc = ruc,
                    nombreEmpresa = empresa
                }
            });
            List<CampanaBE> lista = logica.exportarAvanzado(new CampanaBE
            {
                denominacion = denominacion,
                listaCampanaEmpresa = listaCampanaEmpresa,
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
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Campaña", 4);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "DENOMINACIÓN", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpPost]
        public JsonResult grabarCampana(CampanaBE campana)
        {
            CampanaLN logica = new CampanaLN();
            campana.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarCampana(campana);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerCampana(int idCampana)
        {
            CampanaLN logica = new CampanaLN();
            CampanaBE campana = logica.obtenerCampana(new CampanaBE { idCampana = idCampana });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", campana == null ? false : true);
            response.Add("object", campana);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<CampanaBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    String.Concat("ENC", c.idCampana.ToString("D4")),
                    c.denominacion,
                    c.txtFechaCreacion,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado" });
                i++;
            });
            return listas;
        }

        [HttpPost]
        public JsonResult copiarCampana(CopiarCampanaBE entidad)
        {
            CampanaLN logica = new CampanaLN();
            entidad.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seCopio = logica.copiarCampana(entidad);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seCopio);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}