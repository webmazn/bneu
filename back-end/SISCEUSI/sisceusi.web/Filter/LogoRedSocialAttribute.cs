using sisceusi.entidad;
using sisceusi.logica;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Filter
{
    public class LogoRedSocialAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                base.OnActionExecuting(filterContext);
                PaginaHomeLN logica = new PaginaHomeLN();
                LogoRedSocialBE logoRedSocial = logica.obtenerLogoRedSocial(new LogoRedSocialBE());
                HttpContext.Current.Session["logoRedSocial"] = logoRedSocial;
                ParametroLN logicaParametro = new ParametroLN();
                List<ParametroBE> opcionesSubSector = logicaParametro.obtenerListaParametroHijo(new ParametroBE { idParametro = 1 });
                HttpContext.Current.Session["opcionesSubSector"] = opcionesSubSector;
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }
    }
}