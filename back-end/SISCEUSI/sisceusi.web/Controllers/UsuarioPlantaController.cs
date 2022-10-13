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
    public class UsuarioPlantaController : BaseController
    {
        // GET: UsuarioPlanta
        public ActionResult Index(int id)
        {
            UsuarioLN logicaUsuario = new UsuarioLN();
            List<UsuarioBE> listaUsuario = logicaUsuario.filtroGeneral(new UsuarioBE
            {
                idPlantaEmpresa = id,
                buscar = "",
                registros = 10,
                pagina = 1,
                columna = "idUsuario",
                orden = "ASC"
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", listaUsuario == null ? false : listaUsuario.Count == 0 ? false : true);
            response.Add("object", listaUsuario);
            ViewData["listaUsuarioPlanta"] = response;
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            ViewData["planta"] = logica.obtenerPlantaEmpresa(new PlantaEmpresaBE() { idPlantaEmpresa = id });
            return View();
        }

        public ActionResult NuevoUsuarioPlanta(int? id, int? idTwo)
        {
            //Lista Rol
            RolLN logicaRol = new RolLN();
            List<RolBE> listaRol = logicaRol.obtenerListaRol();
            PlantaEmpresaLN logicaPlanta = new PlantaEmpresaLN();
            PlantaEmpresaBE planta = logicaPlanta.obtenerPlantaEmpresa(new PlantaEmpresaBE() { idPlantaEmpresa = id.GetValueOrDefault() });
            //Obtener Empresa
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            EmpresaIndustriaBE empresa = logica.obtenerEmpresa(new EmpresaIndustriaBE { idEmpresaIndustria = planta.idEmpresaIndustria });
            //Obtener Usuario
            UsuarioBE usuario = null;
            if (idTwo != null)
            {
                UsuarioLN logicaUsuario = new UsuarioLN();
                usuario = logicaUsuario.obtenerUsuario(new UsuarioBE { idUsuario = idTwo.Value });
                usuario.empresaIndustria = empresa;
            }
            
            ViewData["idPlantaEmpresa"] = id;
            ViewData["idUsuario"] = idTwo;
            ViewData["empresa"] = empresa;
            ViewData["usuario"] = usuario;
            ViewData["listaRol"] = listaRol;
            return View();
        }


    }
}