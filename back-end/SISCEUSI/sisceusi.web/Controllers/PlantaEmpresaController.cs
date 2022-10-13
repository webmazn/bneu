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
    [LoginRequiredAttribute]
    [RoutePrefix("PlantaEmpresa")]
    public class PlantaEmpresaController : BaseController
    {
        // GET: PlantaEmpresa
        public ActionResult Index(int id)
        {
            PlantaEmpresaLN logicaPlanta = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logicaPlanta.filtroGeneral(new PlantaEmpresaBE
            {
                idEmpresaIndustria = id,
                buscar = "",
                registros = 10,
                pagina = 1,
                columna = "pem_idPlantaEmpresa",
                orden = "ASC"
            });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            
            EmpresaIndustriaLN logica = new EmpresaIndustriaLN();
            ViewData["empresa"] = logica.obtenerEmpresa(new EmpresaIndustriaBE() { idEmpresaIndustria = id });

            ParametroLN logicaParametro = new ParametroLN();
            //Lista Parametro - Ciuu
            List<ParametroBE> listaCiuu = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 10 }); //id Parametro = Ciuu
            //Lista Departamento
            DepartamentoLN logicaDepartamento = new DepartamentoLN();
            List<DepartamentoBE> listaDepartamento = logicaDepartamento.obtenerListaDepartamento();
            //Lista Provincia
            ProvinciaLN logicaProvincia = new ProvinciaLN();
            List<ProvinciaBE> listaProvincia = logicaProvincia.obtenerListaProvincia();
            //Lista Distrito
            DistritoLN logicaDistrito = new DistritoLN();
            List<DistritoBE> listaDistrito = logicaDistrito.obtenerListaDistrito();
            ViewData["listaPlanta"] = response;
            ViewData["listaCiuu"] = listaCiuu;
            ViewData["listaDepartamento"] = listaDepartamento;
            ViewData["listaProvincia"] = listaProvincia;
            ViewData["listaDistrito"] = listaDistrito;
            return View();
        }

        public ActionResult NuevaPlanta(int? id, int? idTwo)
        {
            ParametroLN logicaParametro = new ParametroLN();
            //Lista Parametro - Giro
            List<ParametroBE> listaGiro = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 6 }); //id Parametro = Giro
            //Lista Parametro - Ciuu
            List<ParametroBE> listaCiuu = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 10 }); //id Parametro = Ciuu
            //Lista Parametro - Empresa Gas
            List<ParametroBE> listaEmpresaGas = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 18 }); //id Parametro = Empresa Gas
            //Lista Parametro - Empresa Luz
            List<ParametroBE> listaEmpresaLuz = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 21 }); //id Parametro = Empresa Luz
            //Lista Parametro - Zona
            List<ParametroBE> listaZona = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 25 }); //id Parametro = Zona

            //Lista Departamento
            DepartamentoLN logicaDepartamento = new DepartamentoLN();
            List<DepartamentoBE> listaDepartamento = logicaDepartamento.obtenerListaDepartamento();
            //Lista Provincia
            ProvinciaLN logicaProvincia = new ProvinciaLN();
            List<ProvinciaBE> listaProvincia = logicaProvincia.obtenerListaProvincia();
            //Lista Distrito
            DistritoLN logicaDistrito = new DistritoLN();
            List<DistritoBE> listaDistrito = logicaDistrito.obtenerListaDistrito();
            //Objeto Campaña
            PlantaEmpresaBE planta = null;
            if (idTwo != null)
            {
                PlantaEmpresaLN logica = new PlantaEmpresaLN();
                planta = logica.obtenerPlantaEmpresa(new PlantaEmpresaBE { idPlantaEmpresa = idTwo.Value });                
            }

            EmpresaIndustriaLN logicaEmpresa = new EmpresaIndustriaLN();
            ViewData["empresa"] = logicaEmpresa.obtenerEmpresa(new EmpresaIndustriaBE() { idEmpresaIndustria = id.Value });
            ViewData["idPlantaEmpresa"] = idTwo;
            ViewData["planta"] = planta;
            ViewData["listaGiro"] = listaGiro;
            ViewData["listaCiuu"] = listaCiuu;
            ViewData["listaDepartamento"] = listaDepartamento;
            ViewData["listaProvincia"] = listaProvincia;
            ViewData["listaDistrito"] = listaDistrito;
            ViewData["listaZona"] = listaZona;
            ViewData["listaEmpresaGas"] = listaEmpresaGas;
            ViewData["listaEmpresaLuz"] = listaEmpresaLuz;
            return View();
        }

        [HttpGet]
        public JsonResult filtroGeneral(int idEmpresa, string buscar, int registros, int pagina, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.filtroGeneral(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
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
        public JsonResult filtroAvanzado(int idEmpresa, string direccion, int idCiuu, string telefono, string idDepartamento, string idProvincia, string idDistrito, int registros, int pagina, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.filtroAvanzado(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                direccion = direccion,
                idCiuu = idCiuu,
                telefono = telefono,
                idDepartamento = idDepartamento,
                idProvincia = idProvincia,
                idDistrito = idDistrito,
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
        public void exportarGeneral(int idEmpresa, string buscar, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.exportarGeneral(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                buscar = buscar,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Planta Empresa", 9);
                    cabecerasReporteExcel(ws, new List<string> { "N°", "DIRECCIÓN", "CIUU", "TELÉFONO", "UBICACIÓN", "DEPARTAMENTO", "PROVINCIA", "DISTRITO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_PLANTA_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        public void exportarAvanzado(int idEmpresa, string direccion, int idCiuu, string telefono, string idDepartamento, string idProvincia, string idDistrito, string columna, string orden)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.exportarAvanzado(new PlantaEmpresaBE
            {
                idEmpresaIndustria = idEmpresa,
                direccion = direccion,
                idCiuu = idCiuu,
                telefono = telefono,
                idDepartamento = idDepartamento,
                idProvincia = idProvincia,
                idDistrito = idDistrito,
                columna = columna,
                orden = orden
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "Mantenimiento Planta Empresa", 9);
                    cabecerasReporteExcel(ws, new List<string> { "N°", "DIRECCIÓN", "CIUU", "TELÉFONO", "UBICACIÓN", "DEPARTAMENTO", "PROVINCIA", "DISTRITO", "ESTADO" });
                    cuerpoReporteExcel(ws, obtenerDatos(lista), 4);
                    exportar(package, "MANTENIMIENTO_PLANTA_EMPRESA_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        [Route("grabarPlanta")]
        [HttpPost]
        public JsonResult grabarPlantaEmpresa(PlantaEmpresaBE planta)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            planta.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarPlantaEmpresa(planta);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminar(int idPlantaEmpresa)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            bool seElimino = logica.eliminar(new PlantaEmpresaBE { idPlantaEmpresa = idPlantaEmpresa });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerPlantaEmpresa(int idPlantaEmpresa)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            PlantaEmpresaBE empresa = logica.obtenerPlantaEmpresa(new PlantaEmpresaBE { idPlantaEmpresa = idPlantaEmpresa });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult obtenerListaPlantaEmpresa()
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            List<PlantaEmpresaBE> lista = logica.obtenerListaPlantaEmpresa();
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", lista == null ? false : lista.Count == 0 ? false : true);
            response.Add("object", lista);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        private List<List<string>> obtenerDatos(List<PlantaEmpresaBE> lista)
        {
            int i = 0;
            List<List<string>> listas = new List<List<string>>();
            lista.ForEach(c =>
            {
                listas.Add(new List<string> {
                    (i + 1).ToString(),
                    c.direccion,
                    c.ciuu.ciuu,
                    c.telefono,
                    String.Concat(c.latitud, ", ",c.longitud),
                    c.departamento.departamento,
                    c.provincia.provincia,
                    c.distrito.distrito,
                    c.idEstado == "1" ? "Habilitado" : "Deshabilitado"});
                i++;
            });
            return listas;
        }

        [HttpPost]
        public JsonResult verificarDatosPlanta(PlantaEmpresaBE plantaEmpresa)
        {
            PlantaEmpresaLN logica = new PlantaEmpresaLN();
            PlantaEmpresaBE planta = logica.verificarDatosPlanta(plantaEmpresa);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", planta == null ? false : plantaEmpresa.idPlantaEmpresa == planta.idPlantaEmpresa ? false : true);
            response.Add("object", planta);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}