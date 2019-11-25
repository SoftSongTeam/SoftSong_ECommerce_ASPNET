using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tcm2._0
{
    public partial class geral : System.Web.UI.MasterPage
    {
        ClasseConexao cs = new ClasseConexao();
        DataSet ds = new DataSet();
        BancoToJs b = new BancoToJs();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.Controls.Add(new LiteralControl("<script>alert('" + this.Page.MasterPageFile + "')</script>"));
            //this.Controls.Add(new LiteralControl("<script>alert('" + Session["teste"] + "')</script>"));
        }

        protected void Page_Init(object sender, EventArgs e)
        {
        //    Session["teste"] = "aa";
        //    Session["logged"] = "1";
        }

		protected void btnCartHidden_Click(object sender, EventArgs e)
		{
			if (Session["logged"] != null && Session["logged"].Equals("1"))
			{
				Response.Redirect("payment.aspx");
			}
			else
			{
				this.Controls.Add(new LiteralControl("<script class='not-logged-correction'>$('#loginModal').modal('show');productAlert('Faça login para acessar o carrinho.');$('.not-logged-correction').remove();</script>"));
			}
		}
	}
}