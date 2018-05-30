<%@page import="java.util.Date"%>
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
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/config/css/jquery.gritter.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">

<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<style>

#pureSubmit{
	background-color: #4dd14d
}
#pureSubmit:focus {
	background-color: green;
	
}


#cancelbtn{
	background-color: #d69491
}
#cancelbtn:focus {
	background-color: #f11006;
}
#cancelbtn:hover {
	background-color: #f11006;
} 

#dialogoverlay{
	display: none;
	opacity: .8;
	position: fixed;
	top: 0px;
	left: 0px;
	background: #FFF;
	width: 100%;
	z-index: 10;
}
#dialogbox{
	display: none;
	position: fixed;
	border-radius:7px; 
	width:550px;
	z-index: 10;
}
#dialogbox > div{ background:#FFF; margin:8px; }
#dialogbox > div > #dialogboxhead{ border-radius:10px 10px 0px 0px;background: #666; font-size:19px; padding:10px; color:#CCC; }
#dialogbox > div > #dialogboxbody{ background:#e8e6e6; padding:20px; color:black; font-family: "Times New Roman", Georgia, Serif; }
#dialogbox > div > #dialogboxfoot{ border-radius:0px 0px 10px 10px;background: #666; padding:10px; text-align:right; }
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
<script>

history.pushState(null, null, document.URL);
window.addEventListener('popstate', function () {
    history.pushState(null, null, document.URL);
});

window.oncontextmenu = function () {
	   return false;
	}

  document.onkeydown = function(){
	  switch (event.keyCode){
	        case 116 : //F5 button
	            event.returnValue = false;
	            event.keyCode = 0;
	            return false;
	        case 82 : //R button
	            if (event.ctrlKey){ 
	                event.returnValue = false;
	                event.keyCode = 0;
	                return false;
	            }
	    }
	}
  
 
  
  
</script>
<%System.out.println("IN Mobile Purchase.jsp"); %>


<!--Header-part-->
<jsp:include page="../common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Purchase</a></div>
    
  </div>
  <% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>
<!--End-breadcrumbs-->

