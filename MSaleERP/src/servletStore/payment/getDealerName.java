package servletStore.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class getDealerName extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		GenericDAO dao=new GenericDAO();
		
		response.setContentType("text/html");
    	PrintWriter out=response.getWriter();
    	
    	String dealerid = request.getParameter("dealerid");
    	
    	
		
    	String qry="select vardealername from dealer_master where intdealerid="+dealerid+";";
    	System.out.println(qry);
		List list=dao.getDataList(qry);
		System.out.println("Dealer=>>"+list);
		Iterator itr=list.iterator();
	       int i=list.size();
				
	       while(itr.hasNext()){  
	    	   out.print(itr.next());  
	       } 		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
