package servletStore.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.SysDate;

public class PurchaseReport extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try
		{
			SysDate date=new SysDate();
			response.setContentType("application/vnd.ms-excel");
	    	response.setHeader("Content-Disposition", "inline; filename="+"Purchase"+"Report("+date.todayDate()+" "+date.currentTime()+").xls");
	    	
	    	PrintWriter out=response.getWriter();
	    	GenericDAO dao=new GenericDAO();
	    	
	    	String toDate = request.getParameter("toDate");
			String fromDate = request.getParameter("fromDate");
			
	    	out.print("<style>table {border-collapse: collapse;}table, th, td {border: 1px solid black;} th{background-color:	#A9A9A9;}</style>");
	    	
	     	out.print("<table>");
	    	out.print("<thead>");
	    	
	    	out.print("<th>INVOICE NO</th>");
	    	out.print("<th>MODEL NAME</th>");
	    	out.print("<th>IMEI</th>");
	    	out.print("<th>DATE</th>");
	    	out.print("<th>BILL AMOUNT</th>");
	    	
	    	out.print("</thead>");
	    	out.print("<tbody>");
	    	
	    	String query="SELECT purchase_master.varinvoiceno,model_details_master.aliasnamemodel,purchase_details.varimeino1,purchase_master.datePurchaseDate,purchase_master.inttotalbillamount FROM purchase_details,purchase_master_details,model_details_master,purchase_master WHERE   purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId and purchase_master_details.intmodelId=model_details_master.intmodelid and purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId AND purchase_master.datePurchaseDate BETWEEN '"+toDate+"' AND '"+fromDate+"'";
        	ResultSet rs1 = dao.getDataRs(query);

        	while(rs1.next()){
        		out.println("<tr>");
				out.println("<td>"+rs1.getString(1)+"</td><td>"+rs1.getString(2)+"</td><td>"+rs1.getString(3)+"</td><td>"+rs1.getString(4)+"</td><td>"+rs1.getString(5)+"</td>");
				out.println("</tr>");	
        	}
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage()+new Date()+" in all report msale servlet ");
		}	
	}
}