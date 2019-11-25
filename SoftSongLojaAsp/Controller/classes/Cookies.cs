using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Cookies
{
    public void AddCookie(String nameCookie, string content, string key,
		TimeSpan duration)
	{
		HttpCookie cookie = HttpContext.Current.Request.Cookies[nameCookie];
		if (cookie != null)
		{
			if (cookie.Values.AllKeys.Contains(key))
			{
				cookie.Values[key] = content;
			}
			else
			{
				cookie.Values.Add(key, content);
			}
			cookie.Expires = DateTime.Now.Add(duration);
		}
		else
		{
			cookie = new HttpCookie(nameCookie);
			cookie.Expires = DateTime.Now.Add(duration);
			cookie.Values.Add(key, content);
		}
		HttpContext.Current.Response.Cookies.Add(cookie);
	}

	public void AddCookie(String nameCookie, string value, TimeSpan duration)
	{
		HttpCookie cookie = HttpContext.Current.Request.Cookies[nameCookie];
		if (cookie == null) cookie = new HttpCookie(nameCookie);
		cookie.Value = value;
		cookie.Expires = DateTime.Now.Add(duration);
		HttpContext.Current.Response.Cookies.Add(cookie);
	}

	public string ReadCookieValue(string cookieName)
	{
		if (HttpContext.Current.Request.Cookies.AllKeys.Contains(cookieName))
		{
			return HttpContext.Current.Request.Cookies[cookieName].Value;
		}
		else return "";
	}

	public string ReadCookieValue(string cookieName, string key)
	{
		if (HttpContext.Current.Request.Cookies.AllKeys.Contains(cookieName) &&
			HttpContext.Current.Request.Cookies[cookieName].Values.AllKeys.Contains(key))
		{
			return HttpContext.Current.Request.Cookies[cookieName].Values[key];
		}
		else return "";
	}


	public void ReadCookieValues(string cookieName, out List<String> keys,
		out List<String> values)
	{
		keys = new List<string>();
		values = new List<string>();
		if (HttpContext.Current.Request.Cookies.AllKeys.Contains(cookieName))
		{
			foreach (string s in HttpContext.Current.Request.Cookies[cookieName].Values.Keys)
			{
				keys.Add(s);
				values.Add(HttpContext.Current.Request.Cookies[cookieName].Values[s]);
			}
		}
	}

	public void RemoveCookie(String nameCookie)
	{
		HttpCookie cookie = HttpContext.Current.Request.Cookies[nameCookie];
		if (cookie != null)
		{
			cookie.Expires = DateTime.Now.AddHours(-1);
			HttpContext.Current.Response.Cookies.Add(cookie);
		}
	}

	public bool ExistsCookie(String nameCookie)
	{
		return HttpContext.Current.Request.Cookies[nameCookie] != null;
	}

	public void ClearCookies()
	{
		HttpCookie cookie;
		foreach (string k in HttpContext.Current.Request.Cookies.AllKeys)
		{
			cookie = HttpContext.Current.Request.Cookies[k];
			cookie.Expires = DateTime.Now.AddHours(-1);
			HttpContext.Current.Response.Cookies.Add(cookie);
		}
	}
}
