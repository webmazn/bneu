using Oracle.DataAccess.Client;
using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class CampanaLN : BaseLN
    {
        CampanaDA datos = new CampanaDA();

        public List<CampanaBE> filtroGeneral(CampanaBE campana)
        {
            List<CampanaBE> lista = new List<CampanaBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(campana, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<CampanaBE> filtroAvanzado(CampanaBE campana)
        {
            List<CampanaBE> lista = new List<CampanaBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(campana, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<CampanaBE> exportarGeneral(CampanaBE empresa)
        {
            List<CampanaBE> lista = new List<CampanaBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<CampanaBE> exportarAvanzado(CampanaBE empresa)
        {
            List<CampanaBE> lista = new List<CampanaBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarCampana(CampanaBE campana)
        {
            bool seGuardo = false;
            try
            {
                if (cn.State != ConnectionState.Open) { cn.Open(); }                
                using (OracleTransaction ot = cn.BeginTransaction(System.Data.IsolationLevel.ReadCommitted))
                {
                    int idCampana = 0;
                    seGuardo = datos.grabarCampana(campana, out idCampana, cn);
                    if (seGuardo)
                    {
                        campana.idCampana = idCampana;
                        seGuardo = datos.actualizarCampanaEmpresaEstado(campana, cn);
                    }
                    if (seGuardo)
                    {
                        foreach (var x in campana.listaCampanaEmpresa)
                        {
                            int idCampanaEmpresa = 0;
                            x.idCampana = idCampana;
                            x.idUsuarioCreacion = campana.idUsuarioCreacion;
                            x.ipCreacion = campana.ipCreacion;
                            seGuardo = datos.grabarCampanaEmpresa(x, out idCampanaEmpresa, cn);
                            if (seGuardo)
                            {
                                List<PlantaEmpresaBE> list = datos.obtenerListaPlantaEmpesa(new PlantaEmpresaBE { idEmpresaIndustria = x.idEmpresaIndustria }, cn);
                                if (list != null)
                                {
                                    foreach (var y in list)
                                    {
                                        if (x.participarEnPiloto.Equals("1"))
                                        {
                                            ControlEncuestaBE controlEncuesta = new ControlEncuestaBE
                                            {
                                                idCampanaEmpresa = idCampanaEmpresa,
                                                idPlantaEmpresa = y.idPlantaEmpresa,
                                                idTipoEncuesta = 1,
                                                idSupervisor = x.idSupervisorPiloto,
                                                idEtapa = campana.idEtapaPiloto,
                                                idUsuarioCreacion = campana.idUsuarioCreacion,
                                                ipCreacion = campana.ipCreacion
                                            };
                                            seGuardo = datos.grabarControlEncuesta(controlEncuesta, cn);
                                        }
                                        if (!seGuardo) break;

                                        if (x.participarEnOficial.Equals("1"))
                                        {
                                            ControlEncuestaBE controlEncuesta = new ControlEncuestaBE
                                            {
                                                idCampanaEmpresa = idCampanaEmpresa,
                                                idPlantaEmpresa = y.idPlantaEmpresa,
                                                idTipoEncuesta = 2,
                                                idSupervisor = x.idSupervisorOficial,
                                                idEtapa = campana.idEtapaOficial,
                                                idUsuarioCreacion = campana.idUsuarioCreacion,
                                                ipCreacion = campana.ipCreacion
                                            };
                                            seGuardo = datos.grabarControlEncuesta(controlEncuesta, cn);
                                        }
                                        if (!seGuardo) break;
                                    }
                                }
                            }                            
                            if (!seGuardo) break;
                        }
                    }
                    if (seGuardo)
                    {
                        seGuardo = datos.actualizarCampanaEncuestaEstado(campana, cn);
                    }
                    if (seGuardo)
                    {
                        foreach (var x in campana.listaPregunta)
                        {
                            int idCampanaEncuesta = 0;
                            x.idCampana = idCampana;
                            x.idUsuarioCreacion = campana.idUsuarioCreacion;
                            x.ipCreacion = campana.ipCreacion;
                            seGuardo = datos.grabarCampanaEncuesta(x, out idCampanaEncuesta, cn);
                            if (seGuardo)
                            {
                                x.idCampanaEncuesta = idCampanaEncuesta;
                                seGuardo = datos.actualizarRespuestaEncuestaEstado(x, cn);
                            }
                            if (seGuardo)
                            {
                                if (x.listaRespuesta != null)
                                {
                                    foreach (var y in x.listaRespuesta)
                                    {
                                        y.idCampanaEncuesta = idCampanaEncuesta;
                                        y.idUsuarioCreacion = campana.idUsuarioCreacion;
                                        y.ipCreacion = campana.ipCreacion;
                                        seGuardo = datos.grabarRespuestaEncuesta(y, cn);
                                        if (!seGuardo) break;
                                    }
                                }                                
                            }
                            else break;
                        }
                    }
                    if (seGuardo) ot.Commit();
                    else ot.Rollback();
                }
            }
            catch (Exception ex) { Log.Error(ex); }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public CampanaBE obtenerCampana(CampanaBE campana)
        {
            CampanaBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerCampana(campana, cn);
                if (item != null)
                {
                    item.listaCampanaEmpresa = datos.obtenerCampanaEmpresa(new CampanaEmpresaBE { idCampana = item.idCampana }, cn);
                    item.listaPregunta = datos.obtenerCampanaEncuesta(new CampanaEncuestaBE { idCampana = item.idCampana }, cn);
                    if (item.listaPregunta != null)
                    {
                        foreach (var x in item.listaPregunta)
                        {
                            x.listaRespuesta = datos.obtenerRespuestaEncuesta(new RespuestaEncuestaBE { idCampanaEncuesta = x.idCampanaEncuesta }, cn);
                        }
                    }
                }
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool copiarCampana(CopiarCampanaBE campana)
        {
            CampanaBE item = null;
            bool seCopio = false;
            try
            {
                cn.Open();
                item = datos.obtenerCampana(new CampanaBE { idCampana = campana.idCampana }, cn);
                if (item != null)
                {
                    item.idUsuarioCreacion = campana.idUsuarioCreacion;
                    item.ipCreacion = campana.ipCreacion;
                    if (campana.copiarEmpresa)
                    {
                        item.listaCampanaEmpresa = datos.obtenerCampanaEmpresa(new CampanaEmpresaBE { idCampana = item.idCampana }, cn);
                        //if (!campana.copiarSupervisor)
                        //{
                        //    item.listaCampanaEmpresa.ForEach(x =>
                        //    {
                        //        x.idSupervisorOficial = 0;
                        //        x.idSupervisorPiloto = 0;
                        //        x.participarEnPiloto = "0";
                        //        x.participarEnOficial = "0";
                        //    });
                        //}
                    }
                    else
                    {
                        item.listaCampanaEmpresa = new List<CampanaEmpresaBE>();
                    }
                    
                    if (campana.copiarPregunta)
                    {
                        item.listaPregunta = datos.obtenerCampanaEncuesta(new CampanaEncuestaBE { idCampana = item.idCampana }, cn);
                        if (item.listaPregunta != null)
                        {
                            foreach (var x in item.listaPregunta)
                            {
                                x.listaRespuesta = datos.obtenerRespuestaEncuesta(new RespuestaEncuestaBE { idCampanaEncuesta = x.idCampanaEncuesta }, cn);
                                x.idCampanaEncuesta = -1;
                                x.listaRespuesta.ForEach(w =>
                                {
                                    w.idRespuestaEncuesta = -1;
                                });
                            }
                        }
                    }
                    else
                    {
                        item.listaPregunta = new List<CampanaEncuestaBE>();
                    }
                    item.idCampana = -1;
                    item.denominacion = campana.nombreCampana;
                    item.fechaInicioPiloto = campana.fechaInicial;
                    item.fechaFinPiloto = campana.fechaFinalizacion;
                    item.idEtapaPiloto = 1;
                    item.fechaInicioEncuesta = campana.fechaInicial;
                    item.fechaFinEncuesta = campana.fechaFinalizacion;
                    item.idEtapaOficial = 1;
                    seCopio = grabarCampana(item);
                }                
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seCopio;
        }
    }
}
