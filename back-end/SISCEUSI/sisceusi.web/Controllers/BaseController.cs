using Newtonsoft.Json;
using sisceusi.entidad;
using sisceusi.web.Models;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class BaseController : Controller
    {
        protected UsuarioBE ObtenerUsuarioLogin()
        {
            string keySession = "user";
            UsuarioBE usuario = Session[keySession] == null ? null : (UsuarioBE)Session[keySession];
            return usuario;
        }

        protected async Task<bool> IsCaptchaValid(string response)
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