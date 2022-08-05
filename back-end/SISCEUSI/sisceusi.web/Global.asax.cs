using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace sisceusi.web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            ValueProviderFactory jsonFactory = null;
            foreach (var factory in ValueProviderFactories.Factories)
            {
                if (factory.GetType().FullName == "System.Web.Mvc.JsonValueProviderFactory")
                {
                    jsonFactory = factory;
                    break;
                }
            }

            if (jsonFactory != null)
            {
                ValueProviderFactories.Factories.Remove(jsonFactory);
            }

            var largeJsonValueProviderFactory = new LargeJsonValueProviderFactory();
            ValueProviderFactories.Factories.Add(largeJsonValueProviderFactory);
        }
    }
}
