package servletStore.saleInvoice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import dao.dbconnect.DBConnection;

public class PrintInvoice extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		String s = request.getParameter("q");
		String aq = request.getParameter("aq");
		GenericDAO da = new GenericDAO();

		List details = null;
		if (s != null) {

			
			String query = "SELECT `intmobilesaleid`,`intmobilesaleid`,`model_details_master`.aliasnamemodel FROM "
					+ "`mobilesale_master`,`model_details_master` WHERE `intmobilesaleid` LIKE '" + s + "%' AND "
					+ "`mobilesale_master`.intmodelid=`model_details_master`.intmodelid AND "
					+ "`mobilesale_master`.`varsaletype`='1' UNION SELECT `mobilesale_master`.`intmobilesaleid`, "
					+ "`varcustname`,`model_details_master`.aliasnamemodel FROM `customer_master`,`mobilesale_master`,"
					+ "`model_details_master` WHERE `varcustname` LIKE '" + s
					+ "%' AND customer_master.intcustid=mobilesale_master.intcustid AND "
					+ "`mobilesale_master`.intmodelid=`model_details_master`.intmodelid AND `mobilesale_master`.`varsaletype`='1' "
					+ "UNION SELECT `mobilesale_master`.`intmobilesaleid`, `varcontactno`,`model_details_master`.aliasnamemodel FROM "
					+ "`customer_master`,`mobilesale_master`,`model_details_master` WHERE `varcontactno` LIKE '" + s
					+ "%' AND "
					+ "customer_master.intcustid=mobilesale_master.intcustid AND `mobilesale_master`.intmodelid=`model_details_master`.intmodelid AND"
					+ " `mobilesale_master`.`varsaletype`='1'";
			System.out.println("query 1====" + query);
			details = da.getData(query);
			System.out.println("Query===" + details);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}
		if (aq != null) {
			String query = "SELECT mobilesale_master.`intmobilesaleid`,mobilesale_master.`intmobilesaleid`,`accessoriessale_master`.varitem FROM "
					+ "`mobilesale_master`,`accessoriessale_master` WHERE mobilesale_master.`intmobilesaleid` LIKE '"+aq+"%'AND "
					+ "`mobilesale_master`.`varsaletype`='2' AND "
					+ "`accessoriessale_master`.intmobilesaleid= `mobilesale_master`.intmobilesaleid GROUP BY mobilesale_master.`intmobilesaleid` "
					+ "UNION SELECT `mobilesale_master`.`intmobilesaleid`, `varcustname`,`accessoriessale_master`.varitem FROM "
					+ "`customer_master`,`mobilesale_master`,`accessoriessale_master` WHERE "
					+ "`varcustname` LIKE '"+aq+"%' AND `mobilesale_master`.`varsaletype`='2' AND customer_master.intcustid=mobilesale_master.intcustid AND"
					+ " `accessoriessale_master`.intmobilesaleid= `mobilesale_master`.intmobilesaleid GROUP BY mobilesale_master.`intmobilesaleid` "
					+ "UNION SELECT `mobilesale_master`.`intmobilesaleid`, `varcontactno`,`accessoriessale_master`.varitem FROM "
					+ "`customer_master`,`mobilesale_master`,`accessoriessale_master` WHERE `varcontactno` LIKE '"+aq+"%' AND "
					+ "`mobilesale_master`.`varsaletype`='2' AND customer_master.intcustid=mobilesale_master.intcustid AND "
					+ "`accessoriessale_master`.intmobilesaleid= `mobilesale_master`.intmobilesaleid GROUP BY mobilesale_master.`intmobilesaleid`";
			System.out.println("query 1====" + query);
			details = da.getData(query);
			System.out.println("Query===" + details);

			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String s = request.getParameter("q");
		String imei= request.getParameter("imei");
		GenericDAO da = new GenericDAO();

		List details = null;
		if (s != null) {

			String query = "select varratetosale from purchase_master_details where intmodelId=" + s
					+ " and intpurchase_master_detailsId=(select max(intpurchase_master_detailsId) from purchase_master_details WHERE intmodelId="
					+ s
					+ ") union SELECT purchase_master_details.hsnsacno from purchase_master_details WHERE intmodelId="
					+ s
					+ " UNION select purchase_details.`varimeino1` FROM `purchase_details` INNER JOIN `purchase_master_details` on purchase_master_details.`intpurchase_master_detailsId`=purchase_details.intpurchase_master_detailsId WHERE purchase_details.`intsalestatus`=0 AND purchase_master_details.`intmodelId`="
					+ s + "";
			details = da.getData(query);
			System.out.println("Query===" + details);

			System.out.println("query 1====" + query);
			Iterator itr = details.iterator();
			while (itr.hasNext()) {
				out.print(itr.next() + ",");

			}
		}
		if (imei !=null) {
			String query="SELECT model_details_master.intmodelid,model_details_master.aliasnamemodel,"
					+ "purchase_master_details.varratetosale,purchase_master_details.hsnsacno FROM `purchase_details`,"
					+ "model_details_master,purchase_master_details WHERE purchase_details.varimeino1='"+imei+"' AND purchase_details.intsalestatus=0 AND "
					+ "purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId AND "
					+ "purchase_master_details.intmodelId=model_details_master.intmodelid";
			
					details = da.getData(query);
					Iterator itr = details.iterator();
					while (itr.hasNext()) {
						out.print(itr.next() + "~");
		
					}
		}
	}

}
