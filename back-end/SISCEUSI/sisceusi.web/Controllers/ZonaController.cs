using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    [LoginRequiredAttribute]
    public class ZonaController : Controller
    {
        // GET: Zona
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult obtenerListaZona()
        {
            ZonaLN logica = new ZonaLN();
            List<ZonaBE> lista = logica.obtenerListaZona();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}