using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class IdStoringSet
{
	public String realID;
	public String fakeID;

	public IdStoringSet(string realID, string fakeID)
	{
		this.realID = realID;
		this.fakeID = fakeID;
	}

}
