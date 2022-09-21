using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.util;
using sres.ut;
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
    public class InicioController : BaseController
    {
        UsuarioLN logica = new UsuarioLN();
        // GET: Inicio
        public ActionResult Index()
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            List<BannerBE> banners = logica.mostrarListaBannerAll();
            List<PublicacionBE> publicaciones = logica.mostrarListaPublicacionAll();
            List<EnlaceBE> enlaces = logica.mostrarListaEnlaceAll();
            LogoRedSocialBE logo = logica.obtenerLogoRedSocial(new LogoRedSocialBE());
            ViewData["listaBanner"] = banners;
            ViewData["listaPublicacion"] = publicaciones;
            ViewData["listaEnlace"] = enlaces;
            ViewData["logo"] = logo;
            return View();
        }

        public ActionResult contacto()
        {
            return View();
        }

        public JsonResult enviarContacto(ContactoBE contacto)
        {
            string correoAdmin = ConfigurationManager.AppSettings["correoAdmin"];
            string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldTelefono = "[TELEFONO]", fieldCorreo = "[CORREO]", fieldMensaje = "[MENSAJE]";
            string[] fields = new string[] { fieldServer, fieldNombres, fieldTelefono, fieldCorreo, fieldMensaje };
            string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldTelefono, fieldCorreo, fieldMensaje };
            string mensaje = $"<span style='font-family: sans-serif;'>{contacto.asunto}</span>";
            Dictionary<string, string> dataBody = new Dictionary<string, string> {[fieldServer] = ConfigurationManager.AppSettings["Server"],[fieldNombres] = contacto.nombres, [fieldTelefono] = contacto.telefono, [fieldCorreo] = contacto.correo, [fieldMensaje] = mensaje };
            string subject = $"CONTACTO: {contacto.nombres} se ha contactado";
            MailAddressCollection mailTo = new MailAddressCollection();
            mailTo.Add(new MailAddress(correoAdmin, contacto.nombres));

            Mailing mailing = new Mailing();
            Task.Factory.StartNew(() => mailing.SendMail(Mailing.Templates.Contacto, dataBody, fields, fieldsRequire, subject, mailTo));

            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", true);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult recuperarClave()
        {
            return View();
        }

        public async Task<ActionResult> enviarCorreoRecuperar(UsuarioBE usuario)
        {
            Dictionary<string, object> response = new Dictionary<string, object> {["success"] = false,["message"] = "" };
            try
            {
                if (string.IsNullOrEmpty(usuario.token))
                {
                    response["success"] = false;
                    response["message"] = "Por favor, debe verificar el captcha";
                    return Json(response);
                }

                var isCaptchaValid = await IsCaptchaValid(usuario.token);
                if (isCaptchaValid)
                {
                    UsuarioLN logica = new UsuarioLN();
                    UsuarioBE user = logica.obtenerUsuarioPorCorreo(new UsuarioBE { idUsuario = 0, correoElectronico = usuario.correoElectronico });
                    if (user != null)
                    {
                        if (user.dni == usuario.dni)
                        {
                            var seed = Environment.TickCount;
                            var random = new Random(seed);
                            int aleatorio = random.Next(123576, 785465);
                            long fechaExpiracion = long.Parse(DateTime.Now.AddMinutes(10).ToString("yyyyMMddHHmmss"));
                            string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldIdUsuario = "[ID_USUARIO]", fieldAleatorio = "[ALEATORIO]", fieldFecha = "[FECHA_EXPIRACION]";
                            string[] fields = new string[] { fieldServer, fieldNombres, fieldIdUsuario, fieldAleatorio, fieldFecha };
                            string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldIdUsuario, fieldAleatorio, fieldFecha };
                            Dictionary<string, string> dataBody = new Dictionary<string, string> {[fieldServer] = ConfigurationManager.AppSettings["Server"], [fieldNombres] = user.nombres, [fieldIdUsuario] = user.idUsuario.ToString(), [fieldAleatorio] = aleatorio.ToString(), [fieldFecha] = fechaExpiracion.ToString() };
                            string subject = $"{user.nombres}, recupere su contraseña";
                            MailAddressCollection mailTo = new MailAddressCollection();
                            mailTo.Add(new MailAddress(user.correoElectronico, $"{user.nombres}"));

                            Mailing mailing = new Mailing();
                            Task.Factory.StartNew(() => mailing.SendMail(Mailing.Templates.RecuperarClave, dataBody, fields, fieldsRequire, subject, mailTo));

                            response["success"] = true;
                            response["message"] = $"se envió link para cambiar la contraseña al correo {user.correoElectronico}";
                        }
                        else
                        {
                            response["success"] = false;
                            response["message"] = "El Dni ingresado no es válido.";
                        }
                    }
                    else
                    {
                        response["success"] = false;
                        response["message"] = "El correo electrónico ingresado no ha sido registrado. Intente con otro correo electrónico.";
                    }
                    return Json(response);
                }
                else
                {
                    response["success"] = false;
                    response["message"] = "Ocurrió un problema en la validación del captcha";
                }
            }
            catch (Exception ex) {
                Log.Error(ex);
                response["success"] = false;
                response["message"] = "Ocurrió un problema en el proceso de recuperar la contraseña";
            }
            return Json(response);
        }

        public ActionResult CambiarClave(string id, string idTwo)
        {
            string[] valores = idTwo.Split('-');
            long fecha = long.Parse(DateTime.Now.ToString("yyyyMMddHHmmss"));
            long fechaExpiracion = long.Parse(valores[1]);
            if (valores[1].Length == 14)
            {
                if (fechaExpiracion > fecha)
                {
                    ViewData["idUsuario"] = valores[0];
                    return View("ContrasenaNuevo");
                }
                else
                {
                    return HttpNotFound();
                }
            }
            else
            {
                return HttpNotFound();
            }         
        }

        public async Task<ActionResult> crearContrasenaNuevo(UsuarioBE user)
        {
            Dictionary<string, object> response = new Dictionary<string, object> {["success"] = false,["message"] = "" };
            UsuarioBE usuario = null;
            try
            {
                if (string.IsNullOrEmpty(user.token))
                {
                    response["success"] = false;
                    response["message"] = "Por favor, debe verificar el captcha";
                    return Json(response);
                }

                var isCaptchaValid = await IsCaptchaValid(user.token);
                if (isCaptchaValid)
                {
                    UsuarioLN logica = new UsuarioLN();
                    usuario = logica.obtenerUsuario(new UsuarioBE { idUsuario = user.idUsuario });
                    if (usuario != null)
                    {
                        usuario.password = user.password;
                        bool seGraba = logica.grabarUsuario(usuario);
                        response["success"] = seGraba;
                        response["message"] = seGraba ? "Se cambió su contraseña exitosamente. Lo estamos redirigiendo." : "Ocurrió un problema al momento de actualizar la contraseña.";
                    }
                    else
                    {
                        response["success"] = false;
                        response["message"] = "Los datos del usuario que se quieren actualizar no son coherentes.";
                    }
                }
                else
                {
                    response["success"] = false;
                    response["message"] = "Ocurrió un problema en la validación del captcha";
                }
            }
            catch (Exception ex) { Log.Error(ex); }
            return Json(response);
        }

    }
}