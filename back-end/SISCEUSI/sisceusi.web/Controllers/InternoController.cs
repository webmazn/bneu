using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    [LoginRequiredAttribute]
    public class InternoController : Controller
    {
        // GET: Interno
        public ActionResult Index()
        {
            return View();
        }
    }
}