package utility;

import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class UpdateData {
	
	GenericDAO gd=new GenericDAO();
	int modelid;
	int colorid;
	int brandid;
	
	//start your methods here...
	
	 public boolean updateStockMaster(int brandid,String modelid, String colorid, int qty)
	{
		
		this.colorid=Integer.parseInt(modelid.toString());
		this.colorid=Integer.parseInt(colorid.toString());
		
		String queryforUpdate="SELECT `intmstockid`, `inttotalqty` FROM `mobilestock_master` WHERE intmodelid="+modelid+" AND intcolorid='"+colorid+"'";
		List getmodelid=gd.getData(queryforUpdate);
		if(!getmodelid.isEmpty())
		{
			int tempStocklId=Integer.parseInt(getmodelid.get(0).toString());
			int tempQty=Integer.parseInt(getmodelid.get(1).toString());
			tempQty+=qty;
			
			String queryForQty="UPDATE `mobilestock_master` SET `inttotalqty`="+tempQty+" WHERE intmstockid='"+tempStocklId+"'";
			int updateStatus=gd.executeCommand(queryForQty);
			
			if(updateStatus!=0)
				return true;
			else
				return false;
				
			
		}
		else
		{
			String insertQuery="INSERT INTO `mobilestock_master`(intbrandid,`intmodelid`, `intcolorid`, `inttotalqty`) VALUES ("+brandid+","+modelid+","+colorid+","+qty+")";
			int insertStatus=gd.executeCommand(insertQuery);
			
			if(insertStatus!=0)
				return true;
			else
				return false;
			
		}
		 
	}
	 public boolean getDataExist(String brandid,String priceratetosale,String modelid,int qty)
	 {
		 List queryfind=gd.getData("SELECT pmd.intmodelId, pmd.intpurchase_masterId, pmd.intqty FROM purchase_master_details pmd, purchase_master pm WHERE pm.intpurchase_masterId=pmd.intpurchase_masterId and pm.intbrandid='"+brandid+"'");
			Iterator itr=queryfind.iterator();
			System.out.println("list "+queryfind);
			while(itr.hasNext())
			{
				String checkingmodelid=itr.next().toString();
				String purchaseId=itr.next().toString();
				int tempqty=Integer.parseInt(itr.next().toString());
				qty=tempqty+qty;
				
				if(modelid.equals(checkingmodelid))
				{
					int updateit=gd.executeCommand("UPDATE `purchase_master_details` SET `varratetosale`="+priceratetosale+", intqty="+qty+" WHERE intpurchase_masterId="+purchaseId+" AND intmodelId='"+modelid+"'");
					if(updateit!=0)
					{
						return true;
					}
				}
			}
		return false;
		 
	 }
}
