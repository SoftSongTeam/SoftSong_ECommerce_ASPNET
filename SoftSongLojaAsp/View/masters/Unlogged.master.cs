using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tcm2._0
{
	public partial class NestedMasterPage1 : System.Web.UI.MasterPage
	{
		DatabaseHandling db = new DatabaseHandling();
		JsHandling js = new JsHandling();
		Validar v = new Validar();

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void btnSignIn_Click(object sender, EventArgs e)
		{
			String[] data = { txtCadName.Text,txtCadCpf.Text, txtCadTel.Text, txtCadCep.Text, txtCadNum.Text, txtCadCom.Text,
				txtCadEmail.Text, txtCadPass.Text, txtCadRepPass.Text};
			String[] names = { "name", "cpf", "tel", "cep", "num", "com", "email", "pass", "repPass" };
			int[] lenghts = { 8, 14, 10, 8, 1, 0, 8, 8, 8 };
			bool passed = true;
			for (int i = 0; i < data.Length; i++)
			{
				data[i] = db.SqlInjectionPrevent(data[i]);
				if (data[i].Length < lenghts[i])
				{
					this.Controls.Add(new LiteralControl("<script class='error'>signInError(" + i + ", 'len')</script>"));
					passed = false;
					break;
				}
				if ((i == 1 && !v.ValidaCpf(data[i].Replace(".", "").Replace("-", ""))) ||
					(i == 3 && !v.ValidaCep(data[i])) ||
					(i == 6 && !v.ValidaEmail(data[i])))
				{
					this.Controls.Add(new LiteralControl("<script class='error'>signInError(" + i + ")</script>"));
					passed = false;
					break;
				}
				if (i == 8 && !data[i].Equals(data[i - 1]))
				{
					this.Controls.Add(new LiteralControl("<script class='error'>signInError(" + i + ", 'dif')</script>"));
					passed = false;
					break;
				}
			}
			if (passed)
			{
				List<List<String>> old = db.CarregaDados("select * from tblCliente where email = '" + data[6] + "'");
				if (old != null && old.Count == 0)
				{
					int ch = db.InsereDados("insert into tblCliente(nome,tel1, email, senha, cpf, endereco, cep, genero) values('" +
						data[0] + "','" +
						data[2] + "','" +
						data[6] + "','" +
						data[7] + "','" +
						data[1] + "','" +
						(data[4] + " " + data[5]) + "','" +
						data[3] + "', 9)");
					txtCadName.Text = txtCadCpf.Text = txtCadTel.Text = txtCadCep.Text = txtCadNum.Text = txtCadCom.Text =
						txtCadEmail.Text = txtCadPass.Text = txtCadRepPass.Text = "";
				}
				else
				{
					this.Controls.Add(new LiteralControl("<script class='error'>signInError('email', 'exs')</script>"));
				}
			}
		}

		protected void btnLogin_Click(object sender, EventArgs e)
		{
			List<List<String>> matrix = db.CarregaDados("select * from tblCliente where email = '" + db.SqlInjectionPrevent(txtLogEmail.Text) + "' and senha = '" +
				db.SqlInjectionPrevent(txtLogPass.Text) + "'");
			if (matrix != null && matrix.Count == 1)
			{
				Session["logged"] = "1";
				Session["userId"] = matrix[0][0];
				Response.Redirect(Request.Url.ToString());
			}
			else
			{
				this.Controls.Add(new LiteralControl("<script class='error'>loginError();</script>"));
				Session["logged"] = "0";
				Session["userId"] = "";
			}
		}

			//protected void btnEntrar_Click(object sender, EventArgs e)
			//{
			//    List<List<String>> data = b.carregaDados("select * from usuario where usu = '" + txtUsu.Text + "' and senha = '" +
			//        txtSenha.Text + "'");
			//    if (data != null && data.Count != 0)
			//    {
			//        Session["logged"] = "1";
			//        Session["user"] = data[0][1];
			//        Response.Redirect(Request.Url.ToString());
			//    }
			//    else
			//    {
			//        this.Controls.Add(new LiteralControl("<script>wrongLogin();</script>"));
			//        Session["logged"] = "0";
			//        Session["user"] = "";
			//    }
			//}

			//protected void btnCriar_Click(object sender, EventArgs e)
			//{
			//    this.Controls.Add(new LiteralControl("<script class='correcao'>$('.erro').remove();$('.correcao').remove()</script>"));
			//    if (txtUsuCreate.Text.Length < 4)
			//    {
			//        this.Controls.Add(new LiteralControl("<script class='erro userCurto'>" +
			//            "errorUser('Nome de usuário muito curto. Mínimo: 4 caracteres');</script>"));
			//    }
			//    else if (txtSenhaCreate.Text.Length < 8)
			//    {
			//        this.Controls.Add(new LiteralControl("<script class='erro senhaCurta'>errorPassword('Senha muito curta. Mínimo: 8 caracteres');$('.correcao-user').remove();</script>"));
			//        this.Controls.Add(new LiteralControl("<script class='correcao correcao-user'>$('.erro.userCurto).remove()<script>"));
			//    }
			//    else if (!txtSenhaCreate.Text.Equals(txtRepetirSenhaCreate.Text))
			//    {
			//        this.Controls.Add(new LiteralControl("<script class='erro senhaCurta'>errorPassword('As senhas não batem');$('.correcao-senha').remove();</script>"));
			//        this.Controls.Add(new LiteralControl("<script class='correcao correcao-senha'>$('.erro.senhaCurta).remove()<script>"));
			//    }
			//    else if (txtCpfCreate.Text.Replace(".", "").Replace("-", "").Length < 11 || !v.ValidaCpf(txtCpfCreate.Text.Replace(".", "").Replace("-", "")))
			//    {
			//        this.Controls.Add(new LiteralControl("<script class='erro cpfInvalido'>errorCpf('CPF Inválido');$('.correcao-cpf').remove();</script>"));
			//        this.Controls.Add(new LiteralControl("<script class='correcao correcao-cpf'>$('.erro.cpfInvalido).remove()<script>"));
			//    }
			//    else if (txtRgCreate.Text.Replace("-", "").Length < 8 || v.ValidaCep(txtCepCreate.Text.Replace("-","")))
			//    {
			//        this.Controls.Add(new LiteralControl("<script class='erro cepInvalido'>errorCep('CPF Inválido');$('.correcao-cpf').remove();</script>"));
			//        this.Controls.Add(new LiteralControl("<script class='correcao correcao-cpf'>$('.erro.cpfInvalido).remove()<script>"));
			//    }
			//    else
			//    {
			//        List<List<String>> data = b.carregaDados("select * from usuario where usu = '" + txtUsuCreate.Text + "'");
			//        if (data != null && data.Count == 0)
			//        {
			//            int n1 = b.insereDados("insert into usuario values('" + txtUsuCreate.Text + "','" + txtSenhaCreate.Text + "','" + txtNomeCreate.Text +
			//            "','" + txtSobrenomeCreate.Text + "', '" + txtCpfCreate.Text.Replace(".", "").Replace("-", "") + "', '" +
			//            txtRgCreate.Text.Replace(".", "").Replace("-", "")  + "',' " + txtCepCreate.Text.Replace("-","") + "')");
			//            txtUsu.Text = txtUsuCreate.Text;
			//            txtSenha.Text = txtSenhaCreate.Text;
			//            btnEntrar_Click(sender, e);
			//        }
			//        else
			//        {
			//            this.Controls.Add(new LiteralControl("<script>errorUser('Usuário já existe');</script>"));
			//        }
			//    }
			//}

		}
}