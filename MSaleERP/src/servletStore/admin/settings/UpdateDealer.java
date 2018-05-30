package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;


public class UpdateDealer extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		PrintWriter out = response.getWriter();
		GenericDAO gd=new GenericDAO();
		
		String dealerName = request.getParameter("update_dealer_name");
		String contactNo = request.getParameter("update_contact_no");
		String emailId = request.getParameter("update_email_id");
		String brandid = request.getParameter("update_brand");
		String organizationName = request.getParameter("update_organization_name"); 
		String id = request.getSession().getAttribute("sessionId").toString();
		
		String query = "UPDATE msale.dealer_master SET vardealername='"+dealerName+"', varcontactNo='"+contactNo+ "', varemailId='"+emailId+ "', varorganizationname='"+organizationName+"'  WHERE intdealerid='"+id+"';";
		
		int status =gd.executeCommand(query);
		
		 if(status==1)
	      {
				request.setAttribute("status1", "Dealer Updated Successfully");
				RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
		    	rd.forward(request, response);
	      }
	}
}