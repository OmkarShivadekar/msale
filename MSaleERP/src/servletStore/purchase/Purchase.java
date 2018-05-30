package servletStore.purchase;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.UpdateData;
import dao.General.GenericDAO;

/**
 * Servlet implementation class Purchase
 */
//@WebServlet("/Purchase.do")
public class Purchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Purchase() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		// delete data
		if(request.getParameter("dInvoiceNo")!=null)
		{
			GenericDAO gd=new GenericDAO();
			String invoiceNo=request.getParameter("dInvoiceNo");
			String dealerId=request.getParameter("dDealerId");
			String aliasName=request.getParameter("dAliasName");
			int countStock=Integer.parseInt(request.getParameter("stockCount").toString());
			String getQty="SELECT model_details_master.aliasnamemodel FROM purchase_master_details,purchase_master,"
					+ "model_details_master WHERE purchase_master.intpurchase_masterId=purchase_master_details."
					+ "intpurchase_masterId and purchase_master_details.intmodelId=model_details_master.intmodelid "
					+ "AND purchase_master.varinvoiceno='"+invoiceNo+"'";
			List getModelName=gd.getData(getQty);
			Iterator getMNameItr=getModelName.iterator();
			while(getMNameItr.hasNext())
			{
				String demoModel=getMNameItr.next().toString();
				System.out.println(demoModel);
				String subQuery="SELECT model_details_master.aliasnamemodel FROM "
						+ "purchase_master_details,purchase_master,purchase_details,model_details_master "
						+ "WHERE purchase_master_details.intmodelId=model_details_master.intmodelid and "
						+ "purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId "
						+ "AND purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId "
						+ "AND purchase_master.varinvoiceno='"+invoiceNo+"' and model_details_master.aliasnamemodel='"+demoModel+"'";
				List demoList1=gd.getData(subQuery);
				Iterator itr2=demoList1.iterator();
				int i=0;
				while(itr2.hasNext())
				{
					itr2.next();
					i++;
				}
				String subQuery2="SELECT mobilestock_master.inttotalqty FROM model_details_master, "
						+ "mobilestock_master WHERE model_details_master.intmodelid=mobilestock_master.intmodelid "
						+ "and model_details_master.aliasnamemodel='"+demoModel+"'";
				int stockQty=Integer.parseInt(gd.getData(subQuery2).iterator().next().toString());
				int setNewQty=stockQty-i;
				if(setNewQty<0)
					setNewQty=0;
				String getStockId="UPDATE `mobilestock_master`,model_details_master SET inttotalqty = "+setNewQty+" "
						+ "WHERE mobilestock_master.intmodelid=(SELECT model_details_master.intmodelid "
						+ "WHERE model_details_master.aliasnamemodel='"+demoModel+"')";
				int stockStatus=gd.executeCommand(getStockId);
				if(stockStatus==1)
				{
					System.out.println("deleted from stock too");
					i=0;
				}
				else
				{
					System.out.println("not deleted in stock");
					i=0;
				}
			}
			int status=0;
			String deleteQuery="DELETE purchase_details,purchase_master_details,purchase_master "
					+ "FROM purchase_details,purchase_master_details,purchase_master "
					+ "WHERE purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId "
					+ "and purchase_master_details.intpurchase_masterId=purchase_master.intpurchase_masterId "
					+ "AND purchase_master.varinvoiceno='"+invoiceNo+"' and purchase_master.intdealerid="+dealerId;
			status=gd.executeCommand(deleteQuery);
			if(status>0)
			{
				System.out.println("delete data");
				request.setAttribute("status", "Deleted Successfully");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/purchase/newMobilePurchase2.jsp?dealerId="+dealerId);
				rd.forward(request, response);
			}
			else
			{
				System.out.println("cannot delete data");
				request.setAttribute("error","error");
				RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/purchase/newMobilePurchase2.jsp?dealerId="+dealerId);
				rd.forward(request, response);
				
			}
		}
		// ajax for finding model
		
		if(request.getParameter("findName")!=null)
		{
			GenericDAO gd = new GenericDAO();
			String name=request.getParameter("findName");
			String dealerId=request.getParameter("dealerId");
			
			String demoQuery="SELECT brand_master.intbrandid FROM brand_master,"
					+ " dealer_master WHERE dealer_master.intdealerid=brand_master.intdealerid AND brand_master.intdealerid="+dealerId;
			
			List dataOne=gd.getData(demoQuery);
			Iterator itrOne=dataOne.iterator();
			boolean flag=false;
			while(itrOne.hasNext())
			{
				List dataTwo=gd.getData("SELECT model_details_master.aliasnamemodel FROM model_details_master,brand_master"
					+ " WHERE brand_master.intbrandid=model_details_master.intbrandid AND "
					+ "brand_master.intbrandid="+itrOne.next()+" AND model_details_master.aliasnamemodel LIKE '%"+name+"%'");

				if(!dataTwo.isEmpty())
				{
					Iterator itr = dataTwo.iterator();
					while (itr.hasNext()) {
						Object alias=itr.next();
						out.print("<option>"+alias+"</option>");
		
						}
				}
			}
		}
		if(request.getParameter("modelAlias")!=null)
		{
			
			GenericDAO da = new GenericDAO();
			String aliasName=request.getParameter("modelAlias");
			
			String query = "SELECT model_details_master.intmodelid,model_details_master.intcolorid,model_details_master.aliasnamemodel FROM model_details_master,brand_master"
					+ " WHERE brand_master.intbrandid=model_details_master.intbrandid "
					+ "AND model_details_master.aliasnamemodel='"+aliasName+"'";
			List details = da.getData(query);
			if(!details.isEmpty())
			{
				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					Object modelId=itr.next();
					Object colorId=itr.next();
					Object alias=itr.next();
					out.print(modelId+","+colorId);
	
					}
			}
		}
		
		//updating imei number
				if(request.getParameter("updatePurchase")!=null)
				{
					String uModelBrandId=request.getParameter("uModelBrandId");
					String uPmid=request.getParameter("upmid");
					String[] imeiLoop=request.getParameter("uimeiLoop").toString().split(",");
					int[] uImeiLoop= new int[imeiLoop.length];
					String[] modelLoop=new String[imeiLoop.length];
					String uInvoiceNumber=request.getParameter("uinvoiceno");
					String uDateOfPurchase=request.getParameter("udop");
					//out.print(uModelBrandId+","+uPmid+","+uInvoiceNumber+","+uDateOfPurchase+","+uBillAmount+","+imeiLoop.length+","+modelLoop.length);
					GenericDAO gd=new GenericDAO();
					int status=0;
					for(int i=0;i<imeiLoop.length;i++)
					{
						uImeiLoop[i]=Integer.parseInt(imeiLoop[i]);
						
					}
					int m=0;
					for(int i=0;i<uImeiLoop.length;i++)
					{
						for(int j=0;j<uImeiLoop[i];j++)
						{
							if(request.getParameter("uImeiId"+m)!=null&&request.getParameter("uImei"+m)!=null)
							{
								String query1="UPDATE `purchase_details` SET`varimeino1`='"+request.getParameter("uImei"+m)+"' WHERE"
										+ " intpurchase_detailsId="+request.getParameter("uImeiId"+m);
								status = gd.executeCommand(query1);	
								if(status==1)
								{
									System.out.println("done imei in "+(j+1));
								}
								m++;
							}
						}
					}
					if(uInvoiceNumber!=null)
					{
						String query2="UPDATE `purchase_master` SET `varinvoiceno`='"+uInvoiceNumber+"',`datePurchaseDate`='"+uDateOfPurchase+"'"
								+ " WHERE purchase_master.intpurchase_masterId="+uPmid;
						status=gd.executeCommand(query2);
						if(status==1)
						{
							System.out.println("done update other data");
							request.setAttribute("status","Updated Successfully");
							RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/purchase/newMobilePurchase2.jsp?dealerId="+uModelBrandId);
							rd.forward(request, response);
						}
					}
				}
		
		//updating imei number
		if(request.getParameter("updIMEI")!=null)
		{
			String ubrandid=request.getParameter("ubrandId");
			String uinvno=request.getParameter("uinvno");
			String ualiasname=request.getParameter("ualiasname");
			GenericDAO gd=new GenericDAO();
			//fetching data queries
			String query0="SELECT purchase_master.intpurchase_masterId,purchase_master.datePurchaseDate,"
					+ "purchase_master.inttotalbillamount FROM purchase_master where "
					+ "purchase_master.intdealerid="+ubrandid+" AND purchase_master.varinvoiceno='"+uinvno+"'";
			List qlist0=gd.getData(query0);
			if(!qlist0.isEmpty())
			{
				Iterator qitr0=qlist0.iterator();
				String pmid=qitr0.next().toString();
				String dop=qitr0.next().toString();
				String billamt=qitr0.next().toString();
			
			
			
			String query1="SELECT model_details_master.aliasnamemodel FROM purchase_master_details,"
					+ "purchase_master,model_details_master WHERE model_details_master.intmodelid="
					+ "purchase_master_details.intmodelId AND purchase_master_details.intpurchase_masterId"
					+ "=purchase_master.intpurchase_masterId AND"
					+ " purchase_master.varinvoiceno='"+uinvno+"' and purchase_master.intdealerid="+ubrandid;
				List qlist1=gd.getData(query1);
				out.print(uinvno+",");
				Iterator itr1=qlist1.iterator();
				while(itr1.hasNext())
				{
					String modelName=itr1.next().toString();
					String query2="SELECT purchase_details.intpurchase_detailsId,purchase_details.varimeino1 FROM purchase_details,purchase_master_details, "
							+ "purchase_master,model_details_master WHERE purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId"
							+ " and purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId "
							+ "and purchase_master_details.intmodelId=model_details_master.intmodelid and "
							+ "model_details_master.aliasnamemodel='"+modelName+"' and purchase_master.varinvoiceno='"+uinvno+"' and purchase_details.intsalestatus=0";
					List qlist2=gd.getData(query2);
					Iterator qitr2=qlist2.iterator();
					out.println(modelName+"#");
					while(qitr2.hasNext())
					{
						out.print(qitr2.next()+"-"+qitr2.next()+"-");
					}
					out.println("?");
				}
				out.println(","+dop+","+billamt+","+pmid);
				
			}

		}
		//validation of invoice
		if(request.getParameter("validateInvoiceNo")!=null)
		{
			GenericDAO gd=new GenericDAO();
			String dealerId=request.getParameter("statusbrid");
			String invoiceNo=request.getParameter("validateInvoiceNo");
			List demolist=gd.getData("SELECT varinvoiceno FROM purchase_master WHERE intdealerid="+dealerId);
			Iterator itrino=demolist.iterator();
			while(itrino.hasNext())
			{	
				String s=itrino.next().toString();
				if(s.equals(invoiceNo))
				{
					out.println("1");
				}
			}
			
		}
		
		//validation of imei
		if(request.getParameter("validate")!=null)
		{
			GenericDAO gd=new GenericDAO();
			String checkimeistatus=request.getParameter("validate");
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
		
		//inserting area of code
		if(request.getParameter("puresubmit")!=null)
		{
			
			try{
			String dealerId=request.getParameter("dealerId");
			String totalBillAmount=request.getParameter("totalBillAmount");
			String parameter = request.getParameter("purchasedate");
			SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
			Date date;
				date = in.parse(parameter);
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			int loopNumber=Integer.parseInt(request.getParameter("loopNumber"));
			String billNo=request.getParameter("billNo");
			String[] mod=new String[loopNumber];
			String[] col=new String[loopNumber];
			String[] hsnsac=new String[loopNumber];
			
			String model[] = new String[loopNumber];
			String totalImei[] = new String[loopNumber];
			String price[] = new String[loopNumber];
			
			List getPMDId;
			int incrementer;
			boolean checkImeiStatus;
			GenericDAO gd=new GenericDAO();
			UpdateData ud=new UpdateData();
			//context parameter object
			
			
			for(int i=0;i<loopNumber;i++)
			{
				String demo = request.getParameter("mod"+i+"");
				String delims = "[,]";
				String[] finaltoken = demo.split(delims);
				mod[i]=finaltoken[0];
				col[i]=finaltoken[1];
			}
			for(int i=0;i<loopNumber;i++)
			{
				hsnsac[i]=request.getParameter("hsnSac"+i+"");
			}
			for(int i=0;i<loopNumber;i++)
			{
				model[i]=request.getParameter("tmodel"+i+"");
			}
			for(int i=0;i<loopNumber;i++)
			{
				totalImei[i]=request.getParameter("timei"+i+"");
			}
			for(int i=0;i<loopNumber;i++)
			{
				price[i]=request.getParameter("rateToSale"+i+"");
			}
			// to check for imei duplicacy
			//first query no need in loop coz its one time----
			String pm="INSERT INTO purchase_master (intdealerid,varinvoiceno,datePurchaseDate,inttotalbillamount) VALUES("+dealerId+",'"+billNo+"','"+fmt.format(date)+"',"+totalBillAmount+")";
			int firstquerystatus=gd.executeCommand(pm);
			System.out.println("in query "+firstquerystatus+"-----");
			if(firstquerystatus!=0)
			{
				String forpmdid="SELECT max(purchase_master.intpurchase_masterId) FROM purchase_master";
				List demoid2=gd.getData(forpmdid);
				Iterator itr2=demoid2.iterator();
				int pmid=0;
				while(itr2.hasNext())
				pmid=Integer.parseInt(itr2.next().toString());
				
				String forremainingamount="select totalremaining from dealer_payment_master where intdealer_payment_id=(SELECT max(intdealer_payment_id) from dealer_payment_master where intdealerid="+dealerId+");";
				
				if(gd.getData(forremainingamount)!=null)
				{
				double totalremainingamount=Double.parseDouble(gd.getData(forremainingamount).get(0).toString());
				totalremainingamount+=Double.parseDouble(totalBillAmount.toString());
				String inserttodpm="INSERT INTO `dealer_payment_master`(`intdealerid`, `intpurchase_masterId`, `intbillamount`, `datetransactiondate`, `totalremaining`) VALUES ("+dealerId+","+pmid+","+totalBillAmount+",'"+fmt.format(date)+"',"+totalremainingamount+")";
				int getexecutestatus=gd.executeCommand(inserttodpm);
				if(getexecutestatus!=0)
				{
					System.out.print("successfull insert into dealer payment master");
				}
				}else
				{
					request.setAttribute("status", "total remaining is null");
					RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/purchase/newMobilePurchase2.jsp?dealerId="+dealerId);
					rd.forward(request, response);
				}
				
			}
			if(dealerId!=null&&!(loopNumber==0) && billNo!=null)
			{
				if(dealerId!=null&&!(loopNumber==0) && billNo!=null)
				{
					
						for(int bigLoop=0;bigLoop<loopNumber;bigLoop++)
						{
							//second query
							System.out.println("2nd query");
							List getPMId=gd.getData("SELECT MAX(intpurchase_masterId) FROM `purchase_master` WHERE intdealerid='"+dealerId+"'");
							//for quantity of numbers of imei
							
							String demoImei = totalImei[bigLoop];
							String delims = "[,]";
							String[] finalImeiNumbers = demoImei.split(delims);
							//dont check this
							
								String pmd="INSERT INTO `purchase_master_details`(`intpurchase_masterId`, `hsnsacno`, `intmodelId`, `intcolorId`, `intqty`, `varratetosale`) VALUES ("+getPMId.get(0)+",'"+hsnsac[bigLoop]+"',"+mod[bigLoop]+","+col[bigLoop]+","+finalImeiNumbers.length+","+price[bigLoop]+")";
								gd.executeCommand(pmd);
								
								//to push entry in Stock to Update
								
								int brandId=Integer.parseInt(gd.getData("SELECT brand_master.intbrandid FROM brand_master, model_details_master "
										+ "WHERE brand_master.intbrandid=model_details_master.intbrandid AND"
										+ " model_details_master.intmodelid="+mod[bigLoop]).get(0).toString());
									
									boolean getstatus=ud.updateStockMaster(brandId, mod[bigLoop], col[bigLoop], finalImeiNumbers.length);
									if(getstatus)
										System.out.println("stock updated successfully");
									else
										out.print("Stock not updated successfully");
								//third query
								
								getPMDId= gd.getData("SELECT MAX(`intpurchase_master_detailsId`) FROM `purchase_master_details` WHERE purchase_master_details.intmodelId='"+mod[bigLoop]+"'");
								
								String pd;
								//for incrementing in pushing imei numbers so that every time we could get different PMDId.
								Iterator itr3=getPMDId.iterator();
								int pmdid=0;
								while(itr3.hasNext())
								pmdid=Integer.parseInt(itr3.next().toString());
								
								for(int i=0;i<finalImeiNumbers.length;i++)
								{
									pd="INSERT INTO `purchase_details`( `intpurchase_master_detailsId`, `varimeino1`) VALUES ("+pmdid+","+finalImeiNumbers[i]+")";
									gd.executeCommand(pd);
								}
								
						}
						
					
					
				}else
				{
					out.print("something wrong with data entered in purchase.java");
				}

				System.out.println("7 above script");
				
				
			}else
			{
				out.print("something wrong with data entered in purchase.java");
			}
		
//			response.sendRedirect("/MSaleERP/jsp/admin/purchase/mobilePurchase.jsp?brandId="+brandId+"");
			request.setAttribute("status", "Imei Inserted Successfully");
			RequestDispatcher rd=request.getRequestDispatcher("jsp/admin/purchase/newMobilePurchase2.jsp?dealerId="+dealerId);
			rd.forward(request, response);
			
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
//		try{
//			
//		String brandId=request.getParameter("brandId");
//		String totalBillAmount=request.getParameter("totalBillAmount");
//		String parameter = request.getParameter("purchasedate");
//		SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
//		Date date;
//			date = in.parse(parameter);
//			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
//		int loopNumber=Integer.parseInt(request.getParameter("loopNumber"));
//		String billNo=request.getParameter("billNo");
//		String[] mod=new String[loopNumber];
//		String[] col=new String[loopNumber];
//		String[] hsnsac=new String[loopNumber];
//		
//		String model[] = new String[loopNumber];
//		String totalImei[] = new String[loopNumber];
//		String price[] = new String[loopNumber];
		
//		
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
		}
	}
	

}
