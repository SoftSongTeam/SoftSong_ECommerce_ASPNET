using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;


    public abstract class AbstractPage : System.Web.UI.Page
    {
        protected virtual void Page_PreInit(object sender, EventArgs e)
        {
            try
            {
                if (HttpContext.Current.Session["logged"].Equals("1"))
                {
                    this.MasterPageFile = "~/masters/Logged.master";
                    return;
                }
                else this.MasterPageFile = "~/masters/Unlogged.master";
            }
            catch (Exception exep)
            {
                this.MasterPageFile = "~/masters/Unlogged.master";
            }
        }

        protected virtual void Page_Load(object sender, EventArgs e)
        {
            if(Session["scriptPreInit"] != null )
            {
                this.Controls.Add(new LiteralControl("<script>" + Session["scriptPreInit"] + "</script>"));
            }
        }

        protected void addScript(string script)
        {
            Session["scriptPreInit"] = script;
        }
    }
