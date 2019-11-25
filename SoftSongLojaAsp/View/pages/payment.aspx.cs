using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftSongLojaAsp.pages
{
	public partial class payment : AbstractPage
	{
		Cookies c = new Cookies();
		DatabaseHandling db = new DatabaseHandling();
		JsHandling js = new JsHandling();
		fakeIdStoring fk = new fakeIdStoring();

		List<int[]> countedCart;
		List<List<String>> cardData;

		override protected void Page_Load(object sender, EventArgs e)
		{
			base.Page_Load(sender, e);
			String[] cart = c.ReadCookieValue("cart", "ids").Split('a');
			if (cart[0].Equals(""))
			{
				this.Controls.Add(new LiteralControl("<script class='dataScript'>emptyCart(); $('.dataScript').remove()</script>"));

			}
			else
			{
				try
				{

					countedCart = new List<int[]>();
					foreach (String ie in cart)
					{
						int id = int.Parse(ie);
						bool isNewItem = true;
						foreach (int[] iee in countedCart)
						{
							if (iee[0] == id)
							{
								iee[1]++;
								isNewItem = false;
								break;
							}
						}
						if (isNewItem) countedCart.Add(new int[] { id, 1 });
					}
					String ids = "(";
					foreach (int[] ie in countedCart)
					{
						ids += ie[0] + ",";
					}
					ids = ids.Substring(0, ids.Length - 1);
					List<List<String>> matrix = db.CarregaDados("select IDTipoProduto, nome, preco_unitario from tblTipoProduto where IDTipoProduto in "
						+ ids + ")");
					cardData = matrix;
					foreach (List<string> me in matrix)
					{
						foreach (int[] ie in countedCart)
						{
							if (me[0].Equals(ie[0] + ""))
							{
								me.Add(ie[1] + "");
								break;
							}
						}
						me[0] = fk.getFakeID(me[0]);
						me[2] = me[2].Replace(",", ".");
					}
					String data = js.MatrixToJsObjectList(matrix, new List<string>() { "'id'", "'n'", "'p'", "'q'" }, new List<int>(), new List<int> { 2, 3 });
					this.Controls.Add(new LiteralControl("<script class='dataScript'>vmPayment.prods = " + data + "; getNextImage(); $('.dataScript').remove()</script>"));


					if (!Session["userId"].Equals(""))
					{
						List<List<String>> endMat = db.CarregaDados("select cep, endereco from tblCliente where IDCliente = " + Session["userId"]);
						txtCEP.Text = endMat[0][0];
						String[] endSpl = endMat[0][1].Split(' ');
						txtNum.Text = endSpl[0];
						for (int i = 1; i < endSpl.Length; i++) txtComp.Text += (i == 1 ? "" : " ") + endSpl[i];
					}
				}
				catch (Exception ex)
				{

				}
			}

		}
	}
}