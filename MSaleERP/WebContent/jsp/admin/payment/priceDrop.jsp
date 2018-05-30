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
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">

<style type="text/css">



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
	if(session.getAttribute("username")==null)
	{
		response.sendRedirect("/MSaleERP");

	}
%>

<body onload="getColor()">


<!--Header-part-->
<jsp:include page="../common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a><a href="#" class="current">Price Drop</a></div>
    
  </div>
<% if(request.getAttribute("status")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status")%></div>
<%} %>
<!--End-breadcrumbs-->
<form action="/MSaleERP/PriceDrop.do" method="post" class="form-horizontal" name="">
<!--Action boxes-->
  <div class="container-fluid">
  	<div class="quick-actions_homepage">
      <ul class="quick-actions">
       <% 	    String brandId=null;
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
                		 int sumofqty=rd.getTotalQuantity(tempbrandid.toString());
                		 
                		
                		 %>
                		 <%-- <input type="text" name="brandIDOm" value="<%=tempbrandid %>"/> --%> 
                  <li class="bg_lb"  id="span_brandid<%=tempbrandid %>" value="" onclick="changeColor(this.id)" style="border: 1px solid;"> <a href="/MSaleERP/jsp/admin/payment/priceDrop.jsp?brandId=<%=tempbrandid %>"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i><br> 
                 <%--  <span class="label label-important" >   
                  <
                  <%=sumofqty %></span> --%><%=itr.next() %></a> </li>
                   
         <%
               }
                }
                 
                else
                {
                	System.out.println("*** in ELSE LOOP of Brand Icon **");
                
                %>
                  <li class="bg_lb"> <a href="#"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i><br> <span class="label label-important" name="brandId" value=""></span></a> </li>
                  <%} %>
        
        
      </ul>
    </div>
 	
    
    <hr>
    <div class="row-fluid">
    
    <%
    if(brandId!=null)
    {%>
    	<div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Organization Details </h5>
        </div>
        <div class="widget-content nopadding" >
          
          <table width="100%">
          	<tr>
          	<td width="40%" style="vertical-align: top;">
          <input type="hidden" value="<%=brandId%>" name="brandId"/>
          <%Object bid=request.getAttribute("bid"); %>
    	   <%Object model=request.getAttribute("modelname"); %>
          <% Object totalAmt=request.getAttribute("totalAmt"); %>
          <%Object dropAmt=request.getAttribute("drop");%>
          <%Object av=request.getAttribute("av"); %>
          <%Object d=request.getAttribute("d"); %>   	
          <%-- <%out.println(model);%> --%>
          <input type="hidden" value="span_brandid<%=bid%>" id="mukesh"/>
              <label class="control-label">Date :</label>
              	<div class="controls">
              	<% SysDate sd= new SysDate();
                  String date =	sd.todayDate();
                  
                  System.out.println("Date is==>"+ date);
              	%>
                <input type="date" name="dropdate" id ="dates" value="<%=date %>">
              </div>
                   
              <label class="control-label">Select Model :</label>
              	<div class="controls">
              		 <select name="mod" id="dropdown" style="width: 220px;" id="mod" onchange="getValue(this.value)">
              		 <option selected>Select</option>
              		 
		                
              	<%
                
                 List modelList = rd.getModelPD(brandId);
                  
              	System.out.println("*** Model List on mobilePurchase. jsp ==> **"+ modelList);
                 
                 if(modelList!= null)
                 {
                	 System.out.println("*** in IF LOOP of Model List **");
                     Iterator itr =modelList.iterator();
                	 while(itr.hasNext())
                	 {%>
                		 
                		 
                  		<option value="<%=itr.next() %>,<%=itr.next() %>"><%=itr.next() %></option>
                  	<%} %>
                </select>
                <%}
                 
                else
                {
                	System.out.println("*** in ELSE LOOP of Model Icon **");
               		 %>
               	<select>
                 		<option>select</option>
                 	
               </select>
               <%} %>
               			<%if(model!=null){ %>
		                <script type="text/javascript">
		                	document.getElementById('dropdown').value ='<%=model%>';
		              
		                </script>
		                <%}else{ %>
		                <script type="text/javascript">
		                	document.getElementById('dropdown').value ='Select';
		               
		                <%}%>
		                </script>
              </div>
              
              <%if(av==null) { av="";}%>
              <label class="control-label">Available Amount :</label>
              	<div class="controls">
                <input type="text" name="avAmt" id ="avAmt" placeholder="Not Available"  value="<%=av %>" readonly="readonly">
              </div>
              
               <%if(dropAmt==null) { dropAmt="";}%>	
              <label class="control-label">Drop Amount :</label>
              	<div class="controls">
              	<table>
              		<tr>
              			<td>
							 <!-- onblur="validate(this.value)" --> 
              				<input type="text" name="dropAmt" id ="dropAmt" placeholder="Drop Amount" onkeyup="saveDrop(this.value);" onblur="validates()"  value="<%=dropAmt%>" autocomplete="off" required>
              			</td>
              		</tr>
              		<tr>
              			<td>
              				<span class="date badge badge-warning" id="message"></span>		
              			</td>
              		</tr>
              	</table>
                
                
              </div>
              
              <%if(d==null) { d="";}%>
              <label class="control-label">Drop By :</label>
              	<div class="controls">
                <input type="text" name="dBy" id ="dBy" placeholder="Drop By"  value="<%=d %>" readonly="readonly">
              </div>
              
              
              <div class="form-actions" >
             
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
              
              <input type="submit" class="btn btn-success" value="Show" id="show" name="show" />
             
            </div>
              </td>
              <td style="vertical-align: top;">
              
              <table width="100%">
              <tr>
              <%List imei=(List)request.getAttribute("imeino");%>
              <%Object quantity=request.getAttribute("qty"); %>
              	
              <td style="vertical-align: top;">
              	<table class="table table-bordered table-striped">
              		<tr>
              			<th style="width:30px;">No</th>
              			<th style="width:200px;">IMEI NO</th>
              		</tr>
              		<tr>
              		<%
	              		if(imei!= null)
	          			{
		              		int count=1;
	              			Iterator itr=imei.iterator();
	              			
	              			while(itr.hasNext())
	              			{
              		%>		<%Object temp=itr.next(); %>	
              			<td><%=count %></td>
              			<td><%=temp%></td>
              			<input type="hidden" id="imei" name="imei<%=count%>" value="<%=temp%>"/>
              		</tr>
              		 	<%count++;}} %>  	
              	</table>
              </td>
              
              <td align="center" style="vertical-align: top; width:450px;">
              <%int zero=0; %>
              	<%if(quantity==null || quantity.equals(zero)) { quantity="";}%>
              	
              	<label class="control-label">Total Quantity:</label>
              	<div class="controls">
                <input type="text" name="totalqty" id ="totalqty" placeholder="Total Quantity" value="<%=quantity%>">
              	</div>
              	
              	<%if(totalAmt==null || totalAmt.equals(zero)) { totalAmt="";}%>
              	<label class="control-label">Total Amount:</label>
              	<div class="controls">
                <input type="text" name="totalamt" id ="totalamt" placeholder="Total Amount" value="<%=totalAmt%>">
              	</div>
              	<br>
              	
              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              	<input type="submit" class="btn btn-success" value="Submit" name="submit" id="pureSubmit" onclick="sendImei()" disabled/>
              	
              	
              </td>
              </tr>
              </table>
              
              
              </td>
              </tr>
              </table>
         
      
      </div>        
   </div>  
   </div>         
   </form>

          

<!--end-main-container-part-->


	 <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Price Drop Details</h5>
            <span class="label label-info"><a href="/MSaleERP/jsp/admin/payment/printPriceDropDetails.jsp?brandId=<%=brandId%>" target="_blank" style="color:white;">Print</a></span> 
            										
            </div>
          <div class="widget-content nopadding">
          <%List priceDropDetails=rd.getPriceDropDetails(brandId);
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
              	<th>Action</th>
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
              	<td><a href="#editPriceDrop" data-toggle="modal" onclick="getModalData(<%=id%>)">Update</a>&nbsp;|&nbsp;<a href="#deleteConfirmBox" data-toggle="modal" onclick="setIdToModal(<%=id%>)">Delete</a></td>
              </tr>
              <%count++;} }%>
            </table>
           </form>
          </div>
        </div>
        </div>
        

    <%}
    %>
    </div>
    </div>
    <!--Footer-part-->
   </div>
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>

