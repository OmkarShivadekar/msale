package servletStore.common;

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

public class searchCustomer extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		GenericDAO gd=new GenericDAO();
		
		response.setContentType("text/html");
    	PrintWriter out=response.getWriter();
    	
    	String customername = request.getParameter("customername");
//    	out.print(customername);
    	
    	
    	String query="SELECT customer_master.varcustname, mobilesale_master.intmobilesaleid, mobilesale_master.datesaledate, mobilesale_master.intsaleprice from msale.customer_master, msale.mobilesale_master where customer_master.intcustid=mobilesale_master.intcustid and customer_master.varcustname like '"+customername+"%'";
		
    	System.out.println(query);
		List list=gd.getData(query);
		
		if(list.isEmpty()){
			out.println("<h1 style=\" font-size: 13px; color: red;\">Record Not Found</h1>");
		}
		Iterator itr=list.iterator();
		
		int i=1;
		while(itr.hasNext())
		{			
			Object custname=itr.next();
			Object mobilesaleid=itr.next();
			Object saledate=itr.next();
			Object saleprice=itr.next();
			out.print("<tr><td>"+(i++)+"</td><td>"+custname+
					  "</td><td>"+mobilesaleid+"</td><td>"+saledate+"</td><td>"+saleprice+"</td><td><a href='#update' data-toggle='modal'  onclick='getSr("+mobilesaleid+")'>View Details</a></td></tr>");
		
			//	+ "<a href='#update' data-toggle='modal' onclick='updateModel("+modelIdLoop+")'>Update</a></td></tr>");
			//	<td> <a href="#update" data-toggle="modal"  onclick="getSr(<%=invoice_no%>)">View Details</a></td> 
		}
			
	}
}