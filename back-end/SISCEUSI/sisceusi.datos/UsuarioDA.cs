using Oracle.DataAccess.Client;
using Dapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using sisceusi.Datos;
using sisceusi.entidad;
using System.Data;
using sres.ut;

namespace sisceusi.datos
{
    public class UsuarioDA : BaseDA
    {
        public List<UsuarioBE> filtroGeneral(UsuarioBE usuario, OracleConnection db)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", usuario.buscar);
                p.Add("piRegistros", usuario.registros);
                p.Add("piPagina", usuario.pagina);
                p.Add("piColumna", usuario.columna);
                p.Add("piOrden", usuario.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new UsuarioBE
                {
                    idUsuario = (int)x.IDUSUARIO,
                    nombres = (string)x.NOMBRES,
                    correoElectronico = (string)x.CORREOELECTRONICO,
                    rol = new RolBE { rol = (string)x.ROL },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA,
                    totalPaginas = (int)x.TOTALPAGINAS,
                    pagina = (int)x.PAGINA,
                    registros = (int)x.REGISTROS,
                    totalRegistros = (int)x.TOTALREGISTROS
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<UsuarioBE> filtroAvanzado(UsuarioBE usuario, OracleConnection db)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_BUSQUEDA_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piRuc", usuario.empresaIndustria.ruc);
                p.Add("piNombreEmpresa", usuario.empresaIndustria.nombreEmpresa);
                p.Add("piIdRol", usuario.idRol);
                p.Add("piFechaInicio", usuario.fechaInicio);
                p.Add("piFechaFin", usuario.fechaFin);
                p.Add("piNombres", usuario.nombres);
                p.Add("piIdEstado", usuario.idEstado);
                p.Add("piRegistros", usuario.registros);
                p.Add("piPagina", usuario.pagina);
                p.Add("piColumna", usuario.columna);
                p.Add("piOrden", usuario.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new UsuarioBE
                {
                    idUsuario = (int)x.IDUSUARIO,
                    nombres = (string)x.NOMBRES,
                    correoElectronico = (string)x.CORREOELECTRONICO,
                    rol = new RolBE { rol = (string)x.ROL },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA,
                    totalPaginas = (int)x.TOTALPAGINAS,
                    pagina = (int)x.PAGINA,
                    registros = (int)x.REGISTROS,
                    totalRegistros = (int)x.TOTALREGISTROS
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarUsuario(UsuarioBE usuario, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Usuario}USP_PRC_GUARDAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdUsuario", usuario.idUsuario);
                p.Add("piIdEmpresaIndustria", usuario.idEmpresaIndustria);
                p.Add("piIdRol", usuario.idRol);
                p.Add("piDni", usuario.dni);
                p.Add("piTelefono", usuario.telefono);
                p.Add("piNombres", usuario.nombres);
                p.Add("piCorreo", usuario.correoElectronico);
                p.Add("piPassword", usuario.password);
                p.Add("piIdEstado", usuario.idEstado);
                p.Add("piIdUsuarioCreacion", usuario.idUsuarioCreacion);
                p.Add("piIpCreacion", usuario.ipCreacion);
                p.Add("piEditarPassword", usuario.editarPassword);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public UsuarioBE obtenerUsuario(UsuarioBE usuario, OracleConnection db)
        {
            UsuarioBE item = null;
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdUsuario", usuario.idUsuario);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<UsuarioBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public UsuarioBE obtenerUsuarioPorCorreo(UsuarioBE usuario, OracleConnection db)
        {
            UsuarioBE item = null;
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_POR_CORREO";
                var p = new OracleDynamicParameters();
                p.Add("piIdUsuario", usuario.idUsuario);
                p.Add("piCorreo", usuario.correoElectronico);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<UsuarioBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public UsuarioBE obtenerUsuarioPorDni(UsuarioBE usuario, OracleConnection db)
        {
            UsuarioBE item = null;
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_POR_DNI";
                var p = new OracleDynamicParameters();
                p.Add("piIdUsuario", usuario.idUsuario);
                p.Add("piDni", usuario.dni);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<UsuarioBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public List<UsuarioBE> exportarGeneral(UsuarioBE usuario, OracleConnection db)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_EXPORTAR_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piBuscar", usuario.buscar);
                p.Add("piColumna", usuario.columna);
                p.Add("piOrden", usuario.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new UsuarioBE
                {
                    idUsuario = (int)x.IDUSUARIO,
                    nombres = (string)x.NOMBRES,
                    correoElectronico = (string)x.CORREOELECTRONICO,
                    rol = new RolBE { rol = (string)x.ROL },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<UsuarioBE> exportarAvanzado(UsuarioBE usuario, OracleConnection db)
        {
            List<UsuarioBE> lista = new List<UsuarioBE>();
            try
            {
                string sp = $"{Package.Usuario}USP_SEL_EXPORTAR_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piRuc", usuario.empresaIndustria.ruc);
                p.Add("piNombreEmpresa", usuario.empresaIndustria.nombreEmpresa);
                p.Add("piIdRol", usuario.idRol);
                p.Add("piFechaInicio", usuario.fechaInicio);
                p.Add("piFechaFin", usuario.fechaFin);
                p.Add("piNombres", usuario.nombres);
                p.Add("piIdEstado", usuario.idEstado);
                p.Add("piColumna", usuario.columna);
                p.Add("piOrden", usuario.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new UsuarioBE
                {
                    idUsuario = (int)x.IDUSUARIO,
                    nombres = (string)x.NOMBRES,
                    correoElectronico = (string)x.CORREOELECTRONICO,
                    rol = new RolBE { rol = (string)x.ROL },
                    fechaCreacion = (DateTime)x.FECHACREACION,
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }
    }
}
