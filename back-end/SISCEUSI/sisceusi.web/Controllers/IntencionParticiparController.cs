using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
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
                if (seGuardo)
                {
                    enviarCorreoIntencion(intencionParticipar);
                }
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

        private void enviarCorreoIntencion(IntencionParticiparBE intencionParticipar)
        {
            UsuarioLN logica = new UsuarioLN();
            UsuarioBE user = logica.obtenerAdministrador();
            string correoDefecto = ConfigurationManager.AppSettings["Mailing.Mail.From.Address"];
            string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldEmpresa = "[EMPRESA]", fieldRuc = "[RUC]", fieldNombreEmpresa = "[NOMBREEMPRESA]", fieldCorreo = "[CORREO]", fieldRepresentante = "[REPRESENTANTE]", fieldDni = "[DNI]", fieldTelefono = "[TELEFONO]";
            string[] fields = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldRuc, fieldCorreo, fieldNombreEmpresa, fieldCorreo, fieldRepresentante, fieldDni, fieldTelefono };
            string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldRuc, fieldCorreo, fieldNombreEmpresa, fieldCorreo, fieldRepresentante, fieldDni, fieldTelefono };
            Dictionary<string, string> dataBody = new Dictionary<string, string>
            {
                [fieldServer] = ConfigurationManager.AppSettings["Server"],
                [fieldNombres] = user == null ? "" : user.nombres,
                [fieldEmpresa] = user == null ? "" : user.empresaIndustria.nombreEmpresa,
                [fieldRuc] = intencionParticipar.ruc,
                [fieldNombreEmpresa] = intencionParticipar.nombreEmpresa,
                [fieldCorreo] = intencionParticipar.correoElectronico,
                [fieldRepresentante] = intencionParticipar.representanteLegal,
                [fieldDni] = intencionParticipar.dni,
                [fieldTelefono] = intencionParticipar.telefono
            };
            string subject = "Sistema de Balance Energético Del MINEM Intención de Participar - Datos de la empresa";
            MailAddressCollection mailTo = new MailAddressCollection();
            mailTo.Add(new MailAddress(user == null ? correoDefecto : user.correoElectronico , user == null ? "" : user.nombres));

            Mailing mailing = new Mailing();
            Task.Factory.StartNew(() => mailing.SendMail(Mailing.Templates.IntencionParticipar, dataBody, fields, fieldsRequire, subject, mailTo));
        }

    }
}