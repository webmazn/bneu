﻿using OfficeOpenXml;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    [LoginRequiredAttribute]
    public class TablaMaestraController : BaseController
    {
        // GET: TablaMaestra
        public ActionResult Index()
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<TablaMaestraBE> lista = logica.filtroGeneral(new TablaMaestraBE
            {
                buscar = "",
                registros = 10,
                pagina = 1,
                columna = "tma_idTablaMaestra",
                orden = "ASC"
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            ViewData["listaTablaMaestra"] = response;
            return View();
        }

        public ActionResult NuevaTablaMaestra(int? id)
        {
            //Lista Parametro
            ParametroLN logicaParametro = new ParametroLN();
            List<ParametroBE> listaParametro = logicaParametro.obtenerListaParametro();

            //Lista TablaMaestra
            TablaMaestraBE tablaMaestra = null;
            Dictionary<string, object> responsePrincipal = new Dictionary<string, object>();
            Dictionary<string, object> responseSecundario = new Dictionary<string, object>();
            List<EncabezadoPrincipalBE> lista = null;
            if (id != null)
            {
                TablaMaestraLN logica = new TablaMaestraLN();
                tablaMaestra = logica.obtenerTablaMaestra(new TablaMaestraBE { idTablaMaestra = id.Value });
                //Lista Encabezado Principal Tabla
                List<EncabezadoPrincipalBE> listaEncabezadoPrincipal = logica.mostrarListaEncabezadoPrincipal(new EncabezadoPrincipalBE
                {
                    idTablaMaestra = id.Value,
                    registros = 10,
                    pagina = 1
                });                
                responsePrincipal.Add("success", listaEncabezadoPrincipal == null ? false : listaEncabezadoPrincipal.Count == 0 ? false : true);
                responsePrincipal.Add("object", listaEncabezadoPrincipal);
                //Lista Encabezado Secundario
                List<EncabezadoSecundarioBE> listaSecundario = logica.mostrarListaEncabezadoSecundario(new EncabezadoSecundarioBE
                {
                    encabezadoPrincipal = new EncabezadoPrincipalBE { idTablaMaestra = id.Value },
                    registros = 10,
                    pagina = 1
                });                
                responseSecundario.Add("success", listaSecundario == null ? false : listaSecundario.Count == 0 ? false : true);
                responseSecundario.Add("object", listaSecundario);
                //Obtener Lista Encabezado Principal
                lista = logica.obtenerListaEncabezadoPrincipal(new EncabezadoPrincipalBE { idTablaMaestra = id.Value });
            }
            
            ViewData["idTablaMaestra"] = id;
            ViewData["tablaMaestra"] = tablaMaestra;
            ViewData["tablaEncabezadoPrincipal"] = responsePrincipal;
            ViewData["tablaEncabezadoSecundario"] = responseSecundario;
            ViewData["listaEncabezadoPrincipal"] = lista;
            ViewData["listaParametro"] = listaParametro; 
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(string buscar, int registros, int pagina, string columna, string orden)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<TablaMaestraBE> lista = logica.filtroGeneral(new TablaMaestraBE
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
        public JsonResult filtroAvanzado(string subtitulo, DateTime? fechaInicio, DateTime? fechaFin, string usuario, string estado, int registros, int pagina, string columna, string orden)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<TablaMaestraBE> lista = logica.filtroAvanzado(new TablaMaestraBE
            {
                subtitulo = subtitulo,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                usuarioRegistro = new UsuarioBE { nombres = usuario },
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
            TablaMaestraLN logica = new TablaMaestraLN();
            List<TablaMaestraBE> lista = logica.exportarGeneral(new TablaMaestraBE
            {
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento tabla maestra", 6);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "SUB TÍTULO", "USUARIO REGISTRO", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_TABLA_MAESTRA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        public void exportarAvanzado(string subtitulo, DateTime? fechaInicio, DateTime? fechaFin, string usuario, string estado, string columna, string orden)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<TablaMaestraBE> lista = logica.exportarAvanzado(new TablaMaestraBE
            {
                subtitulo = subtitulo,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                usuarioRegistro = new UsuarioBE { nombres = usuario },
                idEstado = estado,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento tabla maestra", 6);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "SUB TÍTULO", "USUARIO REGISTRO", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_TABLA_MAESTRA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpGet]
        public JsonResult mostrarListaEncabezadoPrincipal(int idTablaMaestra, int registros, int pagina)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<EncabezadoPrincipalBE> lista = logica.mostrarListaEncabezadoPrincipal(new EncabezadoPrincipalBE
            {
                idTablaMaestra = idTablaMaestra,
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

        [HttpGet]
        public JsonResult mostrarListaEncabezadoSecundario(int idTablaMaestra, int registros, int pagina)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<EncabezadoSecundarioBE> lista = logica.mostrarListaEncabezadoSecundario(new EncabezadoSecundarioBE
            {
                encabezadoPrincipal = new EncabezadoPrincipalBE { idTablaMaestra = idTablaMaestra },
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
        public JsonResult grabarTablaMaestra(TablaMaestraBE tablaMaestra)
        {
            int idTablaMaestra = -1;
            TablaMaestraLN logica = new TablaMaestraLN();
            tablaMaestra.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarTablaMaestra(tablaMaestra, out idTablaMaestra);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            response.Add("object", idTablaMaestra);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpPost]
        public JsonResult grabarEncabezadoPrincipal(EncabezadoPrincipalBE encabezado)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            encabezado.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarEncabezadoPrincipal(encabezado);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpPost]
        public JsonResult grabarEncabezadoSecundario(EncabezadoSecundarioBE encabezado)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            encabezado.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarEncabezadoSecundario(encabezado);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerListaEncabezadoPrincipal(int idTablaMaestra)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<EncabezadoPrincipalBE> lista = logica.obtenerListaEncabezadoPrincipal(new EncabezadoPrincipalBE { idTablaMaestra = idTablaMaestra });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerTablaMaestra(int idTablaMaestra)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            TablaMaestraBE encabezado = logica.obtenerTablaMaestra(new TablaMaestraBE { idTablaMaestra = idTablaMaestra });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", encabezado == null ? false : true);
            response.Add("object", encabezado);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerEncabezadoPrincipal(int idEncabezadoPrincipal)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            EncabezadoPrincipalBE encabezado = logica.obtenerEncabezadoPrincipal(new EncabezadoPrincipalBE { idEncabezadoPrincipal = idEncabezadoPrincipal });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", encabezado == null ? false : true);
            response.Add("object", encabezado);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerEncabezadoSecundario(int idEncabezadoSecundario)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            EncabezadoSecundarioBE encabezado = logica.obtenerEncabezadoSecundario(new EncabezadoSecundarioBE { idEncabezadoSecundario = idEncabezadoSecundario });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", encabezado == null ? false : true);
            response.Add("object", encabezado);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerListaTablaMaestra()
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            List<TablaMaestraBE> lista = logica.obtenerListaTablaMaestra();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idTablaMaestra)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            bool seElimino = logica.eliminar(new TablaMaestraBE { idTablaMaestra = idTablaMaestra });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminarPrincipal(int idEncabezadoPrincipal)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            bool seElimino = logica.eliminarPrincipal(new EncabezadoPrincipalBE { idEncabezadoPrincipal = idEncabezadoPrincipal });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminarSecundario(int idEncabezadoSecundario)
        {
            TablaMaestraLN logica = new TablaMaestraLN();
            bool seElimino = logica.eliminarSecundario(new EncabezadoSecundarioBE { idEncabezadoSecundario = idEncabezadoSecundario });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<TablaMaestraBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    String.Concat("TMA", c.idTablaMaestra.ToString("D4")),
                    c.subtitulo,
                    c.usuarioRegistro.nombres,
                    c.txtFechaCreacion,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado" });
                i++;
            });
            return listas;
        }

    }
}