<!--end-Footer-part-->


<div class="modal hide fade" id="editPriceDrop" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Edit Price Drop Details</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/PriceDrop.do" method="post">
					<div class="form-group">
						<label class="control-label">Date &nbsp; </label>
						<div class='controls' style="margin: 0 auto;">
							<input type="date" name="modalDate" id ="modalDate" value=""/>
						</div>
						<label class="control-label">Model &nbsp; </label>
						<div class='controls' style="margin: 0 auto;">
							<input type="text" name="modalModel" id ="modalModel" disabled/>
						</div>
						
						<div id="updateDataMI">
						<label class="control-label">Imei &nbsp; </label>
						<div class='controls' style="width: 220px;">
							<div id="dataForImei" style="padding-top: 0px;margin: 0 auto; position: relative;right: 20px;">
								
								<br><div id="demoTest" style="margin-top:-20px;">
								
								</div>
							</div>
						</div>
						</div>
						
						<label class="control-label" style="margin-top:-10px;" >Quantity &nbsp; </label>
						<div class='controls' style="margin: 0 auto;margin-top:-10px;">
							<input type="text" name="modalQty" id ="modalQty" disabled/>
						</div	>
						<label class="control-label">Total Amount &nbsp; </label>
						<div class='controls' style="margin: 0 auto;">
							<input type="text" name="modalAmt" id ="modalAmt" />
						</div>
					</div>
					<div class="modal-footer">
					<input type="submit" class="btn btn-primary" name="modalUpdate" value="Update" />
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
				<form action="/MSaleERP/PriceDrop.do">
				<input type="hidden" id="checkTest" name="checkTest">
				<input type="hidden" id="" name="">
					<input type="submit" class="btn btn-primary" value="OK" name="DeleteRec" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>
	

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

