package servletStore.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Statement;

import dao.General.GenericDAO;


@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter out=response.getWriter();
		GenericDAO dao=new GenericDAO();
		try
		{  
			List list=new ArrayList();
			String query = (String)request.getParameter("search_txt");
			if(query!=""){
				String qry="select brand from brand_master";
				list=dao.getDataList(qry);
			}
			    
		       Iterator itr=list.iterator();
		       int i=list.size();
		    //   System.out.println("***********"+i);
	            String str[]=new String[i];
	            
	            int k=0;
				while(itr.hasNext())
				{
					String p =itr.next().toString();	
					str[k]=p;
					k++;
				}
				
					
				//jQuery related start		
				
					out.print("<datalist id='list1'>"); 
					for(int j=0;j<str.length;j++)
					{
						
							out.print("<option value='"+str[j]+"'>");
					}
					out.print("</datalist>"); 
				//jQuery related end	    			
			    } 
			catch(Exception e){ 
	 			e.printStackTrace(); 
	 		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
	
	}

}
