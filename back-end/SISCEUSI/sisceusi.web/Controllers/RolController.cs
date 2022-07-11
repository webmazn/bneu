using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class RolController : Controller
    {
        // GET: Rol
        public ActionResult Rol()
        {
            return View();
        }

        [HttpPost]
        public JsonResult grabarRol(RolBE rol)
        {
            RolLN logica = new RolLN();
            bool seGuardo = logica.grabarRol(rol);
            string message = string.Empty;
            

            if (seGuardo)
                message = "Se guardó correctamente";
            else
                message = "Hubo un problema en la grabación de los datos, intentelo nuevamente";

            var jsonResult = Json(new { success = seGuardo, message = message }, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]    
        public JsonResult obtenerRol(int id)
        {
            RolLN logica = new RolLN();
            RolBE rol = logica.obtenerRol(new RolBE(id));

            var jsonResult = Json(new { objeto = rol }, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}