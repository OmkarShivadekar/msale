package utility;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.joda.time.Days;

import dao.General.GenericDAO;

public class demou {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		GenericDAO gd=new GenericDAO();
		RequireData rd =new  RequireData();
		
		String demoQuery="SELECT brand_master.intbrandid FROM brand_master,"
				+ " dealer_master WHERE dealer_master.intdealerid=brand_master.intdealerid AND brand_master.intdealerid="+2;
		
		List dataOne=gd.getData(demoQuery);
		System.out.println(dataOne);
		List dataTwo=null;
		List dataTotal=new ArrayList();
		Iterator itrOne=dataOne.iterator();
		boolean flag=false;
		while(itrOne.hasNext())
		{
			dataTwo=gd.getData("SELECT model_details_master.intmodelid, "
					+ "model_details_master.intcolorid,model_details_master.aliasnamemodel"
					+ " FROM model_details_master, brand_master WHERE brand_master.intbrandid=model_details_master.intbrandid"
					+ " AND brand_master.intbrandid="+itrOne.next());
			System.out.println(dataTwo);
			Iterator itr=dataTwo.iterator();
			while(itr.hasNext())
			{
				dataTotal.add(itr.next());
				dataTotal.add(itr.next());
				dataTotal.add(itr.next());
			}
		}
		System.out.println(dataTotal);
		
		
		
		
		
		
		
		
		
		
		
		
		
//		String demo="SELECT * FROM `organization_details_master`";
//		System.out.println(gd.getData(demo));
//		
//		SecureCode sd=new SecureCode();
//		System.out.println(sd.encrypt("4564VRSOFT", 10));
//		
//		
//		
//		System.out.println(sd.decrypt(sd.encrypt("12VFX12", 10), 10));
	}
	public int term(int number)
	{
		int a=0;
		switch(number){  
	    case 1: a=1;break; 
	    case 2: a=2;break; 
	    case 3: a=3;break; 
	    case 4: a=4;break; 
	    case 5: a=5;break; 
	    case 6: a=6;break; 
	    case 7: a=7;break; 
	    case 8: a=8;break; 
	    case 9: a=9;break; 
	    default:a=0;
	    } 
		return a;
		
		
	}
	

}
