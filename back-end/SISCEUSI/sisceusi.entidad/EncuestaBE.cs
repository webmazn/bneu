using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class EncuestaBE : BaseBE
    {
        public List<RespuestaEncuestaPlantaBE> listaRespuestaEncuestaPlanta { get; set; }
        public List<RespuestaEncuestaTablaBE> listaRespuestaEncuestaTabla { get; set; }
    }
}
