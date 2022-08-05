using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class EmpresaGasController : Controller
    {
        // GET: EmpresaGas
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult obtenerListaEmpresaGas()
        {
            EmpresaGasLN logica = new EmpresaGasLN();
            List<EmpresaGasBE> lista = logica.obtenerListaEmpresaGas();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}