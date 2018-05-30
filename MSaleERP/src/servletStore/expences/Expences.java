package servletStore.expences;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.General.GenericDAO;

public class Expences extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");			
		GenericDAO da = new GenericDAO();

		String date=request.getParameter("date");
		String amount=request.getParameter("amount");
		String to=request.getParameter("to");
		String reason=request.getParameter("reason");
				
		String str="insert into exp_master(`dateexpdate`,`intamount`,`varto`,`varreason`) values ('"+date+"','"+amount+"','"+to+"','"+reason+"')";
		if(da.executeCommand(str)==1)
			request.setAttribute("status1", "Expense Added Succesfully");
		else
			request.setAttribute("status1", "Expense Added Fail");
		RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/settings/expences.jsp");
		rd.include(request,response);
	}
}