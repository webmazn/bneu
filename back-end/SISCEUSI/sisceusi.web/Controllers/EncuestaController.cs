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
    public class EncuestaController : BaseController
    {
        // GET: Encuesta
        public ActionResult Inicio(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = logica.obtenerControlEncuesta( new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult participarTratamientoDatos(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.participarTratamientoDatos(controlEncuesta);
            if (seGuardo)
            {
                ControlEncuestaBE obj = logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = controlEncuesta.idControlEncuesta });
                Session["controlEncuesta"] = obj;
            }
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult Firma(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult firmarEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.firmarEncuesta(controlEncuesta);
            if (seGuardo)
            {
                ControlEncuestaBE obj = logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = controlEncuesta.idControlEncuesta });
                Session["controlEncuesta"] = obj;
            }
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult Formulario(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult formularioEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.formularioEncuesta(controlEncuesta);
            if (seGuardo)
            {
                ControlEncuestaBE obj = logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = controlEncuesta.idControlEncuesta });
                Session["controlEncuesta"] = obj;
            }
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult PreguntaEncuesta(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;

            List<CampanaEncuestaBE> listCampanaEncuesta = logica.obtenerListaCampanaEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            //Session["pregunta"] = listCampanaEncuesta;
            //realizar validacion para mostrar la pregunta

            //Ubicarse en la ultima pregunta y recorrer hasta el separador de pagina
            EncuestaLN logicaEncuesta = new EncuestaLN();
            int ultimaPregunta = logicaEncuesta.obtenerUltimaPregunta(new ControlEncuestaBE { idControlEncuesta = id });
            bool detener = false;
            List<CampanaEncuestaBE> listaPregunta = new List<CampanaEncuestaBE>();
            while (!detener)
            {
                CampanaEncuestaBE campanaEncuesta = listCampanaEncuesta.Find(x => x.numeroOrdenPregunta == ultimaPregunta);
                if (campanaEncuesta != null)
                {
                    listaPregunta.Add(campanaEncuesta);
                    ultimaPregunta++;
                    if (campanaEncuesta.separador.Equals("1"))
                    {
                        detener = true;
                    }
                }
                else
                {
                    detener = true;
                }
            }
            //Verificar cada pregunta si presenta una tabla mestra
            listaPregunta.ForEach(x =>
            {
                x.listaRespuesta = logica.obtenerListaRespuestaEncuesta(x);
                if (x.idParametroTabla > 0)
                {
                    x.listaEncabezadoSecundario = logica.obtenerTablaMaestraEncabezados(new CampanaEncuestaBE { idParametroTabla = x.idParametroTabla });
                }
            });
            //CampanaEncuestaBE campanaEncuesta = listCampanaEncuesta[0];
            //if (campanaEncuesta.idParametroTabla > 0)
            //{
            //    campanaEncuesta.listaEncabezadoSecundario = logica.obtenerTablaMaestraEncabezados(new CampanaEncuestaBE { idParametroTabla = campanaEncuesta.idParametroTabla });
            //}
            ViewData["preguntaMostrar"] = listaPregunta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult grabarEncuesta(EncuestaBE encuesta)
        {
            EncuestaLN logica = new EncuestaLN();
            encuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.grabarEncuesta(encuesta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}