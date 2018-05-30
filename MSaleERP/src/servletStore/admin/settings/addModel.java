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
import utility.RequireData;


public class addModel extends HttpServlet {
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd = new GenericDAO();
		
		
		
		//for getting brand information(list)
		if(request.getParameter("getBrand")!=null)
		{
			String val=request.getParameter("getBrand");
			String getQuery="SELECT brand_master.varbrandname,model_details_master.varmodel,model_details_master.intmodelid,"
					+ "color_master.varcolorname,model_details_master.aliasnamemodel FROM brand_master,model_details_master,color_master "
					+ "WHERE model_details_master.intbrandid=brand_master.intbrandid and "
					+ "color_master.intcolorid=model_details_master.intcolorid "
					+ "and brand_master.intbrandid="+val+" ORDER by model_details_master.varmodel";
			List l=gd.getData(getQuery);
			Iterator itr=l.iterator();
			int i=1;
			while(itr.hasNext())
			{
				Object brandLoop=itr.next();
				Object modelLoop=itr.next();
				Object modelIdLoop=itr.next();
				Object colorLoop=itr.next();
				Object aliasLoop=itr.next();
				out.print("<tr><td style='text-align:center'>"+i+"</td>"
						+ "<td style='text-align:center'>"+brandLoop+"</td>"
						+ "<td style='text-align:center' value='"+modelIdLoop+"'>"+modelLoop+"</td>"
						+ "<td style='text-align:center'>"+colorLoop+"</td>"
						+ "<td style='text-align:center'>"+aliasLoop+"</td>"
						+ "<td style='text-align:center'> <a href='#update' data-toggle='modal' onclick='updateModel("+modelIdLoop+")'>Update</a> / "
								+ "  <a href='/MSaleERP/DeleteModel.do?modelId="+modelIdLoop+"'>Delete</a>  </td></tr>");
				i++;
			}
		}
		
		
		
		if(request.getParameter("popAddModel")!=null)
		{
			String brandid=request.getParameter("purBrandid");
			String model=request.getParameter("purModelName");
			String[] colormId = request.getParameterValues("purMcolor");
			
			//check if model already exists
			if(request.getParameter("purModelName")!=null)
			{
				String demoModel=request.getParameter("purModelName");
				boolean checkmodelstatus;
				RequireData rd1=new RequireData();
				checkmodelstatus=rd1.getModelStatus(demoModel, colormId);
				if(checkmodelstatus)
				{
					out.print("model already present,");
					//already present model part
//					request.setAttribute("aStatus", "success");
//					RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/purchase/mobilePurchase.jsp");
//		            rd.forward(request, response);						
				}
				else
				{
					String ram = request.getParameter("purRam");
					String rom = request.getParameter("purRom");
					String[] aliasnamemodel=new String[colormId.length];
					GenericDAO da= new GenericDAO();
					int status=0;
					
					// checking if already exist
					String query1="SELECT varbrandname FROM brand_master WHERE intbrandid="+brandid+";";
					List getbrand= da.getData(query1);
					String aliasforajax="";
					for(int i=0;i<colormId.length;i++)
					{
						String query2="SELECT varcolorname FROM color_master WHERE intcolorid="+colormId[i]+";";
						List getcolorid= da.getData(query2);
						
						if(ram.equals("") && rom.equals(""))
						{
							aliasnamemodel[i]=getbrand.get(0)+"_"+model+"_"+getcolorid.get(0);
							aliasforajax=aliasnamemodel[i];
						}
						else
						{
							aliasnamemodel[i]=getbrand.get(0)+"_"+model+"_"+ram+"_"+rom+"_"+getcolorid.get(0);
							aliasforajax=aliasnamemodel[i];
						}
						String query= "INSERT INTO `model_details_master` (`intbrandid`, `varmodel`, `intcolorid`, `varram`, `varrom`, `aliasnamemodel`) VALUES ('"+brandid+"', '"+model+"', '"+colormId[i]+"', '"+ram+"', '"+rom+"', '"+aliasnamemodel[i]+"')";
						status=da.executeCommand(query);
		            
					}
					//confirm success part
					if(status==1)
					{
						String querynew="SELECT `intmodelid`, `intcolorid`,`aliasnamemodel` FROM `model_details_master` WHERE model_details_master.aliasnamemodel='"+aliasforajax+"'";
						List ajaxlist=da.getData(querynew);
						if(!ajaxlist.isEmpty()){
							Iterator itr=ajaxlist.iterator();
							while(itr.hasNext())
							{
								out.print("Successfully Inserted,"+itr.next()+","+itr.next()+","+itr.next());
							}
						}
					}
					
//					request.setAttribute("aliasName",aliasnamemodel[0]);
//					RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/purchase/mobilePurchase.jsp?brandId="+brandid);
//		            rd.forward(request, response);
				}
			}
			
		}
		
		
		
		//normal insert queries and validations
		if(request.getParameter("brand")!=null)
		{
			
			if(request.getParameter("brand")!=null && request.getParameter("modelname")!=null ) 
			{
				String brandid=request.getParameter("brand");
				String model=request.getParameter("modelname");
				String[] colormId={};  
				
				System.out.println(colormId.length);
				
				if(request.getParameterValues("mcolor")!=null){
					colormId = request.getParameterValues("mcolor");
				}
				
				
				//check if model already exists
				if(request.getParameter("modelname")!=null)
				{
					String demoModel=request.getParameter("modelname");
					boolean checkmodelstatus;
					RequireData rd1=new RequireData();
					checkmodelstatus=rd1.getModelStatus(demoModel, colormId);
					if(checkmodelstatus)
					{
						request.setAttribute("error", "6");
						RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
			            rd.forward(request, response);						
					}
					else
					{
						String ram = request.getParameter("ram");
						String rom = request.getParameter("rom");
						String[] aliasnamemodel=new String[colormId.length];
						GenericDAO da= new GenericDAO();
						// checking if already exist
						String query1="SELECT varbrandname FROM brand_master WHERE intbrandid="+brandid+";";
						List getbrand= da.getData(query1);
						
						for(int i=0;i<colormId.length;i++)
						{
							String query2="SELECT varcolorname FROM color_master WHERE intcolorid="+colormId[i]+";";
							List getcolorid= da.getData(query2);
							
							if(colormId.length==0){
								aliasnamemodel[i]=getbrand.get(0)+"_"+model;
							}
							else if(ram.equals("") && rom.equals(""))
							{
								aliasnamemodel[i]=getbrand.get(0)+"_"+model+"_"+getcolorid.get(0);
							}
							else
							{
								aliasnamemodel[i]=getbrand.get(0)+"_"+model+"_"+ram+"_"+rom+"_"+getcolorid.get(0);
				
							}
							String query= "INSERT INTO `model_details_master` (`intbrandid`, `varmodel`, `intcolorid`, `varram`, `varrom`, `aliasnamemodel`) VALUES ('"+brandid+"', '"+model+"', '"+colormId[i]+"', '"+ram+"', '"+rom+"', '"+aliasnamemodel[i]+"')";
				            da.executeCommand(query);
			            
						}
						request.setAttribute("status1","Inserted Successfully");
						RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
			            rd.forward(request, response);
					}
				}
			}
			else
			{
				request.setAttribute("error", "2");
				RequestDispatcher rd= request.getRequestDispatcher("jsp/admin/settings/addModel.jsp");
		        rd.forward(request, response);
			}
		}
	}
}