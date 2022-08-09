using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
using System;
using System.Collections.Generic;
using System.Linq;
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

        public ActionResult MaestroMantenimiento()
        {
            return View();
        }
    }
}