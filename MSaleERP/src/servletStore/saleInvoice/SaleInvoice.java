package servletStore.saleInvoice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
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

import utility.SysDate;

import com.mysql.jdbc.Statement;

import dao.General.GenericDAO;

@WebServlet("/SaleInvoice")
public class SaleInvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		GenericDAO da = new GenericDAO();

		String saletype = request.getParameter("saletype");
		String invoiceid = request.getParameter("invoiceid");

		if (saletype.equals("1")) {
			String imei = request.getParameter("imei");
			String query4 = "SELECT `inttotalqty` FROM `mobilestock_master`,`mobilesale_master` WHERE `mobilestock_master`.`intmodelid`=`mobilesale_master`.`intmodelid` AND `mobilesale_master`.`intmobilesaleid`="
					+ invoiceid;
			String totalqty = da.getData(query4).get(0).toString();
			int updatetotalqty = Integer.parseInt(totalqty) + 1;

			String updateIMEI = "UPDATE `purchase_details` SET `intsalestatus`=0 WHERE `varimeino1`='" + imei + "'";
			String updateQty = "UPDATE `mobilestock_master`,`mobilesale_master` SET `mobilestock_master`.`inttotalqty`="
					+ updatetotalqty
					+ " WHERE `mobilestock_master`.`intmodelid`=`mobilesale_master`.`intmodelid` AND `mobilesale_master`.`intmobilesaleid`="
					+ invoiceid;
			int update = da.executeCommand(updateIMEI);
			int Qty = da.executeCommand(updateQty);
			if (update == 1 && Qty == 1) {
//				String query = "DELETE mobilesale_master,customer_master FROM `mobilesale_master` "
//						+ "INNER JOIN `customer_master` WHERE `mobilesale_master`.`intmobilesaleid`=" + invoiceid
//						+ " AND" + "`mobilesale_master`.`intcustid`=`customer_master`.`intcustid`";
				String query="UPDATE `mobilesale_master`,`customer_master` SET `mobilesale_master`.`intmodelid`=null,"
						+ "`mobilesale_master`.`varimeino1`='-',`mobilesale_master`.`varimeino2`='-',`mobilesale_master`.`varserialno`='-',"
						+ "`mobilesale_master`.`varhhsnsacno`='-',`mobilesale_master`.`varbatteryno`='-',`mobilesale_master`.`varchargerno`='-',"
						+ "`mobilesale_master`.`intsaleprice`=null,`mobilesale_master`.`intcustdiscount`=null,`mobilesale_master`.`varpaymentmode`='-',"
						+ "`mobilesale_master`.`varsaletype`='2',`customer_master`.`varcustname`='Canceled',`customer_master`.`varaddress`='-',`customer_master`.`varcontactno`='-',"
						+ "`customer_master`.`varcustgstin`='-' WHERE `mobilesale_master`.`intmobilesaleid`="+invoiceid+" AND `mobilesale_master`.`intcustid`=`customer_master`.`intcustid`";
				int a = da.executeCommand(query);
				if (a >= 1) {
					out.println("Invoice Delete Successfully!");
				} else {
					out.print("something wrong");
				}
			} else {
				out.print("something wrong with this IMEI NO OR Qty");
			}
			// out.println(invoiceid);
		} else {
			String deleteAccessories = "DELETE FROM `accessoriessale_master` WHERE `intmobilesaleid`=" + invoiceid;
			int intdelete = da.executeCommand(deleteAccessories);
			if (intdelete >= 1) {
//				String query = "DELETE mobilesale_master,customer_master FROM `mobilesale_master` "
//						+ "INNER JOIN `customer_master` WHERE `mobilesale_master`.`intmobilesaleid`=" + invoiceid
//						+ " AND" + "`mobilesale_master`.`intcustid`=`customer_master`.`intcustid`";
				String query="UPDATE `mobilesale_master`,`customer_master` SET `mobilesale_master`.`intmodelid`=null,"
						+ "`mobilesale_master`.`varimeino1`='-',`mobilesale_master`.`varimeino2`='-',`mobilesale_master`.`varserialno`='-',"
						+ "`mobilesale_master`.`varhhsnsacno`='-',`mobilesale_master`.`varbatteryno`='-',`mobilesale_master`.`varchargerno`='-',"
						+ "`mobilesale_master`.`intsaleprice`=null,`mobilesale_master`.`intcustdiscount`=null,`mobilesale_master`.`varpaymentmode`='-',"
						+ "`mobilesale_master`.`varsaletype`='2',`customer_master`.`varcustname`='Canceled',`customer_master`.`varaddress`='-',`customer_master`.`varcontactno`='-',"
						+ "`customer_master`.`varcustgstin`='-' WHERE `mobilesale_master`.`intmobilesaleid`="+invoiceid+" AND `mobilesale_master`.`intcustid`=`customer_master`.`intcustid`";
				
				int a = da.executeCommand(query);
				if (a >= 1) {
					out.println("Invoice Delete Successfully!");
				} else {
					out.print("something wrong");
				}
			} else {
				out.print("something wrong with this Accessories");
			}
		}

	} // doPost close

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		GenericDAO da = new GenericDAO();
		String getid = "SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'msale' AND   TABLE_NAME   = 'mobilesale_master'";
		String invoiceid = da.getData(getid).get(0).toString();

		// Mobile Sale
		String custname = request.getParameter("CustName");
		String address = request.getParameter("address");
		String mobile = request.getParameter("mobile");
		String custgst = request.getParameter("custgst");
		String model = request.getParameter("modelname");
		String imei = request.getParameter("imeino");
		String imei2 = request.getParameter("imeino2");
		String battery = request.getParameter("battery1");
		String snno = request.getParameter("snno");
		String charger = request.getParameter("charger1");
		String hscode = request.getParameter("hscode");
		String amount = request.getParameter("div_modelrate1");
		String saledate = request.getParameter("saledate");
		String paymentmode = request.getParameter("paymentbtn");
		String check_no = request.getParameter("check_no");
		String withdrawalDate = request.getParameter("withdrawalDate");
		String discount = "null";
		String page=request.getParameter("page");

		if (custgst.isEmpty()) {
			custgst = "null";
		}
		if (discount.isEmpty()) {
			discount = "null";
		}
		if (imei2 == null) {
			imei2 = "null";
		}
		if (snno == null) {
			snno = "null";
		}
		if (amount == null) {
			amount = "0";
		}
		if (model == null) {
			model = "null";
		}
		if (address == null) {
			address = "-";
		}
		if (paymentmode == null) {
			paymentmode = "null";
		}
		if (page == null) {
			page = "null";
		}
