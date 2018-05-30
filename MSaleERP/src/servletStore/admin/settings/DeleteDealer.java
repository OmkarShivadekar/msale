package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class DeleteDealer extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter out = response.getWriter();
		
		GenericDAO gd=new GenericDAO();
		int flag=0;
		
		String dealerid = request.getParameter("dealerid");
		String deletebrandname = request.getParameter("deletebrandname");
		
		
		String query1="delete from dealer_master where intdealerid='"+dealerid+"';";
		
		int status = gd.executeCommand(query1);
		
		if (status==1) 
		{
			
			request.setAttribute("status1", "Dealer Deleted Successfully");
		}
		else
		{
			request.setAttribute("error", "3");
			flag=3;
		}
		
		if(flag==3) {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp?error=3");
			rd.forward(request, response);
		}
		else{	
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException	{	
	}
}