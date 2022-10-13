using OfficeOpenXml;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.util;
using sisceusi.web.Filter;
using sres.ut;
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
    public class CampanaController : BaseController
    {
        // GET: Campana
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

        public ActionResult NuevaCampana(int? id)
        {
            //Lista Empresa
            EmpresaIndustriaLN logicaEmpresa = new EmpresaIndustriaLN();
            List<EmpresaIndustriaBE> listaEmpresa = logicaEmpresa.obtenerListaEmpresa();
            //Lista Revisor
            UsuarioLN logicaRevisor = new UsuarioLN();
            List<UsuarioBE> listaRevisor = logicaRevisor.obtenerListaRolEspecifico(new UsuarioBE { idRol = 2 });
            //Lista TablaMaestra
            TablaMaestraLN logicaTablaMaestra = new TablaMaestraLN();
            List<TablaMaestraBE> listaTablaMaestra = logicaTablaMaestra.obtenerListaTablaMaestra();
            //Lista Parametro - SubSector
            ParametroLN logicaParametro = new ParametroLN();
            List<ParametroBE> listaSubSector = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 1 }); //id Parametro = SubSector
            //Lista Parametro - Giro
            List<ParametroBE> listaGiro = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 6 }); //id Parametro = Giro
            //Lista Parametro - Ciuu
            List<ParametroBE> listaCiuu = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 10 }); //id Parametro = Ciuu
            //Objeto Campaña
            CampanaBE campana = null;
            if (id != null)
            {
                CampanaLN logica = new CampanaLN();
                campana = logica.obtenerCampana(new CampanaBE { idCampana = id.Value });
            }

            ViewData["idCampana"] = id;
            ViewData["campana"] = campana;
            ViewData["listaGiro"] = listaGiro;
            ViewData["listaCiuu"] = listaCiuu;
            ViewData["listaEmpresa"] = listaEmpresa;
            ViewData["listaRevisor"] = listaRevisor;
            ViewData["listaTablaMaestra"] = listaTablaMaestra;
            ViewData["listaSubSector"] = listaSubSector;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(string buscar, int registros, int pagina, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaBE> lista = logica.filtroGeneral(new CampanaBE
            {
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
        public JsonResult filtroAvanzado(string denominacion, string ruc, string empresa, DateTime? fechaInicio, DateTime? fechaFin, string estado, int registros, int pagina, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaEmpresaBE> listaCampanaEmpresa = new List<CampanaEmpresaBE>();
            listaCampanaEmpresa.Add(new CampanaEmpresaBE
            {
                empresaIndustria = new EmpresaIndustriaBE
                {
                    ruc = ruc,
                    nombreEmpresa = empresa
                }                
            });
            List<CampanaBE> lista = logica.filtroAvanzado(new CampanaBE
            {
                denominacion = denominacion,
                listaCampanaEmpresa = listaCampanaEmpresa,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                idEstado = estado,
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
        public void exportarGeneral(string buscar, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaBE> lista = logica.exportarGeneral(new CampanaBE
            {
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Campaña", 4);
                    cabecerasReporteExcel(ws, new List<string> { "N°", "CÓDIGO", "DENOMINACIÓN", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpGet]
        public void exportarAvanzado(string denominacion, string ruc, string empresa, DateTime? fechaInicio, DateTime? fechaFin, string estado, string columna, string orden)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaEmpresaBE> listaCampanaEmpresa = new List<CampanaEmpresaBE>();
            listaCampanaEmpresa.Add(new CampanaEmpresaBE
            {
                empresaIndustria = new EmpresaIndustriaBE
                {
                    ruc = ruc,
                    nombreEmpresa = empresa
                }
            });
            List<CampanaBE> lista = logica.exportarAvanzado(new CampanaBE
            {
                denominacion = denominacion,
                listaCampanaEmpresa = listaCampanaEmpresa,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                idEstado = estado,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Campaña", 4);
                    cabecerasReporteExcel(ws, new List<string> { "N°", "CÓDIGO", "DENOMINACIÓN", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpPost]
        public JsonResult grabarCampana(CampanaBE campana)
        {
            CampanaLN logica = new CampanaLN();
            campana.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarCampana(campana);
            if (seGrabo)
            {
                if (campana.idEtapaPiloto == 2) enviarCorreoInicio(campana.idCampana, 1);
                if (campana.idEtapaOficial == 2) enviarCorreoInicio(campana.idCampana, 2);
                if (campana.idEtapaPiloto == 3) enviarCorreoFinalizacion(campana.idCampana, 1);
                if (campana.idEtapaOficial == 3) enviarCorreoFinalizacion(campana.idCampana, 2);
            }
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerCampana(int idCampana)
        {
            CampanaLN logica = new CampanaLN();
            CampanaBE campana = logica.obtenerCampana(new CampanaBE { idCampana = idCampana });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", campana == null ? false : true);
            response.Add("object", campana);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<CampanaBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    String.Concat("ENC", c.idCampana.ToString("D4")),
                    c.denominacion,
                    c.txtFechaCreacion,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado" });
                i++;
            });
            return listas;
        }

        [HttpPost]
        public JsonResult copiarCampana(CopiarCampanaBE entidad)
        {
            CampanaLN logica = new CampanaLN();
            entidad.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seCopio = logica.copiarCampana(entidad);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seCopio);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idCampana)
        {
            CampanaLN logica = new CampanaLN();
            bool seElimino = logica.eliminar(new CampanaBE { idCampana = idCampana });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private void enviarCorreoInicio(int idCampana, int idTipoEncuesta)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaCorreoBE> lista = logica.obtenerListaCampanaCorreo(idCampana, idTipoEncuesta);
            List<dynamic> listaEnvios = new List<dynamic>();
            foreach (CampanaCorreoBE item in lista)
            {
                string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldEmpresa = "[EMPRESA]", fieldCampana = "[CAMPANA]", fieldCorreo = "[CORREO]", fieldRol = "[ROL]", fieldFecha = "[FECHAINICIO]";
                string[] fields = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana, fieldCorreo, fieldRol, fieldFecha };
                string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana, fieldCorreo, fieldRol, fieldFecha };
                Dictionary<string, string> dataBody = new Dictionary<string, string>
                {
                    [fieldServer] = ConfigurationManager.AppSettings["Server"],
                    [fieldNombres] = item.nombres,
                    [fieldEmpresa] = item.nombreEmpresa,
                    [fieldCampana] = item.denominacion,
                    [fieldCorreo] = item.correoElectronico,
                    [fieldRol] = item.rol,
                    [fieldFecha] = idTipoEncuesta == 1 ? item.txtfechaFinPiloto : item.txtfechaFinOficial
                };
                string subject = $"Solicitud de información – {item.denominacion}";
                MailAddressCollection mailTo = new MailAddressCollection();
                mailTo.Add(new MailAddress(item.correoElectronico, item.nombres));

                dynamic envio = new
                {
                    Template = Mailing.Templates.InicioCampana,
                    Databody = dataBody,
                    Fields = fields,
                    FieldsRequire = fieldsRequire,
                    Subject = subject,
                    MailTo = mailTo
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
                        mailing.SendMail(item.Template, item.Databody, item.Fields, item.FieldsRequire, item.Subject, item.MailTo);
                    }
                }
            });
        }

        private void enviarCorreoFinalizacion(int idCampana, int idTipoEncuesta)
        {
            CampanaLN logica = new CampanaLN();
            List<CampanaCorreoBE> lista = logica.obtenerListaCampanaCorreo(idCampana, idTipoEncuesta);
            List<dynamic> listaEnvios = new List<dynamic>();
            foreach (CampanaCorreoBE item in lista)
            {
                string fieldServer = "[SERVER]", fieldNombres = "[NOMBRES]", fieldEmpresa = "[EMPRESA]", fieldCampana = "[CAMPANA]";
                string[] fields = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana };
                string[] fieldsRequire = new string[] { fieldServer, fieldNombres, fieldEmpresa, fieldCampana };
                Dictionary<string, string> dataBody = new Dictionary<string, string>
                {
                    [fieldServer] = ConfigurationManager.AppSettings["Server"],
                    [fieldNombres] = item.nombres,
                    [fieldEmpresa] = item.nombreEmpresa,
                    [fieldCampana] = item.denominacion,
                };
                string subject = $"{item.denominacion.ToUpper()} FINALIZADA";
                MailAddressCollection mailTo = new MailAddressCollection();
                mailTo.Add(new MailAddress(item.correoElectronico, item.nombres));

                dynamic envio = new
                {
                    Template = Mailing.Templates.FinalizacionCampana,
                    Databody = dataBody,
                    Fields = fields,
                    FieldsRequire = fieldsRequire,
                    Subject = subject,
                    MailTo = mailTo
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
                        mailing.SendMail(item.Template, item.Databody, item.Fields, item.FieldsRequire, item.Subject, item.MailTo);
                    }
                }
            });
        }
    }
}