System.out.println(">>"+amount);
		// Accessories Sale
		String item = request.getParameter("item1");
		String sale_type;
		int totbox = 0;
		if (item == null) {
			sale_type = "1";
		} else {
			sale_type = "2";
			totbox = Integer.parseInt(request.getParameter("totbox").toString());
		}

		// Accessories Multiple Box Array
		String[] m_item = new String[totbox];
		String[] item_detail = new String[totbox];
		String item_qty = "1";
		String[] item_price = new String[totbox];
		String[] gst = new String[totbox];
		
		if (sale_type.equals("2")) {
			for (int i = 0; i < totbox; i++) {
				m_item[i] = request.getParameter("item" + (i + 1));
				item_detail[i] = request.getParameter("item_detail" + (i + 1));
				item_price[i] = request.getParameter("item_price" + (i + 1));
				gst[i] = request.getParameter("gst" + (i + 1));
			}
		}

		String query = "INSERT INTO `customer_master`(`varcustname`, `varaddress`, `varcontactno`, `varcustgstin`) VALUES('"
				+ custname + "','" + address + "','" + mobile + "','" + custgst + "') ";
		String query1 = "SELECT MAX(`intcustid`) FROM `customer_master`";
		int insertstatus = da.executeCommand(query);
		String custId = da.getData(query1).get(0).toString();
		
		if (paymentmode.equals("Check")) {
			String checkquery = "INSERT INTO `cheque_payment_master`(`varchequeno`, `datewithdrawaldate`, `intchequeamount`, `varchequeparticular`,   `intcustid`) VALUES ('"
					+ check_no + "','" + withdrawalDate + "','" + amount + "','D'," + custId + ")";
			int checksatatus = da.executeCommand(checkquery);
		}
		if (insertstatus != 0) {

			String query2 = "INSERT INTO `mobilesale_master`(`intmobilesaleid`, `intcustid`, `datesaledate`, `intmodelid`, `varimeino1`, `varimeino2`, `varserialno`, `varhhsnsacno`, `varbatteryno`, `varchargerno`, `intsaleprice`, `intcustdiscount`, `varpaymentmode`, `varsaletype`) "
					+ "VALUES(DEFAULT," + custId + ",'" + saledate + "'," + model + ",'" + imei + "','" + imei2 + "','"
					+ snno + "','" + hscode + "','" + battery + "','" + charger + "','" + amount + "'," + discount
					+ ",'" + paymentmode + "','" + sale_type + "')";
System.out.println(">>>"+query2);
			int a = da.executeCommand(query2);

			if (a == 1) {
				if (sale_type.equals("1")) {
					String query3 = "UPDATE `purchase_details` SET `intsalestatus` = '1' WHERE `purchase_details`.`varimeino1` = '"
							+ imei + "'";
					String query4 = "SELECT `inttotalqty` FROM `mobilestock_master` WHERE `intmodelid`=" + model;

					String totalqty = da.getData(query4).get(0).toString();
					int updatetotalqty = Integer.parseInt(totalqty) - 1;
					
					String query5 = "UPDATE `mobilestock_master` SET `inttotalqty`=" + updatetotalqty
							+ " WHERE `intmodelid`=" + model;

					int a1 = da.executeCommand(query3);
					
					int a2 = da.executeCommand(query5);
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
					for (int i = 0; i < totbox; i++) {
						String AccessoriesQuery = "INSERT INTO `accessoriessale_master`(`intaccessoriesid`, `intmobilesaleid`, `varitem`, `varitem_detail`, `varitem_qty`, `intaccessoriessaleprice`, `gst`) VALUES "
								+ "(DEFAULT," + invoiceid + ",'" + m_item[i] + "','" + item_detail[i] + "','" + item_qty
								+ "'," + item_price[i] + ",'" + gst[i] + "')";

						da.executeCommand(AccessoriesQuery);
					}
					// html head
					out.print("<html><head>");
					out.println("<link rel=\"stylesheet\" href=\"/MSaleERP/config/css/bootstrap.min.css\" />");
					out.println("<link rel=\"stylesheet\" href=\"/MSaleERP/config/css/matrix-style.css\" />");
					out.println("<script src=\"/MSaleERP/config/js/jquery.min.js\"></script>");
					// script
					out.println("<script type=\"text/javascript\">");
					out.println(" function myFunction() {");
					out.println("var url=\"jsp/admin/sale/PrintAccessoriesInvoice.jsp?invoiceId=" + invoiceid
							+ "&totbox=" + totbox + "\";");
					out.println("var w = window.open(url); $(w);");
					out.println("window.location.assign(\"jsp/admin/sale/AccessoriesInvoice.jsp\")");
					out.println("}");
					out.println("</script>");
					// body
					out.print("</head><body onload=\"myFunction()\">");
					out.println("<br><br><br>");
					out.println(
							"<div class=\"progress progress-mini active progress-striped\" style=\"margin-top: 60px;\">");
					out.println("LOADING...<div style=\"width: 1%;\" id=\"box\" class=\"bar\"></div></div>");
					out.print(
							"<script>var i = 1; function myLoop () {setTimeout(function () {document.getElementById('box').style.width=i+'%'; i++;if (i < 90){myLoop();} }, 100)}myLoop();</script>");
					out.print("</body></html>");
				}

			} else {
				System.out.println(
						"something wrong at insert data into sale_details table ..msg from  SaleInvoice.java...");
				out.write("something wrong at insert data into sale_details table .....");

			}

		} else {
			System.out.println("To Insert data into invoice master table faild ...");
			out.print("To Insert data into invoice master table faild ...");
		}
	}

}
