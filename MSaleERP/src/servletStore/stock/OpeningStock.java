package servletStore.stock;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;
import utility.demou;


public class OpeningStock extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		String HSNCode = request.getParameter("hsnCode");
		
		GenericDAO gd = new GenericDAO();
		
		if(request.getParameter("hsnCode")!=null)
		{
		
			String MRPPrice = request.getParameter("mrpprice");
			String quantity = request.getParameter("stockqnt");
			String brand = request.getParameter("brand");
			String model = request.getParameter("model");
			String color = request.getParameter("color");
			String modelName = request.getParameter("modelname");

			int counter = Integer.parseInt(request.getParameter("counter"));
			String IMEI[] = new String[counter];
			int flag=0;
			
			for(int i=0; i<counter; i++){
				IMEI[i] = request.getParameter("imei"+(i+1));
			}
			
			String getColorIdQuery = "select intcolorid from color_master where varcolorname='"+color+"'";
			List l2 = gd.getData(getColorIdQuery);
			String colorid = l2.get(0).toString();
			
			String getbrandIdQuery = "select intbrandid from brand_master where varbrandname='"+brand+"'";
			List l3 = gd.getData(getbrandIdQuery);
			String brandid = l3.get(0).toString();
			
			
			String OpeningStock = "insert into purchase_master_details ( hsnsacno, intmodelId, intcolorId, intqty, varratetosale) VALUES('"+HSNCode+"','"+model+"','"+colorid+"','"+quantity+"','"+MRPPrice+"');";
			
			int i = gd.executeCommand(OpeningStock);
			
			if(i==1){
				System.out.println("insert opening stock success");
			
				List getMaxid= gd.getData("SELECT MAX(`intpurchase_master_detailsId`) FROM `purchase_master_details` WHERE purchase_master_details.intmodelId='"+model+"'");
		
				for(int j=0;j<counter; j++){
					String insertImeiQeury="INSERT INTO `purchase_details`( `intpurchase_master_detailsId`, `varimeino1`) VALUES ("+getMaxid.get(0)+","+IMEI[j]+")";
					int x = gd.executeCommand(insertImeiQeury);
					
					if(x==1){
						System.out.println("insert opening stock imei success");
						flag=1;
						
					}
					else
					{
						System.out.println("insert opening stock imei fail");
					}
				}
			}
			else
			{
				System.out.println("insert opening stock fail");
			}
			
			
			if(flag==1){
				
				
				String checkModelExist = "select inttotalqty from mobilestock_master where intmodelid="+model+" and intcolorid="+colorid+"";
				List l5 = gd.getData(checkModelExist);
				
				if(l5.isEmpty()){
				
					String insertStockQuery = "insert into mobilestock_master ( intbrandid, intmodelId, intcolorId, inttotalqty) VALUES('"+brandid+"','"+model+"','"+colorid+"','"+quantity+"');";
					
					int k = gd.executeCommand(insertStockQuery);
					
					if(k==1){
						System.out.println("insert stock  success");
						request.setAttribute("brandId1", brandid);
						request.setAttribute("status1", " Stock of '"+modelName+"' added Succesfully");
						RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/stock/openingStock.jsp");
						rd.forward(request, response);
					}
					else{
						System.out.println("insert stock fail");
					}
				}
				else{
					
					String totalqty = l5.get(0).toString();
					
					int total = Integer.parseInt(quantity) + Integer.parseInt(totalqty);
					
					String update = "update mobilestock_master set inttotalqty="+total+" where intmodelid="+model+" and intcolorid="+colorid+";";
					
					int m = gd.executeCommand(update);
					if(m==1){
						System.out.println("insert stock  success1");
						request.setAttribute("brandId1", brandid);
						request.setAttribute("status1", "Stock of  '"+modelName+"'  added Succesfully");
						RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/stock/openingStock.jsp");
						rd.forward(request, response);
					}
					else{
						System.out.println("insert stock  fail1");
					}
					
				}
			}
		}
		
		
		if(request.getParameter("updateid")!=null)
		{
			String RowId=request.getParameter("updateid");
			RequireData rd=new RequireData();
			List demoList=rd.getOpeningStockRowData(RowId);
			Iterator itr=demoList.iterator();
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
			}
	
		}
		
		if(request.getParameter("modelid")!=null)
		{
			String modelName="";
			String modelid=request.getParameter("modelid");
			String query="SELECT `aliasnamemodel` FROM `model_details_master` where intmodelid="+modelid;
			List getmodel = gd.getData(query);

			out.print(getmodel.get(0));
			
		}
		
		
		if(request.getParameter("validateImei")!=null)
		{
			String checkimeistatus=request.getParameter("validateImei");
			List demolist=gd.getData("SELECT varimeino1 FROM `purchase_details`");
			
			Iterator itrimei=demolist.iterator();
			while(itrimei.hasNext())
			{	
				String s=itrimei.next().toString();
				if(s.equals(checkimeistatus))
				{
					out.println("1");
				}
			}
			
		}
		
		if(request.getParameter("validateImei1")!=null)
		{
			
			String checkimeistatus=request.getParameter("validateImei1");
			List demolist=gd.getData("SELECT varimeino1 FROM `purchase_details`where varimeino1 NOT in ("+checkimeistatus+")");
			
			Iterator itrimei=demolist.iterator();
			while(itrimei.hasNext())
			{	
				String s=itrimei.next().toString();
				if(s.equals(checkimeistatus))
				{
					System.out.println("1");
					out.println("1");
				}
			}
			
		}
		
		if(request.getParameter("updateSubmitBtn")!=null || request.getParameter("updatemodelId")!=null)
		{
			
			String updatemodelId=request.getParameter("updatemodelId");
			String updateQty=request.getParameter("updateQty");
			String updateModelAlias=request.getParameter("updateModelAlias");
			String updatePrice=request.getParameter("updatePrice");
			
			int count=Integer.parseInt(updateQty);
			String imei[] = new String[count];
			
			for(int i=1; count>0; i++){
				imei[i-1] = request.getParameter("updateimei"+i);
				count--;
			}
			
			
			String query = "select purchase_details.intpurchase_detailsId from purchase_details WHERE "
					+ "purchase_details.intpurchase_master_detailsId in ( select purchase_master_details.intpurchase_master_detailsId "
					+ "from purchase_master_details where purchase_master_details.intmodelId="+updatemodelId+" and purchase_master_details.intpurchase_masterId is null ) and purchase_details.intsalestatus=0";
			
			List queryList = gd.getData(query);
		
			System.out.println(queryList);
			
			Iterator itr = queryList.iterator();
			String[] imei_id = new String[Integer.parseInt(updateQty)];
			
			for(int k=0; itr.hasNext(); k++){
				imei_id[k] = itr.next().toString();
			}
			
			int status=1, flag=0;;
			for(int m=0; m<imei.length; m++){
				
				String updateQuery = "update purchase_details set purchase_details.varimeino1='"+imei[m]+"' where purchase_details.intpurchase_detailsId="+imei_id[m]+";";
				status = gd.executeCommand(updateQuery);
				
				if(status==0){
					break;
				}else{
					flag=1;
					String updateQuery1 = "update purchase_master_details set purchase_master_details.varratetosale='"+updatePrice+"' where purchase_master_details.intmodelId="+updatemodelId;
					int status1 = gd.executeCommand(updateQuery1);
					
				}
			}
			
			if(flag==1){
				request.setAttribute("status1", "Stock of  '"+updateModelAlias+"'  Updated Succesfully");
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/stock/openingStock.jsp");
				rd.forward(request, response);
			}
			
		}
		
		
		if(request.getParameter("deleteSubmitBtn")!=null)
		{
			
			String[] deleteimeis = request.getParameterValues("deleteimei");
			String deleteAlias = request.getParameter("deleteModelAlias");
			System.out.println("alias "+deleteAlias);
			
			for(String x : deleteimeis){
				
				String query = "select purchase_details.intpurchase_detailsId, purchase_details.intpurchase_master_detailsId, varimeino1 from purchase_details where varimeino1="+x;
				
				List deleteIdList = gd.getData(query);
				String deleteId5 = deleteIdList.get(0).toString();
				System.out.println("pur details "+deleteId5);
				
				String deleteId = deleteIdList.get(1).toString();
				System.out.println("pur master details "+deleteId);
				
				
				String deleteQuery = "delete from purchase_details where purchase_details.intpurchase_detailsId="+deleteId5;
				int status = gd.executeCommand(deleteQuery);
				
				if(status==1){
					
					System.out.println("success");
					String query2 = "select purchase_master_details.intqty from purchase_master_details where purchase_master_details.intpurchase_master_detailsId="+deleteId;
					
					List qtyList = gd.getData(query2);
					String qty = qtyList.get(0).toString();
					System.out.println("qty "+qty);
					
					int intQty = Integer.parseInt(qty);
					System.out.println("qty "+intQty);
					
					int newQty = intQty-1;
					System.out.println("newqty "+newQty);
					
					if(newQty==0){
						
						String deleteQuery1 = "delete from purchase_master_details where purchase_master_details.intpurchase_master_detailsId="+deleteId;
						int status1 = gd.executeCommand(deleteQuery);
						
						if(status1==1){
							request.setAttribute("status1", "IMEI's of  '"+deleteAlias+"'  Deleted Succesfully");
						}
						
					}else{
						
						String updateQty = "update purchase_master_details set purchase_master_details.intqty="+newQty+" where purchase_master_details.intpurchase_master_detailsId="+deleteId;
						status = gd.executeCommand(updateQty);
						
						if(status==1){
							request.setAttribute("status1", "IMEI's of  '"+deleteAlias+"'  Deleted Succesfully");
						}
					}
					
				}
				
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/stock/openingStock.jsp");
			rd.forward(request, response);
		}
		
		
		
	}

}
