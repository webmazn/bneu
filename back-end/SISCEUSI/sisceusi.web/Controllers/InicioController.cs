using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class InicioController : Controller
    {
        UsuarioLN logica = new UsuarioLN();
        // GET: Inicio
        public ActionResult Index()
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            List<BannerBE> banners = logica.mostrarListaBannerAll();
            List<PublicacionBE> publicaciones = logica.mostrarListaPublicacionAll();
            List<EnlaceBE> enlaces = logica.mostrarListaEnlaceAll();
            LogoRedSocialBE logo = logica.obtenerLogoRedSocial(new LogoRedSocialBE());
            ViewData["listaBanner"] = banners;
            ViewData["listaPublicacion"] = publicaciones;
            ViewData["listaEnlace"] = enlaces;
            ViewData["logo"] = logo;
            return View();
        }

        public ActionResult contacto()
        {
            return View();
        }

    }
}