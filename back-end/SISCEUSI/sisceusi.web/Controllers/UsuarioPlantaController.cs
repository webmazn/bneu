using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    [LoginRequiredAttribute]
    public class UsuarioPlantaController : Controller
    {
        // GET: UsuarioPlanta
        public ActionResult Index(int id)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            ViewData["planta"] = logica.obtenerPlantaEmpresa(new PlantaEmpresaBE() { idPlantaEmpresa = id });
            return View();
        }

        public ActionResult NuevoUsuarioPlanta(int? id, int? idTwo)
        {
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            PlantaEmpresaLN logicaPlanta = new PlantaEmpresaLN();            
            PlantaEmpresaBE planta = logicaPlanta.obtenerPlantaEmpresa(new PlantaEmpresaBE() { idPlantaEmpresa = id.GetValueOrDefault() });
            ViewData["idPlantaEmpresa"] = id;
            ViewData["idUsuario"] = idTwo;
            ViewData["empresa"] = logica.obtenerEmpresa(new EmpresaIndustriaBE { idEmpresaIndustria = planta.idEmpresaIndustria });
            return View();
        }


    }
}