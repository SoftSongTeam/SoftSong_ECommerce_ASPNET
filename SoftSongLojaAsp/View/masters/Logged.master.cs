using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tcm2._0
{
    public partial class Logged : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.lblUser.Text = "Bem Vindo " + Session["user"];
        }

        protected void btnFecharSessao_Click(object sender, EventArgs e)
        {
            Session["logged"] = "0";
            Session["userId"] = "";
			Response.Redirect(Request.Url.ToString());
        }
    }
}