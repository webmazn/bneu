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
    public class ControlEncuestaLN : BaseLN
    {
        ControlEncuestaDA datos = new ControlEncuestaDA();

        public ControlEncuestaBE obtenerControlEncuesta(ControlEncuestaBE controlEncuesta)
        {
            ControlEncuestaBE item = null;
            try
            {
                cn.Open();
                item = datos.obtenerControlEncuesta(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return item;
        }

        public bool participarTratamientoDatos(ControlEncuestaBE controlEncuesta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.participarTratamientoDatos(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }

        public bool firmarEncuesta(ControlEncuestaBE controlEncuesta)
        {
            bool seGuardo = false;
            try
            {
                cn.Open();
                seGuardo = datos.firmarEncuesta(controlEncuesta, cn);
            }
            finally { if (cn.State == ConnectionState.Open) cn.Close(); }
            return seGuardo;
        }
    }
}