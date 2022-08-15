﻿using sisceusi.datos;
using sisceusi.entidad;
using sisceusi.Logica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sisceusi.logica
{
    public class TablaMaestraLN : BaseLN
    {
        TablaMaestraDA datos = new TablaMaestraDA();

        public List<TablaMaestraBE> filtroGeneral(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.filtroGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<TablaMaestraBE> filtroAvanzado(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.filtroAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<TablaMaestraBE> exportarGeneral(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.exportarGeneral(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<TablaMaestraBE> exportarAvanzado(TablaMaestraBE empresa)
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.exportarAvanzado(empresa, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EncabezadoPrincipalBE> mostrarListaEncabezadoPrincipal(EncabezadoPrincipalBE entidad)
        {
            List<EncabezadoPrincipalBE> lista = new List<EncabezadoPrincipalBE>();
            try
            {
                cn.Open();
                lista = datos.mostrarListaEncabezadoPrincipal(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public List<EncabezadoSecundarioBE> mostrarListaEncabezadoSecundario(EncabezadoSecundarioBE entidad)
        {
            List<EncabezadoSecundarioBE> lista = new List<EncabezadoSecundarioBE>();
            try
            {
                cn.Open();
                lista = datos.mostrarListaEncabezadoSecundario(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }

        public bool grabarTablaMaestra(TablaMaestraBE tablaMaestra, out int idTablaMaestra)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarTablaMaestra(tablaMaestra, out idTablaMaestra, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool grabarEncabezadoPrincipal(EncabezadoPrincipalBE encabezado)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarEncabezadoPrincipal(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool grabarEncabezadoSecundario(EncabezadoSecundarioBE encabezado)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.grabarEncabezadoSecundario(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public TablaMaestraBE obtenerTablaMaestra(TablaMaestraBE encabezado)
        {
            TablaMaestraBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerTablaMaestra(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public EncabezadoPrincipalBE obtenerEncabezadoPrincipal(EncabezadoPrincipalBE encabezado)
        {
            EncabezadoPrincipalBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerEncabezadoPrincipal(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public EncabezadoSecundarioBE obtenerEncabezadoSecundario(EncabezadoSecundarioBE encabezado)
        {
            EncabezadoSecundarioBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerEncabezadoSecundario(encabezado, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool eliminar(TablaMaestraBE entidad)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminar(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

        public bool eliminarPrincipal(EncabezadoPrincipalBE entidad)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminarPrincipal(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

        public bool eliminarSecundario(EncabezadoSecundarioBE entidad)
        {
            bool seElimino = false;
            try
            {
                cn.Open();
                seElimino = datos.eliminarSecundario(entidad, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seElimino;
        }

        public List<TablaMaestraBE> obtenerListaTablaMaestra()
        {
            List<TablaMaestraBE> lista = new List<TablaMaestraBE>();
            try
            {
                cn.Open();
                lista = datos.obtenerListaTablaMaestra(cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return lista;
        }
    }
}
