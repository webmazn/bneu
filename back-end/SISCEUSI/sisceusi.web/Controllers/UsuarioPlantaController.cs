using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class UsuarioPlantaController : Controller
    {
        // GET: UsuarioPlanta
        public ActionResult Index(int id)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            ViewData["planta"] = logica.obtenerPlantaEmpresa(new PlantaEmpresaBE() { idPlantaEmpresa = id });
            return View();
        }
    }
}