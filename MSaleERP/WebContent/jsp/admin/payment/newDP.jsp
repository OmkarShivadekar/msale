<%@page import="java.util.Date"%>
<%@page import="dao.General.GenericDAO"%>
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

<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/MSaleERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/datepicker.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">

<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/config/css/jquery.gritter.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<style type="text/css">
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

	#TFtable{
		width:100%; 
		border-collapse:collapse; 
	}
	#TFtable td{ 
		padding:7px; border:#dfe1e2 1px solid;
	}
	/* provide some minimal visual accomodation for IE8 and below */
	#TFtable tr{
		background: #f9f9f9;
	}
	/*  Define the background color for all the ODD background rows  */
	#TFtable tr:nth-child(odd){ 
		background: #f9f9f9;
	}
	/*  Define the background color for all the EVEN background rows  */
	#TFtable tr:nth-child(even){
		background: #efefef;
	}

#snackbar {
    visibility: hidden;
    min-width: 250px;
    margin-left: -125px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border-radius: 20px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    left: 50%;
    top: 80px;
    font-size: 14px;
}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {top: 0; opacity: 0;} 
    to {top: 80px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 80px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 80px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 80px; opacity: 1;}
    to {top: 0; opacity: 0;}
}
.table td {
   text-align: center;   
}
</style>
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

<body onload="setFocusToTextBox()">

<script type="text/javascript">
history.pushState(null, null, document.URL);
window.addEventListener('popstate', function () {
    history.pushState(null, null, document.URL);
});

window.oncontextmenu = function () {
	   return false;
	}
</script>

<jsp:include page="../common/header_navbar.jsp"></jsp:include>


<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Payment</a> <a href="/MSaleERP/jsp/admin/report/priceProfit.jsp" class="tip-bottom" title="To Set Purchase Price" style="margin-left: 810px;"><span class="date badge badge-info">Purchase Price</span></a>  </div>
  </div>
