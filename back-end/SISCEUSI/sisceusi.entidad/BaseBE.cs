using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.entidad
{
    public class BaseBE
    {
        //Auditoria
        public int idUsuarioCreacion { get; set; }
        public int idUsuarioModificacion { get; set; }
        public DateTime fechaCreacion { get; set; }
        public string ipCreacion { get; set; }
        //Seguridad
        public string token { get; set; }
        //Busqueda
        public string buscar { get; set; }
        public DateTime? fechaInicio { get; set; }
        public DateTime? fechaFin { get; set; }
        //Paginacion
        public int registros { get; set; }
        public int totalRegistros { get; set; }
        public int pagina { get; set; }
        public int totalPaginas { get; set; }
        //Ordenamiento
        public int fila { get; set; }
        public string columna { get; set; }
        public string orden { get; set; }
        //Validacion Contraseña
        public bool editarPassword { get; set; }
        //Fecha String
        public string txtFechaCreacion
        {
            get
            {
                return fechaCreacion.ToString("dd/MM/yyyy");
            }
        }

        public UsuarioBE usuarioRegistro { get; set; }
    }
}
