using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Text.RegularExpressions;

namespace SoftSongLojaAsp.svc
{
	[ServiceContract(Namespace = "")]
	[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
	public class Utilities
	{

		DatabaseHandling b = new DatabaseHandling();
		JsHandling j = new JsHandling();
		WSCorreios.AtendeClienteClient ws = new WSCorreios.AtendeClienteClient();

		[OperationContract]
		public string saveImage(Int16[] img)
		{
			int i = 0;
			int j = i + 1;

			return "salve";
		}


		[OperationContract]
		public string searchProducts(String s, String order, String categories, String page)
		{
			s = b.SqlInjectionPrevent(s);
			order = b.SqlInjectionPrevent(order);
			categories = b.SqlInjectionPrevent(categories);
			page = b.SqlInjectionPrevent(page);
			String oldS = s;
			s = s.ToLower();
			if (categories == null || categories.Equals("")) categories = ";;";
			List<String> catArr = new List<string>(categories.Split(';'));
			String[] vogais = { "aáàãäâ", "cç", "eéèëê", "iîíìï", "oóòõôö", "uúùûü", "yýÿ" };
			for (int vi = 0; vi < vogais.Count(); vi++)
			{
				String v = vogais[vi];
				foreach (char vc in v) s = s.Replace(vc + "", "[{" + vi + "}]");
			}
			s = String.Format(s, vogais);
			for (int i = 0; i < catArr.Count; i++)
			{
				catArr[i].ToLower();
				for (int vi = 0; vi < vogais.Count(); vi++)
				{
					String v = vogais[vi];
					foreach (char vc in v) catArr[i] = catArr[i].Replace(vc + "", "[{" + vi + "}]");
				}
				catArr[i] = "%" + String.Format(catArr[i], vogais) + "%";
			}
			while (catArr.Count < 3) catArr.Add("");
			String query = "select top " + (int.Parse(page) * 12) + " IDTipoProduto, nome,preco_unitario, descricao, (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) as ammount " +
				"from tblTipoProduto tp where (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) > 0 " +
				"and lower(tp.nome) like '%" + s + "%' and tp.ID_Categoria in (select c.IDCategoria from tblCategoria c where c.nome like '" + catArr[0] + "' " +
				"or c.nome like '" + catArr[1] + "' or c.nome like '" + catArr[2] + "') order by " + (order == "valCres" ? "tp.preco_unitario asc" : "tp.preco_unitario desc");
			String nextPageQuery = "select count(*) from tblTipoProduto tp where (select count(*) from tblProduto p where tp.IDTipoProduto = p.ID_TipoProduto) > 0 " +
				"and lower(tp.nome) like '%" + s + "%' and tp.ID_Categoria in (select c.IDCategoria from tblCategoria c where c.nome like '" + catArr[0] + "' " +
				"or c.nome like '" + catArr[1] + "' or c.nome like '" + catArr[2] + "')";
			List<List<String>> matrix = b.CarregaDados(query);
			Double productNumber = double.Parse(b.CarregaDados(nextPageQuery)[0][0]);
			bool isLastPage = Math.Ceiling((productNumber / 12)) < int.Parse(page);
			matrix.RemoveRange(0, (int.Parse(page) - 1) * 12);
			fakeIdStoring idStoring = new fakeIdStoring();
			for (int pi = 0; pi < matrix.Count; pi++)
			{
				matrix[pi][0] = idStoring.keepID(matrix[pi][0]);
				matrix[pi].Add("");
			}
			String prods = j.MatrixToJsObjectList(matrix, new List<string>() { "\"id\"", "\"name\"", "\"price\"", "\"desc\"", "\"ammount\"", "\"img\"" }, new List<int>() { });
			return "{\"next\":\"" + isLastPage + "\",\"s\":\"" + oldS + "\",\"o\":\"" + order + "\",\"c\":" + j.ListToJS(new List<string>(categories.Split(';'))) + ",\"page\":\"" + page + "\",\"p\":" + prods + "}";
		}

		[OperationContract]
		public string searchCategories(String s)
		{
			String oldS = s;
			s.ToLower();
			String[] vogais = { "aáàãäâ", "eéèëê", "iîíìï", "oóòõôö", "uúùûü", "yýÿ" };
			for (int vi = 0; vi < vogais.Count(); vi++)
			{
				String v = vogais[vi];
				foreach (char vc in v) s = s.Replace(vc + "", "[{" + vi + "}]");
			}
			s = String.Format(s, vogais);
			List<List<String>> ret = b.CarregaDados("select top 3 nome from tblCategoria where lower(nome) like '%" + s + "%'");
			List<String> vector = new List<string>();
			foreach (List<String> row in ret) vector.Add(row[0]);
			return "{\"s\": \"" + oldS + "\", \"ret\": " + j.ListToJS(vector) + "}";
		}

		[OperationContract]
		public string getProductImage(String s)
		{
			String id = (new fakeIdStoring()).getRealID(s);
			if (!id.Equals(""))
			{
				return b.CarregaImagens("select imagem from tblTipoProduto where IDTipoProduto = " + id)[0];
			}
			return "Product Code Not Found";
		}

		[OperationContract]
		public string AddressFromCep(String cep)
		{
			try
			{
				WSCorreios.enderecoERP ret = ws.consultaCEP(cep);
				return cep + ret.end + ", " + ret.cidade + ", " + ret.uf;
			}
			catch
			{
				return "CEP não encontrado";
			}
		}
		
	}
}
