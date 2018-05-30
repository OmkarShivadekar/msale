<%@ page errorPage="../error/errorPage.jsp" %>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> 
<%@ page import="java.util.*" %>
<%@page import="java.sql.ResultSet"%>
<%@ page import="dao.General.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Vertical Software</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>


</head>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	if(session.getAttribute("username")==null)
	{
		response.sendRedirect("/MSaleERP");

	}
%>

<body onload="myFunction()">

<!--Header-part-->
<jsp:include page="../common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->

  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Stock</a></div>
 
  <div class="container-fluid">
  	<div class="quick-actions_homepage">
      <ul class="quick-actions">
      
       <% 		
       RequireData rd=new RequireData();
		List demoList1=rd.getStockDetails();  
		

		Iterator itr=demoList1.iterator();
	
		while(itr.hasNext())
		{
			Object brandid=itr.next();
			Object brandname=itr.next();
			int sumofqtty=rd.getTotalQuantity(brandid.toString());
                		
             %>
                		 
                  <li class="bg_lb"  id="span_brandid" style="border: 1px solid; "> 
                  <a href= "/MSaleERP/jsp/admin/stock/Stock.jsp?brandid=<%=brandid%>"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i><br><span class="label label-important"><%=sumofqtty %></span><%=brandname %></a>
                  </li>
                 
        <%} %>
          </ul>
    </div>    
    
      </div>
    
    <% 
    //RequireData rd=new RequireData();
		List demoList=rd.getStockDetails();
		if(!demoList.isEmpty())
		{
	%>
		    

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped with-check">
              <thead style="text-align: center">
                <tr>
                  <th style="width: 5px">S.No.</th>
                  <th style="width: 260px">Brand Name</th>
                  <th colspan="2" style="width: 160px"><div style="position:relative;	 left:50px; width:350px;"><div style=" width:80px; float: left;">Model(s)</div><div style="float:left;margin-left: 50px;">Quantity</div> <div style="position: relative;right: 60px;">Price</div> <div style="position: relative;left: 0px;margin-top:-20px;">Total</div></div></th>
                </tr>
              </thead>
              <tbody>
                <%
                	if(request.getParameter("brandid")!=null){
                		
                		List d=rd.getStockDetailsByBrand(request.getParameter("brandid"));
                		
                        
    					Iterator itr1=d.iterator();
    					int i=1;
    					while(itr1.hasNext())
    					{
    						Object brandid=itr1.next();
                    %>
                    <tr>
                     <td><%=i %></td><%i++; %>
                     <td  style="text-align: center;"><%=itr1.next() %>
                     <%int sumofqty=rd.getTotalQuantity(brandid.toString()); %>
                     <br><br>
                     <span class="badge badge-important">Total Stock = <%=sumofqty %> nos</span><br><br>
                     <span class="badge badge-warning" id="total">Total Amount = </span>
                     
                     </td>
                     <td>
                     <table  style="width: 350px">
                     <%List demoList2=rd.getStockDetails2(brandid.toString());
                     Iterator itr2=demoList2.iterator();
                     int totalsum=0;
                     while(itr2.hasNext())
                     {
                    	 Object modelname=itr2.next();
                    	 String quan=itr2.next().toString();
                    	 String price=itr2.next().toString();
                    	 int totalPrice=Integer.parseInt(quan)*Integer.parseInt(price);
                    	 totalsum+=totalPrice;
                    	 
                     %>
                     
                     
                     <tr>
                     	<td style="width: 350px;"><%=modelname %></td>
                     	<td style="width: 100px; text-align: center;"><%=quan %></td>
                     	<td style="width: 100px; text-align: center;"><%=price %></td>
                     	<td style="width: 100px; text-align: center;"><%=totalPrice %></td>
                     </tr>
                     <%} 
                     %>
                     <input type="hidden" id="tAmt" value="<%=totalsum %>"/>
                     
                     </table>
                     </td>
                     
                    </tr>
                    <%} 
                	}else{
                        
    					Iterator itr1=demoList.iterator();
    					int i=1;
    					while(itr1.hasNext())
    					{
    						Object brandid=itr1.next();
                    %>
                    <tr>
                     <td><%=i %></td><%i++; %>
                     <td  style="text-align: center;"><%=itr1.next() %>
                     <%int sumofqty=rd.getTotalQuantity(brandid.toString()); %>
                     <br><br>
                     <span class="badge badge-important">Total Stock = <%=sumofqty %> nos</span><br><br>
                     
                     </td>
                     <td>
                     <table  style="width: 350px">
                     <%List demoList2=rd.getStockDetails2(brandid.toString());
                     Iterator itr2=demoList2.iterator();
                     int totalSum1=0;
                     while(itr2.hasNext())
                     {
                    	 Object modelname=itr2.next();
                    	 String quan=itr2.next().toString();
                    	 String price=itr2.next().toString();
                    	 int totalPrice=Integer.parseInt(quan)*Integer.parseInt(price);
                    	 totalSum1+=totalPrice;
                    	 
                     %>
                     
                     <tr>
                     	<td style="width: 350px;"><%=modelname %></td>
                     	<td style="width: 100px; text-align: center;"><%=quan %></td>
                     	<td style="width: 100px; text-align: center;"><%=price %></td>
                     	<td style="width: 100px; text-align: center;"><%=totalPrice %></td>
                     
                     </tr>
                     <%} %>
                     
                     </table>
                     </td>
                     
                    </tr>
                    <%} 	
                	}//end ELSE
                %>

                
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  <%} %>
</div>
<!--end-main-container-part-->


