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
    public class CampanaController : Controller
    {
        // GET: Campana
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NuevaCampana(int? id)
        {
            ViewData["idCampana"] = id;
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
    }
}