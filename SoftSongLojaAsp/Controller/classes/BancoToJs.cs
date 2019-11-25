using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

public class BancoToJs
{
    ClasseConexao cs = new ClasseConexao();
    DataSet ds = new DataSet();

    public List<List<String>> carregaDados(String sql)
    {
        return this.carregaDados(sql, false);
    }
    public List<List<String>> carregaDados(String sql, bool colsFirst)
    {
        ds = new DataSet();
        cs = new ClasseConexao();
        ds = cs.executa_sql(sql);
        List<List<String>> matrix = new List<List<String>>();
        List<String> subMat;
        try
        {
            if (colsFirst)
            {
                subMat = new List<string>();
                foreach (DataColumn c in ds.Tables[0].Columns)
                {
                    subMat.Add(c.ToString());
                }
                matrix.Add(subMat);
            }
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                subMat = new List<string>();
                foreach (DataColumn c in ds.Tables[0].Columns)
                {
                    subMat.Add(ds.Tables[0].Rows[i][c.ToString()].ToString());
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

    public int insereDados(string sql)
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


    public string matrixToJs(List<List<String>> matrix)
    {
        String js = "[";
        foreach (List<String> l in matrix)
        {
            js += "[";
            foreach (string s in l)
            {
                js += "'" + s + "', ";
            }
            js.Remove(0, js.Length - 2);
            js += "], ";
        }
        js.Remove(0, js.Length - 2);
        js += "]";
        return js;
    }

    public string matrixToJs(List<List<String>> matrix, List<String> cols)
    {
        String js = "[";
        foreach (List<String> l in matrix)
        {
            js += "{";
            for (int i = 0; i < cols.Count; i++)
            {
                js += cols[i] + ": '" + l[i] + "', ";
            }
            js.Remove(0, js.Length - 2);
            js += "}, ";
        }
        js.Remove(0, js.Length - 2);
        js += "]";
        return js;
    }

    public string matrixToJs(List<List<String>> matrix, bool firstRowCols)
    {
        if (firstRowCols)
        {
            List<string> m0 = matrix[0];
            matrix.RemoveAt(matrix.Count - 1);
            return matrixToJs(matrix, m0);
        }
        else return matrixToJs(matrix);
    }
}