<!--Action boxes-->
  <div class="container-fluid">
  	<div class="quick-actions_homepage">
      <ul class="quick-actions">
       <% 	    
       			String brandId=null;
       			if((request.getParameter("brandId")!=null))
						{
							brandId=request.getParameter("brandId");
						}
       				
       				RequireData rd =new  RequireData();
                	List brandIcon = rd.getBrandIcon();
                 
                	System.out.println("On mobilePurchase.jsp ****** brandIcon List is ==>"+ brandIcon);
                 if(brandIcon!= null)
                 {
                	
                	 System.out.println("*** in IF LOOP of Brand Icon **");
                     Iterator itr =brandIcon.iterator();
                     %>
                     <%
                	 while(itr.hasNext())
                	 {
                		 Object tempbrandid=itr.next();
                		 int sumofqty=rd.getTotalStockPurchase(tempbrandid.toString());
                		 
                		 //System.out.println("*** in while loop **");
                		 %>
                  <li tabindex=-1; class="bg_lb" style="border: 1px solid;"  id="span_brandid<%=tempbrandid %>" value="" onclick="changeColor(this.id)"> <a href="/MSaleERP/jsp/admin/purchase/mobilePurchase.jsp?brandId=<%=tempbrandid %>"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i><br> <span class="label label-important" >   
                  
                  <%=sumofqty %></span><%=itr.next() %></a> </li>
         <%
               }
                }
                 
                else
                {
                	System.out.println("*** in ELSE LOOP of Brand Icon **");
                
                %>
                  <li class="bg_lb"> <a href="#"> <i class="fa fa-mobile" style="font-size: 3em;"></i><br> <span class="label label-important" name="brandId" value=""> </span></a> </li>
                  <%} %>
        
        
      </ul>
    </div>
 	
    
    <hr>
    <div class="row-fluid">
    <div class="span12">
    <%
    if(brandId!=null)
    {
    	 if(rd.getDealerAssignStatus(brandId))
    			 {
    %>
    	<div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>New Purchase </h5>
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/Purchase.do" method="post" class="form-horizontal" name="dynamicData">
          <input type="hidden" value="<%=brandId%>" id="brandid" name="brandId"/>
            <table width="100%">
            <tr>
            <td style="width: 400px;" valign="top">
              <label class="control-label" style="margin-left: -70px;">Date :</label>
              	<div class="controls">
              	<% SysDate sd= new SysDate();
                  String date =	sd.todayDate();
                  
                  System.out.println("Date is==>"+ date);
              	%>
                <input type="date" name="purchasedate" id ="purchasedateid" style="margin-left: -50px;" value="<%= date %>">
              </div>
              <label class="control-label" style="margin-left: -70px;">Invoice No :</label>
              <div class="controls">
                <input type="text" tabindex="1" class="span2" placeholder="Invoice No" style="margin-left: -50px; width: 220px;" id="billNumber" name="billNo" onblur="checkInvoice(this.value,<%=brandId %>,this.id)" style="width: 220px;" required />
                <p id="invoiceStatus" style="display:none; font-size: 13px;color: red;position: absolute;">Invoice Number already exist</p>
              </div>
              <label class="control-label" style="margin-left: -70px;">Total Amount :</label>
              	<div class="controls">
              	
                <input type="text" tabindex="2" name="totalBillAmount" id ="totalBillPrice" style="margin-left: -50px;" onkeypress="return isNumber(event)" placeholder="Total Invoice Amount" required />
              </div>
              <table>
              	<tr>
              		<td><label class="control-label" style="margin-left: -70px;">Select Model :</label></td>
              		<td>
              		 <input name=""  tabindex="3" list="getList" id="modelDemo" onblur="getModelBox(this.value,<%=brandId%>,this.id)" onkeyup="searchModel(this.value,this.id,<%=brandId %>)" autocomplete="off" type="text" class="span4" style="position:relative; left:38px; width:220px" placeholder="Model"/>
              			<datalist id="getList"></datalist>
              		<div class="controls" style="display:none">
              		 <select name="mod" style="margin-left: -163px;"  id="mod">
              		 <option selected> Select</option>

              		 
              	<%
                
                 List modelList = rd.getModel(brandId);
              	
                  
              	System.out.println("*** Model List on mobilePurchase. jsp ==> **"+ modelList);
                 
                 if(modelList!= null)
                 {
                	 System.out.println("*** in IF LOOP of Model List **");
                     Iterator itr =modelList.iterator();
                	 while(itr.hasNext())
                	 {
                		 
                		 %>
                  		<option value="<%=itr.next() %>,<%=itr.next() %>"><%=itr.next() %></option>
                  	<%} %>
                </select></div></td>
              		<td>&nbsp;<a href="#addModel" type="button" style="position: relative; left: 35px;" data-toggle="modal" ><span class="badge badge-inverse"><i class="icon-plus"></i></span></a></td>
              	</tr>
              </table>
              	
                <%}
                else
                {
                	System.out.println("*** in ELSE LOOP of Model Icon **");
               		 %>
                 		<option>select</option>
                 	
               </select>
               <%} %>
               
              <%--  <%String brandid=request.getParameter("brandid"); %> --%>
               
              <label class="control-label" style="margin-left: -70px;">HSN/SAC No :</label>
              <div class="controls" style="position:relative; right:35px; font-size:15px; width:205px;">
              <div style="width:200px;">
                	<input tabindex="4" type="radio" name="hsnSac" id="85171290" value="85171290" checked="checked" style="position:relative; bottom:2px">&nbsp;85171290
                	&nbsp;&nbsp;&nbsp;
                	<input type="radio" name="hsnSac" id="85171210" value="85171210" style="position:relative; bottom:2px">&nbsp;85171210
               </div>
              </div>
            <label class="control-label" style="margin-left: -70px;">MRP :</label>
              <div class="controls">
                <input tabindex="5" type="text" id="price" class="span11" style="margin-left: -50px; width: 220px;" placeholder="Price" name="price" value="" onkeypress="return isNumber(event)" style="width: 221px;"  />
              </div>
            
            <label class="control-label" style="margin-left: -70px;">Quantity :</label>
              <div class="controls">
                <input type="number" tabindex="6" id="member" style="margin-left: -50px; width: 220px;" class="span11" onkeydown="return stopTab(event)" onkeyup="turnOnText()" onKeyPress="addFields()" placeholder="Quantity" name="qty" value="" style="width: 221px;"  />
               <p id="onEnter"></p>
              </div>
              
              <div class="form-actions" >
             
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
              <button type="button" id="done" class="btn btn-danger" onclick="onSubmit()" style="background-color:black;" disabled	>Done</button>
              <input name="puresubmit" type="submit" class="btn btn-success" value="submit" id="pureSubmit" disabled/>
            </div>
              
              </td>
              
              
              <td style="vertical-align: top;">
              
              <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Purchase Details</h5>
            </div>
          <div class="widget-content nopadding">
          <table class="table table-bordered table-striped" id="tid" style="text-align: center; width:735px;">
              <thead>
                <tr>
                  <th style="width:10px;">No</th>
                  <th style="width:180px;">Model Name</th>
                  <th style="width:30px;">HSN/SAC</th>
                  <th  style="width:17px;">Quantity</th>
                  <th style="width:30px;" align="center">IMEI</th>
                  <th style="width:50px;">Price</th>
  
                </tr>                
              </thead>
              <tbody>
              	<tr id="trid" >
              		<td valign="top" id="tno" align="center"></td>
              		<td valign="top" id="mn"align="center"></td>
              		<td valign="top" id="hsn" align="center"></td>
              		<td valign="top" id="tqty"align="center"></td>
              		<td align="center"> <div id="dvTable"></div> </td>
              		<td id="tprice"></td>
              		<!-- <td id="imei" style="text-align: center;"></td>
              		<td valign="top" id="actn"></td> -->
              	</tr>
              </tbody>
            </table>
            
          </div>
        </div>
              </td>
              </tr>
              </table>
                                       
          </form>
        </div>
     </div>
    </div>  
</div>

<!--end-main-container-part-->

<div class="modal hide fade" id="imeiModel" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add IMEI</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" method="post" name="form3">
					<div class="form-group">
						<label class="control-label">IMEI :</label> 
						<div class='controls' id="container" style="margin: 150 auto;">
						</div>
					</div>
					<input type="hidden" id="checker">
					<div class="modal-footer">
					<input type="button" class="btn btn-primary" value="Add" onclick="insert()" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" onclick="document.getElementById('member').focus()" value="Cancel"/>
					</div>
			</form>
			</div>
				
			</div>
		</div>
	</div>
	
	<div class="modal hide fade" id="addModel" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add Model In <%=rd.getBrandNameById(request.getParameter("brandId")) %></h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/addModel.do" method="post" name="addmodel">
					<div class="form-group">
						<label class="control-label">Model Name &nbsp; </label>
						<div class='controls' style="margin: 0 auto;">
							<input type="text" name="purModelName" id ="purModelName" onkeyup="this.value=this.value.toUpperCase();" required />
						</div>
						<label class="control-label">Select Color &nbsp;</label>
						<div class='controls' style="margin: 0 auto;">
							<select name="purMcolor" id="purMcolor">
			                  <option>Select-Color</option>
			                   <% 
			                	List colorlist1 = rd.getColor();
			                 
			                 if(colorlist1!= null)
			                 {
			                     Iterator itr1 =colorlist1.iterator();
			                	 while(itr1.hasNext())
			                	 {		
			                		 %>
			                  <option value="<%=itr1.next() %>"><%=itr1.next() %></option>
			                  <%}}
			                  else {%>
			                  
			                	  <option>none</option>
			                	  <%} %>
			                	  
			                	  
			                </select>
			                <label class="control-label" style="margin-top: 10px;">RAM &nbsp;</label>
							<div class='controls' style="margin: 8px auto;">
								<input type="text" name="purRam" id ="purRam" onkeyup="this.value=this.value.toUpperCase();"/>
							</div>
							<label class="control-label" style="margin-top: -10px;">ROM &nbsp;</label>
							<div class='controls' style="margin:-10px auto;">
								<input type="text" name="purRom" id ="purRom"  onkeyup="this.value=this.value.toUpperCase();"/>
							</div>			
					</div>
					
					</div>
					<div class="modal-footer">
					<input type="button" class="btn btn-primary" data-dismiss="modal" onclick="searchName()" value="Add" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
					</div>
					
			</form>
			</div>
				
			</div>
		</div>
	</div>
<div class="modal hide fade" id="deleteConfirmBox" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"><span style="color:red">Confirm Delete</span></h4>
			</div>
			
			<div class="modal-body">
				<div class="alert alert-warning" style="margin-top: 18px;">
  				<i class="icon-exclamation-sign" style="font-size: 2em;"></i> &nbsp; <strong style="font-size: 15px;">Are you sure you want to Delete this record?</strong>
				</div>
			</div>
			<div class="modal-footer">
				<form action="/MSaleERP/Purchase.do" method="POST">
				<input type="hidden" id="invoiceId" name="dInvoiceNo">
				<input type="hidden" id="brandId" name="dBrandId">
				<input type="hidden" id="dAliasName" name="dAliasName">
				<input type="hidden" id="stockCount" name="stockCount">
					<a href=""></a><input type="submit" class="btn btn-primary" value="OK" name="DeleteRec" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>
	<div class="modal hide fade" id="editIMEI" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" action="/MSaleERP/Purchase.do" method="post">
					<div class="modal-header">
						<h4 class="modal-title">Edit IMEI Data</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label class="control-label">Invoice Number &nbsp; </label>
							<div class='controls' style="margin: 0 auto;">
								<input type="text" name="uinvoiceno" id ="uinvoiceno" required />
								<input type="hidden" name="uModelBrandId" value="<%=brandId %>" />
								<input type="hidden" name="upmid" id ="upmid" />
							</div>
							<div id="updateDataMI">
							</div>
							<label class="control-label">Date Of Purchase &nbsp; </label>
							<div class='controls' style="margin: 0 auto;">
								<input type="date" name="udop" id ="udop" value="<%=sd.todayDate() %>" required/>
							</div>
							<input type="hidden" id="uimeiLoop" name="uimeiLoop">
							<label class="control-label">Invoice Amount &nbsp; </label>
							<div class='controls' style="margin: 0 auto;">
								<input type="text" name="ubillamount" id ="ubillamount" required/>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<input type="submit" class="btn btn-primary" name="updatePurchase" value="Update" />
						<input type="button" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
					</div>
			    </form>
			</div>
		</div>
	</div>



<!--   VIJAY WORK --> 
 <div class="widget-box" >
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>QUICK STOCK:-</h5> </div>
          <div class="widget-content nopadding">
          
          <form action="" method="post">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th style="width:30px;">SR.NO</th>
                  <th style="width:60px;">Invoice No</th>
                  <th style="width:135px;">Alias Name</th>
                  <th style="width:200px;">IMEI</th>
                  <th style="width:90px;">Date Of Purchase</th>
                  <th style="width:90px;">Invoice Amount</th>
                  <th style="width:100px;">Action</th>
                </tr>
              </thead>
              <tbody>
              <!-- add content here -->
              <% if(request.getParameter("brandId")!=null)
              {%>
              <%
              List demoList1=rd.getPurchaseDetail1(request.getParameter("brandId").toString());
              String aliasNme=null;
              	Iterator itr1=demoList1.iterator();
              	int i=1;
              	while(itr1.hasNext())
              	{
              %>
              
              	<tr>
              		<td style="text-align:center"><%=i %></td><%i++; Object invoiceId=itr1.next(); %>
	              	<td style="text-align:center"><%=invoiceId %></td>
	              	<td colspan="2" style="text-align:center">
						<!-- for alias name and Imei NEXT LOOP with a new Table -->
					
					<table  style="position: relative; bottom: 5px;">
		              <tbody>
		              
		              <% RequireData rd2=new RequireData();
		              	 List demoList2=rd2.getPurchaseDetail2(invoiceId.toString(),brandId);
		              	 Iterator itr2=demoList2.iterator();
		              	int count=0;
		              	 while(itr2.hasNext())
		              	 {
						 %>
		              	<tr>
		              	<% Object aliasName=itr2.next(); aliasNme=aliasName.toString();%>
		              	<td style="width:170px; text-align:center"><%=aliasName %></td>
	              		<td style="text-align:center">
	              			<!-- for IMEI NEXT LOOP with a new Table -->
	              			<table style="position: relative; bottom: 8px;">
	              				<tbody>
	              				<%count=0;
	              				RequireData rd3=new RequireData();
		   		              	 List demoList3=rd3.getPurchaseDetail3(aliasName.toString(),invoiceId.toString());
		   		              	 Iterator itr3=demoList3.iterator();
		   		              	 
		   		              	 while(itr3.hasNext())
	   		              	 { count++;
	              				%>
	              				<tr>
	              					<td><%=itr3.next() %></td>
	              				</tr>
	              				
	              				<%} %>
	              				</tbody>
	              				
	              			</table>
	              		</td>
		              	</tr>
		              	<%} %>
		              	
		              </tbody>
		            </table>
					</td>
					
					<% String[] dop=itr1.next().toString().split("-"); %>
	              	<td style="text-align:center"><%=dop[2]+"/"+dop[1]+"/"+dop[0] %></td>
	              	<td style="text-align:center"><%=itr1.next() %></td>
	              	<td style="text-align:center"><a href="#editIMEI" onclick="updateImeino('<%=brandId %>','<%=invoiceId %>','<%=aliasNme %>')" data-toggle="modal">Update</a>|<a href="#deleteConfirmBox" onclick="getDeleteId(<%=invoiceId %>,<%=brandId %>,'<%=aliasNme %>',<%=count %>)" data-toggle="modal">Delete</a></td>
              	</tr>
              	<%} %>
              	<%} %>
              </tbody>
	
         
              </tbody>
            </table>
           </form>
          <%}else{%>
          <script>
          </script>
          
          <div class="modal hide fade" id="addDealerStatus" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<h4 class="modal-title"><span style="color:red">Action Required</span></h4>
				</div>
			
			<div class="modal-body" style="padding:20px; padding-bottom: 0px;">
			<div class="alert alert-info">
			<h5>Add Dealer First</h5>
			</div>
				
			</div>
			<div class="modal-footer">
			<input type="button" class="btn btn-primary" data-dismiss="modal" pattern="[^'\x22]+" title="Don't Use ' or '' " onclick="document.getElementById('organization_name').focus();" value="Add" name="ok" />
			<a href="/MSaleERP/jsp/admin/purchase/mobilePurchase.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
			</div>
		</div>		
	</div>
</div> 
          <!-- for adding dealer if not added -->
	<%if(request.getParameter("brandId")!=null){ %>
	<div class="row-fluid">
    <div class="span12">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Add Dealer For <%=rd.getBrandNameById(brandId) %></h5>
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/InsertDealer.do" method="post" class="form-horizontal" name="form1">
             <div class="control-group">
              <label class="control-label">Brand</label>
              <div class="controls">
                <input class="span11" placeholder="Brand" value="<%=rd.getBrandNameById(brandId) %>" style="width: 300px;" disabled />
                <input type="hidden" value="<%=brandId%>" name="brand"/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Organization Name :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Organization Name" onkeyup="this.value=this.value.toUpperCase()" name="organization_name" id="organization_name" required style="width: 300px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Dealer Name :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Dealer Name" onkeyup="this.value=this.value.toUpperCase()" name="dealer_name"  required style="width: 300px;" />
              </div>
            </div>
             <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Contact No :</label>
               
              	<div class="controls controls-row">
            		<input type="text" placeholder="Contact No" class="span6 m-wrap" onkeypress="return isNumber(event)" maxlength="10"  name="contact_no" required  style="width: 300px;"> 
          		</div>
            </div>
            <div class="control-group">
              <label class="control-label">Email Id :</label>
              <div class="controls">
                <input type="email" class="span11" placeholder="Email Id" name="email_id" style="width: 300px;"  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Balance Amount :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Balance Amount" name="balanceAmount" style="width: 300px;" />
              </div>
            </div>
              <div class="form-actions" style="margin-top:0px;">
                <button type="submit" id="submitbtn" name="assign" style="position: relative;  float: right; right: 600px;" class="btn btn-success">Assign</button>
                <a href="/MSaleERP/jsp/admin/purchase/mobilePurchase.jsp?brandId="+<%=brandId %> style="position: relative;  float: right; right: 450px;" class="btn btn-danger">Exit</a>
              </div>
          </form>
          
        </div>
      </div>
     </div>
    </div>
	<%} %>
           <%}}%>
          </div>
        </div>      
         
          
 </div>
   
 
    
    <!--Footer-part-->

 </div>
 
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>
<!--end-Footer-part-->

