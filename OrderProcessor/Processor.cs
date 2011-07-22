using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
using OrderProcessor.PgpService;
using System.Net.Mail;
using System.Configuration;

namespace OrderProcessor
{
    public class Processor
    {
        //TODO: hardcode service_uri
        private string SERVICE_URI = "";

        private List<string> _ids;

        public Processor() 
        {
            _ids = new List<string>(5);
            SERVICE_URI = System.Configuration.ConfigurationSettings.AppSettings["serviceURI"];

        }


        public void Process(string input)
        {
            XDocument doc = null;

            //HACK: checking c:\ as a test.. remove for production
            if (input.Contains("C:\\")) // testing from file
                doc = XDocument.Load(new StreamReader(input));
            else
                doc = XDocument.Load(new StringReader(input));

            Process(doc);

            // Can this be Parrell.For?
            foreach (string item in _ids)
            {
                int i = int.Parse(item);

                PgpEntities svc = new PgpEntities(new Uri(SERVICE_URI));

                var query = from card in svc.Cards
                            where card.CardId == i
                            select card;

                try
                {
                    //
                }
                catch (Exception ex)
                {
                    
                }

                foreach (var card in query)
                {
                    SendMail(card);

                    card.IsSent = true;
                    svc.UpdateObject(card);
                    svc.SaveChanges();
                }
            }

        }

        private void Process(XDocument doc)
        {
            
            XNamespace ns = "http://checkout.google.com/schema/2";

            // crazy query to pull out the order items
            var query = from e in doc.Elements
                        (ns + "new-order-notification").Elements
                        (ns + "order-summary").Elements
                        (ns + "shopping-cart").Elements
                        (ns + "items").Elements(ns + "item")
                        select e;

            foreach (XElement element in query)
            {
                string item = element.Element(ns + "item-name").Value;

                string itemNumber = item.Substring(item.IndexOf("#") + 1);
                _ids.Add(itemNumber);

                Console.WriteLine(item + " --- " + itemNumber);
            }
        }

        private void SendMail(Card card)
        {
            

            PgpEntities svc = new PgpEntities(new Uri(SERVICE_URI));
            var query = from m in svc.MailSettings select m;
            MailSetting settings = query.First();

            //TODO: using my email address for my relay.. replace with BF relay info
            MailMessage msg = new MailMessage(
                new MailAddress(card.RecipientEmail),
                new MailAddress("don@tracibrowning.com")
                );

            if(settings.CC != null)
                msg.CC.Add(new MailAddress(settings.CC));

            msg.Subject = settings.Subject;

            //TODO: Check URL for paint georgia pink
            string body = settings.Body + "\n" + settings.PickupURL + "?CardId=" + card.CardId;
            msg.Body = body;

            SmtpClient mailer = new SmtpClient(settings.SmtpServer,80);


            mailer.Credentials = new System.Net.NetworkCredential(settings.EmailAccountName, settings.EmailAccountPassword);

            mailer.Send(msg);


        }

    }
}
