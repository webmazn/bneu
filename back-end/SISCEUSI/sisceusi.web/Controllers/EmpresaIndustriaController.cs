using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class EmpresaIndustriaController : Controller
    {
        // GET: Empresa
        public ActionResult Index()
        {
            return View();
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
    }
}