<%if(request.getAttribute("error")!=null){ %>
<div class="modal fade" id="error-msg-delete" role="dialog">
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
          					
				              <h4>Cannot delete the Selected record as it is linked with some other records..!! </h4>
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
<%} %>





<script type="text/javascript">
	

</script>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 


<script type="text/javascript">
var quantity=[];
var modelname=[];
var imei=[];
var varImei=[];
var hsnno=[];

var count=0;
var ct=1;
var mcount=0;
var imeicount=0;
var xyz=[];
var imeiDot;
var xyz2=[];
function bubbleSort() { 
	var st=false;
	xyz.length=0;
	
	for(var i=0;i<imeiDot;i++)
		{
		xyz[i]=document.getElementById("mem"+i).value;
		}
	    var length = xyz.length;
	    for (var i = 0; i < length; i++) {
	        //Number of passes
	        for (var j = i+1; j < length; j++) {
	            //Compare the adjacent positions
	            if (xyz[i]==xyz[j]) {
	            	st=true;
	            	if(document.getElementById("mem"+j)!=null)
	            	document.getElementById("mem"+j).focus();
	            	document.getElementById("p"+i).innerHTML="same";
					document.getElementById("p"+i).style.color="red";
					document.getElementById("p"+j).innerHTML="same";
					document.getElementById("p"+j).style.color="red";
	            }
	            else
	            	{
	            	if((document.getElementById("p"+i))!=null)
	            		{
	            		document.getElementById("p"+i).innerHTML="";
	            		}
	            	}
	        }
	    }
	    if(xyz2.length>0 && st==false)
	    	{
	    		st=false;
	    		var demoArray=[];
	    		demoArray=(xyz+","+xyz2).split(",");
	    		for(var i=0;i<demoArray.length-1;i++)
    			{
    			for(var j=i+1;j<demoArray.length;j++)
    				{
    					if(demoArray[i]==demoArray[j])
    						{
    						st=true;
    						if(document.getElementById("mem"+i)!=null)
    						document.getElementById("mem"+i).focus();
    						document.getElementById("p"+i).innerHTML="Inserted";
    						document.getElementById("p"+i).style.color="red";
    						}
    				}
    			}
	    		if(st)
	    	    	return false;
	    	    else
	    	    	return true;
	    	}
	    else
	    {
	    if(st)
	    	return false;
	    else
	    	return true;
	    }
	}



