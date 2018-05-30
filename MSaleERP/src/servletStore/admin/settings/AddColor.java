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

import dao.General.GenericDAO;


public class AddColor extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		GenericDAO da = new GenericDAO();
		
		String colorname = request.getParameter("colorname");
		String updatecolorid = "";//request.getSession().getAttribute("sessionId").toString();
		String colorid=request.getParameter("update");
		String colorDetele=request.getParameter("delete");
		String ucolor = request.getParameter("ucolorname");
		String updatecolor = request.getParameter("updateColorId");

		
		
		String modelpage="";
		
		if(request.getParameter("addmodalpage")!=null){
			modelpage = request.getParameter("addmodalpage");
		}
		
		
		//String name=request.getParameter("name");
		
		PrintWriter out = response.getWriter();
		
		//out.write(brandid);
		//out.write(colorDetele);
		
		List checkColor = null;
		if (colorname != null) 
		{
			String query = "SELECT `varcolorname` FROM `color_master` WHERE `varcolorname`='" + colorname + "'";
			checkColor = da.getData(query);
		}
		
		List checkColor1 = null;
		if (ucolor != null) 
		{
			String query = "SELECT `varcolorname` FROM `color_master` WHERE `varcolorname`='" + ucolor + "'";
			checkColor = da.getData(query);
		}
		
		if (colorid==null && colorDetele==null) 
		{
			if (checkColor.isEmpty()) 
			{
				String query= "INSERT INTO color_master (varcolorname) VALUES('"+colorname+"') ";
				int a=	da.executeCommand(query);
				
				if(a==1)
			      {
					 if(modelpage.equals("addmodalpage")){
						  request.setAttribute("status1", " Color Added Succesfully");
				    	  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
				    	  rd.forward(request, response);
					 }
					 else
					 {
						 request.setAttribute("status1", " Color Added Succesfully");
						 RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addColor.jsp");
				    	 rd.forward(request, response);
					 }
			      }
		      }
			  else{
				  
				  
				  if(modelpage.equals("addmodalpage"))
		    	  {
					  request.setAttribute("error", "4");
			    	  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
			    	  rd.forward(request, response);
		    	  }
		    	  else
		    	  {
		    		  request.setAttribute("error", "4");
		    		  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addColor.jsp");
			    	  rd.forward(request, response);
		    	  }
				  
				  
			  }
		}
		else if (colorDetele==null) 
		{
			
			if (checkColor.isEmpty()) 
			{
				String query= "UPDATE `color_master` SET `varcolorname`='"+ucolor+"' WHERE `intcolorid`='"+updatecolor+"'";
				
				int a=	da.executeCommand(query);
				
				 if(a==1)
			      {
					 request.setAttribute("status1", " Color Updated Succesfully");
			      }
				 else{
					 System.out.println(updatecolorid + ucolor);
				 }
		    	  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addColor.jsp");
		    	  rd.forward(request, response);
			}
			else{
				  request.setAttribute("error", "4");
				  
				  if(modelpage.equals("addmodalpage"))
		    	  {
			    	  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
			    	  rd.forward(request, response);
		    	  }
		    	  else
		    	  {
		    		  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addColor.jsp");
			    	  rd.forward(request, response);
		    	  }
				  
				  
			  }
		}
		else 
		{
			
			String query= "DELETE FROM `color_master` WHERE `intcolorid`='"+colorDetele+"'";
	
			int a=da.executeCommand(query);
			
			if(a==1)
		      {
				  request.setAttribute("status1", " Color Deleted Succesfully");
		    	  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addColor.jsp");
		    	  rd.forward(request, response);
		      }
		      else
		      {
		    	  request.setAttribute("error", "3");
		    	  RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addColor.jsp");
		    	  rd.forward(request, response);
		      }
		}
		
		
	}

}
