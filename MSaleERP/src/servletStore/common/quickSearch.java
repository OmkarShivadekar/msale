package servletStore.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class quickSearch extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession session=request.getSession();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String model= request.getParameter("model_id");
		String invoiceid= request.getParameter("invoice_no");
		
		System.out.println("Model "+model);
		System.out.println("Invoice "+invoiceid);
		
		
	  out.print("<html><body onload=\"myFunction()\">");
	  out.print("<script type=\"text/javascript\">");
	  out.print(" function myFunction() {");
      out.print("window.open('jsp/admin/sale/PrintInvoiceGST.jsp?invoiceId="+invoiceid+"&model="+model+"\', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');");
      out.print("window.location.assign(\"jsp/admin/common/quickSearch.jsp\")");
      out.print("}");
      out.print("</script>");
      out.print("</body></html>");
		
	}

}
