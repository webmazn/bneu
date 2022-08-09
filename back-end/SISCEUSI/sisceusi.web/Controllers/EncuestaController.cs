using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class EncuestaController : BaseController
    {
        // GET: Encuesta
        public ActionResult Inicio(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = logica.obtenerControlEncuesta( new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult participarTratamientoDatos(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.participarTratamientoDatos(controlEncuesta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult Firma(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult firmarEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.firmarEncuesta(controlEncuesta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult Formulario(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }
    }
}