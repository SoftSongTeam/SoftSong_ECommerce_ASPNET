using System;
using System.Text.RegularExpressions;

class Validar
{
    public bool ValidaCnpj(String cnpj)
    {
        try
        {
            String iniCnpj = cnpj.Substring(0, 12);
            String fimCnpj = cnpj.Substring(12);
            char[] a = new char[12];
            a = iniCnpj.ToCharArray();
            int[] b = new int[] { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int t = 0;
            int i;
            for (i = 0; i < 12; i++)
            {
                t = t + int.Parse(a[i].ToString()) * b[i];
            }
            iniCnpj = iniCnpj + (((t % 11) < 2) ? 0 : 11 - (t % 11)).ToString().ToCharArray()[0];
            b = new int[] { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            a = iniCnpj.ToCharArray();
            t = 0;
            for (i = 0; i < 13; i++)
            {
                t = t + int.Parse(a[i].ToString()) * b[i];
            }
            return (iniCnpj + (((t % 11) < 2) ? 0 : 11 - (t % 11)).ToString().ToCharArray()[0]).Equals(cnpj);
        }
        catch
        {
            return false;
        }
    }

    public bool ValidaCpf(String cpf)
    {
        try
        {
            String iniCpf = cpf.Substring(0, 9);
            String fimCpf = cpf.Substring(9);
            int t = 0;
            char[] cIni = iniCpf.ToCharArray();
            int i;
            for (i = 0; i <= 8; i++)
            {
                t = t + int.Parse(cIni[i].ToString()) * (10 - i);
            }
            iniCpf = iniCpf + (((t % 11) < 2) ? "0" : (11 - (t % 11)).ToString());
            cIni = iniCpf.ToCharArray();
            t = 0;
            for (i = 0; i <= 9; i++)
            {
                t = t + int.Parse(cIni[i].ToString()) * (11 - i);
            }
            return (iniCpf + (((t % 11) < 2) ? "0" : (11 - (t % 11)).ToString())).Equals(cpf);
        }
        catch
        {
            return false;
        }
    }
    public bool ValidaData(String data)
    {
        bool a = true;
        try
        {
            DateTime.Parse(data);
        }
        catch
        {
            a = false;
        }
        return a;
    }

    public bool ValidaCep(string cep)
    {
        try
        {
            var ws = new SoftSongLojaAsp.WSCorreios.AtendeClienteClient();
            var resposta = ws.consultaCEP(cep);
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
    public bool ValidaEmail(string email)
    {
        Regex rg = new Regex(@"^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$");
        return rg.IsMatch(email);
    }

    public String TiraAcento(String txt)
    {
        String[] acentos = { "á", "à", "ã", "â", "ä", "é", "è", "ê", "ë", "í", "ì", "î", "ï", "ó", "ò", "ô", "õ", "ö", "ú", "ù", "û", "ü", "ý", "ÿ" };
        String[] letras = { "a", "a", "a", "a", "a", "e", "e", "e", "e", "i", "i", "i", "i", "o", "o", "o", "o", "o", "u", "u", "u", "u", "y", "y" };
        for (int i = 0; i < acentos.Length; i++)
        {
            txt = txt.Replace(acentos[i], letras[i]);
            txt = txt.Replace(acentos[i].ToUpper(), letras[i].ToUpper());
        }
        return txt;
    }

    public SoftSongLojaAsp.WSCorreios.enderecoERP GetEnderecoERP(String cep)
    {
        try
        {
            return (new SoftSongLojaAsp.WSCorreios.AtendeClienteClient()).consultaCEP(cep);
        }
        catch
        {
            return null;
        }
    }
}

