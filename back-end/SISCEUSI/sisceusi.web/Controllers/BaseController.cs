using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using sisceusi.entidad;
using sisceusi.web.Models;
using sres.ut;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace sisceusi.web.Controllers
{
    public class BaseController : Controller
    {
        protected UsuarioBE ObtenerUsuarioLogin()
        {
            string keySession = "user";
            UsuarioBE usuario = Session[keySession] == null ? null : (UsuarioBE)Session[keySession];
            return usuario;
        }

        protected async Task<bool> IsCaptchaValid(string response)
        {
            try
            {
                var secret = ConfigurationManager.AppSettings["ReCAPTCHA_Secret_Key"];
                using (var client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                        {"secret", secret},
                        {"response", response},
                        {"remoteip", Request.UserHostAddress}
                    };

                    var content = new FormUrlEncodedContent(values);
                    var verify = await client.PostAsync("https://www.google.com/recaptcha/api/siteverify", content);
                    var captchaResponseJson = await verify.Content.ReadAsStringAsync();
                    var captchaResult = JsonConvert.DeserializeObject<RecaptchaResponse>(captchaResponseJson);
                    return captchaResult.success;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);
                return false;
            }
        }

        protected ExcelWorksheet tituloReporteExcel(ExcelPackage package, string nombreTituloReporte, int cantidadColumnas)
        {
            ExcelWorksheet ws = package.Workbook.Worksheets.Add(nombreTituloReporte);
            using (ExcelRange m = ws.Cells[1, 1, 2, cantidadColumnas]) //Cells[Fila1, Column1, Fila2, Column2]
            {
                m.Style.Font.Bold = true;
                m.Style.WrapText = true;
                //Border
                m.Style.Border.Top.Style = ExcelBorderStyle.Thick;
                m.Style.Border.Right.Style = ExcelBorderStyle.Thick;
                m.Style.Border.Bottom.Style = ExcelBorderStyle.Thick;
                m.Style.Border.Left.Style = ExcelBorderStyle.Thick;
                //Alineacion
                m.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                m.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                m.Style.Font.Size = 14;                
                m.Merge = true;
                m.Value = nombreTituloReporte + " " + DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            }
            ws.View.FreezePanes(4, 1);//FreezePanes(Fila, Columna)
            return ws;
        }

        protected void cabecerasReporteExcel(ExcelWorksheet ws, List<string> cabeceras)
        {
            int ascii = 65;
            cabeceras.ForEach(c =>
            {
                using (ExcelRange m = ws.Cells[String.Concat(Convert.ToChar(ascii).ToString(), "3")]) //Cells[Fila1, Column1, Fila2, Column2]
                {
                    m.Style.Font.Bold = true;
                    m.Style.WrapText = false;
                    m.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                    m.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    m.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    m.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(16, 39, 189));
                    m.Style.Font.Color.SetColor(Color.FromArgb(255, 255, 255));
                    m.Style.Font.Size = 12;
                    m.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    m.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    m.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    m.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    m.AutoFitColumns(50, 75);
                    m.Value = c;
                }
                ascii++;
            });
            ws.Row(3).Height = 30;
        }

        protected void cuerpoReporteExcel(ExcelWorksheet ws, List<List<string>> cuerpo, int fila)
        {
            cuerpo.ForEach(c =>
            {
                int ascii = 65;
                c.ForEach(d =>
                {
                    using (ExcelRange m = ws.Cells[String.Concat(Convert.ToChar(ascii).ToString(), fila)])
                    {
                        m.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                        m.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                        m.Style.Font.Size = 10;
                        m.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        m.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        m.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                        m.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        m.AutoFitColumns(40, 60);
                        m.Value = d;
                    }
                    ascii++;
                });
                fila++;
            });
        }

        protected void exportar(ExcelPackage package, string nombreReporte)
        {
            string strFileName = nombreReporte + DateTime.Now.ToString() + ".xlsx";            
            byte[] dataByte = package.GetAsByteArray();
            Response.Clear();
            Response.AddHeader("Content-Disposition", "inline;filename=\"" + strFileName + "\"");
            Response.AddHeader("Content-Length", dataByte.Length.ToString());
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.BinaryWrite(dataByte);
            Response.End();
        }
    }
}