<!-- END breadcrumbs-->  

	<% Object error1=request.getAttribute("error1");%>
	<input type="hidden" name="error1" id="error1" value="<%=error1 %>" />
  
  
  	<% if(request.getAttribute("status1")!=null){ %>
	<div id="snackbar"><%=request.getAttribute("status1")%></div>
	<%}else if(request.getParameter("dealerId")==null){ %>
	<div id="snackbar">Please Select Dealer First</div>
	<%}%>
	
  
  
  
    <div class="row-fluid">
    <div class="container-fluid">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Dealer Payment </h5>
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/DealersPayment.do" method="post" class="form-horizontal" name="paymentform">
              	
          <%
	        	String dealerId="";
          		String dealerName="";
	        	if(request.getParameter("dealerId")!=null)
	        	{
	        		dealerId=request.getParameter("dealerId");
	        	}
	        		
	        	RequireData rd=new RequireData();
	        	SysDate sd= new SysDate();
	            String date =	sd.todayDate();
		  %>

            
            
            <div class="control-group" style="height: 55px;">
             	<label class="control-label" style="margin-left: 0px;"><span style="color: red;">*</span>Organization Name :</label>
            	<div class="controls" >
	              <select name="dealerId"  id="dealerList" style="width: 300px;" required onchange="window.location.href='/MSaleERP/jsp/admin/payment/newDP.jsp?dealerId='+this.value">
    	          	<option value=''>select</option>
        	      	
        	      	<% 
        	      		List getDealers=rd.getDealerList(); 
            	  		if(!(getDealers.isEmpty()))
		              	{
		          	    	Iterator itrGetDealerList=getDealers.iterator();
		            	  	while(itrGetDealerList.hasNext()){
		              			Object id=itrGetDealerList.next();
		              			Object name=itrGetDealerList.next();
		              		if(id.toString().equals(dealerId.toString())){
              		%>
              			<option selected="selected" value="<%=id%>"><%=name%></option>
              		<%}else{ %>
              			<option value="<%=id%>"><%=name%></option>
              		<%} %>
              	<%} }%>
              </select>
              </div>
              
              <%
              		dealerName=rd.getDealerName(request.getParameter("dealerId"));
              %>
              
              <label class="control-label" style="margin-top: -4.5%; margin-left: 45%;">Dealer Name :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Dealer Name" name="dealerName" readonly="readonly" value="<%=dealerName %>" style="width: 300px;  margin-top: -5.4%; margin-left: 55%;" />
              </div>
            </div>
            
            <div class="control-group" style="height: 55px;">
            <%
            	String totalremining="0";
            	if(request.getParameter("dealerId")!=null){
	            	totalremining=rd.getTotalReminingAmount(request.getParameter("dealerId"));
            	}
            %>
            
            
              <label class="control-label">Total Due Amount :</label>
              <div class="controls">
              	<input type="text" id="tdamt" readonly="readonly" value="<%=totalremining %>" class="span11" name="tda" style="width: 300px;"/>
              </div>
              
              <label class="control-label" style="margin-top: -4.5%; margin-left: 45%;">Date :</label>
              <div class="controls">
                <input type="date" class="span11" value="<%=date %>" name="paymentdate" style="width: 300px;  margin-top: -5.4%; margin-left: 55%;" />
              </div>              
            </div>
            
            <div class="control-group" style="height: 55px;">
				<label class="control-label"><span style="color: red;">*</span>Current Pay Amount :</label>
			    	<div class="controls">
			    		<input type="text" class="span2" onkeyup="remainingDueAmount()" onkeypress="return isNumber(event)" placeholder="Current Pay Amount" autocomplete="off" id="cpamt" name="cpa" value="" style="width: 300px;" required />
			    	</div>
			    	
			    	<label class="control-label" style="margin-top: -4.5%; margin-left: 45%;">Remaining Amount :</label>
			    	<div class="controls">
			    		<input type="text" class="span2" readonly="readonly" placeholder="Remaining Amount" id="trda" name="trda"  value="" style="width: 300px; margin-top: -5.4%; margin-left: 55%;"/>
			    	</div>
            </div>
                 
            <div class="control-group" style="height: 55px;">
            	<label class="control-label"><span style="color: red;">*</span>Payment Mode :</label>
	            <div>
	                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                  Cheque &nbsp;&nbsp;&nbsp;&nbsp;<input value="Cheque" type="radio" id="cheque"  name="radio_payment" checked="checked" style="border: 50px;  height: 50px;" onclick="chk_fun('cheque')">
	                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                  Cash&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="cash" name="radio_payment" style="border: 50px;  height: 50px;"value="Cash" onclick="chk_fun('cash')">
	              </div>
	        </div>
	        
            <div class="control-group">
		   	<div class="span10">
		   		<div class="widget-box" style="margin-left: 180px;">
		          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
				            <h5 style="font-size: 14px;">Cheque's</h5>
				            <a href="#addcheques" data-toggle="modal"><span class="badge badge-inverse tip-right" title="Add Cheque" style="position: relative; float: right; padding-top: 3px; top: 9px; right: 10px;"><i class="icon-plus"></i></span></a>
		          </div>
		          <div class="widget-content nopadding">
		            <table class="table table-bordered table-striped" id="TFtable">
		              <thead>
		                <tr>
		                  <th>No.</th>
		                  <th>Cheque No.</th>
		                  <th>Action</th>
		                </tr>
		              </thead>
		              	
		              <%
		              		List dealerCheque=rd.getDealerCheque(request.getParameter("dealerId"));
		              		
		              		int count=0;
		              		if(dealerCheque!=null){
		              			Iterator itr=dealerCheque.iterator();
		              			int i=1;
		              			
		              			while(itr.hasNext()){
		              				Object chq_no=itr.next();
		              				%>
		                <tr class="odd gradeX">
		                  <td ><%=i %></td>
		                  <td><%=chq_no %></td>
		                  <td><input type="radio" name="checkbox_cheque_no" id="<%=i%>" value="<%=chq_no %>" required></td>
		                </tr>
		                <% i++;count++;}
		              	}
		              %>
		               <input type="hidden" id="count" value="<%=count%>" />
		               
		              </tbody>
		            </table>
		          </div>
		        </div>
		       </div>   
	        </div>	        
	        
                       
              <div class="form-actions" style="margin-top:0px;" align="center">
                <button type="submit" id="submitbtn"  class="btn btn-success">PAY</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/MSaleERP/jsp/admin/homePage.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
              </div>
          </form>
          
        </div>
      </div>
      
      
        <div class="widget-box">
          <div class="widget-title" style="font-size: 20px;"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5 style="font-size: 15px;">Payment List</h5>&nbsp;
            <h5 style="font-size: 13px;">Last Month Due :</h5>
            <h5 style="font-size: 13px; color: red; margin-left: -15px;" >
            <%
            	List l=rd.getLastMonthDue(request.getParameter("dealerId"));
            	int size=l.size();
            %>
            <%out.print(l.get(size-1));%>
            </h5>
             <select onchange="hello(this.value)" id="monthlydata" style="width: 120px; margin-top: 5px; margin-right: 5px; border: 1px solid #000000; background-color: #f9f9f9; height: 26px; font-family: georgia, sans-serif; positive:relative; float:right;" >
                  <option value="none" selected>Select</option>
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
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped" id="TFtable">
              <thead>
                <tr>
                  <th style="width: 23px">No.</th>
                  <th style="width: 200px">Date</th>
                  <th style="width: 200px">Invoice No</th>
                  <th style="width: 200px">Bill Amount</th>
                  <th style="width: 200px">Paid Amount</th>
                  <th style="width: 160px">Payment Mode</th>
                  <th style="width: 160px">Cheque No</th>
                  <th style="width: 200px">Total Remaining Amount</th>
                </tr>
              </thead>
              <tbody>
              <%
              
              	 GenericDAO gd=new GenericDAO();
                 List dealerPaymentDetail;
              	 if(request.getParameter("monthId")!=null)
              	 {
              		dealerPaymentDetail = rd.getMonthlyDetails(request.getParameter("dealerId"),request.getParameter("monthId"));
              	 }
              	 else
              	 {
              		dealerPaymentDetail = rd.DealerPaymentDetails(request.getParameter("dealerId"));
              	 }
                 
                 
                 Iterator itr =dealerPaymentDetail.iterator();
                 int i=1;
                 while(itr.hasNext())
                {	
                	Object transactdate=itr.next();
                	Object invoiceno=itr.next();
     				int billamount=Integer.parseInt(itr.next().toString());
     				Object paidamount=itr.next();
     				int chequeid=Integer.parseInt(itr.next().toString());
     				Object remaining=itr.next();
     				
     				String chq_no=null;
     				String chq_mode=null;
    				
     				if(invoiceno==null){
     					invoiceno="-";
     				}
     				
     				if(chequeid!=0)
    				{
    					String query2="SELECT  chequebook.varchequeno from chequebook where chequebook.intchequebookid='"+chequeid+"'";
    					List demolist=gd.getData(query2);
    					Iterator iterator=demolist.iterator();
    					while(iterator.hasNext()){
    						chq_no=iterator.next().toString();
    					}
    					chq_mode="Cheque";
    				}
     				else{
     					chq_no=" ";
     					if(!(billamount!=0))
     						chq_mode="Cash";
     					else
     						chq_mode=" - ";
     					chq_no=" - ";
     				}
     				
                	 
               %>
                		 
              	<tr>
              	  <td style="text-align: center;"><%=i%></td>
                  <td style="text-align: center;"><%=transactdate %></td>
                  <td style="text-align: center;"><%=invoiceno %></td>
                  <td style="text-align: center;" ><%=billamount %></td>
                  <td style="text-align: center;"><%=paidamount %></td>
                  <td style="text-align: center;"><%=chq_mode %></td>
                  <td style="text-align: center;"><%=chq_no %></td> 
                  <td style="text-align: center;"><%=remaining %></td>
                </tr>
                <% i++;} 
                %>            
              </tbody>
            </table>
          </div>
       </div>
      
      
     </div>
    </div>
    
    
