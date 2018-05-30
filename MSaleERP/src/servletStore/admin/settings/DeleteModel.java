package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.RequireData;
import dao.General.GenericDAO;


public class DeleteModel extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		int modelId=Integer.parseInt(request.getParameter("modelId"));
		if(modelId !=0)
			{
				GenericDAO gd=new GenericDAO();
				int success=gd.executeCommand("DELETE FROM model_details_master WHERE intmodelid='"+modelId+"'");
				if( success!=0)
				{
					RequestDispatcher rDis= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
		            rDis.forward(request, response);
				}
				else
				{
					request.setAttribute("error", "3");
					RequestDispatcher rDis= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
		            rDis.forward(request, response);	
				}
			}
		
	}

}
