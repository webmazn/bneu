using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    [LoginRequiredAttribute]
    public class CampanaController : Controller
    {
        // GET: Campana
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NuevaCampana(int? id)
        {
            ViewData["idCampana"] = id;
            return View();
        }
    }
}