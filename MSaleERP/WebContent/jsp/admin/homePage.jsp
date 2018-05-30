<%@page import="java.util.Date"%>
<%@ page errorPage="error/errorPage.jsp" %>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utility.SysDate"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/MSaleERP/config/font-awesome/css/font-awesome.css"  />
<link rel="stylesheet" href="/MSaleERP/config/css/jquery.gritter.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>


<style type="text/css">

.quick-actions_homepage {
    width: 100%;
    text-align: center;
    position: relative;
    float: none; 
    margin-top: 0px; 
}

#submitbtn{
	background-color: 64b566
}
#submitbtn:focus {
	font-size: 14px;
	background-color: green;
	
}
#submitbtn:hover {
	font-size: 14px;
	background-color: green;
}

#cancelbtn{
	background-color: #e2554f;
}
#cancelbtn:focus {
	font-size: 14px;
	background-color: #da312a;
}
#cancelbtn:hover {
	font-size: 14px;
	background-color: #da312a;
}
</style></head>

<%
	
	if(session.getAttribute("username")==null)
	{
		response.sendRedirect("/MSaleERP");

	}
%>


<body onload="showModal()">

<!--Header-part-->
<jsp:include page="common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->


<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    
  </div>
<!--End-breadcrumbs-->


<!--Action boxes-->
  <div class="container-fluid">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
      
		<li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/sale/InvoiceScanner.jsp"> <i class="fa fa-line-chart" style="font-size: 2.33333333333em;"></i> <br> <span class="label label-important"></span>Sale By The Scanner</a> </li>
        
      	<li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/purchase/newMobilePurchase2.jsp"> <i class="fa fa-mobile" style="font-size: 2.3566em;"></i> <br> <span class="label label-important"></span> Purchase</a> </li>
      	
        <li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/sale/Invoice.jsp"> <i class="fa fa-line-chart" style="font-size: 2.33333333333em;"></i> <br> <span class="label label-important"></span>Mobile Sale</a> </li>
        
        <li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/sale/AccessoriesInvoice.jsp"> <i class="fa fa-line-chart" style="font-size: 2.33333333333em;"></i> <br> <span class="label label-important"></span>Accessories Sale</a> </li>
        
        <li class="bg_lb" style="border:1px solid;"> <a href="#paymentPassword" data-toggle="modal"> <i class="fa fa-inr" style="font-size: 2.33333333333em;" ></i>  <br> <span class="label label-important"></span> Payment</a> </li>
        
        <li class="bg_lb" style="border:1px solid;"> <a href="#cheque-bounce1"  data-toggle="modal"> <i class="fa fa-bank" style="font-size: 2.33333333333em;" ></i>  <br> <span class="label label-important"></span> Cheque Bounce</a> </li>
        
        <li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/stock/Stock.jsp"> <i class="fa fa-cubes" style="font-size: 2.33333333333em;"></i> <br><span class="label label-important"></span> Stock</a> </li>
        
        <li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/stock/agewiseStock.jsp"> <i class="fa fa-cubes" style="font-size: 2.33333333333em;"></i> <br><span class="label label-important"></span> Age wise Stock</a> </li>
        
        <li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/settings/expences.jsp"> <i class="fa fa-money" style="font-size: 2.33333333333em;"></i> <br> <span class="label label-important"></span> Expenses</a> </li>
      
        <li class="bg_lb" style="border:1px solid;"> <a href="/MSaleERP/jsp/admin/common/quickSearch.jsp" > <i class="fa fa-search" style="font-size: 2.02333333333em;"></i> <br> <span class="label label-important"></span> Quick Search</a> </li>
      </ul>
    </div>   
  </div>
    
<!--End-Action boxes-->    

<!--Chart-box-->    
    
<!--End-Chart-box--> 


</div>

<!--end-main-container-part-->


<div class="modal hide fade" id="paymentPassword" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title"><span style="color:red">Password</span></h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/DealersPayment.do" method="post" name="paymentpass">
					<div class="form-group">
						<label class="control-label">Enter Password : &nbsp;</label>
						<div class='controls' id="container" style="margin: 0 auto;">
							<input type="password" class="span11" placeholder="Enter Password" id="getpassword"  name="getpassword" autocomplete="off" style="width: 300px;" required />			
						</div>									
					</div>
					<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" value="Submit" onclick="" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>			
			</form>
			</div>
				
			</div>
		</div>
	</div>
	

<div class="modal hide fade" id="wrong-password-msg" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" name="form6">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">  					
				              <h4>Please enter correct Password... </h4>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="button" class="btn btn-primary" data-dismiss="modal" value="OK"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>	

<%
	Object error1 = request.getAttribute("error1");
	if(error1=="2"){
			%>
			<script type="text/javascript">
				localStorage.setItem("error1", "2");
			</script>
			<%}	%>
	
<input type="hidden" name="error1" id="error1" value="<%=error1 %>" />
	

<div class="modal hide fade" id="datewiseReport" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Multiple Sales Report</h4>
			</div>
			<% SysDate sd= new SysDate();
                  String date =	sd.todayDate();
                  
              	%>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/Report.do" method="post" name="salereport">
					<div class="form-group">
						<label class="control-label">To &nbsp;</label>
						<div class='controls' id="container" style="margin: 0 auto;">
							<input type="date" name="toDate" id ="purchasedateid" value="<%%>">				
						</div>
						<label class="control-label">From &nbsp;</label>
						<div class='controls' id="container" style="margin: 0 auto;">
							<input type="date" name="fromDate" id ="purchasedateid" value="<%=date%>">				
						</div>
					
					</div>
					<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" value="Generate" onclick="" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>
					
			</form>
			</div>
				
			</div>
		</div>
	</div>



