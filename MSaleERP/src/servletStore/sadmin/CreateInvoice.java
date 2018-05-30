package servletStore.sadmin;

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
 * Servlet implementation class CreateInvoice
 */
@WebServlet("/CreateInvoice")
public class CreateInvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateInvoice() {
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
		
		String insertOrg="INSERT INTO `organization_invoice`"
				+ "(`id`, `invoice_header`, `tag`, `address`, `tal`, `dist`, `phone_no`, `pan`, `gstin`, `place`, `scode`) VALUES "
				+ "(2,'"+orgName+"','"+tag+"','"+orgAddress+"','"+tal+"','"+dist+"','"+phoneNo+"','"+pan+"','"+gstin+"','"+place+"','"+scode+"')";
		int status=da.executeCommand(insertOrg);
		if(status==1)
		{
					System.out.println("requestion");
					request.setAttribute("status", "Invoice Created Successfully.Now Login As User");
					RequestDispatcher rd= request.getRequestDispatcher("jsp/common/login.jsp");
				   	rd.forward(request, response);
				   	
		}
		
	}

}
