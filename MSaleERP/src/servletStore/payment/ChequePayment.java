package servletStore.payment;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;


public class ChequePayment extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		PrintWriter out = response.getWriter();
		out.print("in cheque payment");
		GenericDAO gd=new GenericDAO();
		
		int customerid = 0; //Integer.parseInt(request.getParameter("customerid"));
		int dealerid = 15; //Integer.parseInt(request.getParameter("dealerid"));
		String chequeno = "123456";
		String withdrawalDate="2017-07-09"; 
		int chequeAmount=25000;
		int chequeClearStatus=0;
		
		
		
		/*if(customerid!=0)
		{
			if(chequeClearStatus==0)
			{
				String insert_query="insert into cheque_payment_master( varchequeno, datewithdrawaldate, intchequeamount, varchequeparticular, intcustid) values('"+chequeno+"', '"+Date.valueOf(withdrawalDate)+"', "+chequeAmount+", 'W', "+customerid+")";
				
				int status = gd.executeCommand(insert_query);
				if (status==1) {
					out.println("cheque payment with custid success");
				}else{
					out.println("cheque payment with custid fail");
				}
			}
			else
			{
				chequeAmount += 250;
				String insert_query="insert into cheque_payment_master( varchequeno, datewithdrawaldate, intchequeamount, varchequeparticular, intchequeclearstatus, intchequebouncecharges, intcustid) values('"+chequeno+"', '"+Date.valueOf(withdrawalDate)+"', "+chequeAmount+", 'W',"+chequeClearStatus+", 250, "+customerid+")";
				
				int status = gd.executeCommand(insert_query);
				if (status==1) {
					out.println("cheque payment with custid success");
				}else{
					out.println("cheque payment with custid fail");
				}
			}
		}
		else*/ if(dealerid!=0)
		{
			if(chequeClearStatus==0)
			{
				String insert_query="insert into cheque_payment_master( varchequeno, datewithdrawaldate, intchequeamount, varchequeparticular, intchequeclearstatus, intdealerid) values('"+chequeno+"', '"+withdrawalDate+"', "+chequeAmount+", 'D',"+chequeClearStatus+", "+dealerid+")";
				
				int status = gd.executeCommand(insert_query);
				if (status==1) {
					out.println("cheque payment with dealerid success");
				}else{
					out.println("cheque payment with dealerid fail");
				}
			}
			else
			{
				chequeAmount += 250;
				String insert_query="insert into cheque_payment_master( varchequeno, datewithdrawaldate, intchequeamount, varchequeparticular, intchequeclearstatus, intchequebouncecharges, intdealerid) values('"+chequeno+"', '"+Date.valueOf(withdrawalDate)+"', "+chequeAmount+", 'D',"+chequeClearStatus+", 250, "+dealerid+")";
				
				int status = gd.executeCommand(insert_query);
				if (status==1) {
					out.println("cheque payment with dealerid success");
				}else{
					out.println("cheque payment with dealerid fail");
				}
			}
		}
		

			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}

}
