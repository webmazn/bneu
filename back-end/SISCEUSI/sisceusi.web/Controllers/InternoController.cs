using OfficeOpenXml;
using OfficeOpenXml.Style;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
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
            //Lista Revisor
            UsuarioLN logicaRevisor = new UsuarioLN();
            List<UsuarioBE> listaRevisor = logicaRevisor.obtenerListaRolEspecifico(new UsuarioBE { idRol = 2 });
            //Parametro
            ParametroLN logicaParametro = new ParametroLN();
            //Lista Parametro - SubSector
            List<ParametroBE> listaSubSector = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 1 }); //id Parametro = SubSector
            //Lista Parametro - Ciuu
            List<ParametroBE> listaCiuu = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 10 }); //id Parametro = Ciuu
            //Lista Parametro - Zona
            List<ParametroBE> listaZona = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 25 }); //id Parametro = Zona

            ViewData["listaDepartamento"] = listaDepartamento;
            ViewData["listaProvincia"] = listaProvincia;
            ViewData["listaDistrito"] = listaDistrito;
            ViewData["listaSubSector"] = listaSubSector;
            ViewData["listaZona"] = listaZona;
            ViewData["listaCiuu"] = listaCiuu;
            ViewData["listaRevisor"] = listaRevisor;
            ViewData["usuario"] = ObtenerUsuarioLogin();
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

        public ActionResult CambiarClave()
        {
            return View();
        }

        public ActionResult MaestroMantenimiento()
        {
            return View();
        }

        public async Task<ActionResult> actualizarClave(UsuarioBE usuario)
        {
            Dictionary<string, object> response = new Dictionary<string, object> {["success"] = false,["message"] = "" };
            try
            {
                if (string.IsNullOrEmpty(usuario.token))
                {
                    response["success"] = false;
                    response["message"] = "Por favor, debe verificar el captcha";
                    return Json(response);
                }

                var isCaptchaValid = await IsCaptchaValid(usuario.token);
                if (isCaptchaValid)
                {
                    UsuarioLN logica = new UsuarioLN();
                    usuario.idUsuario = ObtenerUsuarioLogin().idUsuario;
                    bool seActualizo = logica.verificarPaswwor(usuario);
                    response["success"] = seActualizo;
                    response["message"] = seActualizo ? "Se actualizó su contraseña exitosamente. Lo estamos redirigiendo" : "Ocurrió un problema al actualizar la contraseña";
                    return Json(response);
                }
                else
                {
                    response["success"] = false;
                    response["message"] = "Ocurrió un problema en la validación del captcha";
                }
            }
            catch (Exception ex) { Log.Error(ex); }
            return Json(response);
        }

        public ActionResult EncuestaFicha(int id)
        {
            ControlEncuestaLN logica = new ControlEncuestaLN();
            ControlEncuestaBE controlEncuesta = logica.obtenerControlEncuesta(new ControlEncuestaBE { idControlEncuesta = id });
            List<CampanaEncuestaBE> listCampanaEncuesta = logica.obtenerListaCampanaEncuesta(new ControlEncuestaBE { idControlEncuesta = id });

            EncuestaLN logicaEncuesta = new EncuestaLN();
            listCampanaEncuesta.ForEach(x =>
            {
                x.listaRespuesta = logica.obtenerListaRespuestaEncuesta(x);
                x.listaRespuestaEncuestaPlanta = logicaEncuesta.obtenerListaRespuestaPlanta(id, x.idCampanaEncuesta);
                if (x.idParametroTabla > 0)
                {
                    x.listaEncabezadoSecundario = logica.obtenerTablaMaestraEncabezados(new CampanaEncuestaBE { idControlEncuesta = id, idParametroTabla = x.idParametroTabla });
                }
            });
            ViewData["controlEncuesta"] = controlEncuesta;
            ViewData["listCampanaEncuesta"] = listCampanaEncuesta;
            return View();
        }

        [HttpGet]
        public JsonResult obtenerPreguntasEncuesta(int id)
        {            
            ControlEncuestaLN logica = new ControlEncuestaLN();
            List<CampanaEncuestaBE> listCampanaEncuesta = logica.obtenerListaCampanaEncuesta(new ControlEncuestaBE { idControlEncuesta = id });

            EncuestaLN logicaEncuesta = new EncuestaLN();
            listCampanaEncuesta.ForEach(x =>
            {
                x.listaRespuesta = logica.obtenerListaRespuestaEncuesta(x);
                x.listaRespuestaEncuestaPlanta = logicaEncuesta.obtenerListaRespuestaPlanta(id, x.idCampanaEncuesta);
                if (x.idParametroTabla > 0)
                {
                    x.listaEncabezadoSecundario = logica.obtenerTablaMaestraEncabezados(new CampanaEncuestaBE { idControlEncuesta = id, idParametroTabla = x.idParametroTabla });
                }
            });

            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", true);
            response.Add("object", listCampanaEncuesta);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        public ActionResult ReporteGeneral()
        {
            CampanaLN logicaCampana = new CampanaLN();
            List<CampanaBE> listaCampana = logicaCampana.obtenerListaCampana();

            ViewData["listaCampana"] = listaCampana;
            return View();
        }

        public JsonResult DatosCampana(int idCampana)
        {
            ReporteLN logicaReporte = new ReporteLN();
            List<ReporteBE> listaReporte = logicaReporte.obtenerListaCampanaPlantaReporte(new CampanaBE { idCampana = idCampana });
            List<CampanaTablaMaestraBE> listaCampanaTablaMaestra = logicaReporte.obtenerListaCampanaTablaMaestra(new CampanaBE { idCampana = idCampana });

            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", true);
            response.Add("listaReporte", listaReporte);
            response.Add("listaCampanaTablaMaestra", listaCampanaTablaMaestra);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public void exportarGeneral(int idCampana, int idTablaMaestra)
        {
            Dictionary<int, string> letras = obtenerDictionaryLetra();
            ReporteLN logicaReporte = new ReporteLN();
            List<ReporteBE> listaReporte = logicaReporte.obtenerListaCampanaPlantaReporte(new CampanaBE { idCampana = idCampana });
            List<CampanaEncuestaBE> listaCampanaEncuesta = logicaReporte.obtenerListaCampanaEncuesta(new CampanaBE { idCampana = idCampana });

            int mayorFila = -1;
            ControlEncuestaLN logica = new ControlEncuestaLN();
            listaCampanaEncuesta.ForEach(x =>
            {
                x.listaRespuesta = logica.obtenerListaRespuestaEncuesta(x);
                x.listaRespuestaEncuestaPlanta = logicaReporte.obtenerListaRespuestaPlanta(x.idCampanaEncuesta);
                if (x.idParametroTabla > 0)
                {
                    TablaMaestraLN logicaTabla = new TablaMaestraLN();
                    TablaMaestraBE tabla = logicaTabla.obtenerTablaMaestra(new TablaMaestraBE { idTablaMaestra = x.idParametroTabla });
                    if (tabla != null) if (tabla.cantidadFilas > mayorFila) mayorFila = tabla.cantidadFilas;

                    x.listaEncabezadoSecundario = logicaReporte.obtenerTablaMaestraEncabezados(new CampanaEncuestaBE { idCampana = idCampana, idParametroTabla = x.idParametroTabla });
                }
            });

            List<CabeceraPrincipalReporteBE> listaCabeceraPrincipal = armarCabeceraPrincipalGeneral();
            List<CabeceraSecundariaReporteBE> listaCabeceraSecundaria = armarCabeceraSecundarioGeneral();
            listaCampanaEncuesta.ForEach(x =>
            {
                if (x.idParametroTabla > 0)
                {
                    x.listaEncabezadoSecundario.ForEach(y =>
                    {
                        int cantidadCeldas = 1;
                        if (y.idParametro > 0)
                            if (y.idTipoControl == 7)
                                cantidadCeldas = y.listaParametro.Count() * 2;

                        int index = listaCabeceraPrincipal.FindIndex(z => z.idEncabezadoPrincipal == y.encabezadoPrincipal.idEncabezadoPrincipal);
                        if (index == -1)
                            listaCabeceraPrincipal.Add(new CabeceraPrincipalReporteBE
                            {
                                idEncabezadoPrincipal = y.encabezadoPrincipal.idEncabezadoPrincipal,
                                descripcion = y.encabezadoPrincipal.tituloEncabezado,
                                cantidadCeldas = cantidadCeldas
                            });
                        else
                            listaCabeceraPrincipal[index].cantidadCeldas = listaCabeceraPrincipal[index].cantidadCeldas + cantidadCeldas;

                        listaCabeceraSecundaria.Add(new CabeceraSecundariaReporteBE
                        {
                            idEncabezadoSecundaria = y.idEncabezadoSecundario,
                            descripcion = y.tituloEncabezado,
                            cantidadCeldas = cantidadCeldas
                        });
                    });
                }
            });

            int columnaCuerpo = 36;
            List<CuerpoReporteBE> listaCuerpo = armarCuerpoGeneral(listaReporte, mayorFila);
            listaCampanaEncuesta.ForEach(x =>
            {
                if (x.idParametroTabla > 0)
                {
                    int contadorCabecera = 0;
                    int cantidadCabecera = x.listaEncabezadoSecundario.Count();
                    x.listaEncabezadoSecundario.ForEach(y =>
                    {
                        contadorCabecera++;
                        columnaCuerpo++;
                        int filaCuerpo = 4;
                        listaReporte.ForEach(z =>
                        {                            
                            List<RespuestaEncuestaTablaBE> lista = y.listaRespuestaEncuestaTabla.FindAll(m => m.idControlEncuesta == z.idControlEncuesta);
                            for (int i = 0; i < mayorFila; i++)
                            {
                                filaCuerpo++;
                                List<RespuestaEncuestaTablaBE> listaResp = lista.FindAll(n => n.filaTabla == i);
                                if (listaResp != null && listaResp.Count > 0)
                                {
                                    int columnaTemp = columnaCuerpo;
                                    listaResp.ForEach(a =>
                                    {
                                        if (y.idParametro > 0)
                                        {
                                            if (y.idTipoControl == 7)
                                            {
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = a.respuesta == "1" ? "X" : "",
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = false
                                                });

                                                columnaTemp++;
                                                ParametroBE p = y.listaParametro.Find(b => b.idParametro == a.idParametro);                           
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = p == null ? "" : p.parametro,
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = contadorCabecera == cantidadCabecera
                                                });
                                            } 
                                            else if (y.idTipoControl == 6)
                                            {
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = a.respuesta == "1" ? "X" : "",
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = contadorCabecera == cantidadCabecera
                                                });
                                            }
                                            else if (y.idTipoControl == 5)
                                            {
                                                ParametroBE p = y.listaParametro.Find(b => b.idParametro == (a.respuesta == null || a.respuesta == "" ? 0 : int.Parse(a.respuesta)));
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = p == null ? "" : p.parametro,
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = contadorCabecera == cantidadCabecera
                                                });
                                            }
                                            else
                                            {
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = a.respuesta,
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = contadorCabecera == cantidadCabecera
                                                });
                                            }
                                        }
                                        else
                                        {
                                            if (y.idTipoControl == 6)
                                            {
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = a.respuesta == "1" ? "X" : "",
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = contadorCabecera == cantidadCabecera
                                                });
                                            }
                                            else
                                            {
                                                listaCuerpo.Add(new CuerpoReporteBE
                                                {
                                                    descripcion = a.respuesta,
                                                    celda = String.Concat(letras[columnaTemp], filaCuerpo.ToString()),
                                                    filaSeparador = i == (mayorFila - 1),
                                                    columnaSeparador = contadorCabecera == cantidadCabecera
                                                });
                                            }
                                        }
                                        columnaTemp++;
                                    });                                    
                                }
                                else
                                {
                                    listaCuerpo.Add(new CuerpoReporteBE
                                    {
                                        descripcion = "",
                                        celda = String.Concat(letras[columnaCuerpo], filaCuerpo.ToString()),
                                        filaSeparador = i == (mayorFila - 1),
                                        columnaSeparador = contadorCabecera == cantidadCabecera
                                    });
                                }
                            }
                        });
                        CabeceraSecundariaReporteBE cab = listaCabeceraSecundaria.Find(c => c.idEncabezadoSecundaria == y.idEncabezadoSecundario);
                        columnaCuerpo += (cab == null ? 0 : cab.cantidadCeldas - 1);
                    });
                }
            });

            try
            {
                using (ExcelPackage package = new ExcelPackage())
                {
                    ExcelWorksheet ws = tituloReporteExcel(package, "REPORTE GENERAL", 8, 5);                    
                    int letra = 0;
                    listaCabeceraPrincipal.ForEach(x =>
                    {
                        letra++;
                        string celdaInicial = String.Concat(letras[letra], "3");
                        letra = letra + x.cantidadCeldas - 1;
                        string celdaFinal = String.Concat(letras[letra], "3");
                        cabecerasReporte(ws, x.descripcion, celdaInicial, celdaFinal);
                    });
                    letra = 0;
                    listaCabeceraSecundaria.ForEach(x =>
                    {
                        letra++;
                        string celdaInicial = String.Concat(letras[letra], "4");
                        letra = letra + x.cantidadCeldas - 1;
                        string celdaFinal = String.Concat(letras[letra], "4");
                        cabecerasReporte(ws, x.descripcion, celdaInicial, celdaFinal);
                    });
                    cuerpoReporte(ws, listaCuerpo);

                    exportar(package, "REPORTE_");
                }
            }
            catch (Exception ex) { Log.Error(ex); }
        }

        private List<CabeceraPrincipalReporteBE> armarCabeceraPrincipalGeneral()
        {
            List<CabeceraPrincipalReporteBE> lista = new List<CabeceraPrincipalReporteBE>();
            lista.Add(new CabeceraPrincipalReporteBE { descripcion = "CAMPAÑA", cantidadCeldas = 5 });
            lista.Add(new CabeceraPrincipalReporteBE { descripcion = "EMPRESA", cantidadCeldas = 10 });
            lista.Add(new CabeceraPrincipalReporteBE { descripcion = "PLANTA", cantidadCeldas = 13 });
            lista.Add(new CabeceraPrincipalReporteBE { descripcion = "USUARIO RESPONDE", cantidadCeldas = 4 });
            lista.Add(new CabeceraPrincipalReporteBE { descripcion = "REVISOR", cantidadCeldas = 4 });
            return lista;
        }

        private List<CabeceraSecundariaReporteBE> armarCabeceraSecundarioGeneral()
        {
            List<CabeceraSecundariaReporteBE> lista = new List<CabeceraSecundariaReporteBE>();
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "CÓDIGO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DENOMINACIÓN", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "SUB SECTOR", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "FECHA INICIO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "FECHA FIN", cantidadCeldas = 1 });

            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "RAZON SOCIAL", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "NOMBRE COMERCIAL", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "RUC", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "GIRO DEL NEGOCIO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "GRUPO EMPRESARIAL", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "CIUU", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "CORREO EMPRESARIAL", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DIRECCION FISCAL", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "REPRESENTANTE LEGAL", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DNI", cantidadCeldas = 1 });

            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DENOMINACIÓN", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "GIRO DEL NEGOCIO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "CIUU", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DEPARTAMENTO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "PROVINCIA", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DISTRITO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "ZONA", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DIRECCIÓN", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "TELÉFONO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "EMPRESA GAS", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "NRO.SUMINISTRO GAS", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "EMPRESA DE LUZ", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "NRO SUMINISTRO LUZ", cantidadCeldas = 1 });

            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "NOMBRES", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DNI", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "CORREO ELECTRÓNICO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "TELÉFONO", cantidadCeldas = 1 });

            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "NOMBRES", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "DNI", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "CORREO ELECTRÓNICO", cantidadCeldas = 1 });
            lista.Add(new CabeceraSecundariaReporteBE { descripcion = "TELÉFONO", cantidadCeldas = 1 });

            return lista;
        }

        private List<CuerpoReporteBE> armarCuerpoGeneral(List<ReporteBE> listaReporte, int mayorFila)
        {
            List<CuerpoReporteBE> listaCuerpo = new List<CuerpoReporteBE>();
            int fila = 4;
            listaReporte.ForEach(x =>
            {
                for (int i = 0; i < mayorFila; i++)
                {
                    fila++;
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = String.Concat("ENC", x.idCampana.ToString("D4")), celda = String.Concat("A", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.campana, celda = String.Concat("B", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.subsector, celda = String.Concat("C", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.txtFechaInicioEncuesta, celda = String.Concat("D", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.txtFechaFinEncuesta, celda = String.Concat("E", fila.ToString()), filaSeparador = i == (mayorFila - 1), columnaSeparador = true });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.nombreEmpresa, celda = String.Concat("F", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.nombreComercial, celda = String.Concat("G", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.ruc, celda = String.Concat("H", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.giroEmpresa, celda = String.Concat("I", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.grupoEmpresa, celda = String.Concat("J", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.ciuuEmpresa, celda = String.Concat("K", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.correoEmpresarial, celda = String.Concat("L", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.direccionFiscal, celda = String.Concat("M", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.representanteLegal, celda = String.Concat("N", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.dniRepresentante, celda = String.Concat("O", fila.ToString()), filaSeparador = i == (mayorFila - 1), columnaSeparador = true });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.planta, celda = String.Concat("P", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.giroPlanta, celda = String.Concat("Q", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.ciuuPlanta, celda = String.Concat("R", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.departamento, celda = String.Concat("S", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.provincia, celda = String.Concat("T", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.distrito, celda = String.Concat("U", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.zona, celda = String.Concat("V", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.direccion, celda = String.Concat("W", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.telefonoPlanta, celda = String.Concat("X", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.empresaGas, celda = String.Concat("Y", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.numeroSuministroGas, celda = String.Concat("Z", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.empresaLuz, celda = String.Concat("AA", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.numeroSuministroAlumbrado, celda = String.Concat("AB", fila.ToString()), filaSeparador = i == (mayorFila - 1), columnaSeparador = true });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.encuestado, celda = String.Concat("AC", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.dniEncuestado, celda = String.Concat("AD", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.correoEncuestado, celda = String.Concat("AE", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.telefonoEncuestado, celda = String.Concat("AF", fila.ToString()), filaSeparador = i == (mayorFila - 1), columnaSeparador = true });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.revisor, celda = String.Concat("AG", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.dniRevisor, celda = String.Concat("AH", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.correoRevisor, celda = String.Concat("AI", fila.ToString()), filaSeparador = i == (mayorFila - 1) });
                    listaCuerpo.Add(new CuerpoReporteBE { descripcion = x.telefonoRevisor, celda = String.Concat("AJ", fila.ToString()), filaSeparador = i == (mayorFila - 1), columnaSeparador = true });
                }
                
            });            

            return listaCuerpo;
        }

        private void cabecerasReporte(ExcelWorksheet ws, string value, string celdaInico, string celdaFin)
        {
            using (ExcelRange m = ws.Cells[String.Concat(celdaInico, ":", celdaFin)]) //Cells[Fila1, Column1, Fila2, Column2]
            {
                m.Style.Font.Bold = true;
                m.Style.WrapText = false;
                m.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                m.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                m.Style.Fill.PatternType = ExcelFillStyle.Solid;
                m.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(16, 39, 189));
                m.Style.Font.Color.SetColor(Color.FromArgb(255, 255, 255));
                m.Style.Font.Size = 12;
                m.Style.Border.Top.Style = ExcelBorderStyle.Thick;
                m.Style.Border.Left.Style = ExcelBorderStyle.Thick;
                m.Style.Border.Right.Style = ExcelBorderStyle.Thick;
                m.Style.Border.Bottom.Style = ExcelBorderStyle.Thick;
                m.AutoFitColumns(30, 40);
                m.Merge = true;
                m.Value = value;
            }
            ws.Row(3).Height = 23;
            ws.Row(4).Height = 23;
        }

        private void cuerpoReporte(ExcelWorksheet ws, List<CuerpoReporteBE> listaCuerpo)
        {
            listaCuerpo.ForEach(x =>
            {
                using (ExcelRange m = ws.Cells[x.celda]) //Cells[Fila1, Column1, Fila2, Column2]
                {
                    m.Style.Font.Bold = true;
                    m.Style.WrapText = false;
                    m.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    m.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    m.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    m.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(255, 255, 255));
                    m.Style.Font.Color.SetColor(Color.FromArgb(0, 0, 0));
                    m.Style.Font.Size = 10;
                    m.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    m.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    m.Style.Border.Right.Style = x.columnaSeparador ? ExcelBorderStyle.Thick : ExcelBorderStyle.Thin;
                    m.Style.Border.Bottom.Style = x.filaSeparador ? ExcelBorderStyle.Thick : ExcelBorderStyle.Thin;
                    m.AutoFitColumns(30, 40);
                    m.Value = x.descripcion;
                }
                //ws.Row(3).Height = 20;
            });            
        }

    }
}