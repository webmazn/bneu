using OfficeOpenXml;
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
    public class UsuarioController : BaseController
    {
        [LoginRequiredAttribute]
        // GET: Usuario
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NuevoUsuario(int? id)
        {
            ViewData["idUsuario"] = id;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(int idPlantaEmpresa, string buscar, int registros, int pagina, string columna, string orden)
        {
            UsuarioLN logica = new UsuarioLN();
            List<UsuarioBE> lista = logica.filtroGeneral(new UsuarioBE {
                idPlantaEmpresa = idPlantaEmpresa,
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
        public JsonResult filtroAvanzado(int idPlantaEmpresa, string ruc, string empresa, int tipoUsuario, DateTime? fechaInicio, DateTime? fechaFin, string nombres, string estado, int registros, int pagina, string columna, string orden)
        {
            UsuarioLN logica = new UsuarioLN();
            List<UsuarioBE> lista = logica.filtroAvanzado(new UsuarioBE {
                empresaIndustria = new EmpresaIndustriaBE { ruc = ruc, nombreEmpresa = empresa },
                idPlantaEmpresa = idPlantaEmpresa,
                idRol = tipoUsuario,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                nombres = nombres,
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

        [HttpPost]
        public JsonResult GrabarUsuario(UsuarioBE usuario)
        {
            UsuarioLN logica = new UsuarioLN();
            usuario.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarUsuario(usuario);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerUsuario(int idUsuario)
        {
            UsuarioLN logica = new UsuarioLN();
            UsuarioBE usuario = logica.obtenerUsuario(new UsuarioBE { idUsuario = idUsuario });
            EmpresaIndustriaLN logicaEmpresa = new EmpresaIndustriaLN();
            usuario.empresaIndustria = logicaEmpresa.obtenerEmpresa(new EmpresaIndustriaBE { idEmpresaIndustria = usuario.idEmpresaIndustria });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", usuario == null ? false : true);
            response.Add("object", usuario);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerListaRevisor()
        {
            UsuarioLN logica = new UsuarioLN();
            List<UsuarioBE> lista = logica.obtenerListaRolEspecifico(new UsuarioBE { idRol = 2 });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult verificarCorreo(int id, string correo)
        {
            UsuarioLN logica = new UsuarioLN();
            UsuarioBE usuario = logica.obtenerUsuarioPorCorreo(new UsuarioBE { idUsuario = id, correoElectronico = correo });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", usuario == null ? false : true);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult verificarDni(int id, string dni)
        {
            UsuarioLN logica = new UsuarioLN();
            UsuarioBE usuario = logica.obtenerUsuarioPorDni(new UsuarioBE { idUsuario = id, dni = dni });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", usuario == null ? false : true);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult verificarDniPide(string dni)
        {
            UsuarioBE usuario = null;
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", usuario == null ? false : true);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public void exportarGeneral(int idPlantaEmpresa, string buscar, string columna, string orden)
        {
            UsuarioLN logica = new UsuarioLN();
            List<UsuarioBE> lista = logica.exportarGeneral(new UsuarioBE
            {
                idPlantaEmpresa = idPlantaEmpresa,
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    string tituloExcel = idPlantaEmpresa == 0 ? "Mantenimiento Usuario" : "Mantenimiento Usuario Planta";
                    string nombreArchivo = idPlantaEmpresa == 0 ? "MANTENIMIENTO_USUARIO_" : "MANTENIMIENTO_USUARIO_PLANTA_";
                    ExcelWorksheet ws = tituloReporteExcel(package, tituloExcel, 6);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "NOMBRE Y APELLIDO", "TIPO USUARIO", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, nombreArchivo);
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [HttpGet]
        public void exportarAvanzado(int idPlantaEmpresa, string ruc, string empresa, int tipoUsuario, DateTime? fechaInicio, DateTime? fechaFin, string nombres, string estado, string columna, string orden)
        {
            UsuarioLN logica = new UsuarioLN();
            List<UsuarioBE> lista = logica.exportarAvanzado(new UsuarioBE
            {
                empresaIndustria = new EmpresaIndustriaBE { ruc = ruc, nombreEmpresa = empresa },
                idPlantaEmpresa = idPlantaEmpresa,
                idRol = tipoUsuario,
                fechaInicio = fechaInicio,
                fechaFin = fechaFin,
                nombres = nombres,
                idEstado = estado,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Usuario", 6);
                    cabecerasReporteExcel(ws, new List<string> { "ITEM", "CÓDIGO", "NOMBRE Y APELLIDO", "TIPO USUARIO", "FECHA REGISTRO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_USUARIO_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        private List<List<string>> obtenerDatos(List<UsuarioBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    String.Concat("USU", c.idUsuario.ToString("D4")),
                    c.nombres, c.rol.rol,
                    c.txtFechaCreacion,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado" });
                i++;
            });
            return listas;
        }
    }
}