package servletStore.saleInvoice;

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

import utility.SysDate;
import dao.General.GenericDAO;

/**
 * Servlet implementation class dummyInvoiceServlet
 */
public class dummyInvoiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dummyInvoiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String printenable ="";
		SysDate sd=new SysDate();
	
		System.out.println("In the servlet do post.....");
		GenericDAO da = new GenericDAO();

		String custname = request.getParameter("CustName");
		String address = request.getParameter("address");
		String mobile = request.getParameter("mobile");
		String custgst=request.getParameter("custgst");
		String model= request.getParameter("modelname");
		String imei1= request.getParameter("imeino1");
		String imei2= request.getParameter("imeino2");
		String snno= request.getParameter("snno1");
		String battery= request.getParameter("battery1");
		String charger= request.getParameter("charger1");
		String amount= request.getParameter("div_modelrate1");
		String invoiceid= request.getParameter("invoiceno1");
		String saledate = request.getParameter("saledate");
		String paymentmode = request.getParameter("paymentbtn");
		String hsn = request.getParameter("hsnsacno");
		String check_no=request.getParameter("check_no");
		String withdrawalDate=request.getParameter("withdrawalDate");
		String discount=request.getParameter("discount");
		System.out.println("invoice no-------- "+invoiceid);
		if (custgst.isEmpty()) {
			custgst="-";
		}
		if (discount.isEmpty()) {
			discount="null";
		}
		String query= "INSERT INTO `dummy`(`varcustname`, `varaddress`, `varcontactno`, `varcustgst`,"
				+ " `varsaledate`, `varaliasnamemodel`, `varimeino1`, `varbatteryno`, `varchargerno`,"
				+ " `varsaleprice`, `intdiscount`, `hsnsacno`, `varimeino2`, `varsnno`) VALUES('"+custname+"','"+address+"','"+mobile+"','"+custgst+"','"+saledate+"','"+model+"','"+imei1+"','"+battery+"','"+charger+"','"+amount+"',"+discount+",'"+hsn+"','"+imei2+"','"+snno+"') ";
		int insertstatus = da.executeCommand(query);
		System.out.println("Insert Status******"+insertstatus);
		System.out.println("Query==="+query);
	if(insertstatus != 0 )		 
	{
		System.out.println("IN IF LOOP dummyInvoice Servlet invoice id is==> "+invoiceid);
			  out.print("<html><body onload=\"myFunction()\">");
			  out.print("<form action=\"jsp/admin/sale/DummyInvoice.jsp\">");
			  out.print("<script type=\"text/javascript\">");
			  out.print(" function myFunction() {");
		      out.print("window.open('jsp/admin/sale/DummyPrintInvoice.jsp?invoiceId="+invoiceid+"\', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');");
		      out.print("window.location.assign(\"jsp/admin/sale/DummyInvoice.jsp\")");
		      out.print("}");
		      out.print("</script>");
		      out.print("</form>");
		      out.print("</body></html>");
		      
	      
	      }
	      else
	      {
	    	  System.out.println("something wrong at insert data into sale_details table ..msg from  SaleInvoice.java...");
	    	  out.write("something wrong at insert data into sale_details table .....");
	    	
	      }


	
	}

}
