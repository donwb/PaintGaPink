using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PaintGeorgiaPink
{
    public partial class preview : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public string Id
        {
            get
            {
                string s = HttpContext.Current.Request.QueryString["CardId"];
                return "Paint Georgia Pink Card #" + s;
            }

        }

        public void cmdSendCard_OnClick(object sender, EventArgs e)
        {
            string s = Id.Substring(Id.IndexOf("#")+1);

            int id;
            bool b = int.TryParse(s, out id);
            if (b)
            {
                OrderProcessor.Processor p = new OrderProcessor.Processor();
                p.DoIt(id);
            }


            Response.Redirect("http://pinked.breastfriends.org");

        }

    }
}