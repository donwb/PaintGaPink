using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;


namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("press <enter> to begin..");
            Console.ReadLine();

            Console.WriteLine("starting at: " + DateTime.Now.ToLongTimeString());
            string filename = @"C:\Users\donwb\Documents\My Dropbox\dev\PaintGeorgiaPink\PGP Sample Order.xml";

            string xml;
            using (StreamReader reader = new StreamReader(filename))
            {
                xml = reader.ReadToEnd();
            }


            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://localhost:55345/ProcessCard.aspx");

            

            byte[] reqBytes = System.Text.UTF8Encoding.UTF8.GetBytes(xml);
            request.ContentLength = reqBytes.Length;
            request.Method = "POST";
            request.ContentType = "text/xml";
            System.IO.Stream oReqStream = request.GetRequestStream();
            oReqStream.Write(reqBytes, 0, reqBytes.Length);	



            Console.WriteLine("done at: " + DateTime.Now.ToLongTimeString());
            Console.ReadLine();
        }
    }
}
