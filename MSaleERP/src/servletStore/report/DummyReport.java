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

public class DummyReport extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		try{
			String toDate = request.getParameter("toDate");
			String fromDate = request.getParameter("fromDate");
			
			SysDate date=new SysDate();
			
			response.setContentType("application/vnd.ms-excel");
        	response.setHeader("Content-Disposition", "inline; filename="+"All_Records_"+"Report("+date.todayDate()+" "+date.currentTime()+").xls");
        	
        	PrintWriter out=response.getWriter();
    	 	
        	
    	 	GenericDAO dao=new GenericDAO();
    	 	
    	 	out.print("<style>table {border-collapse: collapse;}table, th, td {border: 1px solid black;} th{background-color:	#A9A9A9;}</style>");
        	
    	 	out.print("<table>");
        	out.print("<thead>");
        	
        	out.print("<th>INVOICE NO</th>");
        	out.print("<th>CUSTOMER NAME</th>");
        	out.print("<th>ADDRESS</th>");
        	out.print("<th>CONTACT NO</th>");
        	out.print("<th>SALEDATE</th>");
        	
        	out.print("<th>MODEL NAME</th>");
        	out.print("<th>IMEI NO1</th>");
        	out.print("<th>IMEI NO2</th>");
        	out.print("<th>BATTERY NO</th>");
        	
        	out.print("<th>CHARGER NO</th>");
        	out.print("<th>SALE PRICE</th>");
        	out.print("<th>CGST</th>");
        	out.print("<th>SGST</th>");
        	out.print("<th>TAXABLE AMOUNT</th>");
        	out.print("<th>DISCOUNT</th>");
        	
        	out.print("<th>HSNSACNO</th>");
        	out.print("<th>SERIAL NO</th>");
        	
        	out.print("</thead>");
        	out.print("<tbody>");
       
        	//String query="SELECT * FROM dummy where varsaledate>='"+toDate+"' and varsaledate<='"+fromDate+"'";
        	String query1="SELECT * from dummy WHERE varsaledate BETWEEN '"+toDate+"' AND '"+fromDate+"'";
        	ResultSet rs1 = dao.getDataRs(query1);	
        	int i =1;
        	while(rs1.next()){
        		String sp = rs1.getString(12);
        		
        		double salePrice=0.0;
        		
        		if(sp.equals("-")){
        			salePrice=0.0;
        		}else{
        			salePrice = Double.parseDouble(rs1.getString(12));
        		}
        		
        		double gst = (salePrice*12)/112;
        		double cgst=gst/2.0;
        		double taxableValue= salePrice-gst;
        		
        		String discount = rs1.getString(13);
        		
        		if(discount==null){
        			discount="-";
        		}
        		
        		out.println("<tr>");
				out.println("<td>"+rs1.getString(1)+"</td><td>"+rs1.getString(2)+"</td><td>"+rs1.getString(3)+"</td><td>"+rs1.getString(4)+"</td>"
						+ "<td>"+rs1.getString(6)+"</td><td>"+rs1.getString(7)+"</td>"
						+ "<td>"+rs1.getString(8)+"</td><td>"+rs1.getString(9)+"</td><td>"+rs1.getString(10)+"</td>"
						+ "<td>"+rs1.getString(11)+"</td>"+ "<td>"+rs1.getString(12)+"</td>"+ "<td>"+gst/2+"</td>" + "<td>"+gst/2+"</td>"
						+ "<td>"+ taxableValue +"</td> <td>"+discount+"</td>" + "<td>"+rs1.getString(14)+"</td>" + "<td>"+rs1.getString(15)+"</td>");
				
				out.println("</tr>");
				i++;
        	}
        	
		}
		catch(Exception ex){
			System.out.println(ex.getMessage()+new Date()+" in all report msale servlet ");
		}

		
	}

}
