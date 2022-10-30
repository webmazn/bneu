using Dapper;
using Oracle.DataAccess.Client;
using sisceusi.Datos;
using sisceusi.entidad;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.datos
{
    public class PlantaEmpresaDA : BaseDA
    {
        public List<PlantaEmpresaBE> filtroGeneral(PlantaEmpresaBE planta, OracleConnection db)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_BUSQUEDA_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresa", planta.idEmpresaIndustria);
                p.Add("piBuscar", planta.buscar);
                p.Add("piRegistros", planta.registros);
                p.Add("piPagina", planta.pagina);
                p.Add("piColumna", planta.columna);
                p.Add("piOrden", planta.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PlantaEmpresaBE
                {
                    idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ciuu = new CiuuBE { ciuu = (string)x.CIUU },
                    departamento = new DepartamentoBE {departamento = (string)x.DEPARTAMENTO } ,
                    provincia = new ProvinciaBE { provincia = (string)x.PROVINCIA },
                    distrito = new DistritoBE { distrito = (string)x.DISTRITO },
                    direccion = (string)x.DIRECCION,
                    telefono = (string)x.TELEFONO,
                    latitud = (string)x.LATITUD,
                    longitud = (string)x.LONGITUD,
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

        public List<PlantaEmpresaBE> filtroAvanzado(PlantaEmpresaBE planta, OracleConnection db)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_BUSQUEDA_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresa", planta.idEmpresaIndustria);
                p.Add("piDireccion", planta.direccion);
                p.Add("piIdCiuu", planta.idCiuu);
                p.Add("piTelefono", planta.telefono);
                p.Add("piIdDepartamento", planta.idDepartamento);
                p.Add("piIdProvincia", planta.idProvincia);
                p.Add("piIdDistrito", planta.idDistrito);
                p.Add("piRegistros", planta.registros);
                p.Add("piPagina", planta.pagina);
                p.Add("piColumna", planta.columna);
                p.Add("piOrden", planta.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PlantaEmpresaBE
                {
                    idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ciuu = new CiuuBE { ciuu = (string)x.CIUU },
                    departamento = new DepartamentoBE { departamento = (string)x.DEPARTAMENTO },
                    provincia = new ProvinciaBE { provincia = (string)x.PROVINCIA },
                    distrito = new DistritoBE { distrito = (string)x.DISTRITO },
                    direccion = (string)x.DIRECCION,
                    telefono = (string)x.TELEFONO,
                    latitud = (string)x.LATITUD,
                    longitud = (string)x.LONGITUD,
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

        public List<PlantaEmpresaBE> exportarGeneral(PlantaEmpresaBE planta, OracleConnection db)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_EXPORTAR_GENERAL";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresa", planta.idEmpresaIndustria);
                p.Add("piBuscar", planta.buscar);
                p.Add("piColumna", planta.columna);
                p.Add("piOrden", planta.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PlantaEmpresaBE
                {
                    idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    denominacion = x.DENOMINACION == null ? "" : (string)x.DENOMINACION,
                    direccion = (string)x.DIRECCION,
                    ciuu = new CiuuBE { ciuu = (string)x.CIUU },
                    telefono = (string)x.TELEFONO,
                    latitud = (string)x.LATITUD,
                    longitud = (string)x.LONGITUD,
                    zona = new ZonaBE { zona = x.ZONA == null ? "" : (string)x.ZONA },
                    departamento = new DepartamentoBE { departamento = (string)x.DEPARTAMENTO },
                    provincia = new ProvinciaBE { provincia = (string)x.PROVINCIA },
                    distrito = new DistritoBE { distrito = (string)x.DISTRITO },
                    empresaGas = new EmpresaGasBE { empresaGas = x.EMPRESAGAS == null ? "" : (string)x.EMPRESAGAS },
                    numeroSuministroGas = x.NUMEROSUMINISTROGAS == null ? "" : (string)x.NUMEROSUMINISTROGAS,
                    empresaLuz = new EmpresaLuzBE { empresaLuz = x.EMPRESALUZ == null ? "" : (string)x.EMPRESALUZ },
                    numeroSuministroAlumbrado = x.NUMEROSUMINISTROALUMBRADO == null ? "" : (string)x.NUMEROSUMINISTROALUMBRADO,
                    giro = new GiroBE { giro = x.GIRO == null ? "" : (string)x.GIRO },
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<PlantaEmpresaBE> exportarAvanzado(PlantaEmpresaBE planta, OracleConnection db)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_EXPORTAR_AVANZADO";
                var p = new OracleDynamicParameters();
                p.Add("piIdEmpresa", planta.idEmpresaIndustria);
                p.Add("piDireccion", planta.direccion);
                p.Add("piIdCiuu", planta.idCiuu);
                p.Add("piTelefono", planta.telefono);
                p.Add("piIdDepartamento", planta.idDepartamento);
                p.Add("piIdProvincia", planta.idProvincia);
                p.Add("piIdDistrito", planta.idDistrito);
                p.Add("piColumna", planta.columna);
                p.Add("piOrden", planta.orden);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PlantaEmpresaBE
                {
                    idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    denominacion = x.DENOMINACION == null ? "" : (string)x.DENOMINACION,
                    direccion = (string)x.DIRECCION,
                    ciuu = new CiuuBE { ciuu = (string)x.CIUU },
                    telefono = (string)x.TELEFONO,
                    latitud = (string)x.LATITUD,
                    longitud = (string)x.LONGITUD,
                    zona = new ZonaBE { zona = x.ZONA == null ? "" : (string)x.ZONA },
                    departamento = new DepartamentoBE { departamento = (string)x.DEPARTAMENTO },
                    provincia = new ProvinciaBE { provincia = (string)x.PROVINCIA },
                    distrito = new DistritoBE { distrito = (string)x.DISTRITO },
                    empresaGas = new EmpresaGasBE { empresaGas = x.EMPRESAGAS == null ? "" : (string)x.EMPRESAGAS },
                    numeroSuministroGas = x.NUMEROSUMINISTROGAS == null ? "" : (string)x.NUMEROSUMINISTROGAS,
                    empresaLuz = new EmpresaLuzBE { empresaLuz = x.EMPRESALUZ == null ? "" : (string)x.EMPRESALUZ },
                    numeroSuministroAlumbrado = x.NUMEROSUMINISTROALUMBRADO == null ? "" : (string)x.NUMEROSUMINISTROALUMBRADO,
                    giro = new GiroBE { giro = x.GIRO == null ? "" : (string)x.GIRO },
                    idEstado = (string)x.IDESTADO,
                    fila = (int)x.FILA
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public bool grabarPlantaEmpresa(PlantaEmpresaBE planta, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_PRC_GUARDAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdPlantaEmpresa", planta.idPlantaEmpresa);
                p.Add("piIdEmpresaIndustria", planta.idEmpresaIndustria);
                p.Add("piIdGiro", planta.idGiro);
                p.Add("piIdCiuu", planta.idCiuu);
                p.Add("piIdDepartamento", planta.idDepartamento);
                p.Add("piIdProvincia", planta.idProvincia);
                p.Add("piIdDistrito", planta.idDistrito);
                p.Add("piIdZona", planta.idZona);
                p.Add("piDenominacion", planta.denominacion);
                p.Add("piDireccion", planta.direccion);
                p.Add("piTelefono", planta.telefono);
                p.Add("piLatitud", planta.latitud);
                p.Add("piLongitud", planta.longitud);
                p.Add("piIdEmpresaGas", planta.idEmpresaGas);
                p.Add("piNumeroSuministroGas", planta.numeroSuministroGas);
                p.Add("piIdEmpresaLuz", planta.idEmpresaLuz);
                p.Add("piNumeroSuministroAlumbrado", planta.numeroSuministroAlumbrado);
                p.Add("piNombreArchivo", planta.nombreArchivo);
                p.Add("piNombreArchivoGenerado", planta.nombreArchivoGenerado);
                p.Add("piIdEstado", planta.idEstado);
                p.Add("piIdUsuarioCreacion", planta.idUsuarioCreacion);
                p.Add("piIpCreacion", planta.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public bool eliminar(PlantaEmpresaBE empresa, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_UPD_DESHABILITAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdPlantaEmpresa", empresa.idPlantaEmpresa);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public PlantaEmpresaBE obtenerPlantaEmpresa(PlantaEmpresaBE empresa, OracleConnection db)
        {
            PlantaEmpresaBE item = null;
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdPlantaEmpresa", empresa.idPlantaEmpresa);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<PlantaEmpresaBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public List<PlantaEmpresaBE> obtenerListaPlantaEmpresa(OracleConnection db)
        {
            List<PlantaEmpresaBE> lista = new List<PlantaEmpresaBE>();
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_LISTA";
                var p = new OracleDynamicParameters();
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new PlantaEmpresaBE
                {
                    idPlantaEmpresa = (int)x.IDPLANTAEMPRESA,
                    idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                    ciuu = new CiuuBE { ciuu = (string)x.CIUU },
                    departamento = new DepartamentoBE { departamento = (string)x.DEPARTAMENTO },
                    provincia = new ProvinciaBE { provincia = (string)x.PROVINCIA },
                    distrito = new DistritoBE { distrito = (string)x.DISTRITO },
                    direccion = (string)x.DIRECCION,
                    empresa = new EmpresaIndustriaBE {
                        idEmpresaIndustria = (int)x.IDEMPRESAINDUSTRIA,
                        nombreEmpresa = (string)x.NOMBREEMPRESA,
                        nombreComercial = (string)x.NOMBRECOMERCIAL
                    },
                    idEstado = (string)x.IDESTADO,
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public PlantaEmpresaBE verificarDatosPlanta(PlantaEmpresaBE entidad, OracleConnection db)
        {
            PlantaEmpresaBE item = null;
            try
            {
                string sp = $"{Package.PlantaEmpresa}USP_SEL_VERIFICADOR_DATOS";
                var p = new OracleDynamicParameters();
                p.Add("piDenominacion", entidad.denominacion);
                p.Add("piDireccion", entidad.direccion);
                p.Add("piLatitud", entidad.latitud);
                p.Add("piLongitud", entidad.longitud);
                p.Add("piNumeroSuministroGas", entidad.numeroSuministroGas);
                p.Add("piNumeroSuministroAlumbrado", entidad.numeroSuministroAlumbrado);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<PlantaEmpresaBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }
    }
}