function setFocusToTextBox() {
	clock();
	
	callToError();
	
	var x=document.getElementById("billNumber");
	if(x==null)
	          document.getElementById("organization_name").focus();
	else
		document.getElementById("billNumber").focus();
	showsnack();
	$('#addDealerStatus').modal('show');
	
	getColor();
	 
	
	
}
function callToError()
{
	
	if(document.getElementById("error-msg-delete")!=null)
	{
		$('#error-msg-delete').modal('show');	
	}
}
function showsnack()
{
	if(document.getElementById("snackbar")==null)
		{
			
		}
	else{
		var x = document.getElementById("snackbar");
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
	}

$('#addDealer').on('shown.bs.modal', function () {
    $('#purModelName').focus();
})  

$('#editIMEI').on('shown.bs.modal', function () {
    $('#uinvoiceno').focus();
})
$('#addModel').on('shown.bs.modal', function () {
    $('#purModelName').focus();
})

function stopTab( e ) {
    var evt = e || window.event;
    if ( evt.keyCode === 9 ) {
        return false;
    }
}
//updating imei numbers
function updateImeino(brid,uinvno,ualnm)
{
	var x=document.getElementById("updateDataMI");
	x.innerHTML="";
	document.getElementById("uimeiLoop").value="";
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var udatademo = this.responseText.split(",");
			var dataDiv=document.getElementById("updateDataMI");
			var wholeData=udatademo[1].split("?");
			var k=0;
			for(var i=0;i<wholeData.length-1;i++)
				{
				
				var modelAndImei=wholeData[i].split("#");
				var modelOnly=modelAndImei[0];
				var imeiList=modelAndImei[1].split("-");
				var l=0;
				
				dataDiv.innerHTML+="<label class='control-label'>Model Name &nbsp; </label>"
					+"<div class='controls' style='margin: 0 auto;'>"
					+"<input type='text' id='ualiasname' disabled value='"+modelOnly+"'>"
					+"</div>"
					+"<label class='control-label' title='You can only edit available IMEI'>IMEI &nbsp; </label>"
					+"<div class='controls' style='width: 220px'>"
					+"<div id='imeiUpdTxt' style='padding-top: 0px;margin: 0 auto; position: relative;right: 20px;'>"
					+"<div style='margin:0 auto;' id='imeiUpd"+i+"'>"
					+"</div>"
					+"</div>"
					+"</div>";
					var newdiv=document.getElementById("imeiUpd"+i);
					for(var j=0;j<imeiList.length-1;j=j+2)
	 					{
						newdiv.innerHTML+="<input type='hidden' name='uImeiId"+k+"' value='"+imeiList[j]+"'><input type='text' pattern='[0-9]*' maxlength='17' name='uImei"+k+"' value='"+imeiList[j+1]+"' required><br><div style='height:5px;'></div>";
	 					k++;
	 					l++;
	 					}
					document.getElementById("uimeiLoop").value+=l+",";
				}
			document.getElementById("uinvoiceno").value=udatademo[0];
			document.getElementById("upmid").value=udatademo[4];
			document.getElementById("udop").value=udatademo[2];
			document.getElementById("ubillamount").value=udatademo[3];
			}
		};
	xhttp.open("POST","/MSaleERP/Purchase.do?updIMEI='updIMEI'&ubrandId="+brid+"&uinvno="+uinvno+"&ualiasname="+ualnm+"", true);
	xhttp.send();
	
	}
