package servletStore.saleInvoice;

import java.util.*;

import dao.General.GenericDAO;

public class demou {

	public static void main(String[] args) {
		
		GenericDAO gd= new GenericDAO();
		String q="SELECT intcolorid, varcolorname from color_master";  
		String brandid="12";
		String modelid="18";
		String getDetails="select purchase_master.varinvoiceno,model_details_master.aliasnamemodel,"
				+ "purchase_details.varimeino,purchase_master.datePurchaseDate,purchase_master.inttotalbillamount"
				+ " from purchase_master inner join purchase_master_details on "
				+ "purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId"
				+ " inner join purchase_details on "
				+ "purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId"
				+ " inner join model_details_master on purchase_master.intbrandid=model_details_master.intbrandid "
				+ "where purchase_master.intbrandid="+brandid+" and purchase_master_details.intmodelId="+modelid+" "
				+ "and model_details_master.intmodelid='"+modelid+"'";
			
		List l=gd.getData(getDetails);
		System.out.println(l);
		
		

	}

}
