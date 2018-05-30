
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utility.SysDate"%>
<%@page import="utility.RequireData"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Vertical Software</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- <link rel="stylesheet" href="/MSaleERP/config/css/bootstrap.min.css" /> -->
<!-- <link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" /> -->
<!-- <link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" /> -->
<!-- <link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" /> -->
<!-- <link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" /> -->
<!-- <link href="config/font-awesome/css/font-awesome.css" rel="stylesheet" /> -->
<!-- <link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" /> -->
<!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'> -->
</head>



<body onload="showModal()">

<!--Header-part-->

<!--close-Header-part--> 


<!--top-Header-menu-->

<!--close-top-Header-menu-->
<!--start-top-serch-->

<!--close-top-serch-->
<!--sidebar-menu-->
<div id="sidebar"><a href="/MSaleERP/jsp/admin/homePage.jsp" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>

    <ul>
    <li><a href="/MSaleERP/jsp/admin/homePage.jsp"><i class="icon icon-home"></i> <span>Dashboard</span></a> </li>
    
    <li class="submenu"> <a href="#"><i class="fa fa-gear"></i> <span>Settings</span> <span class="label label-important">6</span></a>
      <ul>
        
        <li><a href="/MSaleERP/jsp/admin/settings/addDealer.jsp">Add Dealer</a></li>
        <li><a href="/MSaleERP/jsp/admin/settings/addBrand.jsp">Add Brand</a></li>
        <li><a href="/MSaleERP/jsp/admin/settings/addColor.jsp">Add Color</a></li>
        <li><a href="/MSaleERP/jsp/admin/settings/addModel.jsp">Add Model</a></li>
        <li><a href="/MSaleERP/jsp/admin/stock/openingStock.jsp">Add Opening Stock</a></li>
        <li><a href="/MSaleERP/jsp/admin/settings/updateOrganization.jsp">Update Organization</a></li>
        <li><a href="/MSaleERP/jsp/admin/settings/updateInvoice.jsp">Update Organization Invoice</a></li>
        
      </ul>
    </li>
    <li><a href="/MSaleERP/jsp/admin/purchase/newMobilePurchase2.jsp"><i class="fa fa-mobile" style="font-size: 1.5em;"></i> <span>Purchase</span></a></li>
    
	 <li class="submenu"> <a href="#"><i class="fa fa-line-chart"></i> <span>Sale</span><span class="label label-important">3<span></a>
    	<ul>
    	<li><a href="/MSaleERP/jsp/admin/sale/InvoiceScanner.jsp">Sale By The Scanner</a></li>
        <li><a href="/MSaleERP/jsp/admin/sale/Invoice.jsp">Mobile Sale</a></li>
        <li><a href="/MSaleERP/jsp/admin/sale/AccessoriesInvoice.jsp">Accessories Sale</a></li>
      </ul>
    </li>

    <li> <a href="/MSaleERP/jsp/admin/payment/ChequeBook.jsp"><i class="fa fa-bank" ></i> <span>ChequeBook</span></a> </li>
    <li> <a href="/MSaleERP/jsp/admin/payment/priceDrop.jsp"><i class="fa fa-bar-chart" ></i> <span>Price Drop</span></a> </li>
    <li class="submenu"> <a href="#"><i class="fa fa-file-text"></i> <span>Report</span> <span class="label label-important">4</span></a>
      <ul>
        <li><a href="#saleReport" data-toggle="modal"> Generate Sales Report</a></li>
        <li><a href="#purchaseReport" data-toggle="modal">Generate Purchase Report</a></li>
        <li><a href="#dummyReport" data-toggle="modal"> Generate Dummy Report</a></li>
         <li><a href="#brandwiseReport" data-toggle="modal"> Generate Brand Report</a></li>
      </ul>
    </li>
    
  	</ul>
</div>
<!--sidebar-menu-->