function getDeleteId(invoiceId, brandId, aliasName, count)
{
	document.getElementById("dAliasName").value=aliasName;
	document.getElementById("invoiceId").value=invoiceId;
	document.getElementById("brandId").value=brandId;
	document.getElementById("stockCount").value=count;
}
function changeColor(sid)
{
	  localStorage.setItem('idColor', sid);
}
//for changing color of Brand at TOP
function getColor()
{
	  if(localStorage.getItem("idColor")==null)
		  {
		  
		  }
	  else
		  {
			  var idColor = localStorage.getItem("idColor");
			  document.getElementById(idColor).style.backgroundColor="#28b779";
			  document.getElementById(idColor).style.border="1px solid";
			  localStorage.setItem("idColor", null);
		  }
	  
	  
}
//assigning model
function getModelBox(str,brandId,id) {
	if(!document.getElementById(id).value==""){
		var xhttp;
		document.getElementById(id).value=str.toUpperCase();
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var demoStr = this.responseText.split(",");
				document.getElementById("mod").value=demoStr[0]+","+demoStr[1];
				}
			};
		xhttp.open("POST", "/MSaleERP/Purchase.do?modelAlias="+str+"&brandId="+brandId, true);
		xhttp.send();
	}
}

//finding modelName
function searchModel(str,id,brId) {
	if (str == " ") {
		document.getElementById(id).value="";
	}
	else if(str==""){
		document.getElementById("getList").innerHTML="";
	}
	else{
		if(!document.getElementById(id).value==""){
			var xhttp;
			document.getElementById(id).value=str.toUpperCase();
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText;
					document.getElementById("getList").innerHTML = demoStr;
					}
				};
			xhttp.open("POST", "/MSaleERP/Purchase.do?findName="+str+"&brandId="+brId, true);
			xhttp.send();
		}
	}
}
function searchName() {
	var id=document.getElementById("brandid").value;
	var modelname=document.getElementById("purModelName").value;
	var colorid=document.getElementById("purMcolor").value;
	var ram=document.getElementById("purRam").value;
	var rom=document.getElementById("purRom").value;
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var datademo = this.responseText.split(",");
			if(datademo[0]=='Model Already Present')
				alert(datademo[0]);
			else{
			var modopt=document.getElementById("mod");
			var newopt=document.createElement("OPTION");
			newopt.value=datademo[1]+","+datademo[2];
			newopt.text=datademo[3];
			modopt.appendChild(newopt);
			document.getElementById('modelDemo').value=datademo[3];
			document.getElementById("mod").value=datademo[1]+","+datademo[2];}
			}
			document.getElementById("modelDemo").focus();
		};
	xhttp.open("POST","/MSaleERP/addModel.do?popAddModel='popAddModel'&purBrandid="+id+"&purModelName="+modelname+"&purMcolor="+colorid+"&purRam="+ram+"&purRom="+rom+"", true);
	xhttp.send();
	}