</div>


<!--Footer-part-->
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>

<!--end-Footer-part-->

<div class="modal hide fade" id="error-msg2" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" name="form4">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <h4>Please Assign Cheque First...</h4>
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

<div class="modal hide fade" id="error-msg" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" name="form4">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <h4>Given cheque Number(s) already Exist...<br> Please check carefully.. </h4>
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



<div class="modal hide fade" id="addcheques" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add Cheque</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/ChequeBook.do" method="post" name="form3">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <label class="control-label">Cheque No :</label>
				              <div class="controls">
				              	<input type="hidden" id="hidden_did" name="hidden_did" value="<%=request.getParameter("dealerId") %>" />
				                <input type="text" class="span11" placeholder="Cheque Number" id="chequeno" onkeypress="return isNumber(event)" maxlength="6" name="chequeno" style="width: 300px;" required />
				              </div>
				            </div>
						</div>
					<div class="modal-footer">
					<input type="submit" id="submitbtn" name="submitbtn" class="btn btn-primary" value="Submit" onSubmit="" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

function setFocusToTextBox() {
	clock();
	document.paymentform.dealerList.focus();
    showModal();
    myFunction();
}

function showModal(){
	
	var someVarName = document.getElementById("error1").value;
	if(someVarName==1)
		{
			$('#error-msg').modal('show');
		}
	else if(someVarName==2)
		{
		$('#error-msg2').modal('show');
		}
	localStorage.setItem('someVarName', null);
}

function myFunction() {
	
	
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

$(document).ready(function() {
	$("#cpamt").keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '9') {
			remainingDueAmount();
		}
		event.stopPropagation();

	});
});

function remainingDueAmount()
{	
	var val1=document.getElementById('tdamt').value;	
	var val2=document.getElementById('cpamt').value;
	var ans=val1-val2;
	document.getElementById("trda").value =ans;
}

function chk_fun(str){
	var no=1;
	var c=document.getElementById('count').value;
	
	for (var i = 1; i <=c; i++) {
		if (str=='cheque')
			document.getElementById(i).disabled=false;
		else
			document.getElementById(i).disabled=true;		
	}	
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function hello(id)
{
	localStorage.setItem('selectId', id);
	window.location ="/MSaleERP/jsp/admin/payment/newDP.jsp?dealerId=<%=request.getParameter("dealerId")%>&monthId="+id;
}
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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

</body>
<script type="text/javascript">
$('#addcheques').on('shown.bs.modal', function () {
    $('#chequeno').focus();
}) 	
</script>
</html>