using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class EncabezadoSecundarioBE : BaseBE
    {
        public int idEncabezadoSecundario { get; set; }
        public int idEncabezadoPrincipal { get; set; }
        public string tituloEncabezado { get; set; }
        public string abreviacion { get; set; }
        public string usarAbreviado { get; set; }
        public int posicion { get; set; }
        public int idOrientacion { get; set; }
        public string descripcionIconoAyuda { get; set; }
        public int idTipoControl { get; set; }
        public int idTipoDato { get; set; }
        public int idParametro { get; set; }
        public int cantidadFilas { get; set; }
        public string agregarFilas { get; set; }
        public string idEstado { get; set; }

        public EncabezadoPrincipalBE encabezadoPrincipal { get; set; }
        public TipoDatoBE tipoDato { get; set; }
        public ParametroBE parametro { get; set; }
        public List<ParametroBE> listaParametro { get; set; }
    }
}