//code for open bootstrap modal(pop-up)

$(document).ready(function() {
	$("#member").keypress(function(event) {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if (keycode == '13') {
			$("#imeiModel").modal();
		}
		event.stopPropagation();

	});
});

$('#imeiModel').on('shown.bs.modal', function (e) 
		{
		var tep=0;
		document.getElementById("mem"+tep).focus();	
		});
//for turning on DONE button

function turnOnText(e)
{
	
	if(document.getElementById("billNumber").value=="")
	{
		alert("Please Fill Bill Number");
		document.getElementById("billNumber").focus();
		}
	else if(document.getElementById("totalBillPrice").value=="")
	{
	alert("Please Fill Bill Price");
	document.getElementById("totalBillPrice").focus();
	document.getElementById("member").value="";
	document.getElementById("onEnter").innerHTML="";
	
	}
	else if(document.getElementById("modelDemo").value=="")
	{
		alert("Please Select Model First");
		document.getElementById("modelDemo").focus();
		}
	else if(document.getElementById("price").value=="")
	{
		alert("Please fill Price");
		document.getElementById("price").focus();
		}
	
	document.getElementById("onEnter").innerHTML="<strong style='position:relative; right:15px;font-size:13px;color:red;'>Press ENTER (After Quantity)</Strong>";
	
	}

