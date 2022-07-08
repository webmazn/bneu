using Newtonsoft.Json;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Models;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Login()
        {
            ViewData["keySiteCaptcha"] = ConfigurationManager.AppSettings["ReCAPTCHA_Site_Key"];
            return View();
        }

        public async Task<ActionResult> iniciarSesion(LoginBE loginUsuario)
        {
            Dictionary<string, object> response = new Dictionary<string, object> {["success"] = false,["message"] = "" };
            UsuarioBE usuario = null;
            try
            {
                if (string.IsNullOrEmpty(loginUsuario.token))
                {
                    response["success"] = false;
                    response["message"] = "Por favor, debe verificar el captcha";
                    return Json(response);
                }

                var isCaptchaValid = await IsCaptchaValid(loginUsuario.token);
                if (isCaptchaValid)
                {
                    LoginLN logica = new LoginLN();
                    bool esValido = logica.validarUsuario(new UsuarioBE(loginUsuario.correoElectronico, loginUsuario.password), out usuario);
                    if (esValido)
                    {
                        RolLN logicaRol = new RolLN();
                        RolBE rol = logicaRol.obtenerRol(new RolBE(usuario.idRol));
                        usuario.rol = rol;
                        Session["user"] = usuario;
                        response["success"] = true;
                        response["message"] = "Validación correcta";
                        return Json(response);
                    }
                    response["success"] = false;
                    response["message"] = "El usuario y/o contraseña no existen o tienen error, reintente";
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

        private async Task<bool> IsCaptchaValid(string response)
        {
            try
            {
                var secret = ConfigurationManager.AppSettings["ReCAPTCHA_Secret_Key"];
                using (var client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                        {"secret", secret},
                        {"response", response},
                        {"remoteip", Request.UserHostAddress}
                    };

                    var content = new FormUrlEncodedContent(values);
                    var verify = await client.PostAsync("https://www.google.com/recaptcha/api/siteverify", content);
                    var captchaResponseJson = await verify.Content.ReadAsStringAsync();
                    var captchaResult = JsonConvert.DeserializeObject<RecaptchaResponse>(captchaResponseJson);
                    return captchaResult.success;
                           //&& captchaResult.action == "Gestion/AccionMitigacion"
                           //&& captchaResult.score > 0.5;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);
                return false;
            }
        }



    }
}