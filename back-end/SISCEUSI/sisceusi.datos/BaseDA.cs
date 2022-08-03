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
                    Rol = $"{esquema}.PKG_SISCEUSI_ROL.",
                    Departamento = $"{esquema}.PKG_SISCEUSI_DEPARTAMENTO.",
                    Provincia = $"{esquema}.PKG_SISCEUSI_PROVINCIA.",
                    Distrito = $"{esquema}.PKG_SISCEUSI_DISTRITO.",
                    Giro = $"{esquema}.PKG_SISCEUSI_GIRO.",
                    GrupoEmpresa = $"{esquema}.PKG_SISCEUSI_GRUPO_EMPRESA.",
                    Ciuu = $"{esquema}.PKG_SISCEUSI_CIUU.",
                    Externo = $"{esquema}.PKG_SISCEUSI_EXTERNO.",
                    Login = $"{esquema}.PKG_SISCEUSI_LOGIN.",
                    Mantenimiento = $"{esquema}.PKG_SISCEUSI_MANTENIMIENTO.",                    
                    Usuario = $"{esquema}.PKG_SISCEUSI_USUARIO.",
                    EmpresaIndustria = $"{esquema}.PKG_SISCEUSI_EMPRESA_IND.",
                    PlantaEmpresa = $"{esquema}.PKG_SISCEUSI_PLANTA_EMPRESA.",
                    Campana = $"{esquema}.PKG_SISCEUSI_CAMPANA.",
                };
            }
        }
    }
}
