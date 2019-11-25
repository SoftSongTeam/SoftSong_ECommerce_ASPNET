using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class fakeIdLStoring
{
	private static List<IdStoringSet> displayingProductsId = new List<IdStoringSet>();
	static Random generator = new Random();

	public string getRealID(String fakeID)
	{
		foreach (IdStoringSet ie in displayingProductsId) if (ie.fakeID.Equals(fakeID)) return ie.realID;
		return null;
	}

	public string getFakeID(String realID)
	{
		foreach (IdStoringSet ie in displayingProductsId) if (ie.realID.Equals(realID)) return ie.fakeID;
		return null;
	}

	public string keepID(String id)
	{
		String fakeId = this.getFakeID(id);
		if (fakeId != null) return fakeId;
		char[] chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToCharArray();
		String randString;
		while (true)
		{
			randString = "";
			for (int i = 0; i < 10; i++) randString += chars[(int)Math.Floor((generator.NextDouble() * 62))];
			if (this.getRealID(randString) == null)
			{
				displayingProductsId.Add(new IdStoringSet(id, randString));
				return randString;
			}
		}
	}
}