//code for generatin IMEI Boxes

function addFields(){
	// Number of inputs to create
	var number = document.getElementById("member").value;
	imeiDot = document.getElementById("member").value;
	// Container <div> where dynamic content will be placed
	var container = document.getElementById("container");
	// Clear previous contents of the container
	while (container.hasChildNodes()) {
		container.removeChild(container.lastChild);
	}
	var tep=0;
	for (var i = 0; i < number; i++) {
		// Append a node with a random text
		//container.appendChild(document.createTextNode("Member " + (i+1)));
		// Create an <input> element, set its type and name attributes
		var input = document.createElement("div");
		input.innerHTML="<input name="+i+" type='text' onkeypress='return isNumber(event)' id='mem"+i+"' pattern='[0-9]*' maxlength='17' onchange='checkIMEIbefore(this.name)' onblur='checkIMEI(this.value,this.name)'/>";
		input.setAttribute("style","float:left;");
		container.appendChild(input);
		var p=document.createElement("p");
		p.id="p"+i;
		p.setAttribute("style","height:20px;float:right;position:relative;right:70px;font-weight:bold;");
		container.appendChild(p);
		// Append a line break 
		container.appendChild(document.createElement("br"));
		container.appendChild(document.createElement("br"));

		document.getElementById("mem"+tep).focus();	
		window.demoNumber=i;
	}
   
}
function checkInvoice(value,brandId,id) {
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var checkValue = this.responseText;
			if(checkValue==1)
			{
				document.getElementById("invoiceStatus").style.display="block";
				document.getElementById(id).focus();
				
			}
			else
				document.getElementById("invoiceStatus").style.display="none";
			}
		};
	xhttp.open("POST","/MSaleERP/Purchase.do?validateInvoiceNo="+value+"&statusbrid="+brandId, true);
	xhttp.send();
	}
function checkIMEIbefore(id)
{
	document.getElementById("p"+id).innerHTML="";
	}
