package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

/**
 * Servlet implementation class UpdateInvoice
 */
public class UpdateInvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateInvoice() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		GenericDAO da = new GenericDAO();
		PrintWriter out=response.getWriter();
		
		String orgName = request.getParameter("orgname");
		String tag = request.getParameter("tag");
		String orgAddress = request.getParameter("orgaddress");
		String tal = request.getParameter("tal");
		String dist = request.getParameter("dist");
		String phoneNo = request.getParameter("phoneNo");
		String pan= request.getParameter("pan");
		String gstin = request.getParameter("gstin");
		String place = request.getParameter("place");
		String scode = request.getParameter("scode");
		
		out.print(orgName+"<br>");
		out.println(tag+"<br>");
		out.println(orgAddress+"<br>");
		out.println(tal+"<br>");
		out.println(dist+"<br>");
		out.println(phoneNo+"<br>");
		out.println(pan+"<br>");
		out.println(gstin+"<br>");
		out.println(place+"<br>");
		out.println(scode+"<br>");
		
		String insertQuery="UPDATE `organization_invoice` SET `invoice_header`='"+orgName+"',`tag`='"+tag+"',"
				+ "`address`='"+orgAddress+"',`tal`='"+tal+"',`dist`='"+dist+"',`phone_no`='"+phoneNo+"',"
				+ "`pan`='"+pan+"',`gstin`='"+gstin+"',`place`='"+place+"',`scode`='"+scode+"' WHERE `id`=1";
		int status=da.executeCommand(insertQuery);
		if(status==1)
		{
			request.setAttribute("status1", "Data Updated Successfully");
			RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/updateInvoice.jsp");
            rd.forward(request, response);
		}
	}

}
