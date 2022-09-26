﻿using Dapper;
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
    public class IndicadorDA : BaseDA
    {
        public List<IndicadorBE> mostrarListaIndicador(IndicadorBE entidad, OracleConnection db)
        {
            List<IndicadorBE> lista = new List<IndicadorBE>();
            try
            {
                string sp = $"{Package.Indicador}USP_SEL_BUSQ_GEN_INDICADOR";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("piRegistros", entidad.registros);
                p.Add("piPagina", entidad.pagina);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new IndicadorBE
                {
                    idIndicador = (int)x.IDINDICADOR,
                    nombreIndicador = x.NOMBREINDICADOR == null ? "" : (string)x.NOMBREINDICADOR,
                    campanaEncuesta = new CampanaEncuestaBE
                    {
                        idCampanaEncuesta = x.IDCAMPANAENCUESTA == null ? 0 : (int)x.IDCAMPANAENCUESTA,
                        pregunta = x.PREGUNTA == null ? "" : (string)x.PREGUNTA,
                        tablaMaestra = new TablaMaestraBE
                        {
                            idTablaMaestra = x.IDTABLAMAESTRA == null ? 0 : (int)x.IDTABLAMAESTRA,
                            subtitulo = x.SUBTITULO == null ? "" : (string)x.SUBTITULO
                        }
                    },                    
                    encabezadoSecundario = new EncabezadoSecundarioBE
                    {
                        idEncabezadoSecundario = x.IDENCABEZADOSECUNDARIO == null ? 0 : (int)x.IDENCABEZADOSECUNDARIO,
                        tituloEncabezado = x.TITULOENCABEZADO == null ? "" : (string)x.TITULOENCABEZADO,
                        encabezadoPrincipal = new EncabezadoPrincipalBE
                        {
                            idEncabezadoPrincipal = x.IDENCABEZADOPRINCIPAL == null ? 0 : (int)x.IDENCABEZADOPRINCIPAL,
                            tituloEncabezado = x.TITULOENCABEZADOPRINCIPAL == null ? "" : (string)x.TITULOENCABEZADOPRINCIPAL,
                        }
                    },
                    metodoCalculo = new MetodoCalculoBE
                    {
                        idMetodoCalculo = x.IDMETODOCALCULO == null ? 0 : (int)x.IDMETODOCALCULO,
                        metodoCalculo = x.METODOCALCULO == null ? "" : (string)x.METODOCALCULO
                    },
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

        public bool grabar(IndicadorBE entidad, OracleConnection db)
        {
            bool seGrabo = false;
            try
            {
                string sp = $"{Package.Indicador}USP_PRC_GUARDAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdIndicador", entidad.idIndicador);
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("piNombreIndicador", entidad.nombreIndicador);
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("piIdCampanaEncuesta", entidad.idCampanaEncuesta);
                p.Add("piIdEncabezadoPrincipal", entidad.idEncabezadoPrincipal);
                p.Add("piIdEncabezadoSecundario", entidad.idEncabezadoSecundario);
                p.Add("piIdMetodoCalculo", entidad.idMetodoCalculo);
                p.Add("piIdTipoControl", entidad.idTipoControl);
                //p.Add("piIdEstado", entidad.idEstado);
                p.Add("piIdUsuarioCreacion", entidad.idUsuarioCreacion);
                p.Add("piIpCreacion", entidad.ipCreacion);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seGrabo = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seGrabo;
        }

        public IndicadorBE obtenerIndicador(IndicadorBE entidad, OracleConnection db)
        {
            IndicadorBE item = null;
            try
            {
                string sp = $"{Package.Indicador}USP_SEL_OBJECT";
                var p = new OracleDynamicParameters();
                p.Add("piIdIndicador", entidad.idIndicador);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                item = db.QueryFirstOrDefault<IndicadorBE>(sp, p, commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex) { Log.Error(ex); }
            return item;
        }

        public bool eliminar(IndicadorBE entidad, OracleConnection db)
        {
            bool seElimino = false;
            try
            {
                string sp = $"{Package.Indicador}USP_UPD_DESHABILITAR";
                var p = new OracleDynamicParameters();
                p.Add("piIdIndicador", entidad.idIndicador);
                p.Add("poRowAffected", dbType: OracleDbType.Int32, direction: ParameterDirection.Output);
                db.Execute(sp, p, commandType: CommandType.StoredProcedure);
                int filasAfectadas = (int)p.Get<dynamic>("poRowAffected").Value;
                seElimino = filasAfectadas > 0;
            }
            catch (Exception ex) { Log.Error(ex); }
            return seElimino;
        }

        public List<IndicadorBE> obtenerListaIndicador(IndicadorBE entidad, OracleConnection db)
        {
            List<IndicadorBE> lista = new List<IndicadorBE>();
            try
            {
                string sp = $"{Package.Indicador}USP_SEL_LISTA_INDICADOR";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<IndicadorBE>(sp, p, commandType: CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

        public List<IndicadorEncabezadoSecundarioBE> obtenerListaIndicadorEncabezadoSecundario(IndicadorBE entidad, OracleConnection db)
        {
            List<IndicadorEncabezadoSecundarioBE> lista = new List<IndicadorEncabezadoSecundarioBE>();
            try
            {
                decimal number = 0;
                string sp = $"{Package.Indicador}USP_SEL_INDICADOR_ENC_SECUN";
                var p = new OracleDynamicParameters();
                p.Add("piIdCampana", entidad.idCampana);
                p.Add("piIdEncabezadoSecundario", entidad.idEncabezadoSecundario);
                p.Add("poRef", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
                lista = db.Query<dynamic>(sp, p, commandType: CommandType.StoredProcedure).Select(x => new IndicadorEncabezadoSecundarioBE
                {
                    campanaEmpresa = new CampanaEmpresaBE
                    {
                        idCampana = x.IDCAMPANA == null ? 0 : (int)x.IDCAMPANA,
                        idEmpresaIndustria = x.IDEMPRESAINDUSTRIA == null ? 0 : (int)x.IDEMPRESAINDUSTRIA,
                    },
                    controlEncuesta = new ControlEncuestaBE
                    {
                        idControlEncuesta = x.IDCONTROLENCUESTA == null ? 0 : (int)x.IDCONTROLENCUESTA,
                    },
                    valor = x.RESPUESTA == null ? 0 : x.RESPUESTA == "" ? 0 : Decimal.TryParse(x.RESPUESTA, out number) ? number : 0
                }).ToList();
            }
            catch (Exception ex) { Log.Error(ex); }
            return lista;
        }

    }
}
