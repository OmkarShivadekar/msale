package servletStore.report;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import utility.SysDate;

public class Report extends HttpServlet {


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
        	response.setHeader("Content-Disposition", "inline; filename="+"Sale_"+"Report("+date.todayDate()+" "+date.currentTime()+").xls");
        	
        	PrintWriter out=response.getWriter();
    	 	
    	 	GenericDAO dao=new GenericDAO();
    	 	
    	 	out.print("<style>table {border-collapse: collapse;}table, th, td {border: 1px solid black;} th{background-color:	#A9A9A9;}</style>");
        	
    	 	out.print("<table>");
        	out.print("<thead>");
        	
        	out.print("<th>ID</th>");
        	out.print("<th>CUSTOMER NAME</th>");
        	out.print("<th>ADDRESS</th>");
        	out.print("<th>CONTACT NO</th>");
        	out.print("<th>SALEDATE</th>");
        	
        	out.print("<th>MODEL NAME</th>");
        	out.print("<th>IMEI NO1</th>");
        	out.print("<th>IMEI NO2</th>");
        	out.print("<th>BATTERY NO</th>");
        	
        	out.print("<th>CHARGER NO</th>");
        	out.print("<th>CUSTOMER GSTIN</th>");
        	out.print("<th>SALE PRICE</th>");
        	out.print("<th>TAXABLE VALUE</th>");
        	out.print("<th>CGST</th>");
        	out.print("<th>SGST</th>");
        	
        	out.print("<th>HSNSACNO</th>");
        	out.print("<th>SERIAL NO</th>");
        	
        	out.print("</thead>");
        	out.print("<tbody>");
       
        	//String query="SELECT * FROM dummy where varsaledate>='"+toDate+"' and varsaledate<='"+fromDate+"'";
        	String query="SELECT m.`intmobilesaleid`,c.`varcustname`,c.`varaddress`,c.`varcontactno`,m.`datesaledate`,md.`aliasnamemodel`,m.`varimeino1`,m.varimeino2,m.`varbatteryno`,m.`varchargerno`,m.`intsaleprice`,c.`varcustgstin`,m.`intcustdiscount`,m.varhhsnsacno,m.varserialno FROM mobilesale_master m INNER JOIN customer_master c ON m.intcustid=c.intcustid INNER JOIN model_details_master md on m.intmodelid=md.intmodelid where m.`datesaledate` BETWEEN '"+toDate+"' AND '"+fromDate+"'";
        	//System.out.println(query);
        	ResultSet rs1 = dao.getDataRs(query);	
        	int i =1;
        	while(rs1.next()){
        		//System.out.println(rs1.getString(11));
        		double actualPrice=Double.parseDouble(rs1.getString(11));
        		double totalGstAmt=(actualPrice*12)/112;
        		double taxableAmt=actualPrice-totalGstAmt;
        		taxableAmt=Math.round(taxableAmt*100.0)/100.0;
        		
        		double cgst=taxableAmt*0.06;
        		cgst=Math.round(cgst*100.0)/100.0;
        		System.out.println(cgst);
        		//System.out.println("12 "+rs1.getString(12)+" 13 "+rs1.getString(13));
        		//System.out.println("taxValue "+taxableAmt+" gst "+cgst);
        		
        		out.println("<tr>");
				out.println("<td>"+rs1.getString(1)+"</td>"
						+ "<td>"+rs1.getString(2)+"</td>"
						+ "<td>"+rs1.getString(3)+"</td>"
						+ "<td>"+rs1.getString(4)+"</td>"
						+ "<td>"+rs1.getString(5)+"</td>"
						+ "<td>"+rs1.getString(6)+"</td>"
						+ "<td>"+rs1.getString(7)+"</td>"
						+ "<td>"+rs1.getString(8)+"</td>"
						+ "<td>"+rs1.getString(9)+"</td>"
						+ "<td>"+rs1.getString(10)+"</td>"
						+ "<td>"+rs1.getString(12)+"</td>"
						+ "<td>"+rs1.getString(11)+"</td>"
						+ "<td>"+taxableAmt+"</td>"
						+ "<td>"+cgst+"</td>"
						+ "<td>"+cgst+"</td>"
						+ "<td>"+rs1.getString(14)+"</td>"
						+ "<td>"+rs1.getString(15)+"</td>");
				
				out.println("</tr>");
				i++;
        	}	
		}
		catch(Exception ex){
			System.out.println(ex.getMessage()+new Date()+" in all report msale servlet ");
		}
	}
}