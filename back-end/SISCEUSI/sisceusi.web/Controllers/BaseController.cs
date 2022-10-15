using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using sisceusi.entidad;
using sisceusi.logica;
using sisceusi.web.Filter;
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
    [LogoRedSocialAttribute]
    public class BaseController : Controller
    {
        protected UsuarioBE ObtenerUsuarioLogin()
        {
            string keySession = "user";
            UsuarioBE usuario = Session[keySession] == null ? null : (UsuarioBE)Session[keySession];
            return usuario;
        }

        /*protected LogoRedSocialBE ObtenerLogoRedSocial()
        {
            PaginaHomeLN logica = new PaginaHomeLN();
            LogoRedSocialBE logoRedSocial = logica.obtenerLogoRedSocial(new LogoRedSocialBE());
            return logoRedSocial;
        }*/

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

        protected ExcelWorksheet tituloReporteExcel(ExcelPackage package, string nombreTituloReporte, int cantidadColumnas, int filaCongelar = 4 )
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
            //ws.View.FreezePanes(4, 1);//FreezePanes(Fila, Columna)
            ws.View.FreezePanes(filaCongelar, 1);//FreezePanes(Fila, Columna)
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

        protected JsonResult json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonResult() { Data = data, ContentType = contentType, ContentEncoding = contentEncoding, JsonRequestBehavior = behavior, MaxJsonLength = Int32.MaxValue };
        }

        protected Dictionary<int, string> obtenerDictionaryLetra()
        {
            Dictionary<int, string> letras = new Dictionary<int, string>();
            letras.Add(1, "A");letras.Add(2, "B");letras.Add(3, "C");letras.Add(4, "D");letras.Add(5, "E");letras.Add(6, "F");letras.Add(7, "G");letras.Add(8, "H");letras.Add(9, "I");letras.Add(10, "J");letras.Add(11, "K");letras.Add(12, "L");letras.Add(13, "M");letras.Add(14, "N");letras.Add(15, "O");letras.Add(16, "P");letras.Add(17, "Q");letras.Add(18, "R");letras.Add(19, "S");letras.Add(20, "T");letras.Add(21, "U");letras.Add(22, "V");letras.Add(23, "W");letras.Add(24, "X");letras.Add(25, "Y");letras.Add(26, "Z");
            letras.Add(27, "AA");letras.Add(28, "AB");letras.Add(29, "AC");letras.Add(30, "AD");letras.Add(31, "AE");letras.Add(32, "AF");letras.Add(33, "AG"); letras.Add(34, "AH"); letras.Add(35, "AI"); letras.Add(36, "AJ");letras.Add(37, "AK");letras.Add(38, "AL");letras.Add(39, "AM");letras.Add(40, "AN");letras.Add(41, "AO");letras.Add(42, "AP");letras.Add(43, "AQ");letras.Add(44, "AR");letras.Add(45, "AS");letras.Add(46, "AT");letras.Add(47, "AU");letras.Add(48, "AV");letras.Add(49, "AW");letras.Add(50, "AX");letras.Add(51, "AY");letras.Add(52, "AZ");
            letras.Add(53, "BA");letras.Add(54, "BB");letras.Add(55, "BC");letras.Add(56, "BD");letras.Add(57, "BE");letras.Add(58, "BF");letras.Add(59, "BG");letras.Add(60, "BH");letras.Add(61, "BI");letras.Add(62, "BJ");letras.Add(63, "BK");letras.Add(64, "BL");letras.Add(65, "BM");letras.Add(66, "BN");letras.Add(67, "BO");letras.Add(68, "BP");letras.Add(69, "BQ");letras.Add(70, "BR");letras.Add(71, "BS");letras.Add(72, "BT");letras.Add(73, "BU");letras.Add(74, "BV");letras.Add(75, "BW");letras.Add(76, "BX");letras.Add(77, "BY");letras.Add(78, "BZ");
            letras.Add(79, "CA");letras.Add(80, "CB");letras.Add(81, "CC");letras.Add(82, "CD");letras.Add(83, "CE");letras.Add(84, "CF");letras.Add(85, "CG");letras.Add(86, "CH");letras.Add(87, "CI");letras.Add(88, "CJ");letras.Add(89, "CK");letras.Add(90, "CL");letras.Add(91, "CM");letras.Add(92, "CN");letras.Add(93, "CO");letras.Add(94, "CP");letras.Add(95, "CQ");letras.Add(96, "CR");letras.Add(97, "CS");letras.Add(98, "CT");letras.Add(99, "CU");letras.Add(100, "CV");letras.Add(101, "CW");letras.Add(102, "CX");letras.Add(103, "CY");letras.Add(104, "CZ");
            letras.Add(105, "DA");
            letras.Add(106, "DB");
            letras.Add(107, "DC");
            letras.Add(108, "DD");
            letras.Add(109, "DE");
            letras.Add(110, "DF");
            letras.Add(111, "DG");
            letras.Add(112, "DH");
            letras.Add(113, "DI");
            letras.Add(114, "DJ");
            letras.Add(115, "DK");
            letras.Add(116, "DL");
            letras.Add(117, "DM");
            letras.Add(118, "DN");
            letras.Add(119, "DO");
            letras.Add(120, "DP");
            letras.Add(121, "DQ");
            letras.Add(122, "DR");
            letras.Add(123, "DS");
            letras.Add(124, "DT");
            letras.Add(125, "DU");
            letras.Add(126, "DV");
            letras.Add(127, "DW");
            letras.Add(128, "DX");
            letras.Add(129, "DY");
            letras.Add(130, "DZ");
            letras.Add(131, "EA");
            letras.Add(132, "EB");
            letras.Add(133, "EC");
            letras.Add(134, "ED");
            letras.Add(135, "EE");
            letras.Add(136, "EF");
            letras.Add(137, "EG");
            letras.Add(138, "EH");
            letras.Add(139, "EI");
            letras.Add(140, "EJ");
            letras.Add(141, "EK");
            letras.Add(142, "EL");
            letras.Add(143, "EM");
            letras.Add(144, "EN");
            letras.Add(145, "EO");
            letras.Add(146, "EP");
            letras.Add(147, "EQ");
            letras.Add(148, "ER");
            letras.Add(149, "ES");
            letras.Add(150, "ET");
            letras.Add(151, "EU");
            letras.Add(152, "EV");
            letras.Add(153, "EW");
            letras.Add(154, "EX");
            letras.Add(155, "EY");
            letras.Add(156, "EZ");
            letras.Add(157, "FA");
            letras.Add(158, "FB");
            letras.Add(159, "FC");
            letras.Add(160, "FD");
            letras.Add(161, "FE");
            letras.Add(162, "FF");
            letras.Add(163, "FG");
            letras.Add(164, "FH");
            letras.Add(165, "FI");
            letras.Add(166, "FJ");
            letras.Add(167, "FK");
            letras.Add(168, "FL");
            letras.Add(169, "FM");
            letras.Add(170, "FN");
            letras.Add(171, "FO");
            letras.Add(172, "FP");
            letras.Add(173, "FQ");
            letras.Add(174, "FR");
            letras.Add(175, "FS");
            letras.Add(176, "FT");
            letras.Add(177, "FU");
            letras.Add(178, "FV");
            letras.Add(179, "FW");
            letras.Add(180, "FX");
            letras.Add(181, "FY");
            letras.Add(182, "FZ");
            letras.Add(183, "GA");
            letras.Add(184, "GB");
            letras.Add(185, "GC");
            letras.Add(186, "GD");
            letras.Add(187, "GE");
            letras.Add(188, "GF");
            letras.Add(189, "GG");
            letras.Add(190, "GH");
            letras.Add(191, "GI");
            letras.Add(192, "GJ");
            letras.Add(193, "GK");
            letras.Add(194, "GL");
            letras.Add(195, "GM");
            letras.Add(196, "GN");
            letras.Add(197, "GO");
            letras.Add(198, "GP");
            letras.Add(199, "GQ");
            letras.Add(200, "GR");
            letras.Add(201, "GS");
            letras.Add(202, "GT");
            letras.Add(203, "GU");
            letras.Add(204, "GV");
            letras.Add(205, "GW");
            letras.Add(206, "GX");
            letras.Add(207, "GY");
            letras.Add(208, "GZ");
            letras.Add(209, "HA");
            letras.Add(210, "HB");
            letras.Add(211, "HC");
            letras.Add(212, "HD");
            letras.Add(213, "HE");
            letras.Add(214, "HF");
            letras.Add(215, "HG");
            letras.Add(216, "HH");
            letras.Add(217, "HI");
            letras.Add(218, "HJ");
            letras.Add(219, "HK");
            letras.Add(220, "HL");
            letras.Add(221, "HM");
            letras.Add(222, "HN");
            letras.Add(223, "HO");
            letras.Add(224, "HP");
            letras.Add(225, "HQ");
            letras.Add(226, "HR");
            letras.Add(227, "HS");
            letras.Add(228, "HT");
            letras.Add(229, "HU");
            letras.Add(230, "HV");
            letras.Add(231, "HW");
            letras.Add(232, "HX");
            letras.Add(233, "HY");
            letras.Add(234, "HZ");
            letras.Add(235, "IA");
            letras.Add(236, "IB");
            letras.Add(237, "IC");
            letras.Add(238, "ID");
            letras.Add(239, "IE");
            letras.Add(240, "IF");
            letras.Add(241, "IG");
            letras.Add(242, "IH");
            letras.Add(243, "II");
            letras.Add(244, "IJ");
            letras.Add(245, "IK");
            letras.Add(246, "IL");
            letras.Add(247, "IM");
            letras.Add(248, "IN");
            letras.Add(249, "IO");
            letras.Add(250, "IP");
            letras.Add(251, "IQ");
            letras.Add(252, "IR");
            letras.Add(253, "IS");
            letras.Add(254, "IT");
            letras.Add(255, "IU");
            letras.Add(256, "IV");
            letras.Add(257, "IW");
            letras.Add(258, "IX");
            letras.Add(259, "IY");
            letras.Add(260, "IZ");
            letras.Add(261, "JA");
            letras.Add(262, "JB");
            letras.Add(263, "JC");
            letras.Add(264, "JD");
            letras.Add(265, "JE");
            letras.Add(266, "JF");
            letras.Add(267, "JG");
            letras.Add(268, "JH");
            letras.Add(269, "JI");
            letras.Add(270, "JJ");
            letras.Add(271, "JK");
            letras.Add(272, "JL");
            letras.Add(273, "JM");
            letras.Add(274, "JN");
            letras.Add(275, "JO");
            letras.Add(276, "JP");
            letras.Add(277, "JQ");
            letras.Add(278, "JR");
            letras.Add(279, "JS");
            letras.Add(280, "JT");
            letras.Add(281, "JU");
            letras.Add(282, "JV");
            letras.Add(283, "JW");
            letras.Add(284, "JX");
            letras.Add(285, "JY");
            letras.Add(286, "JZ");
            letras.Add(287, "KA");
            letras.Add(288, "KB");
            letras.Add(289, "KC");
            letras.Add(290, "KD");
            letras.Add(291, "KE");
            letras.Add(292, "KF");
            letras.Add(293, "KG");
            letras.Add(294, "KH");
            letras.Add(295, "KI");
            letras.Add(296, "KJ");
            letras.Add(297, "KK");
            letras.Add(298, "KL");
            letras.Add(299, "KM");
            letras.Add(300, "KN");
            letras.Add(301, "KO");
            letras.Add(302, "KP");
            letras.Add(303, "KQ");
            letras.Add(304, "KR");
            letras.Add(305, "KS");
            letras.Add(306, "KT");
            letras.Add(307, "KU");
            letras.Add(308, "KV");
            letras.Add(309, "KW");
            letras.Add(310, "KX");
            letras.Add(311, "KY");
            letras.Add(312, "KZ");
            return letras;
        }

    }
}