<div class="modal hide fade" id="brandwiseReport" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Brand Report</h4>
			</div>
			<% SysDate sd= new SysDate();
                  String date2 =	sd.todayDate();
                %>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/BrandwiseReport.do" method="post" name="brandreport">
					<div class="form-group">
						
						
						<label class="control-label">Select Brand : &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
			                <select name="brandname" id="brandname" style="width: 220px;">
					              <%
					              	 String  brandid="", brandname="";
					              
					                 RequireData rd =new  RequireData();
					                 
					                 List brandnamelist = rd.getBrandIcon();
					                  
					                 
					                 if(brandnamelist!= null)
					                 {
					                     Iterator itr =brandnamelist.iterator();
					                	 while(itr.hasNext())
					                	 {
					                		 brandid= itr.next().toString();
					                		 brandname = itr.next().toString();
					                		 %>
					                		    <option value="<%=brandid %>" > <%=brandname %> </option>
					                		 <%
					                	 }
					                	 %>
					                	   </select>
					                	 <%
					                 }
					                 %>
						</div>
						
						<label class="control-label">From : &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="toDate" id ="purchasedateid" required />				
						</div>
						<label class="control-label">To : &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="fromDate" id ="purchasedateid" value="<%=date2%>" />				
						</div>
					
					</div>
					<div class="modal-footer">
					<input type="submit" name="submitbtn" class="btn btn-primary" value="Generate"  />
					<input type="button" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>
					
			</form>
			</div>
				
			</div>
		</div>
	</div>

<div class="modal hide fade" id="saleReport" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Sales Report</h4>
			</div>
			<% 
                  String date =	sd.todayDate();
                %>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/Report.do" method="post" name="salereport">
					<div class="form-group">
						<label class="control-label">From &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="toDate" id ="purchasedateid" required />				
						</div>
						<label class="control-label">To &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="fromDate" id ="purchasedateid" value="<%=date%>" />				
						</div>
					
					</div>
					<div class="modal-footer">
					<input type="submit" class="btn btn-primary" value="Generate"  />
					<input type="button" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>
					
			</form>
			</div>
				
			</div>
		</div>
	</div>
	
	
	<div class="modal hide fade" id="dummyReport" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Dummy Sales Report</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/DummyReport.do" method="post" name="salereport">
					<div class="form-group">
						<label class="control-label">From &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="toDate" id ="purchasedateid" required />				
						</div>
						<label class="control-label">To &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="fromDate" id ="purchasedateid" value="<%=date%>" />				
						</div>
					
					</div>
					<div class="modal-footer">
					<input type="submit" class="btn btn-primary" value="Generate"  />
					<input type="button" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>
					
			</form>
			</div>
				
			</div>
		</div>
	</div>
	

<div class="modal hide fade" id="purchaseReport" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Purchase Report</h4>
			</div>
			<% SysDate sysd= new SysDate();
                  String date1 =	sysd.todayDate();
                %>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/PurchaseReport.do" method="post" name="purchaseReport">
					<div class="form-group">
						<label class="control-label">From &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="toDate" id ="purchasedateid" required />				
						</div>
						<label class="control-label">To &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="fromDate" id ="purchasedateid" value="<%=date1%>" />				
						</div>
					
					</div>
					<div class="modal-footer">
					<input type="submit" class="btn btn-primary" value="Generate" />
					<input type="button" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>
					
			</form>
			</div>
				
			</div>
		</div>
	</div>


<script type="text/javascript">

</script>

<!--end-Footer-part-->

<!-- <script src="/MSaleERP/config/js/excanvas.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.ui.custom.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/bootstrap.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.flot.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.flot.resize.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.peity.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/fullcalendar.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/matrix.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/matrix.dashboard.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.gritter.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/matrix.interface.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/matrix.chat.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.validate.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/matrix.form_validation.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.wizard.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.uniform.js"></script>  -->
<script src="/MSaleERP/config/js/select2.min.js"></script> 
<!-- <script src="/MSaleERP/config/js/matrix.popover.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/jquery.dataTables.min.js"></script>  -->
<!-- <script src="/MSaleERP/config/js/matrix.tables.js"></script>  -->


</html>