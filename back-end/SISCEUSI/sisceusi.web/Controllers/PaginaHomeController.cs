﻿using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class PaginaHomeController : Controller
    {
        // GET: PaginaHome
        public ActionResult Index()
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            List<BannerBE> banners = logica.mostrarListaBanner(new BannerBE
            {
                registros = 10,
                pagina = 1
            });
            Dictionary<string, object> listaBanner = new Dictionary<string, object>();
            listaBanner.Add("success", banners == null ? false : banners.Count == 0 ? false : true);
            listaBanner.Add("object", banners);

            List<PublicacionBE> publicaciones = logica.mostrarListaPublicacion(new PublicacionBE
            {
                registros = 10,
                pagina = 1
            });
            Dictionary<string, object> listaPublicacion = new Dictionary<string, object>();
            listaPublicacion.Add("success", publicaciones == null ? false : publicaciones.Count == 0 ? false : true);
            listaPublicacion.Add("object", publicaciones);

            ViewData["listaBanner"] = listaBanner;
            ViewData["listaPublicacion"] = listaPublicacion;
            return View();
        }

        [HttpPost]
        public JsonResult grabarBanner(BannerBE banner)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            banner.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarBanner(banner);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult mostrarListaBanner(int registros, int pagina)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            List<BannerBE> lista = logica.mostrarListaBanner(new BannerBE
            {
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
        public JsonResult obtenerBanner(int idBanner)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            BannerBE empresa = logica.obtenerBanner(new BannerBE { idBanner = idBanner });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", empresa == null ? false : true);
            response.Add("object", empresa);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminarBanner(int idBanner)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            bool seElimino = logica.eliminarBanner(new BannerBE { idBanner = idBanner });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpPost]
        public JsonResult grabarPublicacion(PublicacionBE entidad)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            entidad.ipCreacion = Request.UserHostAddress.ToString().Trim();
            bool seGrabo = logica.grabarPublicacion(entidad);
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seGrabo);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult mostrarListaPublicacion(int registros, int pagina)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            List<PublicacionBE> lista = logica.mostrarListaPublicacion(new PublicacionBE
            {
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
        public JsonResult obtenerPublicacion(int idPublicacion)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            PublicacionBE entidad = logica.obtenerPublicacion(new PublicacionBE { idPublicacion = idPublicacion });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", entidad == null ? false : true);
            response.Add("object", entidad);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [HttpGet]
        public JsonResult eliminarPublicacion(int idPublicacion)
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            bool seElimino = logica.eliminarPublicacion(new PublicacionBE { idPublicacion = idPublicacion });
            Dictionary<string, object> response = new Dictionary<string, object>();
            response.Add("success", seElimino);
            var jsonResult = Json(response, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }
    }
}