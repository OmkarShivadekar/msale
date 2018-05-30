package servletStore.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class InsertChequeBook extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		
		GenericDAO gd=new GenericDAO();
		String deletechequeid = request.getParameter("deletechequeid");
		int flag = 0;
		String query1="delete from chequebook where intchequebookid='"+deletechequeid+"';";
		
		int status = gd.executeCommand(query1);
		
		if (status==1) 
		{
			System.out.println("delete ChequeBook success");
		}
		else
		{
			System.out.println("delete ChequeBook fail");
			flag=2;
		}
		
		if(flag==2)
		{
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/ChequeBook.jsp?error=2");
			rd.forward(request, response);
		}
		else
		{	
			RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/ChequeBook.jsp");
			rd.forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		PrintWriter out = response.getWriter();
		GenericDAO gd=new GenericDAO();
		
		if(request.getParameter("submitbtn")!=null){
			System.out.println("SARANG");
			int i=1, flag=0;
			int chequeno = Integer.parseInt(request.getParameter("chequeno"));
			String dealerid = request.getParameter("hidden_did");
			
			System.out.println("C : "+ chequeno);
			System.out.println("D : "+ dealerid);
			String insert_query="insert into chequebook (varchequeno, intdealerid) values( '"+chequeno+"', '"+dealerid+"');";
			
			System.out.println("Q ====> "+ insert_query);
			
			int status = gd.executeCommand(insert_query);
			 
			if (status==1) {
				System.out.print("insert ChequeBook success ");	
			}else{
				System.out.print("insert ChequeBook fail ");
				flag=1;
			}
			System.out.println(chequeno +" "+ dealerid);
			
			
		    if(flag==1)
			{
		    	request.setAttribute("error1", "1");
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/newDP.jsp?dealerId="+dealerid+"&error1=1");
				rd.forward(request, response);
			}
			else
			{	
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/newDP.jsp?dealerId="+dealerid);
				rd.forward(request, response);
			}


		}else{
		
			int counter = Integer.parseInt(request.getParameter("counter"));
			int i=1, flag=0;
			
			while(counter>0){
				
				String chequeno = request.getParameter("chequeno"+i);
				String dealerid = request.getParameter("orgname"+i);				
				
				String insert_query="insert into chequebook (varchequeno, intdealerid) values( '"+chequeno+"', '"+dealerid+"');";
				
				int status = gd.executeCommand(insert_query);
				 
				if (status==1) {
					System.out.print("insert ChequeBook success ");
					
				}else{
					System.out.print("insert ChequeBook fail ");
					flag=1;
					break;
				}
				
				System.out.println(i+" " +chequeno +" "+ dealerid);
				i++;
				counter--;
			}
		    if(flag==1)
			{
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/ChequeBook.jsp?error=1");
				rd.forward(request, response);
			}
			else
			{	
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/ChequeBook.jsp");
				rd.forward(request, response);
			}
		}   
		
	}
	
	String abc(){
		
		return "a";
	}

}
