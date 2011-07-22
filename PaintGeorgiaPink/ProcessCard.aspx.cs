using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Xml.Linq;
//using PaintGeorgiaPink.NewPgpService;
using PaintGeorgiaPink;

namespace WebApplication1
{
    public partial class ProcessCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Logger logger = new Logger();

            try
            {
                logger.Log("Begin processing card...");

                string url = System.Configuration.ConfigurationSettings.AppSettings["serviceURI"];
                
                string input = "";

                using (StreamReader sr = new StreamReader(HttpContext.Current.Request.InputStream))
                {
                    input = sr.ReadToEnd();
                }

                if (input == "") 
                {
                    logger.Log("There was no input xml passed from Google Cart");
                    return; 
                }

                OrderProcessor.Processor p = new OrderProcessor.Processor();
                p.DoIt(input);

               
            }
            catch (Exception ex)
            {
                logger.Log(ex.Source, ex.Message, ex.Data.ToString(), ex.StackTrace, ex.TargetSite.Name, Logger.ErrorLevels.ERROR, "some bad shit occured");
            }


        }
    }
}