package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;
import utility.SysDate;

public class InsertDealer extends HttpServlet 
{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		PrintWriter out = response.getWriter();
		GenericDAO gd=new GenericDAO();
		
		String dealerName = request.getParameter("dealer_name");
		String contactNo = request.getParameter("contact_no");
		String emailId = request.getParameter("email_id");
		String balanceAmount = request.getParameter("balanceAmount");
		String organizationname = request.getParameter("organization_name");
		String sourcePage = request.getParameter("addBrandPage");
		
		if(sourcePage==null){
			sourcePage="";
		}
		
		if(balanceAmount.equals("")){
			balanceAmount="0";
		}
		
		System.out.println(balanceAmount);
		int brandId1=0;
		
		String insert_query="insert into dealer_master (vardealername, varcontactno, varemailid, varorganizationname) values('"+dealerName+"', '"+contactNo+"', '"+emailId+"', '"+organizationname+"');";
		
		int status = gd.executeCommand(insert_query);
		
		if (status==1) 
		{
			SysDate sysdate = new SysDate();
			String date = sysdate.todayDate();	
			String delaerid="";
			
			RequireData rd = new RequireData();
			List dealerlist = rd.getdealerid(organizationname);
			delaerid = dealerlist.get(0).toString();
			
			
			String paymentMasterquery = "INSERT INTO dealer_payment_master (intdealerId, datetransactiondate, totalremaining) values("+delaerid+", '"+date+"', "+balanceAmount+");";
			int balancestatus = gd.executeCommand(paymentMasterquery);
			request.setAttribute("status1", "Dealer "+ dealerName +" Added Successfully");
			
		}
		
		if(sourcePage.equals("addBrandPage"))
		{
			RequestDispatcher rd1 = request.getRequestDispatcher("jsp/admin/settings/addBrand.jsp");
			rd1.forward(request, response);
		}
		else{
			RequestDispatcher rd1 = request.getRequestDispatcher("jsp/admin/settings/addDealer.jsp");
			rd1.forward(request, response);
		}
		

	}
}