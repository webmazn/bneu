using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class InicioController : Controller
    {
        UsuarioLN logica = new UsuarioLN();
        // GET: Inicio
        public ActionResult Index()
        {
            return View();
        }

    }
}