function checkIMEI(imei,id)
{
	var request=new XMLHttpRequest();
	var url="/MSaleERP/Purchase.do?validate="+imei;  

	try{  
			request.onreadystatechange=function()
			{  
				if(request.readyState==4)
				{  
					var val=request.responseText;
					if(val==1)
					{
						document.getElementById("p"+id).innerHTML="exist";
						document.getElementById("p"+id).style.color="red";
						document.getElementById("mem"+id).focus();
						document.getElementById("checker").value="exist";
						
					}
					else
						document.getElementById("checker").value="done";
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



function getTemplateRow() {
var x = document.getElementById("trid").cloneNode(true);
return x;
}

function insert()
{
	var status=bubbleSort();
	
	if(document.getElementById("checker").value=="done")
		{
		window.qty=document.getElementById("member").value;
		window.model=document.getElementById("mod").value;
		window.mod=document.getElementById("mod").options[document.getElementById("mod").selectedIndex].text;
		window.hsnSac;
		if(document.getElementById("85171290").checked==true)
		    		window.hsnSac=document.getElementById("85171290").value;
		    else
		    	window.hsnSac=document.getElementById("85171290").value;
		
	
		var a=document.getElementById("member").value;
		 for(var i=0;i<a;i++)
			 {
			  if(document.getElementById("mem"+i).value=="")
				  {
				  	alert("Fill IMEI");
				  	return false;
				  }
			 }
		for(var i=0;i<qty;i++)
		{
			var temp=document.getElementById('mem'+i).value;
			varImei.push(temp);
		}
		
		var mname=mod;
		var hsnsacno;
		    if(document.getElementById("85171290").checked==true)
		    	hsnsacno=document.getElementById("85171290").value;
		        else
		        	hsnsacno=document.getElementById("85171210").value;
		quantity.push([qty]);
		modelname.push([mname]);
		hsnno.push(hsnsacno);
		if(status==true)
			{
			xyz2+=xyz+",";
			$('#imeiModel').modal('hide');
			clearAndShow();
			}
		}
		
	
}	

function clearAndShow()
{
	var t = document.getElementById("tid");
	
	var rows = t.getElementsByTagName("tr");
	var r = rows[rows.length - 1];
	r.parentNode.insertBefore(getTemplateRow(), r);
		
	var tcelln  = document.getElementById("tno");
	var tcellhsn= document.getElementById("hsn");
	var tcellq  = document.getElementById("tqty");
	var tcellmn  = document.getElementById("mn");
	var tcellimei = document.getElementById("imei");
	var tcella  = document.getElementById("actn");
	
	//set value in temporary table
	tcelln.innerHTML=""+ct+"";
	tcellhsn.innerHTML=hsnno[count];
	tcellmn.innerHTML=modelname[count];
	var input=document.createElement("INPUT");
    input.type="hidden";
    input.value=modelname[count];
    input.name="tmodel"+mcount; //model (1)
    document.dynamicData.appendChild(input);
	tcellq.innerHTML=quantity[count];
	
	var tempTemp= parseInt(document.getElementById("member").value);
	var qty= document.getElementById("member").value;
	
    //Build an array containing Customer records.
    var customers = new Array();
    for(var i=0;i<qty;i++)
    {
    	var temp=document.getElementById('mem'+i).value;
		customers.push([temp]);

    }
 
    //Create a HTML Table element.
    var table = document.createElement("TABLE");
  	table.setAttribute("style", "text-align:center;border-collapse:collapse; height:56px; width:175px; margin:0 auto;");
 
    //Get the count of columns.
    var columnCount = customers[0].length;
 
    //Add the header row.
    var row = table.insertRow(-1);
    
    //Add the data rows.
    
    var bunchImei=[];
    for (var i = 0; i < customers.length; i++) {
        row = table.insertRow(-1);
        for (var j = 0; j < columnCount; j++) {
            var cell = row.insertCell(-1);
            cell.innerHTML = customers[i][j];

			bunchImei.push(customers[i][j]);
        }
        
    }
    
    //set value in hidden fields
    var input=document.createElement("INPUT");
    input.type="hidden";
    input.value=bunchImei;
    input.name="timei"+imeicount;
    document.dynamicData.appendChild(input);
    
    document.getElementById("tprice").innerHTML=document.getElementById("price").value;
    
    var input=document.createElement("INPUT");
    input.type="hidden";
    input.value=document.getElementById("price").value;
    input.name="rateToSale"+mcount;
    document.dynamicData.appendChild(input);

    var input=document.createElement("INPUT");
    input.type="hidden";
    
    if(document.getElementById("85171290").checked==true)
        input.value=document.getElementById("85171290").value;
        else
        input.value=document.getElementById("85171210").value;
    
    input.name="hsnSac"+mcount;
    document.dynamicData.appendChild(input);
    
    var input=document.createElement("INPUT");
    input.type="hidden";
    input.value=document.getElementById("mod").value;
    input.name="mod"+mcount;
    document.dynamicData.appendChild(input);
    
 
    var dvTable = document.getElementById("dvTable");
    dvTable.innerHTML = "";
    dvTable.appendChild(table);
		

	count++;
	ct++;
	mcount++;
	imeicount++;
	document.getElementById("member").value="";
	document.getElementById("price").value="";
	document.getElementById("done").disabled=false;
	document.getElementById('modelDemo').value="";
	document.getElementById('modelDemo').focus();
}
  // This function is called from the pop-up menus to transfer to
//document.getElementById("nochapter").value
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
  function onSubmit()
  {
	 	document.getElementById("done").disabled=true;
	  	var input=document.createElement("INPUT");
	    input.type="hidden";
	    input.value=mcount;
	    input.name="loopNumber";
	    document.dynamicData.appendChild(input);
	    
	    document.getElementById("pureSubmit").disabled=false;
		
	  }
  
  function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
  
</script>
</body>
</html>