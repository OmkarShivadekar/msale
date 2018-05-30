package servletStore.payment;

import java.io.IOException;
import java.sql.Date;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CountDownLatch;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.SysDate;


public class UpdateChequeBounce extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		GenericDAO gd = new GenericDAO();
		SysDate sd = new SysDate();
		
		String dealerOrg =  request.getParameter("bounce_cheque_org_name");
		String chequeno = request.getParameter("cheque-number");
		int chequeAmount=Integer.parseInt(request.getParameter("bounce_cheque_amount"));
		String withdrawalDate= sd.todayDate();
		int chequeClearStatus=1;
		
		
		String q1 = "select intdealerid from dealer_master where varorganizationname='"+dealerOrg+"';";
		List dealerOrg_name = gd.getData(q1);
		String dealerid = dealerOrg_name.get(0).toString();
		
		
		if(chequeClearStatus==1)
		{
			String insert_query="insert into cheque_payment_master( varchequeno, datewithdrawaldate, intchequeamount, varchequeparticular, intchequeclearstatus, intchequebouncecharges, intdealerid) values('"+chequeno+"', '"+Date.valueOf(withdrawalDate)+"', "+chequeAmount+", 'D',"+chequeClearStatus+", 250, "+dealerid+")";
			int status = gd.executeCommand(insert_query);

			if (status==1)
			{
				System.out.println("cheque payment with dealerid success");
				doPost(request, response);
			}
			else
			{
				System.out.println("cheque payment with dealerid fail");
			}
		}
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{	
		
		GenericDAO gd = new GenericDAO();
		String chequebookid="", dealerid="", chequeamount="", chequebouncecharges="", totalremaining="";
		
		SysDate sd = new SysDate();
		String withdrawalDate= sd.todayDate();
		
		String bouncedChequeNo = request.getParameter("cheque-number");
		System.out.println(bouncedChequeNo);
		
		String query="SELECT chequebook.intchequebookid, chequebook.intdealerid, cheque_payment_master.intchequeamount, cheque_payment_master.intchequebouncecharges FROM `chequebook`, `cheque_payment_master` WHERE chequebook.varchequeno="+bouncedChequeNo+" AND cheque_payment_master.varchequeno="+bouncedChequeNo+";";
		List bouncedChequedetails = gd.getData(query);
		
		if (bouncedChequedetails!=null) {
			System.out.println(bouncedChequedetails);
			
			Iterator itr = bouncedChequedetails.iterator();
			while(itr.hasNext()){
				
				chequebookid = itr.next().toString();
				dealerid =  itr.next().toString();
				chequeamount =  itr.next().toString();
				chequebouncecharges =  itr.next().toString();
				
			}
			
			int lasttotal=0, charges=0, chequeamount1=0, flag=0;
			String lasttotal1 = null;
			
			String qury1 = "select totalremaining from dealer_payment_master where intdealer_payment_id=(SELECT max(intdealer_payment_id) from dealer_payment_master where intdealerid="+dealerid+");";	
			
			List lasttotallist = gd.getData(qury1);
			Iterator itr1 = lasttotallist.iterator();
			
			
			while(itr1.hasNext()){
				lasttotal1 = itr1.next().toString();
			}
			lasttotal = Integer.parseInt(lasttotal1); 
			charges = Integer.parseInt(chequebouncecharges);
			chequeamount1=Integer.parseInt(chequeamount);
			
			lasttotal = lasttotal+charges+chequeamount1;
			
			String query1 = "insert into dealer_payment_master (intdealerid, intchequebookid, intbouncedchequeamount, intchequebouncecharges, datetransactiondate, totalremaining) values ('"+dealerid+"','"+chequebookid+"','"+chequeamount+"','"+chequebouncecharges+"','"+withdrawalDate+"','"+lasttotal+"');";
			
			int status =gd.executeCommand(query1);
			System.out.println(query1);
			if (status==1) {
				System.out.println("insert success");
				
			}else{
				System.out.println("insert fail");
				flag=1;
			}
			
			
			
			if(flag==1)
			{
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/homePage.jsp?error=1");
				rd.forward(request, response);
			}
			else
			{	
				RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/homePage.jsp");
				rd.forward(request, response);
			}
			
			
		}
		
	}

}
