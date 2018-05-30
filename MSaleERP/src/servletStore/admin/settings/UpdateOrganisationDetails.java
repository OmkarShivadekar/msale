package servletStore.admin.settings;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;

public class UpdateOrganisationDetails extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		if(request.getParameter("update")!=null)
		{
			GenericDAO gd=new GenericDAO();
			if(request.getParameter("ownerName")!=null)
			{
				System.out.println("in elngalh");
				String ownerName = request.getParameter("ownerName");
				String orgAddress = request.getParameter("orgaddress");
				String cno1 = request.getParameter("cno1");
				String cno2 = request.getParameter("cno2");
				String email = request.getParameter("email");
				String updateData="";
				String demo="SELECT `owner_name`, `org_address`, `cno1`, `cno2`,"
						+ " `email` FROM `organization_details_master`";
				int demoStatus=0;
				List demoList1=gd.getData(demo);
				System.out.println(demoList1);
				Iterator itr=demoList1.iterator();
				while(itr.hasNext())
				{
					if(!(itr.next().toString().compareTo(ownerName.trim())==0))
					{
						updateData+=" NAME"+",";
						demoStatus++;
					}
					if(!(itr.next().toString().compareTo(orgAddress.trim())==0))
					{
						updateData+=" Address"+",";
						demoStatus++;
					}
					if(!(itr.next().toString().compareTo(cno1.trim())==0))
					{
						updateData+=" Contact 1"+",";
						demoStatus++;
					}
					if(!(itr.next().toString().compareTo(cno2.trim())==0))
					{
						updateData+=" COntact 2"+",";
						demoStatus++;
					}
					if(!(itr.next().toString().compareTo(email.trim())==0))
					{
						updateData+=" E-mail"+",";
						demoStatus++;
					}
					if(demoStatus>2)
						request.setAttribute("status1", "Data Updated Successfully");
					else if(demoStatus==0)
						request.setAttribute("status1", "Nothing For Update");
					else
						request.setAttribute("status1", updateData.substring(1, updateData.length()-1)+" Updated Successfully");
				}
				String insertQuery="UPDATE `organization_details_master` SET "
						+ "`owner_name`='"+ownerName+"',`org_address`='"+orgAddress+"',`cno1`='"+cno1+"',`cno2`='"+cno2+"',`email`='"+email+"'";
				int status=gd.executeCommand(insertQuery);
				if(status==1)
				{
					RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/updateOrganization.jsp");
		            rd.forward(request, response);
				}
			}
		}
	}

}
