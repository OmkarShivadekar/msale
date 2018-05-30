<%@page import="utility.RequireData"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<script type="text/javascript">

function getSr(id){
		$('form5')
		var someVarName = id;
		localStorage.setItem("someVarName", someVarName);
		var f=document.getElementById("customerTable");
	    f.action='/MSaleERP/jsp/admin/common/quickSearch.jsp?update='+id;
	    f.method="post";
	    f.submit();     
	}
	

	function showModal(){
		var someVarName = localStorage.getItem("someVarName");
		
		if(someVarName>0)
		{
			$('#update').modal('show');
		}
		localStorage.setItem('someVarName', null);
	}
	
	
function monthlyID(id)
{
	localStorage.setItem('selectId', id);
	window.location ="/MSaleERP/jsp/admin/common/quickSearch.jsp?monthId="+id;
}	

function getCustomerList()
{  		
		var request=new XMLHttpRequest();
		var customername = document.getElementById("customername").value;
		var url="/MSaleERP/searchCustomer.do?customername="+customername;  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;
						document.getElementById('tb').innerHTML=val;  
					}  
				}
				request.open("POST",url,true);  
				request.send();  
		}
		catch(e)
		{
			alert("Unable to connect to server");
		}  
} 


</script>
</head>
<body onload="clock()">

	<!--Header-part-->
	<jsp:include page="../common/header_navbar.jsp"></jsp:include>
	
	<!--sidebar-menu-->
	<jsp:include page="../common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->

	<div class='modal hide fade' id='update' role='dialog' style="width: 55%; margin-left:-27%; ">
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
				<h5 style="font-size: 20px;"> Customer Details</h5>

				</div>
				<div class='modal-body' style="max-height: 400px;">
					<%

						
						String rowId = "";
						if (request.getParameter("update") != null) {
							rowId = request.getParameter("update");
							session.setAttribute("sessionId", rowId);
							System.out.print(rowId);
							RequireData rd = new RequireData();
							List cust = rd.getCustomerRowId(rowId);
						
							Iterator iter=cust.iterator();
							
							while (iter.hasNext()) {
								
								Object cust_name=iter.next();
			                	Object address=iter.next();
			                	Object contact=iter.next();
			                	Object invoice_no=iter.next();
								Object date=iter.next();
			                	Object pay_amount=iter.next();
			                	Object imei1=iter.next();
			                	String imei2=iter.next().toString();
			                	Object battery_no=iter.next();
			                	Object charger_no=iter.next();
			                	Object payment_mode=iter.next();
			                	Object modelid=iter.next();
			                	
			                	if(imei2.matches("null")){
			                		imei2="-";
			                	}
					%>
					
					<form class='form-horizontal' method='post' name="form3"  action="/MSaleERP/quickSearch.do" >

						<div class='form-group' >
						  <div class='widget-content nopadding'>
						<table class="table table-bordered table-invoice-full" style="border-color: white;">							
						   
				              <tr><td><label>Invoice No :</label></td>
 				                  <td><input type="text" class="span11" value="<%=invoice_no %>" name="invoice" style="width: 200px; " disabled="disabled"/></td>
								  <td><label>Customer Name :</label></td>
				                  <td><input type="text" class="span11" value="<%=cust_name %>"  style="width: 200px; " disabled="disabled"/></td>
				              </tr>
				  
				              <tr><td><label>Address :</label></td>
 				                  <td><input type="text" class="span11" value="<%=address %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
								  <td><label>Contact No :</label></td>
				                  <td><input type="text" class="span11" value="<%=contact %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
				              </tr>		           

				              <tr><td><label>IMEI 1 :</label></td>
				                  <td><input type="text" class="span11" value="<%=imei1 %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
				                  <td><label>IMEI 2 :</label></td>
 				                  <td><input type="text" class="span11" value="<%=imei2 %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
				              </tr>
				              
				              <tr><td><label>Battery No :</label></td>
				                  <td><input type="text" class="span11" value="<%=battery_no %>" name="update_email_id" style="width: 200px;" disabled="disabled"/></td>
				                  <td><label>Charger No :</label></td>
 				                  <td><input type="text" class="span11" value="<%=charger_no %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
				              </tr>

				              <tr><td><label>Date :</label></td>
 				                  <td><input type="text" class="span11" value="<%=date %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
								  <td><label>Payment Mode :</label></td>
				                  <td><input type="text" class="span11" value="<%=payment_mode %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
				              </tr>

				              <tr><td><label>Pay Amount :</label></td>
 				                  <td><input type="text" class="span11" value="<%=pay_amount %>" name="update_email_id" style="width: 200px; " disabled="disabled"/></td>
 				                  <td></td>
 				                  <td></td>
				              </tr>						              			              			              
</table>			           
								<input type="hidden" name="model_id" value="<%=modelid %>" />
								<input type="hidden" name="invoice_no" value="<%=invoice_no %>" />
				            
							</div>
						
							<%
							}
						}
							%>
						
							
							<div class='modal-footer'>
								<input type='submit' class='btn btn-primary' value='PRINT' onSubmit='' /> 
								<input type='button' class='btn btn-primary' data-dismiss='modal' value='Cancel' />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!--End-breadcrumbs-->

	<!--Action boxes-->
	<div id="content">
	
	<div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">QuickSearch</a> </div>
    <h1>Customer Details</h1>
  </div>
		<div class="container-fluid">
			<hr>
			
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i></span>
							<h5>Search Customer</h5>
						</div>
						<div class="widget-content nopadding">
							<div class="form-horizontal">
								<div class="control-group">
									<label class="control-label" style="margin-left: 270px;"><span style="color: red;">*</span>Customer Name :</label>
									<div class="controls">
										<input type="text" class="span11" placeholder="Customer Name" id="customername" name="customername" onkeyup="myFunction()" style="width: 300px; margin-left: 30px;" /><span class="status"></span>
									</div>
								</div>
								<div class="form-actions" name="customerform" >
									
									<button type="submit" class="btn btn-success" onclick="getCustomerList()" style="margin-left: 420px; font-size: 18px; height: 30px;">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			
			<div class="row-fluid">
				<div class="span12" >
					<div class="widget-box">
						<div class="widget-title" >
							<span class="icon" ><i class="icon-th"></i></span>
							<h5 style="font-size: 1em;" >Customer List</h5>
							<label style="float: right;  margin-top: 5px; margin-right: 10px;">
							<select onchange="monthlyID(this.value)" id="month" style="float: right; width: 200px; ">
			                  <option value="none" selected>Select Month</option>
			                  <option value="01">JANUARY</option>
			                  <option value="02">FEBRUARY</option>
			                  <option value="03">MARCH</option>
			                  <option value="04">APRIL</option>
			                  <option value="05">MAY</option>
			                  <option value="06">JUNE</option>
			                  <option value="07">JULY</option>
			                  <option value="08">AUGUST</option>
			                  <option value="09">SEPTEMBER</option>
			                  <option value="10">OCTOBER</option>
			                  <option value="11">NOVEMBER</option>
			                  <option value="12">DECEMBER</option>
			                </select>
							</label>
							
						</div>
						<div class="widget-content nopadding">
						 <form name="form5" id="customerTable" method="post">
							<table class="table table-bordered data-table">
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Customer Name</th>
										<th>Invoice No</th>
										<th>Date</th>
										<th>Pay Amount</th>
										<th>Action</th>
									</tr>
								</thead >
								<%
								RequireData data = new RequireData();
								List details=null;

								if(request.getParameter("monthId")!=null){
									details = data.getCustomerMonthlyList(request.getParameter("monthId"));
								}else{
									details = data.getCustomerList();
								}
								
									int srno = 0;
									String brandid = "";
									String brand_name = "";

									if (details != null) {
										//System.out.println("in Print quickSearch.jsp" + details);

										Iterator itr = details.iterator();
								%>
								<tbody id="tb">
									<%
										while (itr.hasNext()) {
												srno++;
												Object cust_name=itr.next();
							                	Object invoice_no=itr.next();
							                	Object sdate=itr.next();
							                	Object pay_amount=itr.next();
									%>
									<tr class="gradeX">
										<td><%=srno%></td>
										<td><%=cust_name%></td>
										<td><%=invoice_no%></td>
										<td><%=sdate %> </td>
										<td><%=pay_amount%></td>
										
										<td> <a href="#update" data-toggle="modal"  onclick="getSr(<%=invoice_no%>)">View Details</a></td>  
										
										
										</td>
									</tr>
									<%
										}
										}
									%>
								</tbody>
							</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--end-main-container-part-->
	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
	<script src="/MSaleERP/config/js/jquery.min.js"></script>

	<script src="/MSaleERP/config/js/matrix.tables.js"></script>
	<!--end-Footer-part-->

	<script src="/MSaleERP/config/js/excanvas.min.js"></script>
<!-- 	<script src="/MSaleERP/config/js/jquery.min.js"></script> -->
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
	<script src="/MSaleERP/config/js/jquery.validate.js"></script>
	<script src="/MSaleERP/config/js/matrix.form_validation.js"></script>
	<script src="/MSaleERP/config/js/jquery.wizard.js"></script>
	<script src="/MSaleERP/config/js/jquery.uniform.js"></script>
	<script src="/MSaleERP/config/js/select2.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.popover.js"></script>
	<script src="/MSaleERP/config/js/jquery.dataTables.min.js"></script>
	<!-- 	<script src="/MSaleERP/config/js/matrix.tables.js"></script> -->
<script>
	$('.textarea_editor').wysihtml5();
</script>
</html>