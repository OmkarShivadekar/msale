package servletStore.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class GoToUserAction extends HttpServlet
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	   PrintWriter out=response.getWriter();
	   
	   GenericDAO gd=new GenericDAO();
	   
	   String query = "select * from user_master where introll=1";
	   List list= gd.getData(query);
	   System.out.println("List is==> "+list);
	   
	   if(!list.isEmpty())
	   {
		   System.out.println("In IF LOOP");
		   RequestDispatcher rd=request.getRequestDispatcher("jsp/common/login.jsp");
		   rd.forward(request, response);
	   }
	   else
	   {
		   System.out.println("In ELSE LOOP");
		   request.setAttribute("expires", "true");
		   RequestDispatcher rd=request.getRequestDispatcher("jsp/common/login.jsp");
		   rd.forward(request, response);
		   
	   }
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

}
