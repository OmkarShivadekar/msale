<%@page import="java.util.Date"%>
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
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">

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

.table td {
   text-align: center;   
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
	    border-radius: 2px;
	    padding: 16px;
	    position: fixed;
	    z-index: 1;
	    left: 50%;
	    top: 50px;
	    font-size: 15px;
	    border-radius:50px 50px;
	}

#snackbar.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {top: 0; opacity: 0;} 
    to {top: 50px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 50px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 50px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 50px; opacity: 1;}
    to {top: 0; opacity: 0;}
}

.tooltip-arrow,
.red-tooltip + .tooltip > .tooltip-inner {background-color: #f00;}

</style>

<script type="text/javascript">


function setFocusToTextBox() {
	clock();	
	showModal();
	myFunction();
}

function myFunction() {
	if(document.getElementById("snackbar")!=null){
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
}


</script>
</head>
<%-- <%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	if(session.getAttribute("username")==null)
	{
		response.sendRedirect("/MSaleERP");

	}
%>
 --%>
<body onload="setFocusToTextBox()">

	<!--Header-part-->
	
	<jsp:include page="../common/header_navbar.jsp"></jsp:include>
	
	<!--sidebar-menu-->
	<jsp:include page="../common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->
	<% if(request.getAttribute("status1")!=null){ %>
	<div id="snackbar"><%=request.getAttribute("status1")%></div>
	<%} %>
	
	
	
	<div id="content">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i
					class="icon-home"></i> Home</a> 
				<a href="/MSaleERP/jsp/admin/payment/newDP.jsp" >Dealers Payment</a>
				<a href="#" class="current">Purchase Price</a>
			</div>
		</div>
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
                 
                	if(brandIcon!= null)
                 {
                	
                	 Iterator itr =brandIcon.iterator();
                     %>
                     <%
                	 while(itr.hasNext())
                	 {
                		 Object tempbrandid=itr.next();
                		 //int sumofqty=rd.getTotalStockPurchase(tempbrandid.toString());
                		 
                		 //System.out.println("*** in while loop **");
                		 %>
                  <li tabindex=-1; class="bg_lb" style="border: 1px solid;"  id="span_brandid<%=tempbrandid %>" value="" onclick="changeColor(this.id)"> <a href="/MSaleERP/jsp/admin/report/priceProfit.jsp?brandId=<%=tempbrandid %>"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i><br><%=itr.next() %></a> </li>
         <%
               }
                }
                 
                else
                {
                	
                %>
                  <li class="bg_lb"> <a href="#"> <i class="fa fa-mobile" style="font-size: 3em;"></i><br> <span class="label label-important" name="brandId" value=""> </span></a> </li>
                  <%} %>
        
        
      </ul>
    </div>
 	
    
    <hr>
			
<%
    if(brandId!=null)
    {
    %>
    <form name="color-form" action="/MSaleERP/PriceProfit.do" id="color-form" method="post">
			<div class="widget-box">
				<div class="widget-title">
					<span class="icon"><i class="icon-th"></i></span>
					<h5>Price Profit</h5>
					 <a style="cursor: pointer" onclick="editableAll()">
					 <input type="button" class="btn btn-info pull-right" id="editAll" 
					 style="margin-top:3px;margin-right:5px;" value="Edit All" /></a>
					<input type="button" class="btn btn-success pull-right" id="submitAll" onclick="onSubmitClick()" style="margin-top:3px;margin-right:5px; display: none" value="Submit" />
					
				</div>
				
				
					<div class="widget-content nopadding">
						<table class="table table-bordered" id="TFtable">
						
						
							<thead>
								<tr>
									<th>Sr.No</th>
									<th>Model Name</th>
									<th>Alias Name</th>
									<th>Real Price</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
							

							
								
								<% List model=rd.getModelPp(brandId);
												Iterator itr1=model.iterator();
												int i=1;
												while(itr1.hasNext())
												{
											%>
									<tr id="trId<%=i %>" class="gradeX">
									<td><%=i%><%Object id=itr1.next(); %></td>
									<td><%=itr1.next() %><input name="modelId<%=i %>" id="modelId<%=i %>" type="hidden" value="<%=id %>"></td>
									<td><%=itr1.next() %></td>
									<td contenteditable='false' id="price<%=i %>" tabindex="<%=i%>" onkeypress="return setData(<%=i%>,this.innerHTML)"><%if(rd.getPriceProfilModelSt(id.toString())!=null){ %><%=rd.getPriceProfilModelSt(id.toString()) %><%} %>
									</td>
									<td>
										<a href="" id="<%=i %>" data-toggle="modal" onclick="getSingle(this.id)">Update</a> / <a onclick="" href="#DeleteColor" data-toggle='modal'>Delete</a> 
									</td>
									</tr>
									<%i++;} 
									%><input type="hidden" id="totalEdits" name="count" style="display:block" value="<%=i%>">
									<input type="hidden" id="totalValue" placeholder="value" name="totalValue" style="display:block" value="">
									<input type="hidden" id="totalModelId" placeholder="model" name="totalModelId" style="display:block" value="">
									<input type="hidden" id="status" placeholder="status" style="display:block" value="">
									
									
								
							</tbody>
							
						</table>
					</div>
				
			</div>
			</form>
<%} %>
		</div>
	</div>
	
	
		<!--end-main-container-part-->

		<!--Footer-part-->
	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
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

	function editableAll()
	{
		var k;
		document.getElementById('status').value="1";
		 if(document.getElementById('submitAll').style.display=='none')
		document.getElementById('submitAll').setAttribute("style","display:block;margin-top:3px;margin-right:5px");
		else
			document.getElementById('submitAll').setAttribute("style","display:none;margin-top:3px;margin-right:5px");
		document.getElementById("trId1").cells[3].focus();
		var x=document.getElementById('totalEdits').value;
		var val=document.getElementById("price1").getAttribute("contenteditable");
		if(val=='false'){
		for(var i=1;i<x;i++)
			{
			 var d=document.getElementById("price"+i+"");
			 
			 d.setAttribute("contenteditable", true);
			}
		for(k=1;k<x;k++)
			{
				if(!(document.getElementById("trId"+k+"").cells[3].innerHTML.trim())=="")
				{
				
				break;
				}
			}
		
		}else{
			for(var i=1;i<x;i++)
			{
			 var d=document.getElementById("price"+i+"");
			 
			 d.setAttribute("contenteditable", false);
			}
		}
		alert("Edit All Data And Click Submit!");
		document.getElementById("trId"+k+"").cells[3].focus();
		
		
		
		
	}
	function onSubmitClick()
	{
		var myArray=[];
		var myModels=[];
		var x=document.getElementById('totalEdits').value;
		for(var i=1;i<x;i++)
		{
			if(!(document.getElementById("trId"+i+"").cells[3].innerHTML.trim())=="")
				{
			var model=document.getElementById("modelId"+i+"").value;
			var data=document.getElementById("trId"+i+"").cells[3].innerHTML;
			myArray.push(data.trim());
			myModels.push(model.trim());
				}
		}
		document.getElementById("totalValue").value=myArray;
		document.getElementById("totalModelId").value=myModels;
		var demoData=document.getElementById("totalValue").value;
		var demoModel=document.getElementById("totalModelId").value;
		getMyAjax(x,demoData,demoModel);
		document.getElementById("submitAll").setAttribute("style","display:none;margin-top:3px;margin-right:5px");
		
		var val=document.getElementById("price1").getAttribute("contenteditable");
		if(val=='false'){
		for(var i=1;i<x;i++)
			{
			 var d=document.getElementById("price"+i+"");
			 
			 d.setAttribute("contenteditable", true);
			}
		}else{
			for(var i=1;i<x;i++)
			{
			 var d=document.getElementById("price"+i+"");
			 
			 d.setAttribute("contenteditable", false);
			}
		}
		document.getElementById('status').value="0";
	}
	
	function getMyAjax(count,data,modelId)
	{
		
		var request=new XMLHttpRequest();
		var url="/MSaleERP/PriceProfit.do?updateMultiple=y&count="+count+"&data="+data+"&modelId="+modelId+"";  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;
						getSnack();
						
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
	
	function getSingle(v)
	{
		var d=document.getElementById("price"+v+"");
		 d.setAttribute("contenteditable", true);
		 document.getElementById("editAll").disabled="disabled";
		 document.getElementById("editAll").setAttribute("style","margin-top:3px;margin-right:5px;cursor:not-allowed");
		 document.getElementById("trId"+v).cells[3].focus();
		
	}
	function setData(count,id)
	{
		if(event.keyCode==13 || (event.which > 31 && (event.which < 48 || event.which > 57)))
			{
			if(document.getElementById('status').value==1){
				return false;
			}else{
			var modelId=document.getElementById("modelId"+count+"").value;
			getAjax(count,id,modelId);
			document.getElementById("editAll").disabled="";
			 document.getElementById("editAll").setAttribute("style","margin-top:3px;margin-right:5px;");
			var d=document.getElementById("price"+count+"");
			 d.setAttribute("contenteditable", false);
			return false;
			}
			}
		
		
	}
	function getAjax(count,id,modelId)
	{
		
		var request=new XMLHttpRequest();
		var url="/MSaleERP/PriceProfit.do?updateSingle=y&count="+count+"&value="+id+"&modelId="+modelId+"";  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;  
						if(val==1)
						getSnack();
						
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
	function getSnack()
	{
		var div=document.createElement("DIV");
		div.setAttribute("id","snackbar");
		div.innerHTML="Update Successfully";
		document.body.appendChild(div);
		showsnack();
		
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

	function getInfo(val)
	{
		var request=new XMLHttpRequest();
		//var mid = document.getElementById("models").value;
		var url="/MSaleERP/PriceProfit.do?modelid="+val;  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;  
						document.getElementById('sold').value=val;  
					}  
				}
				request.open("GET",url,true);  
				request.send();  
		}
		catch(e)
		{
			alert("Unable to connect to server");
		}  

	}
		function calc(temp)
	{
		var sitems = document.getElementById("sold").value;
		var total=temp*sitems;
		document.getElementById('tprice').value=total;  
	}
	
	function getDeleteId(id)
	{
		document.getElementById("deleteId").value=id;
	}
		
	function getSr(id){
		$('color-form')
		var someVarName = id;
		localStorage.setItem("someVarName", someVarName);
		var f=document.getElementById("color-form");
	    f.action='/MSaleERP/jsp/admin/settings/addColor.jsp?colorRowId='+id;
	    f.method="post";
	    f.submit();     
	}
	
	
	function showModal(){
		var someVarName = localStorage.getItem("someVarName");
		var error = document.getElementById("error").value;
		if(error==4)
		{
			$('#update').modal('show');
		}
		else if(error==3)
		{
			$('#error-msg-delete').modal('show');	
		}
		else if(someVarName>0)
		{
			$('#update').modal('show');
		}
		localStorage.setItem('someVarName', null);
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
</script>
		
</body>
</html>