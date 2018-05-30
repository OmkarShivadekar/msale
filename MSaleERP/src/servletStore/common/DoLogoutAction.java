package servletStore.common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class DoLogoutAction extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		response.setContentType("Text/HTML");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("sAdmin")!=null)
		session.removeAttribute("sAdmin");
		session.removeAttribute("username");
		session.invalidate();
		
		RequestDispatcher rd= request.getRequestDispatcher("jsp/common/login.jsp");
	   	rd.forward(request, response);
	}

}
