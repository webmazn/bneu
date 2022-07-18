using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class GrupoEmpresaController : Controller
    {
        // GET: GrupoEmpresa
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult obtenerListaGrupoEmpresa()
        {
            GrupoEmpresaLN logica = new GrupoEmpresaLN();
            List<GrupoEmpresaBE> lista = logica.obtenerListaGrupoEmpresa();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}