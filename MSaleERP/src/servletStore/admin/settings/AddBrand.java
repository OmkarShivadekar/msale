package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.General.GenericDAO;
import utility.RequireData;

public class AddBrand extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/html");

		String printenable = "";

		GenericDAO da = new GenericDAO();

		String brandid = request.getParameter("update");
		String brandDetele = request.getParameter("delete");
		String sourcepage="";
		
		if(request.getParameter("dealerpage")!=null){
			sourcepage = request.getParameter("dealerpage");
		}
		String brandname = request.getParameter("brandname");
		String dealerid = request.getParameter("dealer");
		
		if(brandname!=null){
			brandname.trim();
		}
		

			PrintWriter out = response.getWriter();

			List checkBrand = null;
			if (brandname != null) 
			{
				String query = "SELECT `varbrandname` FROM `brand_master` WHERE `varbrandname`='" + brandname + "' and brand_master.intbrandid<>"+brandid;
				checkBrand = da.getData(query);
			}

			if (brandid == null && brandDetele == null) 
			{

				if (checkBrand.isEmpty()) 
				{
					char x= brandname.charAt(0);
					if(x==' ')
					{
						brandname=null;
						System.out.println("Sarang");
						if(sourcepage.equals("dealerpage"))
						 {
							 request.setAttribute("status1", "Please enter Correct Brand Name");
							 RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
							 rd.forward(request, response);
							 
						 }
						else if(sourcepage.equals("modelpage")) 
						{
							request.setAttribute("status1", "Please enter Correct Brand Name");
							RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
							rd.forward(request, response);
						}
						else
						{
							request.setAttribute("status1", "Please enter Correct Brand Name");
							RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
							rd.forward(request, response);
						}
					}
					else{
					String query1 = "INSERT INTO brand_master (varbrandname, intdealerid) VALUES('" + brandname + "', '" + dealerid + "') ";
					int a1 = da.executeCommand(query1);
					if (a1 == 1) 
					{
						if(sourcepage.equals("dealerpage"))
						 {
							 request.setAttribute("status1", "New Brand added Succesfully");
							 RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
							 rd.forward(request, response);
							 
						 }
						else if(sourcepage.equals("modelpage")) 
						{
							request.setAttribute("status1", "New Brand added Succesfully");
							RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
							rd.forward(request, response);
						}
						else
						{
							request.setAttribute("status1", "New Brand added Succesfully");
							RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
							rd.forward(request, response);
						}			
					} 
					else 
					{
						out.write("something wrong.....");
					}
					}
				} 
				else 
				{
//					out.println("<script type=\"text/javascript\">");  
//					out.println("alert('Brand already exists.....');");  
//					out.println("</script>");
					
					
					request.setAttribute("error", "2");
					if(sourcepage.equals("dealerpage"))
					 {
						 RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
						 rd.forward(request, response);
						 
					 }
					else if(sourcepage.equals("modelpage")) 
					{
						RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
						rd.forward(request, response);
					}
					else
					{
						RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
						rd.forward(request, response);
					}
			
				}

			}
			else if (brandDetele == null) 
			{
				if (checkBrand.isEmpty()) 
				{
					char x= brandname.charAt(0);
					if(x==' '){
						brandname=null;
						System.out.println("Sarang");
						if(sourcepage.equals("dealerpage"))
						 {
							 request.setAttribute("status1", "Please enter Correct Brand Name");
							 RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
							 rd.forward(request, response);
							 
						 }
						else if(sourcepage.equals("modelpage")) 
						{
							request.setAttribute("status1", "Please enter Correct Brand Name");
							RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
							rd.forward(request, response);
						}
						else
						{
							request.setAttribute("status1", "Please enter Correct Brand Name");
							RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
							rd.forward(request, response);
						}
					}
					else{
						
					String did = request.getParameter("update_Dealer");	
					String query = "UPDATE `brand_master` SET `varbrandname`='" + brandname + "', intdealerid="+did+" WHERE `intbrandid`=" + brandid;
					int a = da.executeCommand(query);
					if (a == 1) 
					{
						request.setAttribute("status1", "Brand Updated Succesfully");
						RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
						rd.forward(request, response);
					}
					else 
					{
						out.write("something wrong.....");
					}
					}
				} 
				else 
				{
//					out.println("<script type=\"text/javascript\">");  
//					out.println("alert('Brand already exists.....');");  
//					out.println("</script>");
					request.setAttribute("error", "2");
					
					if(sourcepage.equals("dealerpage"))
					 {
						 RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
						 rd.forward(request, response);
						 
					 }
					else{
						RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
						rd.forward(request, response);
					}
					

				}
			} 
			else 
			{
				String query = "DELETE FROM `brand_master` WHERE `intbrandid`=" + brandDetele;
				int a = da.executeCommand(query);
				if (a == 1) 
				{
					request.setAttribute("status1", " Brand Deleted Succesfully");
					RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
					rd.forward(request, response);
				} 
				else 
				{
					request.setAttribute("error", "3");
					RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
					rd.forward(request, response);
					//out.write("something wrong in delete.....");

				}
			}
		
		


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
