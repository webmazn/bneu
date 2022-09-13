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

        public ActionResult PreguntaEncuesta(int id, int? idTwo)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;

            List<CampanaEncuestaBE> listCampanaEncuesta = logica.obtenerListaCampanaEncuesta(new ControlEncuestaBE { idControlEncuesta = id });

            //Ubicarse en la ultima pregunta y recorrer hasta el separador de pagina
            int ultimaPregunta = 0;
            int anteriorPregunta = 0;
            EncuestaLN logicaEncuesta = new EncuestaLN();

            if (ObtenerUsuarioLogin().idRol == 2)
            {
                ultimaPregunta = idTwo == null ? 0 : idTwo.Value;
            }
            else
            {
                if (controlEncuesta.idFase == 3)
                {
                    ultimaPregunta = idTwo == null ? 0 : idTwo.Value;
                } else if (idTwo == null)
                {
                    ultimaPregunta = logicaEncuesta.obtenerUltimaPregunta(new ControlEncuestaBE { idControlEncuesta = id });
                }
                else
                {
                    ultimaPregunta = idTwo.Value;
                }
            }
            
            anteriorPregunta = ultimaPregunta == 0 ? 0 : obtenerAnteriorPregunta(listCampanaEncuesta, ultimaPregunta);
            int preguntaActual = ultimaPregunta;

            bool detener = false, finalizarEncuesta = false, esUltimaPregunta = false;
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
                    finalizarEncuesta = true;
                    detener = true;
                }
            }

            //Verificamos si respondió la ultima pregunta de la encuesta
            if (finalizarEncuesta)
            {
                int numeroUltimaPregunta = listCampanaEncuesta.Max(x => x.numeroOrdenPregunta);
                if (ultimaPregunta > numeroUltimaPregunta)
                {
                    return View("RevisarEncuesta");
                } 
            }
            else
            {
                int numeroUltimaPregunta = listCampanaEncuesta.Max(x => x.numeroOrdenPregunta);
                esUltimaPregunta = numeroUltimaPregunta == (ultimaPregunta - 1);
            }


            //Verificar cada pregunta si presenta una tabla mestra
            listaPregunta.ForEach(x =>
            {
                x.encuestaComentario = x.idCampanaEncuesta == listaPregunta[0].idCampanaEncuesta ? logicaEncuesta.obtenerEncuestaComentario(new EncuestaComentarioBE { idControlEncuesta = controlEncuesta.idControlEncuesta, idCampanaEncuesta = x.idCampanaEncuesta }) : null;
                x.listaRespuesta = logica.obtenerListaRespuestaEncuesta(x);
                x.listaRespuestaEncuestaPlanta = logicaEncuesta.obtenerListaRespuestaPlanta(id, x.idCampanaEncuesta);
                if (x.idParametroTabla > 0)
                {
                    x.listaEncabezadoSecundario = logica.obtenerTablaMaestraEncabezados(new CampanaEncuestaBE { idControlEncuesta = id, idParametroTabla = x.idParametroTabla });
                }
            });

            ViewData["preguntaMostrar"] = listaPregunta;
            ViewData["preguntaInicio"] = preguntaActual;
            ViewData["preguntaUltimo"] = ultimaPregunta;
            ViewData["preguntaAnterior"] = anteriorPregunta;
            ViewData["esUltimaPregunta"] = esUltimaPregunta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }       

        private int obtenerAnteriorPregunta(List<CampanaEncuestaBE> lista, int ultimaPregunta)
        {
            bool detener = false;            
            while (!detener)
            {
                ultimaPregunta--;
                CampanaEncuestaBE campanaEncuesta = lista.Find(x => x.numeroOrdenPregunta == ultimaPregunta);
                if (campanaEncuesta != null)
                {
                    if (campanaEncuesta.titulo.Equals("1"))
                    {
                        detener = true;
                    }
                }
                else
                {
                    ultimaPregunta = 0;
                    detener = true;
                }
            }
            return ultimaPregunta;
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

        public ActionResult RevisarEncuesta(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = ViewData["controlEncuesta"] != null ? (ControlEncuestaBE)ViewData["controlEncuesta"] : logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            return View();
        }

        [HttpPost]
        public JsonResult GuardarObservacionEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.GuardarRevisionEncuesta(controlEncuesta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpPost]
        public JsonResult GuardarRevisionEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            controlEncuesta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGuardo = logica.GuardarRevisionEncuesta(controlEncuesta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

    }
}