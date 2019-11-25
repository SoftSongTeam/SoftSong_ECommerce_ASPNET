using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

public class JsHandling
{
	public string MatrixToJs(List<List<String>> matrix)
	{
		return MatrixToJs(matrix, new List<int>() { });
	}

	public string MatrixToJs(List<List<String>> matrix, List<int> noCommaCols)
	{
		try
		{
			String js = "[";
			foreach (List<String> l in matrix)
			{
				js += "[";
				for (int i = 0; i < l.Count; i++)
				{
					js += (noCommaCols.Contains(i) ? "" : "\"") + l[i] +
						(noCommaCols.Contains(i) ? ", " : "\", ");
				}
				js = js.Remove(js.Length - 2, 2);
				js += "], ";
			}
			js = js.Remove(js.Length - 2, 2);
			js += "]";
			return js;
		}
		catch
		{
			return "{}";
		}
	}

	public string MatrixToJs(List<List<String>> matrix, bool firstRowCols)
	{
		try
		{
			if (firstRowCols)
			{
				List<string> m0 = matrix[0];
				matrix.RemoveAt(matrix.Count - 1);
				return MatrixToJsObjectList(matrix, m0);
			}
			else return MatrixToJs(matrix);
		}
		catch
		{
			return "{}";
		}
	}

	public string MatrixToJsObjectList(List<List<String>> matrix, List<String> cols)
	{
        //try
        //{
        //	String js = "[";
        //	foreach (List<String> l in matrix)
        //	{
        //		js += "{";
        //		for (int i = 0; i < cols.Count; i++)
        //		{
        //			js += cols[i] + ": \"" + l[i] + "\", ";
        //		}
        //		js = js.Remove(js.Length - 2, 2);
        //		js += "}, ";
        //	}
        //	js = js.Remove(js.Length - 2, 2);
        //	js += "]";
        //	return js;
        //}
        //catch
        //{
        //	return "[]";
        //}
        return MatrixToJsObjectList(matrix, cols, new List<int>());
	}

	public string MatrixToJsObjectList(List<List<String>> matrix, List<String> cols, List<int> excludeCol)
	{
        //try
        //{
        //	String js = "[";
        //	int j;
        //	foreach (List<String> l in matrix)
        //	{
        //		j = 0;
        //		js += "{";
        //		for (int i = 0; i < l.Count; i++)
        //		{
        //			if (excludeCol.Contains(i))
        //			{
        //				continue;
        //			}
        //			else
        //			{
        //				js += cols[j] + ": \"" + l[i] + "\", ";
        //				j++;
        //			}
        //		}
        //		js = js.Remove(js.Length - 2, 2);
        //		js += "}, ";
        //	}
        //	js = js.Remove(js.Length - 2, 2);
        //	js += "]";
        //	return js;
        //}
        //catch
        //{
        //	return "{}";
        //}
        return MatrixToJsObjectList(matrix, cols, excludeCol, new List<int>());
	}

	public string MatrixToJsObjectList(List<List<String>> matrix, List<String> cols, List<int> excludeCol, List<int> noQuotesCols)
	{
		try
		{
			String js = "[";
			int j;
			foreach (List<String> l in matrix)
			{
				j = 0;
				js += "{";
				for (int i = 0; i < l.Count; i++)
				{
					if (excludeCol.Contains(i))
					{
						continue;
					}
					else
					{
						js += cols[j] + (noQuotesCols.Contains(i) ? ": " : ": \"") + l[i] + (noQuotesCols.Contains(i) ? ", " : "\", ");
						j++;
					}
				}
				js = js.Remove(js.Length - 2, 2);
				js += "}, ";
			}
			js = js.Remove(js.Length - 2, 2);
			js += "]";
			return js;
		}
		catch
		{
			return "{}";
		}
	}

	public string VectorToJsObject(List<String> matrix, List<string> cols)
	{
		try
		{
			String js = "{";
			for (int i = 0; i < cols.Count; i++)
			{
				js += "\"" + cols[i] + "\": \"" + matrix[i] + "\", ";
			}
			js = js.Remove(js.Length - 2, 2);
			js += "}";
			return js;
		}
		catch
		{
			return "{}";
		}
	}

	public string VectorToJsObject(List<String> matrix, List<string> cols, List<int> noQuoteCols)
	{
		try
		{
			String js = "{";
			for (int i = 0; i < cols.Count; i++)
			{
				js += "\"" + cols[i] + "\": " + (noQuoteCols.Contains(i) ? "" : "\"") + matrix[i] + (noQuoteCols.Contains(i) ? "" : "\"") + ", ";
			}
			js = js.Remove(js.Length - 2, 2);
			js += "}";
			return js;
		}
		catch
		{
			return "{}";
		}
	}

	public string VectorToJsObject(List<String> matrix, List<string> cols, string aditional)
	{
		try
		{
			String js = "{" + aditional + ", ";
			for (int i = 0; i < cols.Count; i++)
			{
				js += "\"" + cols[i] + "\": \"" + matrix[i] + "\", ";
			}
			js = js.Remove(js.Length - 2, 2);
			js += "}";
			return js;
		}
		catch
		{
			return "{}";
		}
	}

	public string ListToJS(List<String> list)
	{
		try
		{
			String js = "[";
			foreach (String l in list)
			{
				js += "\"" + l + "\", ";
			}
			js = js.Remove(js.Length - 2, 2);
			js += "]";
			return js;
		}
		catch
		{
			return "{}";
		}
	}

	public string dateTimeToJs(string date)
	{
		string[] a = Regex.Split(date, "[:./ ]");
		if (a.Count() == 6) return "new Date(" + a[2] + ", " + a[1] + ", " + a[0] + ", " + a[3] + ", " + a[4] + ", " + a[5] + ", 0)";
		else return "new Date(" + a[2] + ", " + a[1] + ", " + a[0] + ", " + a[3] + ", " + a[4] + ", " + a[5] + ", " + a[6] + ")";
	}
}
