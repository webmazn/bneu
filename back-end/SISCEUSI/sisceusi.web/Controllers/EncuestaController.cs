using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.util;
using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
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
                    if (ObtenerUsuarioLogin().idRol == 2)
                    {
                        return RedirectToAction("RevisarEncuesta", new { id = id });
                    }                    
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
            if (seGuardo)
            {
                if (encuesta.esUltimaPregunta) enviarCorreoCulminacionSubsanacionCampana(encuesta.idControlEncuesta);
            }
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
            //Parametro
            ParametroLN logicaParametro = new ParametroLN();
            //Lista Parametro - Método de verificación
            List<ParametroBE> listaMetodoVerificacion = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 28 }); //id Parametro = Método de verificación
            //Lista Parametro - Validez de la entrevista
            List<ParametroBE> listaValidezEntrevista = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 32 }); //id Parametro = Validez de la entrevista
            Session["controlEncuesta"] = controlEncuesta;
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["usuario"] = ObtenerUsuarioLogin();
            ViewData["listaMetodoVerificacion"] = listaMetodoVerificacion;
            ViewData["listaValidezEntrevista"] = listaValidezEntrevista;
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
            if (seGuardo)
            {
                enviarCorreoRevision(controlEncuesta.idControlEncuesta);
            }
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGuardo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private void enviarCorreoCulminacionSubsanacionCampana(int idControlEncuesta)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaCorreoBE> lista = logica.obtenerListaCampanaEncuestaCorreo(idControlEncuesta);
            List<dynamic> listaEnvios = new List<dynamic>();
            foreach (CampanaCorreoBE item in lista)
            {
                string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldEmpresa = "[EMPRESA]", fieldCampana = "[CAMPANA]", fieldCorreo = "[CORREO]", fieldRol = "[ROL]", fieldRevisor = "[REVISOR]";
                string[] fields = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana, fieldCorreo, fieldRol, fieldRevisor };
                string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana, fieldCorreo, fieldRol, fieldRevisor };
                Dictionary<string, string> dataBody = new Dictionary<string, string>
                {
                    [fieldServer] = ConfigurationManager.AppSettings["Server"],
                    [fieldNombres] = item.nombres,
                    [fieldEmpresa] = item.nombreEmpresa,
                    [fieldCampana] = item.denominacion,
                    [fieldCorreo] = item.correoElectronico,
                    [fieldRol] = item.rol,
                    [fieldRevisor] = item.revisor
                };
                string mensaje = item.idFase == 2 ? "culminación" : "subsanación";
                string subject = $"Confirmación de {mensaje} de encuesta – {item.denominacion}";
                MailAddressCollection mailTo = new MailAddressCollection();
                mailTo.Add(new MailAddress(item.correoElectronico, item.nombres));
                MailAddressCollection mailToCC = new MailAddressCollection();
                mailToCC.Add(new MailAddress(item.correoRevisor, item.revisor));
                mailToCC.Add(new MailAddress(item.correoAdmin, item.admin));

                dynamic envio = new
                {
                    Template = Mailing.Templates.CulminacionSubsanacionCampana,
                    Databody = dataBody,
                    Fields = fields,
                    FieldsRequire = fieldsRequire,
                    Subject = subject,
                    MailTo = mailTo,
                    MailToCC = mailToCC
                };
                listaEnvios.Add(envio);
            }

            Mailing mailing = new Mailing();
            Task.Factory.StartNew(() =>
            {
                if (listaEnvios.Count > 0)
                {
                    foreach (dynamic item in listaEnvios)
                    {
                        mailing.SendMail(item.Template, item.Databody, item.Fields, item.FieldsRequire, item.Subject, item.MailTo, item.MailToCC);
                    }
                }
            });
        }

        private void enviarCorreoRevision(int idControlEncuesta)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaCorreoBE> lista = logica.obtenerListaCampanaEncuestaCorreo(idControlEncuesta);
            List<dynamic> listaEnvios = new List<dynamic>();
            foreach (CampanaCorreoBE item in lista)
            {
                string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldEmpresa = "[EMPRESA]", fieldCampana = "[CAMPANA]", fieldCorreo = "[CORREO]", fieldRol = "[ROL]";
                string[] fields = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana, fieldCorreo, fieldRol };
                string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana, fieldCorreo, fieldRol };
                Dictionary<string, string> dataBody = new Dictionary<string, string>
                {
                    [fieldServer] = ConfigurationManager.AppSettings["Server"],
                    [fieldNombres] = item.nombres,
                    [fieldEmpresa] = item.nombreEmpresa,
                    [fieldCampana] = item.denominacion,
                    [fieldCorreo] = item.correoElectronico,
                    [fieldRol] = item.rol
                };
                string subject = $"Confirmación de revisión de encuesta – {item.denominacion}";
                MailAddressCollection mailTo = new MailAddressCollection();
                mailTo.Add(new MailAddress(item.correoElectronico, item.nombres));
                MailAddressCollection mailToCC = new MailAddressCollection();
                mailToCC.Add(new MailAddress(item.correoRevisor, item.revisor));
                mailToCC.Add(new MailAddress(item.correoAdmin, item.admin));

                dynamic envio = new
                {
                    Template = Mailing.Templates.RevisionEncuesta,
                    Databody = dataBody,
                    Fields = fields,
                    FieldsRequire = fieldsRequire,
                    Subject = subject,
                    MailTo = mailTo,
                    MailToCC = mailToCC
                };
                listaEnvios.Add(envio);
            }

            Mailing mailing = new Mailing();
            Task.Factory.StartNew(() =>
            {
                if (listaEnvios.Count > 0)
                {
                    foreach (dynamic item in listaEnvios)
                    {
                        mailing.SendMail(item.Template, item.Databody, item.Fields, item.FieldsRequire, item.Subject, item.MailTo, item.MailToCC);
                    }
                }
            });
        }

    }
}