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
    public class InternoController : BaseController
    {
        // GET: Interno
        public ActionResult Index()
        {
            //Lista Departamento
            DepartamentoLN logicaDepartamento = new DepartamentoLN();
            List<DepartamentoBE> listaDepartamento = logicaDepartamento.obtenerListaDepartamento();
            //Lista Provincia
            ProvinciaLN logicaProvincia = new ProvinciaLN();
            List<ProvinciaBE> listaProvincia = logicaProvincia.obtenerListaProvincia();
            //Lista Distrito
            DistritoLN logicaDistrito = new DistritoLN();
            List<DistritoBE> listaDistrito = logicaDistrito.obtenerListaDistrito();
            //Lista Zona
            ZonaLN logicaZona = new ZonaLN();
            List<ZonaBE> listaZona = logicaZona.obtenerListaZona();
            //Lista Revisor
            UsuarioLN logicaRevisor = new UsuarioLN();
            List<UsuarioBE> listaRevisor = logicaRevisor.obtenerListaRolEspecifico(new UsuarioBE { idRol = 2 });
            //Lista Ciuu
            CiuuLN logicaCiuu = new CiuuLN();
            List<CiuuBE> listaCiuu = logicaCiuu.obtenerListaCiuu();

            ViewData["listaDepartamento"] = listaDepartamento;
            ViewData["listaProvincia"] = listaProvincia;
            ViewData["listaDistrito"] = listaDistrito;
            ViewData["listaZona"] = listaZona;
            ViewData["listaCiuu"] = listaCiuu;
            ViewData["listaRevisor"] = listaRevisor;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(int idUsuario, string buscar, int registros, int pagina, string columna, string orden)
        {
            int idRol = ObtenerUsuarioLogin() == null ? 0 : ObtenerUsuarioLogin().rol.idRol;
            InternoLN logica = new InternoLN();
            List<InternoBE> lista = logica.filtroGeneral(new InternoBE
            {
                idUsuario = idUsuario,
                idRol = idRol,
                buscar = buscar,
                registros = registros,
                pagina = pagina,
                columna = columna,
                orden = orden
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult filtroAvanzado(int idUsuario, string denominacion, string ruc, string empresa, string idDepartamento, string idProvincia, string idDistrito, int idZona, int idSubSector, int idCiuu, int idRevisor, int idTipoEncuesta, DateTime? fechaInicio, DateTime? fechaFin, int estado, int registros, int pagina, string columna, string orden)
        {
            int idRol = ObtenerUsuarioLogin() == null ? 0 : ObtenerUsuarioLogin().rol.idRol;
            InternoLN logica = new InternoLN();
            List<InternoBE> lista = logica.filtroAvanzado(new InternoBE
            {
                idUsuario = idUsuario,
                idRol = idRol,
                campana = new CampanaBE
                {
                    denominacion = denominacion,
                    idSubSector = idSubSector
                },
                empresa = new EmpresaIndustriaBE
                {
                    ruc = ruc,
                    nombreEmpresa = empresa
                },
                planta = new PlantaEmpresaBE {
                    idDepartamento = idDepartamento,
                    idProvincia = idProvincia,
                    idDistrito = idDistrito,
                    idZona = idZona,
                    idCiuu = idCiuu
                },
                controlEncuesta = new ControlEncuestaBE
                {
                    idSupervisor = idRevisor,
                    idTipoEncuesta = idTipoEncuesta,
                    idEtapa = estado
                },
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                registros = registros,
                pagina = pagina,
                columna = columna,
                orden = orden
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult MaestroMantenimiento()
        {
            return View();
        }
    }
}