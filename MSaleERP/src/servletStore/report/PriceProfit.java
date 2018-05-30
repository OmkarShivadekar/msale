package servletStore.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.General.GenericDAO;
import utility.RequireData;


//@WebServlet("/PriceProfit")
public class PriceProfit extends HttpServlet {
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			GenericDAO gd=new GenericDAO();
			RequireData rd =new  RequireData();
			
			String modelid=request.getParameter("modelid");
			List sitems=rd.getSoldItems(modelid);
			
			out.print(sitems.get(0));
    	 	
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		GenericDAO gd=new GenericDAO();
		RequireData rd =new  RequireData();
		if(request.getParameter("updateSingle")!=null)
		{
			String count=request.getParameter("count");
			String modelId=request.getParameter("modelId");
			String amount=request.getParameter("value");
			String checkQuery="SELECT `intmodelid` FROM `price_profit`";
			List demoList=gd.getData(checkQuery);
			Iterator itr=demoList.iterator();
			boolean status=false;
			while(itr.hasNext())
			{
				if(modelId.equals(itr.next().toString()))
				status=true;
			}
			if(status)
			{
			String updateQuery="UPDATE `price_profit` SET `intamount`="+amount+" WHERE price_profit.intmodelid="+modelId;
			if(gd.executeCommand(updateQuery)>0)
				out.print(1);
			else
				out.print(0);
			}else{
			String query="INSERT INTO `price_profit`(`intmodelid`, `intamount`) VALUES ("+modelId+","+amount+")";
			if(gd.executeCommand(query)!=0)
				out.print(1);
			else
				out.print(0);
			}
		}
		if(request.getParameter("updateMultiple")!=null)
		{
			String totalModelId[]=request.getParameter("modelId").toString().split(",");
			String totalData[]=request.getParameter("data").toString().split(",");
			for(int i=0;i<totalModelId.length;i++)
			{
				String checkQuery="SELECT `intmodelid` FROM `price_profit`";
				List demoList=gd.getData(checkQuery);
				Iterator itr=demoList.iterator();
				boolean status=false;
				while(itr.hasNext())
				{
					if(totalModelId[i].equals(itr.next().toString()))
					status=true;
				}
				if(status)
				{
				String updateQuery="UPDATE `price_profit` SET `intamount`="+totalData[i]+" WHERE price_profit.intmodelid="+totalModelId[i];
				if(gd.executeCommand(updateQuery)!=0)
					out.print(1);
				else
					out.print(0);
				}else{
				String query="INSERT INTO `price_profit`(`intmodelid`, `intamount`) VALUES ("+totalModelId[i]+","+totalData[i]+")";
				if(gd.executeCommand(query)!=0)
					out.print(1);
				else
					out.print(0);
				}
			}
			
			
		}
	}

}
