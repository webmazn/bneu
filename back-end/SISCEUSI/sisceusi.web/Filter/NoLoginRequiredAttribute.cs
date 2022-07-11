using sisceusi.entidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace sisceusi.web.Filter
{
    public class NoLoginRequiredAttribute : ActionFilterAttribute
    {
        // No acceder al Login cuando ya se inicio sesion
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                base.OnActionExecuting(filterContext);
                UsuarioBE user = (UsuarioBE)HttpContext.Current.Session["user"];
                if (user != null)
                {
                    filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new
                    {
                        controller = "Interno",
                        action = "Index"
                    }));
                }
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }
    }
}