$('#editPriceDrop').on('hidden.bs.modal', function (e) {
    $('body').removeClass('modal-open');
});


function saveDrop(amt)
{
	//alert(amt);
	
	 var avAmt= document.getElementById("avAmt").value;
	 var dBy=avAmt-amt;
	 document.getElementById("dBy").value=dBy;
	 //var lAmt=document.getElementById("").value
	 
	//localStorage.setItem('dropAt', dropAmt);
	//alert('hello'+dropAt);
}

function validates()
{	var dby=document.getElementById("dBy").value;
	if(dby<0)
	 {
		document.getElementById("message").innerHTML="Should Not Exceed Available Amount";
		document.getElementById("show").disabled = true;
		document.getElementById("avAmt").focus();
		
	 }
	else
	{
		document.getElementById("message").innerHTML="";
		document.getElementById("show").disabled = false;
	}
}

function getColor()
{
	if(document.getElementById("dates")!=null)
	{
		document.getElementById("dates").focus();
	}
	clock();
	$('#editPriceDrop').on('hidden.bs.modal', function (e) {
	    $('body').removeClass('modal-open');
	});

	myFunction();
	
	  
}



function myFunction()
{
	
	
	if(document.getElementById("snackbar")==null)
	{
		
	}
	else
	{
		var tamt=document.getElementById("totalamt").value;
		if(tamt=="")
		{
			//alert('working');
			document.getElementById("pureSubmit").disabled = true;
			
		}
		else
		{
			document.getElementById("pureSubmit").disabled = false;
		}
		
		var x = document.getElementById("snackbar");
    	x.className = "show";
    	setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
	
	if((localStorage.getItem("idColor")!=null))
		{
	  var idColor = localStorage.getItem("idColor");
	  document.getElementById(idColor).style.backgroundColor="#28b779";
	  document.getElementById(idColor).style.border="1px solid";
		
		
		localStorage.setItem('idColor', null);
		}
    }
    
    
function setIdToModal(id)
{
	document.getElementById("checkTest").value = id;	
}

function sendImei()
{
	var tcellimei = document.getElementById("cellimei").value;
	alert(tcellimei);
}

function getValue(val)
{
	//document.getElementById('dropAmt').value=val;
	 var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() 
	{
		if (this.readyState == 4 && this.status == 200) 
		{
			var demoStr = this.responseText.split(",");
			document.getElementById("avAmt").value = demoStr[0];
			//document.getElementById("").value = demoStr[1];
			
		}	
	};
	xhttp.open("POST","/MSaleERP/PriceDrop.do?getPrice="+val+"", true);
	xhttp.send();	
	
	
}


function getModalData(pdid) {
	
	var node=document.getElementById('demoTest');
	node.innerHTML="";
	
	var input = document.createElement("input");
	input.type="hidden";
	input.name="mId";
	input.value=pdid;
	document.getElementById('demoTest').appendChild(input);
	
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var demoStr = this.responseText.split(",");
			document.getElementById("modalDate").value = demoStr[0];
			document.getElementById("modalModel").value = demoStr[1];
			document.getElementById("modalQty").value = demoStr[2];
			document.getElementById("modalAmt").value = demoStr[3];
			
			var imei=demoStr[4].split("#");
			//alert(imei.length-1);
			//document.getElementById('demoTest').removeChild(input);
			 for(var i=0;i<imei.length-1;i++)
			{
				 var input = document.createElement("input");
				 input.type = "text";
				 input.style = "margin-bottom:10px;";
				 input.name="imei"+i;
				 input.id="imei"+i;
				 input.value=imei[i];
				 input.disabled="disabled";
				 document.getElementById('demoTest').appendChild(input);
				 //container.appendChild(input); // put it into the DOM
				//document.getElementById("imei1").value = imei[0];
				
			} 
			 
			
			
			}
		};
	xhttp.open("POST","/MSaleERP/PriceDrop.do?upid="+pdid+"", true);
	xhttp.send(); 
	
}



function changeColor(id)
{
	  localStorage.setItem('idColor', id);
	 
//	  demoObj.style.background="#28b779";
}
</script>
</body>
</html>