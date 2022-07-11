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
    public class IntencionParticiparController : BaseController
    {
        // GET: IntencionParticipar
        public ActionResult Index()
        {
            return View();
        }

        public async Task<ActionResult> registrar(IntencionParticiparBE intencionParticipar)
        {
            Dictionary<string, object> response = new Dictionary<string, object> {["success"] = false,["message"] = "" };
            if (string.IsNullOrEmpty(intencionParticipar.token))
            {
                response["success"] = false;
                response["message"] = "Por favor, debe verificar el captcha";
                return Json(response);
            }

            var isCaptchaValid = await IsCaptchaValid(intencionParticipar.token);
            if (isCaptchaValid)
            {
                IntencionParticiparLN logica = new IntencionParticiparLN();
                intencionParticipar.ipCreacion = Request.UserHostAddress.ToString().Trim();
                bool seGuardo = logica.grabarIntencionParticipar(intencionParticipar);
                response["success"] = seGuardo;
                response["message"] = seGuardo ? "Los datos ingresados fueron guardados exitosamente" : "Ocurrió un problema al guardar los datos, inténtelo nuevamente";
                return Json(response);
            }
            else
            {
                response["success"] = false;
                response["message"] = "Ocurrió un problema en la validación del captcha";
                return Json(response);
            }
        }

    }
}