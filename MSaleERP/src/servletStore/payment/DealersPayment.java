package servletStore.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class DealersPayment extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		GenericDAO gd=new GenericDAO();	
		
		if(request.getParameter("getpassword")!=null)	{
			String password=request.getParameter("getpassword");
			if(password.equals("pass123"))// password
		    {
		    	RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/payment/newDP.jsp");
		    	rd.forward(request, response);
		    }else{
		    	request.setAttribute("error1", "2");
		    	RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/homePage.jsp");
		    	rd.forward(request, response);
		    }
		}
	    else
	    {
			try 
			{
				
				String pAmount=request.getParameter("cpa");
				String pDate=request.getParameter("paymentdate");
				String dealerId=request.getParameter("dealerId");
				String dueAmt=request.getParameter("trda");
				String pMode=request.getParameter("radio_payment");
				
				System.out.println("cpa : "+pAmount);
				System.out.println("PayDAte : "+pDate);
				System.out.println("DID : "+dealerId);
				System.out.println("TRDA : "+dueAmt);
				System.out.println("Mode : "+pMode);
				
				String checkbox_cheque_no=request.getParameter("checkbox_cheque_no");
				System.out.println("checkbox_cheque_no : "+checkbox_cheque_no);
				
				if(pMode.equals("Cheque") && checkbox_cheque_no==null){
					System.out.println("HIIII");
					request.setAttribute("error1", "2");
//					RequestDispatcher rd = request.getRequestDispatcher("/jsp/admin/payment/newDP.jsp");
					RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/payment/newDP.jsp?dealerId="+dealerId);
					rd.forward(request, response);   //include(request, response);
				}
				else{
				
					SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd");
					Date date = in.parse(pDate);
					
					SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			
					
					String query= "insert into paid_payment_details (datepaymentdate,intpaidamount,varpaymentmode,intdealerid) values('"+fmt.format(date)+"',"+pAmount+",'"+pMode+"',"+dealerId+")";
					gd.executeCommand(query);
					String query1="SELECT count(*) FROM paid_payment_details;";
					List c=gd.getData(query1);
					String insert;
					
					if(pMode.equals("Cash")){
						insert="insert into dealer_payment_master (intdealerId,intpaymentdetailsid,intpaidamount,datetransactiondate,totalremaining) values ("+dealerId+","+c.get(0)+","+pAmount+",'"+fmt.format(date)+"',"+dueAmt+")";
					}
					else{
						
						String query2="SELECT intchequebookid FROM chequebook where varchequeno='"+checkbox_cheque_no+"';";
						List getchequebookid=gd.getData(query2);
						gd.executeCommand("update chequebook set intchequestatus=1 where varchequeno='"+checkbox_cheque_no+"';");
					    insert="insert into dealer_payment_master (intdealerId,intpaymentdetailsid,intpaidamount,datetransactiondate,totalremaining,intchequebookid) values ("+dealerId+","+c.get(0)+","+pAmount+",'"+fmt.format(date)+"',"+dueAmt+","+getchequebookid.get(0)+")";	    
					    gd.executeCommand("insert into cheque_payment_master (varchequeno,datewithdrawaldate,intchequeamount,varchequeparticular,intdealerid) values ('"+checkbox_cheque_no+"','"+fmt.format(date)+"',"+pAmount+",'D',"+dealerId+");");
					    
					}
					gd.executeCommand(insert);
					request.setAttribute("status1", "Payment Succesfully Done...");
					RequestDispatcher rd = request.getRequestDispatcher("/jsp/admin/payment/newDP.jsp");
					rd.include(request, response);
				}
				
			}	
			catch (ParseException e) 
			{
				e.printStackTrace();
			}
	    }
	}
}