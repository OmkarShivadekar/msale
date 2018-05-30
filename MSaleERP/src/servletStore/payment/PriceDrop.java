package servletStore.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

/**
 * Servlet implementation class PriceDrop
 */
//@WebServlet("/PriceDrop")
public class PriceDrop extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PriceDrop() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd=new GenericDAO();
		RequireData rd =new  RequireData();
		
		
		//for sending data to modal using AJAX
		if(request.getParameter("upid")!=null)
		{
			String id=request.getParameter("upid");
			List priceDropDetailsById=rd.getPriceDropDetailsById(id);
			Iterator itr=priceDropDetailsById.iterator();
			PrintWriter out1=response.getWriter();
			
			while(itr.hasNext())
			{
				out.print(itr.next()+",");
				out.print(itr.next()+",");
				out.print(itr.next()+",");
				out.print(itr.next()+",");
			}
			
			int cid=Integer.valueOf(id);
			List priceDropDetailsImei=rd.getPriceDropDetailsImei(cid);
			Iterator itr1=priceDropDetailsImei.iterator();
			
			while(itr1.hasNext())
			{
				out1.print(itr1.next()+"#");
			}
		}
		
		//for getting Rate To Sale from purchase master using AJAX
		if(request.getParameter("getPrice")!=null)
		{
			String id=request.getParameter("getPrice");
			
			String query="select varratetosale FROM purchase_master_details WHERE intmodelId='"+id+"' GROUP BY varratetosale";
			List getRateToSale=gd.getData(query);
			if(getRateToSale!=null)
			{
				Iterator itr=getRateToSale.iterator();
				while(itr.hasNext())
				{
					out.print(itr.next()+",");
				}
			}
			
			
			
		}
		
		if(request.getParameter("modalUpdate")!=null)
		{
			String mId=request.getParameter("mId");
			String mDate=request.getParameter("modalDate");
			int mAmt=Integer.parseInt(request.getParameter("modalAmt"));
			int status=0;
			
			String query="UPDATE price_drop_master SET price_drop_master.datepricedropdate='"+mDate+"',price_drop_master.intdropamount="+mAmt+" WHERE price_drop_master.intpdid='"+mId+"'";
			status=gd.executeCommand(query);	
			if(status==1)
			{
				request.setAttribute("status", "Updated Successfully");
				System.out.println("Updated Successfully");
				RequestDispatcher rd1=request.getRequestDispatcher("jsp/admin/payment/priceDrop.jsp?brandId=1");
				rd1.forward(request, response);
			}
			
		}
		
		
		if(request.getParameter("show")!=null)
		{
			
			String val=request.getParameter("mod");
			String brandid=request.getParameter("brandId");
			String dropAmt=request.getParameter("dropAmt");
			String para=request.getParameter("dropdate");
			String tqty=request.getParameter("totalqty");
			String avAmt=request.getParameter("avAmt");
			String dBy=request.getParameter("dBy");
			
			SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
			Date date = null;
			try {
				date = in.parse(para);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			
			
			String delims = "[,]";
			String[] finaltoken = val.split(delims);
			String modelid=finaltoken[0];
			
			//for showing imeino
			
				//out.write(modelid);
				String query="SELECT purchase_details.varimeino1 from purchase_details INNER JOIN purchase_master_details on purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId WHERE purchase_master_details.intmodelId="+modelid+" and purchase_details.intsalestatus=0";
				List imei=gd.getData(query);
				Iterator itr=imei.iterator();
				int total=Integer.parseInt(dropAmt)*imei.size();
				
				
				request.setAttribute("qty",imei.size());
				request.setAttribute("bid", brandid);
				request.setAttribute("modelname", val);
				request.setAttribute("imeino", imei);
				request.setAttribute("totalAmt", total);		
				request.setAttribute("av", avAmt);
				request.setAttribute("d", dBy);
				request.setAttribute("drop", dropAmt);
				
				
				if(imei.isEmpty())
				{
					request.setAttribute("status", "Data Unavailable");
					RequestDispatcher rqd = request.getRequestDispatcher("jsp/admin/payment/priceDrop.jsp?brandId="+brandid);
			  	  	rqd.include(request, response);
				}
				else
				{
					request.setAttribute("status", "Records Found");
					RequestDispatcher rqd = request.getRequestDispatcher("jsp/admin/payment/priceDrop.jsp?brandId="+brandid);
			  	  	rqd.include(request, response);
				}
				
		  	  	
			}
		
			//for insert data into database
			if(request.getParameter("submit")!=null)
			{
				
				String val=request.getParameter("mod");
				String brandid=request.getParameter("brandId");
				String dropAmt=request.getParameter("dropAmt");
				String para=request.getParameter("dropdate");
				String tqty=request.getParameter("totalqty");
				
				/*SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
				Date date = null;
				try {
					date = in.parse(para);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				*/
				
				String delims = "[,]";
				String[] finaltoken = val.split(delims);
				String modelid=finaltoken[0];
				//out.write("hello submit");
				String query="INSERT INTO price_drop_master (intbrandid,intmodelid,intdropamount,datepricedropdate,inttotalqty) VALUES("+brandid+","+modelid+","+dropAmt+",'"+para+"',"+tqty+")";
				String getid="SELECT MAX(`intpdid`) FROM `price_drop_master`";
				int getexecutestatus=gd.executeCommand(query);
				String pdid=gd.getData(getid).get(0).toString();
				
				if(getexecutestatus!=0)
				{
					System.out.println("insert successfully in price_drop_master");
				}
				
				int getexecutestatus1=0;    
				for(int i=1;i<=Integer.parseInt(tqty);i++)
				{
					request.getParameter("imei"+i);
					String query1="INSERT INTO pricedrop_detailsmaster (intpdid,varimeino)VALUES("+pdid+","+request.getParameter("imei"+i)+");";
					getexecutestatus1=gd.executeCommand(query1);
				}
				if(getexecutestatus1!=0)
				{
					System.out.println("insert successfully in price_drop_detailsmaster");
					//out.print("insert successfully in price_drop_detailsmaster");
					request.setAttribute("status", "Inserted Successfully");
					RequestDispatcher rqd = request.getRequestDispatcher("jsp/admin/payment/priceDrop.jsp?brandId="+brandid);
			  	  	rqd.include(request, response);
				}

				
			}
			
			if(request.getParameter("DeleteRec")!=null)
			{
				int status=0;
				String brandid=request.getParameter("brandId");
				String id=request.getParameter("checkTest");
				String query1="DELETE pricedrop_detailsmaster,price_drop_master FROM pricedrop_detailsmaster,price_drop_master WHERE pricedrop_detailsmaster.intpdid=price_drop_master.intpdid AND pricedrop_detailsmaster.intpdid='"+id+"'";
				status=gd.executeCommand(query1);
				if(status>0)
				{
					System.out.println("delete data");
					request.setAttribute("status", "Deleted Successfully");
					RequestDispatcher rd1=request.getRequestDispatcher("jsp/admin/payment/priceDrop.jsp?brandId="+brandid);
					rd1.forward(request, response);
				}
				
			}
			
			if(request.getParameter("print")!=null)
			{
				out.print("sdad");
			}
			
			
	
		
	}

}
