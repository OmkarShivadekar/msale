package servletStore.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.SysDate;

public class BrandwiseReport extends HttpServlet {
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		try{
			String start_date = request.getParameter("toDate");
			String end_date = request.getParameter("fromDate");
			String brandname = request.getParameter("brandname");
			
			SysDate date=new SysDate();
			
			response.setContentType("application/vnd.ms-excel");
        	response.setHeader("Content-Disposition", "inline; filename="+"Brand_"+"Report("+date.todayDate()+" "+date.currentTime()+").xls");
        	
        	PrintWriter out=response.getWriter();
        	
    	 	GenericDAO dao=new GenericDAO();
    	 	
    	 	out.print("<style>table {border-collapse: collapse;}table, th, td {border: 1px solid black;} th{background-color:	#A9A9A9;}</style>");
        	
    	 	out.print("<table>");
        	out.print("<thead>");
        	
        	out.print("<th>NO</th>");
        	out.print("<th>SALE DATE</th>");
        	out.print("<th>CUSTOMER NAME</th>");
        	out.print("<th>CONTACT NO</th>");        	
        	out.print("<th>MODEL NAME</th>");
        	out.print("<th>MODEL ALIAS NAME</th>");
        	out.print("<th>SALE PRICE</th>");
        	out.print("<th>IMEI NO</th>");
        	
        	out.print("</thead>");
        	out.print("<tbody>");
       
        	String query="SELECT mobilesale_master.datesaledate, customer_master.varcustname, customer_master.varcontactno,"
        			+ " model_details_master.varmodel, model_details_master.aliasnamemodel, mobilesale_master.intsaleprice, mobilesale_master.varimeino1 "
        			+ " FROM mobilesale_master "
        			+ " INNER JOIN customer_master ON customer_master.intcustid=mobilesale_master.intcustid "
        			+ " INNER JOIN model_details_master ON model_details_master.intmodelid=mobilesale_master.intmodelid "
        			+ " WHERE model_details_master.intbrandid="+brandname+""
        			+ " AND mobilesale_master.datesaledate BETWEEN '"+start_date+"' AND '"+end_date+"' "
        			+ " ORDER BY mobilesale_master.datesaledate ASC";
        	
        	ResultSet rs1 = dao.getDataRs(query);	
        	int i =1;
        	while(rs1.next()){		
        		
        		out.println("<tr>");
        		out.println("<td>"+i+"</td>");
				out.println("<td>"+rs1.getString(1)+"</td>");
				out.println("<td>"+rs1.getString(2)+"</td>");
				out.println("<td>"+rs1.getString(3)+"</td>");
				out.println("<td>"+rs1.getString(4)+"</td>");
				out.println("<td>"+rs1.getString(5)+"</td>");
				out.println("<td>"+rs1.getString(6)+"</td>");
				out.println("<td>"+rs1.getString(7)+"</td>");
				
				out.println("</tr>");
				i++;
        	}
		}
		catch(Exception ex){
			System.out.println(ex.getMessage());
		}
	}
}