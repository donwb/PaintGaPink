using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PaintGeorgiaPink
{
    public class Logger
    {
        public enum ErrorLevels { INFO, ERROR };

        public void Log(string source, string message, string data, string stackTrace,
            string targetSite, ErrorLevels errorLevel, string customMessage)
        {
            ErrorEdm edm = new ErrorEdm();
            ErrorLog log = new ErrorLog
            {
                Source = source,
                Message = message,
                Data = data,
                StackTrace = stackTrace,
                TargetSite = targetSite,
                ErrorLevel = errorLevel.ToString(),
                ErrorDate = DateTime.Now,
                CustomMessage = customMessage
            };

            edm.AddObject("ErrorLogs", log);
            edm.SaveChanges();

        }

        public void Log(string customMessage)
        {
            Log(null, null, null, null, null, ErrorLevels.INFO, customMessage);

        }

    }
}