<div class="modal hide fade" id="cheque-bounce1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Cheque Bounce Status</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" name="form4">
					<div class="form-group">
						<div class="control-group">
				              <label class="control-label">Cheque Number :</label>
				              <div class="controls">
				                <input type="text" class="span11" pattern= "[0-9]*" maxlength="6" placeholder="Enter Bounced Cheque Number" id="cheque-number"  name="cheque-number" style="width: 300px;" />
				              </div>
				        </div>					
					</div>
					<div class="modal-footer">
					<input type="button" id="submitbtn" class="btn btn-primary" value="Submit" onclick="getSr()" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" on value="Cancel"/>
					</div>					
			</form>
			</div>
				
			</div>
		</div>
	</div>


<%

String chequeno = request.getParameter("chequeno");
String error = request.getParameter("error");

if(chequeno!=null){
	
	GenericDAO gd1 = new GenericDAO();
	String dealerid="", dealer_org_name="";
	String q="SELECT chequebook.intdealerid, cheque_payment_master.datewithdrawaldate ,cheque_payment_master.intchequeamount FROM `chequebook`, `cheque_payment_master` WHERE chequebook.varchequeno='"+chequeno+"' AND cheque_payment_master.varchequeno='"+chequeno+"';";
	List BouceChequeData =gd1.getData(q);
	System.out.println(BouceChequeData);
	
	Iterator itr1 =  BouceChequeData.iterator();
	
	if(itr1.hasNext()){
		dealerid = itr1.next().toString();
		String q1 = "select varorganizationname from dealer_master where intdealerid='"+dealerid+"';";
		List dealerOrg_name = gd1.getData(q1);
		
		dealer_org_name = dealerOrg_name.get(0).toString();
		
	}
	else{
		%>
		<script type="text/javascript">
			localStorage.setItem("error", "1");
		</script>
		<%
	}
	
	
%>



<div class="modal hide fade" id="cheque-bounce2" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Cheque Number  "<%= chequeno %>"  Deatils</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/ChequeBounce.do"  method="get" name="form3">
					<div class="form-group">
					
					<%
						
						while(itr1.hasNext())
						{
					%>
						
  				        <div class="control-group">
			              <label class="control-label">Organization Name :</label>
			              	<div class="controls">
			                	<input type="text" class="span11" placeholder="Dealer Name" id="bounce_cheque_dealer_id" value="<%= dealer_org_name %>" name="bounce_cheque_org_name" style="width: 300px;" readonly="readonly" />
			                	<input type="hidden" name="cheque-number" id="cheque-number" value="<%= chequeno %>">
			              </div>
            			</div>
            			
            			<div class="control-group">
			              <label class="control-label">Cheque Date :</label>       
			              	<div class="controls controls-row">
			            		<input type="text" class="span11" placeholder="Cheque Date"  id="bounce_chequebook_date" value="<%= itr1.next() %>" name="bounce_chequebook_date"  style="width: 300px;" readonly="readonly" /> 
			          		</div>
			            </div>	
			            
			            <div class="control-group">
				              <label class="control-label">Cheque Amount :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Cheque Amount" id="bounce_cheque_amount" value="<%= itr1.next() %>"  name="bounce_cheque_amount" style="width: 300px;" readonly="readonly" />
				              </div>
  				        </div>
  				        
  				         
			  		<% 
						}
						
					%>		        	
			            	
					</div>
					<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" value="Submit" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel"/>
					</div>
			</form>
			</div>
				
			</div>
		</div>
	</div>


<input type="hidden" name="error" id="error" value="<%= error %>" />
 


<div class="modal hide fade" id="error-msg" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" name="form3">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">  					
				              <h4>Please check given cheque number carefully.. </h4>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="button" class="btn btn-primary" data-dismiss="modal" value="OK"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>




<% 
	}
%>

<!--Footer-part-->

<div class="row-fluid">
<div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>



<!--end-Footer-part-->

<script src="/MSaleERP/config/js/excanvas.min.js"></script> 
<script src="/MSaleERP/config/js/jquery.min.js"></script> 
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
<script src="/MSaleERP/config/js/matrix.tables.js"></script> 

<script type="text/javascript">
$('.modal-backdrop').remove();
	
	function getSr(){
		$('form4')
		var id = document.getElementById("cheque-number").value;
		var someVarName = id;
		localStorage.setItem("someVarName", someVarName);
		var f=document.form4;
	    f.action='/MSaleERP/jsp/admin/homePage.jsp?chequeno='+id;
	    f.method="post";
	    f.submit();     
	}
	
	function showModal(){
		var someVarName = localStorage.getItem("someVarName");
		var error = localStorage.getItem("error");
		var error1 = localStorage.getItem("error1");

		
		if(error==1)
		{
			$('#error-msg').modal('show');
		}
		else if(error1==2)
		{
			$('#wrong-password-msg').modal('show');
		}			
		else if(someVarName>0)
		{
			$('#cheque-bounce2').modal('show');
		}
		
		
		localStorage.setItem('someVarName', null);
		localStorage.setItem('error', null);
		localStorage.setItem('error1', null);
		clock();
	}



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
  
$('#paymentPassword').on('shown.bs.modal', function () {
    $('#getpassword').focus();
}) 
</script>

</html>