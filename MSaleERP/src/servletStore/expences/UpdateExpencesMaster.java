package servletStore.expences;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;


public class UpdateExpencesMaster extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		GenericDAO gd=new GenericDAO();
		
		String date=request.getParameter("date");
		String amount=request.getParameter("amount");
		String to=request.getParameter("to");
		String reason=request.getParameter("reason");
		String exp_id = request.getSession().getAttribute("sessionId").toString(); 
		System.out.println("expid "+exp_id+"id "+exp_id);
		
		String query="UPDATE exp_master SET `dateexpdate`='"+date+"', `intamount`='"+amount+"', `varto`='"+to+"', `varreason`='"+reason+"' WHERE `intexp_id`="+exp_id+";";
		if(gd.executeCommand(query)==1)
			request.setAttribute("status1", "Expense Updated Succesfully");
		else
			request.setAttribute("status1", "Expense Update Fail");
			
		RequestDispatcher rd=request.getRequestDispatcher("/jsp/admin/settings/expences.jsp");
		rd.include(request, response);		
	}
}