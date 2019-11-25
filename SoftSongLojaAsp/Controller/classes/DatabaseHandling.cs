using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

public class DatabaseHandling
{
	ClasseConexao cs = new ClasseConexao();
	DataSet ds = new DataSet();

	public String SqlInjectionPrevent(String s)
	{
		if (s == String.Empty || s.Equals("")) return s;
		String[] remove = new string[] { " or ", " and ", "update", "-shutdown", "--", "' or '1' = '1'", "insert", "drop", "delete", "xp_", "sp_", "select", "1 union select" };
		foreach (string r in remove) s = s.Replace(r, "");
		s = s.Replace("'", "''");
		s = s.Replace("--", " ");
		s = s.Replace("/*", " ");
		s = s.Replace("*/", " ");
		return s;
	}

	public List<List<String>> DataTableToMatrix(DataTable d, bool colsFirst)
	{

		List<List<String>> matrix = new List<List<String>>();
		List<String> subMat;
		try
		{
			if (colsFirst)
			{
				subMat = new List<string>();
				foreach (DataColumn c in d.Columns)
				{
					subMat.Add(c.ToString());
				}
				matrix.Add(subMat);
			}
			for (int i = 0; i < d.Rows.Count; i++)
			{
				subMat = new List<string>();
				foreach (DataColumn c in d.Columns)
				{
					if (c.DataType.Name == "Byte[]")
						subMat.Add(Convert.ToBase64String((Byte[])d.Rows[i][c.ToString()]));
					else
						subMat.Add(d.Rows[i][c.ToString()].ToString());
				}
				matrix.Add(subMat);
			}
		}
		catch (Exception ex)
		{
			if (ex is NullReferenceException) matrix = null;
		}
		return matrix;
	}

	public List<List<String>> CarregaDados(String sql)
	{
		return this.CarregaDados(sql, false);
	}

	public List<List<String>> CarregaDados(String sql, bool colsFirst)
	{
		try
		{
			ds = new DataSet();
			cs = new ClasseConexao();
			ds = cs.executa_sql(sql);
			return DataTableToMatrix(ds.Tables[0], colsFirst);
		}
		catch
		{
			return new List<List<string>>();
		}
	}

	public List<String> CarregaImagens(string sql)
	{
		try
		{
			ds = new DataSet();
			cs = new ClasseConexao();
			ds = cs.executa_sql(sql);
			DataColumn c = ds.Tables[0].Columns[0];
			List<String> ret = new List<string>();

			for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
			{
				ret.Add(Convert.ToBase64String((Byte[])ds.Tables[0].Rows[i][c.ToString()]));
			}

			return ret;
		}
		catch
		{
			return new List<string>();
		}
	}

	//public List<List<string>> CarregaDadosProcedure(String sql, List<List<string>> parameters)
	//{
	//	return CarregaDadosProcedure(sql, parameters, false);
	//}

	//public List<List<string>> CarregaDadosProcedure(String sql, List<List<string>> parameters, bool colsFirst)
	//{
	//	ds = new DataSet();
	//	cs = new ClasseConexao();
	//	return DataTableToMatrix(cs.executa_Procedure(sql, parameters), colsFirst);

	//}

	public int InsereDados(string sql)
	{
		try
		{
			ds = new DataSet();
			cs = new ClasseConexao();
			return cs.executa_IncAltExcParametros(new SqlCommand(sql));
		}
		catch
		{
			return 0;
		}
	}
}
