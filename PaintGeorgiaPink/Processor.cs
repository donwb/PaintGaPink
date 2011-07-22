using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
//using PaintGeorgiaPink.NewPgpService;
using System.Net.Mail;
using System.Configuration;
using PaintGeorgiaPink;

namespace OrderProcessor
{
    public class Processor
    {
        private PaintGeorgiaPink.Logger logger = new PaintGeorgiaPink.Logger();
        private string SERVICE_URI;
        

        public Processor() 
        {
            SERVICE_URI = System.Configuration.ConfigurationSettings.AppSettings["serviceURI"];
            logger.Log("Order Processor using uri: " + SERVICE_URI);
        }

        // Named by @ShawnWildermuth via twitter
        public void DoIt(string xmlFromGoogleCart)
        {
            // Pull out the serial number
            XDocument doc = XDocument.Load(new StringReader(xmlFromGoogleCart));
            var query = from elems in doc.Elements().Attributes("serial-number") select elems;
            string serial = query.First().Value;


            // Now check to see if that serial exists..
            PgpEntities entities = new PgpEntities();

            var cards = from c in entities.ProcessedCards
                        where c.Serial == serial
                        select new { c.Serial };

            if (cards.Count() > 0)
            {
                logger.Log("The serial number " + cards.First().Serial + " already exists.. Stopping");
                return;
            }


            ProcessedCard card = new ProcessedCard { RawData = xmlFromGoogleCart, Serial = serial };
            entities.AddToProcessedCards(card);
            entities.SaveChanges();

            
            GetIdsFromCartXml(card.RawData);
        }


        public void DoIt(int cardId)
        {
            List<string> ids = new List<string>() { cardId.ToString() };
            ProcessCards(ids);
        }

      

        private void GetIdsFromCartXml(string input)
        {
            XDocument doc = null;

            //HACK: checking c:\ as a test.. remove for production
            if (input.Contains("C:\\")) // testing from file
                doc = XDocument.Load(new StreamReader(input));
            else
                doc = XDocument.Load(new StringReader(input));


            XNamespace ns = "http://checkout.google.com/schema/2";

            // crazy query to pull out the order items
            var query = from e in doc.Elements
                        (ns + "new-order-notification").Elements
                        (ns + "order-summary").Elements
                        (ns + "shopping-cart").Elements
                        (ns + "items").Elements(ns + "item")
                        select e;

            List<string> ids = new List<string>();

            foreach (XElement element in query)
            {
                string item = element.Element(ns + "item-name").Value;

                string itemNumber = item.Substring(item.IndexOf("#") + 1);
                ids.Add(itemNumber);

                //Console.WriteLine(item + " --- " + itemNumber);
            }


            ProcessCards(ids);

        }

        private void ProcessCards(List<string> ids)
        {
            try
            {
                // Can this be Parrell.For?
                foreach (string item in ids)
                {
                    int i = int.Parse(item);

                    PgpEntities svc = new PgpEntities();


                    var query = (from card in svc.Cards where card.CardId == i select card).ToList();

                    foreach (var card in query)
                    {
                        SendMail(card);

                        card.IsSent = true;
                        svc.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                logger.Log(ex.Source, ex.Message, ex.Data.ToString(), ex.StackTrace, ex.TargetSite.ToString(), Logger.ErrorLevels.ERROR,
                    "--Exception occured in ProcessCards()");
            }
        }


        private void SendMail(Card card)
        {
            string mailState = System.Configuration.ConfigurationSettings.AppSettings["mailState"];

            try
            {
                logger.Log("Entering Send Mail--" + card.CardId);

                PgpEntities svc = new PgpEntities();

                var query = from m in svc.MailSettings
                            where m.Active == true
                            select m;
                MailSetting settings = query.First();

                
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(settings.EmailAccountName);
                msg.To.Add(card.RecipientEmail);
                msg.CC.Add(card.SenderEmail);

                msg.Subject = settings.Subject;

                //TODO: Check URL for paint georgia pink
                string body = settings.Body + "\n" + settings.PickupURL + "?CardId=" + card.CardId;
                msg.Body = body;

                //SmtpClient mailer = new SmtpClient(settings.SmtpServer,587);
                SmtpClient mailer = new SmtpClient(settings.SmtpServer,settings.Port);
                mailer.UseDefaultCredentials = false;
                
                mailer.EnableSsl = false;
                mailer.ServicePoint.MaxIdleTime = 1;

                //mailer.Credentials = new System.Net.NetworkCredential
                //    (settings.EmailAccountName, settings.EmailAccountPassword);

                logger.Log(settings.EmailAccountName + " | " + settings.EmailAccountPassword + " | " + settings.SmtpServer);
                logger.Log("SSL: " + mailer.EnableSsl.ToString() + "HOST:" + mailer.Host + "PORT:" + mailer.Port.ToString() + "DEFAULT-CREDS: " +  mailer.UseDefaultCredentials.ToString());

                if (mailState == "on")
                {
                    mailer.Send(msg);
                    logger.Log("Card #" + card.CardId + " -- mail sent!");
                }
                else
                    logger.Log("Mail setting is off.. switch config to 'on' to enable mail sending");

               

            }
            catch (Exception ex)
            {
                string exMsg = null;
                if (ex.InnerException != null)
                    exMsg = ex.InnerException.Message;
                else
                    exMsg = ex.Message;

                logger.Log(ex.Source, exMsg, ex.Data.ToString(), ex.StackTrace, ex.TargetSite.Name, PaintGeorgiaPink.Logger.ErrorLevels.ERROR,
                    "CARD NO: " + card.CardId + "-- unable to send mail");

            }

        }

    }
}
