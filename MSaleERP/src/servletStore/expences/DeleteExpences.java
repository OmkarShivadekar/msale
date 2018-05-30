package servletStore.expences;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;


public class DeleteExpences extends HttpServlet {
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out=response.getWriter();
		
		GenericDAO gd=new GenericDAO();
		
		String exp_id=request.getParameter("exp_id");
		
		String query="Delete from exp_master where intexp_id='"+exp_id+"';";
		
		if(gd.executeCommand(query)==1)
		{
			request.setAttribute("status1", "Expense Deleted Succesfully");		
		}
		else{
			request.setAttribute("status1", "Expense Delete Fail");
		}
		RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/settings/expences.jsp");
		rd.include(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}