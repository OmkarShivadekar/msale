package servletStore.saleInvoice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

/**
 * @author Himanshu Patel Servlet implementation class EditPrintInvoice
 */
@WebServlet("/EditPrintInvoice")
public class EditPrintInvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		String s = request.getParameter("q");

		GenericDAO da = new GenericDAO();

		List details = null;
		String saletype = "SELECT `varsaletype` FROM `mobilesale_master` WHERE `intmobilesaleid`=" + s;
		saletype = da.getData(saletype).get(0).toString();
		if (saletype.equals("1")) {
			if (s != null) {
				String query = "SELECT m.`varsaletype`,c.`varcustname`, c.`varaddress`,c. `varcontactno`,m.`datesaledate`,md.`aliasnamemodel`,"
						+ "m.`varimeino1`,m.`varimeino2`,m.`varserialno`,m.`varhhsnsacno`,m.`varbatteryno`,m.`varchargerno`,m.`intsaleprice`,"
						+ "c.`varcustgstin`,m.`intmobilesaleid`,md.`intmodelid` FROM `mobilesale_master` m, `customer_master` c,`model_details_master` md WHERE "
						+ "m.`intmobilesaleid`=" + s
						+ " AND m.`intcustid`=c.`intcustid` AND m.`intmodelid`=md.`intmodelid`";
				System.out.println("query 1====" + query);
				details = da.getData(query);
				System.out.println("Query===" + details);

				Iterator itr = details.iterator();
				while (itr.hasNext()) {
					out.print(itr.next() + "~");
				}
			}
		} else {
			// out.println(saletype);
			String query = "SELECT m.`varsaletype`,m.`intmobilesaleid`,c.`varcustname`, c.`varaddress`,c.`varcontactno`,m.`datesaledate`,c.`varcustgstin` FROM `mobilesale_master` m, `customer_master` c WHERE m.`intmobilesaleid`="
					+ s + " AND m.`intcustid`=c.`intcustid`";
			String accessories = "SELECT `varitem`, `varitem_detail`,`intaccessoriessaleprice`,`intaccessoriesid`, `gst` FROM `accessoriessale_master` WHERE `intmobilesaleid` ="+ s;

			List l1 = da.getData(query);
			List l2 = da.getData(accessories);

			Iterator itr = l1.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");
			}

			itr = l2.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + "~");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		GenericDAO da = new GenericDAO();

		String saletype = request.getParameter("sale_type");
		String custname = request.getParameter("edit_name");
		String address = request.getParameter("edit_address");
		String mobile = request.getParameter("edit_contactno");
		String custgst = request.getParameter("edit_gstin");
		String invoiceid = request.getParameter("edit_invoice");
		String page=request.getParameter("page");
		
		if (page == null) {
			page = "null";
		}

		String customerUpdateQuery = "UPDATE `customer_master`,`mobilesale_master` SET " + "`varcustname`='" + custname
				+ "',`varaddress`='" + address + "',`varcontactno`='" + mobile + "',`varcustgstin`='" + custgst + "' "
				+ "WHERE mobilesale_master.intmobilesaleid=" + invoiceid
				+ " AND mobilesale_master.intcustid=customer_master.intcustid";
		int a = da.executeCommand(customerUpdateQuery);

		if (a == 1) {

			if (saletype.equals("1")) {
				String model = request.getParameter("edit_modelid");
				String imei = request.getParameter("edit_imei1");
				String imei2 = request.getParameter("edit_imei2");
				String battery = request.getParameter("edit_battery");
				String snno = request.getParameter("edit_serial");
				String charger = request.getParameter("edit_charer");
				String hscode = request.getParameter("edit_hsn");
				String amount = request.getParameter("edit_amount");
				String saledate = request.getParameter("edit_saledate");
				String paymentmode = request.getParameter("paymentbtn");
				String discount = "null";

				if (custgst.isEmpty()) {
					custgst = "null";
				}
				if (discount.isEmpty()) {
					discount = "null";
				}
				if (imei2.isEmpty()) {
					imei2 = "null";
				}
				if (snno.isEmpty()) {
					snno = "null";
				}
				if (amount.isEmpty()) {
					amount = "null";
				}
				if (model.isEmpty()) {
					model = "null";
				}
				String mobilesaleUpadateQuery = "UPDATE `mobilesale_master` SET " + "`datesaledate`='" + saledate
						+ "',`varimeino1`='" + imei + "',`varimeino2`='" + imei2 + "'," + "`varserialno`='" + snno
						+ "',`varhhsnsacno`='" + hscode + "',`varbatteryno`='" + battery + "',`varchargerno`='"
						+ charger + "'," + "`intsaleprice`=" + amount + " WHERE `intmobilesaleid`=" + invoiceid;
				int b = da.executeCommand(mobilesaleUpadateQuery);
				if (b == 1) {
					//html head
					out.print("<html><head>");
					out.println("<link rel=\"stylesheet\" href=\"/MSaleERP/config/css/bootstrap.min.css\" />");
					out.println("<link rel=\"stylesheet\" href=\"/MSaleERP/config/css/matrix-style.css\" />");
					out.println("<script src=\"/MSaleERP/config/js/jquery.min.js\"></script>");
					//script
					out.println("<script type=\"text/javascript\">");
					out.println(" function myFunction() {");
					out.println("var url=\"jsp/admin/sale/PrintInvoiceGST.jsp?invoiceId=" + invoiceid + "&model="+ model +"\";");
					out.println("var w = window.open(url); $(w);");
					if (page.equals("scanner")) {
						out.print("window.location.assign(\"jsp/admin/sale/InvoiceScanner.jsp\")");
					}else {
						out.print("window.location.assign(\"jsp/admin/sale/Invoice.jsp\")");
					}
					out.println("}");
					out.println("</script>");
					//body
					out.print("</head><body onload=\"myFunction()\">");					
					out.println("<br><br><br>");
					out.println("<div class=\"progress progress-mini active progress-striped\" style=\"margin-top: 60px;\">");
					out.println("LOADING...<div style=\"width: 1%;\" id=\"box\" class=\"bar\"></div></div>");
					out.print("<script>var i = 1; function myLoop () {setTimeout(function () {document.getElementById('box').style.width=i+'%'; i++;if (i < 90){myLoop();} }, 100)}myLoop();</script>");
					out.print("</body></html>");
				} else {
					out.println("something wrong");
				}
			} else {
				int totbox = Integer.parseInt(request.getParameter("totboxAccessories").toString());
				String sale_type;
				// multi
				String[] item = new String[totbox];
				String[] item_detail = new String[totbox];
				String item_qty ="1";
				String[] item_price = new String[totbox];
				String[] accssoriesId = new String[totbox];
				String[] gst = new String[totbox];
				for (int i = 0; i < totbox; i++) {
					item[i] = request.getParameter("item" + (i + 1));
					item_detail[i] = request.getParameter("item_detail" + (i + 1));
					item_price[i] = request.getParameter("item_price" + (i + 1));
					accssoriesId[i] = request.getParameter("accessoriesid" + (i + 1));
					gst[i] = request.getParameter("gst" + (i + 1));
				}
				int c=0;
				for (int i = 0; i < totbox; i++) {
					
					String AccessoriesQuery="UPDATE `accessoriessale_master` SET `varitem`='"+item[i]+"',`varitem_detail`='"+item_detail[i]+"',`varitem_qty`='"+item_qty+"',`intaccessoriessaleprice`='"+item_price[i]+"',`gst`='"+gst[i]+"'  WHERE `intaccessoriesid`="+accssoriesId[i];
					c = da.executeCommand(AccessoriesQuery);
					
				}
				if (c==1) {
					//html head
					out.print("<html><head>");
					out.println("<link rel=\"stylesheet\" href=\"/MSaleERP/config/css/bootstrap.min.css\" />");
					out.println("<link rel=\"stylesheet\" href=\"/MSaleERP/config/css/matrix-style.css\" />");
					out.println("<script src=\"/MSaleERP/config/js/jquery.min.js\"></script>");
					//script
					out.println("<script type=\"text/javascript\">");
					out.println(" function myFunction() {");
					out.println("var url=\"jsp/admin/sale/PrintAccessoriesInvoice.jsp?invoiceId=" + invoiceid +"&totbox="+totbox+"\";");
					out.println("var w = window.open(url); $(w);");
					out.println("window.location.assign(\"jsp/admin/sale/AccessoriesInvoice.jsp\")");
					out.println("}");
					out.println("</script>");
					//body
					out.print("</head><body onload=\"myFunction()\">");					
					out.println("<br><br><br>");
					out.println("<div class=\"progress progress-mini active progress-striped\" style=\"margin-top: 60px;\">");
					out.println("LOADING...<div style=\"width: 1%;\" id=\"box\" class=\"bar\"></div></div>");
					out.print("<script>var i = 1; function myLoop () {setTimeout(function () {document.getElementById('box').style.width=i+'%'; i++;if (i < 90){myLoop();} }, 100)}myLoop();</script>");
					out.print("</body></html>");
				}else {
					out.println("No");
				}
			}	
		} else {
			out.println("something wrong with customer side");
		}
	}

}
