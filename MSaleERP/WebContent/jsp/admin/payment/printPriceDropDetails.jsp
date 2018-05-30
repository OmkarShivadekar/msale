<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="utility.SysDate"%>
<%@page import="utility.RequireData"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/config/css/jquery.gritter.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">

<title>Vertical Software</title>
</head>
<body>
	
	
	<div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Price Drop Details</h5>
            <span class="label label-info"></span> 
            										
            </div>
          <div class="widget-content nopadding">
          <%RequireData rd =new  RequireData(); %>
          <%String bid = request.getParameter("brandId"); %>
          <%List priceDropDetails=rd.getPriceDropDetails(bid);
           int count=1;
           Iterator itr=priceDropDetails.iterator();
           
           //List priceDropDetailsImei=rd.getPriceDropDetailsImei();
           //Iterator itr1=priceDropDetailsImei.iterator();
          %>
          <form action="" method="post">
            <table class="table table-bordered table-striped">
              <tr>
              	<th>No</th>
              	<th>Date</th>
              	<th>Model</th>
              	<th>IMEI No</th>
              	<th>Total Quantity</th>
              	<th>Drop Amount</th>
              </tr>
              
              <%if(priceDropDetails!=null) {%>
              <%while(itr.hasNext()) {%>
              <tr>
              	<%Object id=itr.next(); %>
              	<td><%=count %></td>
              	<td><%=itr.next()%></td>
              	<td><%=itr.next()%></td>              	
              	<%String sid=id.toString(); %>
              	<td>
              	<!-- for getting imei -->
              	<%
              		List priceDropDetailsImei=rd.getPriceDropDetailsImei(Integer.parseInt(sid));
              		Iterator itr1=priceDropDetailsImei.iterator();
              	%>	
              		<table>
              		<%
              			while(itr1.hasNext()){
              		%>
              			<tr>
              				<td><%=itr1.next()%></td>
              			</tr>
              		<%} %>	
              		</table>
              	</td>	
              	
              	<td><%=itr.next()%></td>
              	<td><%=itr.next()%></td>
              </tr>
              <%count++;} }%>
            </table>
           </form>
          </div>
        </div>
        </div>

    
	
</body>
</html>