<!--Footer-part-->
</div>
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>

<!--end-Footer-part-->
	
	<script src="/MSaleERP/config/js/jquery.validate.js"></script>
	<script src="/MSaleERP/config/js/matrix.form_validation.js"></script>
	<script src="/MSaleERP/config/js/jquery.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.tables.js"></script>
	<script src="/MSaleERP/config/js/excanvas.min.js"></script>
	<script src="/MSaleERP/config/js/jquery.ui.custom.js"></script>
	<script src="/MSaleERP/config/js/bootstrap.min.js"></script>
	<script src="/MSaleERP/config/js/jquery.flot.min.js"></script>
	<script src="/MSaleERP/config/js/jquery.flot.resize.min.js"></script>
	<script src="/MSaleERP/config/js/jquery.peity.min.js"></script>
	<script src="/MSaleERP/config/js/fullcalendar.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.js"></script>
	<script src="/MSaleERP/config/js/matrix.dashboard.js"></script>
	<script src="/MSaleERP/config/js/jquery.gritter.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.interface.js"></script>
	<script src="/MSaleERP/config/js/matrix.chat.js"></script>
	<script src="/MSaleERP/config/js/jquery.wizard.js"></script>
	<script src="/MSaleERP/config/js/jquery.uniform.js"></script>
	<script src="/MSaleERP/config/js/select2.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.popover.js"></script>
	<script src="/MSaleERP/config/js/jquery.dataTables.min.js"></script>
	<script src="/MSaleERP/config/js/jquery.validate.js"></script>
	<script src="/MSaleERP/config/js/matrix.form_validation.js"></script>


<script type="text/javascript">

  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
  function goPage (newURL) {

      // if url is empty, skip the menu dividers and reset the menu selection to default
      if (newURL != "") {
      
          // if url is "-", it is this page -- reset the menu:
          if (newURL == "-" ) {
              resetMenu();            
          } 
          // else, send page to designated URL            
          else {  
            document.location.href = newURL;
          }
      }
  }

// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
  function myFunction()
  {
	  clock();
	  var amt=document.getElementById('tAmt').value;
	 
	  
	  document.getElementById('total').innerHTML="Total Amount = "+amt+" Rs.";
  }
</script>

</html>