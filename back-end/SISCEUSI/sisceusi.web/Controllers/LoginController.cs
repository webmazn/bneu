using Newtonsoft.Json;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
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
    public class LoginController : BaseController
    {
        [NoLoginRequiredAttribute]
        public ActionResult Index()
        {
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
                        EmpresaIndustriaLN logicaEmpresa = new EmpresaIndustriaLN();
                        EmpresaIndustriaBE empresa = logicaEmpresa.obtenerEmpresa(new EmpresaIndustriaBE { idEmpresaIndustria = usuario.idEmpresaIndustria });
                        usuario.rol = rol;
                        usuario.empresaIndustria = empresa;
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

        public ActionResult Salir()
        {
            Session["user"] = null;
            return View("Index");
        }
    }
}