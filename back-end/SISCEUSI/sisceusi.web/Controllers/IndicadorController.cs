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
    public class IndicadorController : Controller
    {
        // GET: Indicador
        public ActionResult Index()
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaBE> lista = logica.filtroGeneral(new CampanaBE
            {
                buscar = "",
                registros = 10,
                pagina = 1,
                columna = "cam_idCampana",
                orden = "ASC"
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            ViewData["listaCampana"] = response;
            return View();
        }

        public ActionResult NuevoIndicador(int id)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaEncuestaBE> listaCampanaEncuesta = logica.obtenerListaPreguntas(new CampanaBE { idCampana = id });

            IndicadorLN logicaIndicador = new IndicadorLN();
            List<IndicadorBE> lista = logicaIndicador.mostrarListaIndicador(new IndicadorBE
            {
                idCampana = id,
                registros = 10,
                pagina = 1
            });
            Dictionary<string, object> listaIndicador = new Dictionary<string, object>();
            listaIndicador.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            listaIndicador.Add("object", lista);

            ViewData["idCampana"] = id;
            ViewData["listaCampanaEncuesta"] = listaCampanaEncuesta;
            ViewData["listaIndicador"] = listaIndicador;
            return View();
        }

        [HttpGet]
        public JsonResult mostrarListaIndicador(int idCampana, int registros, int pagina)
        {
            IndicadorLN logica = new IndicadorLN();
            List<IndicadorBE> lista = logica.mostrarListaIndicador(new IndicadorBE
            {
                idCampana = idCampana,
                registros = registros,
                pagina = pagina
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpPost]
        public JsonResult grabar(IndicadorBE entidad)
        {
            IndicadorLN logica = new IndicadorLN();
            entidad.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabar(entidad);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idIndicador)
        {
            IndicadorLN logica = new IndicadorLN();
            bool seElimino = logica.eliminar(new IndicadorBE { idIndicador = idIndicador });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerIndicador(int idIndicador)
        {
            IndicadorLN logica = new IndicadorLN();
            IndicadorBE empresa = logica.obtenerEmpresa(new IndicadorBE { idIndicador = idIndicador });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}