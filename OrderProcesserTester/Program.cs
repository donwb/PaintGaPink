using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OrderProcesserTester
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("starting...");
            
            OrderProcessor.Processor p = new OrderProcessor.Processor();
            p.Process(@"C:\Users\donwb\Documents\My Dropbox\dev\PaintGeorgiaPink\PGP Sample Order.xml");

            Console.WriteLine("done..");
            Console.ReadLine();

        }
    }
}
