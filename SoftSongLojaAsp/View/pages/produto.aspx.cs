using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftSongLojaAsp.pages
{
	public partial class produto : AbstractPage
	{
		DatabaseHandling db = new DatabaseHandling();
		Cookies c = new Cookies();

		String prodID, ammount;

		protected override void Page_Load(object sender, EventArgs e)
		{

			base.Page_Load(sender, e);

			String fakeID = Request.QueryString["id"];
			prodID = (new fakeIdStoring()).getRealID(fakeID);

			if (prodID == null || prodID.Equals("")) this.Controls.Add(new LiteralControl("<script>alertUndefinedProd()</script>"));
			else
			{
				List<List<String>> prodData = db.CarregaDados("exec readProductData " + prodID);
				if (prodData.Count == 0)
				{
					this.Controls.Add(new LiteralControl("<script>alertUndefinedProd()</script>"));
				}

				else
				{
					lnkCategoria.Text = prodData[0][0];
					lnkCategoria.NavigateUrl = "~/pages/produto.aspx?id=" + prodData[0][0];
					//lnkSecao.Text = prodData[0][1];
					lblNome.Text = prodData[0][2];
					lblPreco.Text = "R$:" + prodData[0][3];
					lblDesc.Text = prodData[0][4];
					imgProduto.ImageUrl = String.Format(@"data:image/png;base64,{0}", prodData[0][5]);
				}
				ammount = db.CarregaDados("select count(*) from tblProduto where ID_TipoProduto = " + prodID)[0][0];
				this.Controls.Add(new LiteralControl("<script class='removeScript'> " +
					(ammount.Equals("0") ? "unavailableProduct()" : "maxAmmount = " + ammount) +
					";$('.removeScript').remove();</script>"));

			}
			//this.Controls.Add(new LiteralControl("<script>alert('" + Request.QueryString["id"] + "');</script>"));

		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			c.ClearCookies();
		}

		protected void btnShow_Click(object sender, EventArgs e)
		{
			this.Controls.Add(new LiteralControl("<script class='removeScript'>productAlert('" + c.ReadCookieValue("cart", "ids") + "');$('.removeScript').remove();</script>"));
		}

		protected void btnBackBuyNow_Click(object sender, EventArgs e)
		{
			btnBackAddCart_Click(sender, e);
			Response.Redirect("payment.aspx");
		}

		protected void btnBackAddCart_Click(object sender, EventArgs e)
		{
			try
			{
				int am = int.Parse(txtAmmount.Text);
				int maxAm = int.Parse(ammount);
				if (maxAm < am)
				{
					this.Controls.Add(new LiteralControl("<script class='removeScript'>productAlert('Muitos produtos selecionados');$('.removeScript').remove();</script>"));
				}
				else
				{
					String prodsString = prodID;
					for (int i = 1; i < am; i++) prodsString += "a" + prodID;
					String oldVal = c.ReadCookieValue("cart", "ids");
					c.AddCookie("cart", (oldVal.Equals("") ? "" : oldVal + "a") + prodsString, "ids", new TimeSpan(2, 0, 0));
					this.Controls.Add(new LiteralControl("<script class='removeScript'>productAlert('Produto adicionado com sucesso ao carrinho');$('.removeScript').remove();</script>"));
				}
			}
			catch (Exception ex)
			{
				this.Controls.Add(new LiteralControl("<script class='removeScript'>productAlert('Houve um erro, não foi possível adicionar o produto ao carrinho.');$('.removeScript').remove();</script>"));
			}
		}
	}
}