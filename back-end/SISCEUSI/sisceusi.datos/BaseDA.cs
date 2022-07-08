using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.Datos
{
    public class BaseDA
    {
        string esquema { get { return ConfigurationManager.AppSettings["cnBD"]; } }

        protected dynamic Package
        {
            get
            {
                return new
                {
                    Login = $"{esquema}.PKG_SISCEUSI_LOGIN.",
                    Mantenimiento = $"{esquema}.PKG_SISCEUSI_MANTENIMIENTO."
                };
            }
        }
    }
}
