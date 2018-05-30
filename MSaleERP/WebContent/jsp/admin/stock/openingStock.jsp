<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Verical Software</title>
<meta charset="UTF-8" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/font-awesome/css/font-awesome.css"  />
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
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



</style> 

<script type="text/javascript">

window.counter = 0;

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)){
        return false;
    }
    return true;
}

	function showModal(){
		clock();
		
		var someVarName = localStorage.getItem("someVarName");
// 		 alert(someVarName); 
			
			if(someVarName>0)
			{
				$('#addStock').modal('show');
			}
		localStorage.setItem('someVarName', null);
		myFunction();		
	}
	
	
function getModelList(id)
{  		
		var request=new XMLHttpRequest();
		var brand =id;
		var url="/MSaleERP/addModel.do?getBrand="+brand;  

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

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}

</script>

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
<body onload="showModal()">

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
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Add Opening Stock</a></div>
    
  </div>
<!--End-breadcrumbs-->

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
                 
                	//System.out.println("On mobilePurchase.jsp ****** brandIcon List is ==>"+ brandIcon);
                 if(brandIcon!= null)
                 {
                	
                	 //System.out.println("*** in IF LOOP of Brand Icon **");
                     Iterator itr =brandIcon.iterator();
                     %>
                     <%
                	 while(itr.hasNext())
                	 {
                		 Object tempbrandid=itr.next();
                		 int sumofqty=rd.getOpeningQty(tempbrandid.toString());
                		 
                		 //System.out.println("*** in while loop **");
                		 %>
                  <li class="bg_lb" style="border: 1px solid;"  id="span_brandid<%=tempbrandid %>" value="" onclick="changeColor(this.id)"> <a href="/MSaleERP/jsp/admin/stock/openingStock.jsp?brandId=<%=tempbrandid %>"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i> <br> <span class="label label-important" >   
                  
                  <%=sumofqty %></span><%=itr.next() %></a> </li>
                  
         <%
               }
                }
                 
                else
                {
                	//System.out.println("*** in ELSE LOOP of Brand Icon **");
                
                %>
                  <li class="bg_lb"> <a href="#"> <i class="fa fa-mobile" style="font-size: 2.3em;"></i> <br> <span class="label label-important" name="brandId" value=""></span></a> </li>
                  <%} %>
                  
      </ul>  
         
    </div>
    
 <%
 
	 	String stockbrandId="";
		if((request.getParameter("brandId")!=null))
		{
			stockbrandId=request.getParameter("brandId");
		}else if(request.getAttribute("brandId1")!=null){
			stockbrandId=request.getAttribute("brandId1").toString();
		}
 
 %>

   <div class="row-fluid">
       <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
         <h5>Dealer List</h5>
          </div>
          <div class="widget-content nopadding">
           <form name="form2" id="stockTable" method="post">
            <table class="table table-bordered data-table" id="TFtable">
              <thead>
                <tr>
                  <th >S.No.</th>
                  <th >Brand Name</th>
                  <th >Model</th>
                  <th >Color</th>
                  <th >Alias Name</th>
                  <th >Quantity</th>
                  <th >Actions</th>
                </tr>
              </thead>
              <tbody id="tb">
              <%
        
              	 RequireData rd2 = new RequireData();
                 List colorData = rd2.getStockByBrandid(stockbrandId);
                  
                 int i=1;
                 if(colorData!= null)
                 {
                     Iterator itr =colorData.iterator();
                     
                	 while(itr.hasNext())
                	 {	
                		 Object brand=itr.next(); 
                		 Object stockRowId=itr.next(); 
                		 Object model=itr.next(); 
                		 Object color=itr.next();
                		 String alias=itr.next().toString();
                  		 
                		 int getQty = rd2.getQuntity(alias);
                		 
                		 %>
               	  
                		 
              	<tr id="qtycolor<%=i%>">
              	  <td><%=i%></td> 
                  <td><%=brand %> <input type="hidden" id="brandname" value="<%=brand %>" /> </td> 
                  <td value="<%=stockRowId %>"><%=model %></td>
                  <td><%=color %></td>
                  <td> <%=alias %></td>
                  <td id="chckColor<%=i%>"><%=getQty%></td>
                   <td>
                   		<a href="#addStock" data-toggle="modal"  onclick="getSr1(<%=stockRowId%>, '<%=brand%>', '<%=stockRowId%>', '<%=color%>')">Add Stock</a> /
                   		<a href="#delete" id="deleteLink<%=i%>"  data-toggle="modal"  onclick="deleteSearchName(<%=stockRowId%>)">Delete</a> /
                   		<a href="#update" id="updateLink<%=i%>" data-toggle="modal"  onclick="searchName(<%=stockRowId%>)">Update</a>
                   
                   </td>
                </tr>
                <% 
	                  i++;
                	} 
	              }
                %>
                <script>for(var j=1;j<<%=i%>;j++){ 
                	var x=document.getElementById("chckColor"+j).innerHTML;
                	if(x==0){
                		document.getElementById("qtycolor"+j).style.background="#f7abab"; 
                		document.getElementById("deleteLink"+j).disabled=true; 
                		document.getElementById("deleteLink"+j).removeAttribute('href');     
                		document.getElementById("deleteLink"+j).style.textDecoration = 'none'; 
                		document.getElementById("deleteLink"+j).style.cursor = 'default'; 
                		
                		document.getElementById("updateLink"+j).disabled=true; 
                		document.getElementById("updateLink"+j).removeAttribute('href');     
                		document.getElementById("updateLink"+j).style.textDecoration = 'none'; 
                		document.getElementById("updateLink"+j).style.cursor = 'default'; 
                	}
                }</script> 
              </tbody>
                
             </table>
            </form>
          </div>
        </div>
     </div>
    </div>
</div>






<!--end-main-container-part-->


<div class="modal hide fade" id="addStock" style="width: 45%" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<%
							String brand = request.getParameter("brand");
							String model = request.getParameter("model");
							String color = request.getParameter("color");
							
							String modelName = rd.getModel1(model);
						
					%>
			<h4 class="modal-title">Add Stock Details for <span id="modelHead" style="color: red"><strong><p id="modelHead"><%=modelName%></p></strong></span></h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/OpeningStock.do" method="post" id="addstockform" name="form3">
				 <input type="hidden" name="counter" id="counter" />
					<div class="form-group">
						<div class="widget-content nopadding">
						
							<input type="hidden" name="brand" id="brand" value="<%=brand %>" />
							<input type="hidden" name="model" id="model" value="<%=model %>" />
							<input type="hidden" name="color" id="color" value="<%=color %>" />
							<input type="hidden" name="modelname" id="modelname" value="<%=modelName %>" />
							
          					<div class="control-group">
							  <label class="control-label">HSN/SAC Code :</label>
								<div class="controls" >
									<label><input type="radio" name="hsnCode" id="hsnCode" value="85171290" checked="checked" style="width: 313px;" > 85171290</label>
									<label><input type="radio" name="hsnCode" id="hsnCode" value="85171210" style="width: 313px;" > 85171210</label>
							  </div>
							</div>
				            
				            <div class="control-group">
				              <label class="control-label">MRP Price :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="MRP Price"  pattern="[0-9]*" id="mrpprice" name="mrpprice" style="width: 300px;" required />
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label">Stock Quantity :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Stock Count" id="stockqnt"  onkeypress="printMessage()" onKeydown="Javascript: if (event.keyCode==13) addRows(this.value);" pattern="[0-9]*" maxlength="3" name="stockqnt" style="width: 300px;" autocomplete="off" required /><br>
				                <span id="printEnterMessage"> </span>
				              </div>
				            </div>
				            
				            
				            <div class="control-group">
				              
					              <label class="control-label">IMEI No. :</label>
					              <div class="controls">
					              <table id="imeiTable">
					              <tr>
					                <input type="text" class="span11" pattern="[0-9]*" maxlength="17" name="imei1" id="imei1" onblur="checkIMEI(this.value, '1')"  style="width: 300px;" disabled="disabled" required />
					                <p style="font-size:14px;     margin-bottom: 0px;" id="exist1"></p>
					              <tr>
					              </table>
					              </div>
				              
				            </div>
				           
				            
					</div>
					<div class="modal-footer">
					<input type="button" id="submitbtn" class="btn btn-primary" value="Submit" onclick="getArray()"  />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>



<div class="modal hide fade" id="update" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Stock Details</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/OpeningStock.do" method="post" id="updateform" name="updateVehicle">
					<div class="form-group">
						<div class="widget-content nopadding">
				            
				             <div class="control-group">
				              <label class="control-label"><span id="required2" style="color: red;"></span>Model Name : </label>
				              <div class="controls">
				                <div class="input-append">
				                  	<input type="hidden" name="updatemodelId" id="updatemodelId">
				                  	<input type="hidden" name="updateQty" id="updateQty">
				                  	<input type="text" required class="span2" name="updateModelAlias" id="updateModelAlias" style="width: 230px;" readonly="readonly" >
				              	</div>
				              </div>
				            </div>
			            	
			            	
			            	<div class="control-group">
				              <label class="control-label"><span id="required2" style="color: red;"></span>MRP Price : </label>
				              <div class="controls">
				                <div class="input-append">
				                  <input type="text" required class="span2" name="updatePrice"  id="updatePrice" style="width: 230px;" >
				              	</div>
				              </div>
				            </div>
				            
				            
				            <div class="control-group">
				              
					              <label class="control-label">IMEI No. :</label>
					              <div class="controls">
					              <table id="updateImeiTable">
					              <tr>
					                <input type="text" class="span11" pattern="[0-9]*" maxlength="17" name="updateimei1" id="updateimei1" onblur='checkIMEI1(this.value, 1)' style="width: 230px;" required />
					                <p style="font-size:14px; margin-bottom: 0px;" id="uexist1"></p>
					              <tr>
					              </table>
					              </div>
				              
				            </div>
				            
			            	
				            <div class="modal-footer">
									<input type="button" id="submitbtn1" name="updateSubmitBtn" class="btn btn-primary" value="Update" onclick="getArray1()" />
									<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
							</div>
						</div>
					</div>
				</form>
			</div>
				
			</div>
		</div>
	</div>


<div class="modal hide fade" id="delete" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title"><span style="color: red;">Delete Stock</span></h4>
			</div>
			
			 
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/OpeningStock.do" method="post" name="deleteIMEI">
					<div class="form-group">
						<div class="widget-content nopadding">
				            
				             <div class="control-group" style="height: 15px;">
				              <div class="controls" >
				               
				                   <strong style='font-size:14px;color:red; margin-bottom: 10px; position:relative; top: -20px;'> Select IMEI's that you want to delete.</Strong>
				              	</div>
				             
				            </div>
				            
				             <div class="control-group">
				              <label class="control-label"><span id="required2" style="color: red;"></span>Model Name : </label>
				              <div class="controls">
				                <div class="input-append">
				                  	<input type="hidden" name="deletemodelId" id="deletemodelId">
				                  	<input type="hidden" name="deleteQty" id="deleteQty">
				                  	<input type="text" required class="span2" name="deleteModelAlias" id="deleteModelAlias" style="width: 230px;" readonly="readonly" >
				              	</div>
				              </div>
				            </div>
			            	
			            	
			            	<div class="control-group">
				              <label class="control-label"><span id="required2" style="color: red;"></span>MRP Price : </label>
				              <div class="controls">
				                <div class="input-append">
				                  <input type="text" required class="span2" name="deletePrice"  id="deletePrice" style="width: 230px;" >
				              	</div>
				              </div>
				            </div>
				            
				            
				            <div class="control-group">
					              <label class="control-label">IMEI No. :</label>
					              <div class="controls">
					              <table id="deleteImeiTable">
					              <tr>
					                <input type="text" class="span11" pattern="[0-9]*" maxlength="17" name="deleteimei1" id="deleteimei1" style="width: 230px;" readonly="readonly" required />
					                <input type="checkbox" name="deleteimei" id="deleteimei11">
					              <tr>
					              </table>
					              </div>
				              
				            </div>
				            
			            	
				            <div class="modal-footer">
									<input type="submit" id="deletebtn" name="deleteSubmitBtn" class="btn btn-primary" value="Delete" />
									<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
							</div>
						</div>
					</div>
				</form>
			</div>
				
			</div>
		</div>
	</div>




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
<script>
var l=1;
var ImeiArray =[];

var l1=1;
var ImeiArray1 =[];
	$('.textarea_editor').wysihtml5();
	
	
	function printMessage() {
		document.getElementById("printEnterMessage").innerHTML="<strong style='font-size:13px;color:red;'>Press ENTER (After Quantity)</Strong>";
	}
	
	
	function getSr1(id, brand, model, color){
	    
		document.getElementById("brand").value = brand;
		document.getElementById("model").value = model;
		document.getElementById("color").value = color;
		
		
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
				var modelName = this.responseText;
				document.getElementById("modelname").value = modelName;
				document.getElementById("modelHead").innerHTML = modelName;
				
			}
		};
	xhttp.open("POST","/MSaleERP/OpeningStock.do?modelid="+model, true);
	xhttp.send();
	    
	}

	
	
	function searchName(id) {
		
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText.split(",");
				
				document.getElementById("updatemodelId").value = demoStr[0];
				document.getElementById("updateModelAlias").value = demoStr[1];
				document.getElementById("updatePrice").value = demoStr[2];
				
				var qty = demoStr[3];
				document.getElementById("updateQty").value = demoStr[3];
				document.getElementById("updateimei1").value = demoStr[4];
				
				
				var table = document.getElementById("updateImeiTable");
				var counter=4; //
				var rowCount1 = table.rows.length;
				var tableHeaderRowCount = 0;
				
				if(rowCount1>0){
					for (var i = tableHeaderRowCount; i < rowCount1; i++) {
					    table.deleteRow(tableHeaderRowCount);
					}
				}
				
				
				for(var i=2; i<=qty; i++)
				{
					counter++;
					var rowCount = table.rows.length;

					var row = table.insertRow(rowCount);
					var cell1 = row.insertCell(0);
					cell1.innerHTML = "<br><tr><input type='text' pattern='[0-9]*' maxlength='17' style='width: 230px;'  id='updateimei"+i+"'  name='updateimei"+i+"' onblur='checkIMEI1(this.value, "+i+")' value='"+demoStr[counter]+"' required /><p style='font-size:14px;     margin-bottom: 0px;' id='uexist"+i+"'></p></tr>"
				}
				
				}
			};
		xhttp.open("POST","/MSaleERP/OpeningStock.do?updateid="+id, true);
		xhttp.send();
		
		
	}
	
	
	
function deleteSearchName(id) {
		
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				
				var demoStr = this.responseText.split(",");
				
				document.getElementById("deletemodelId").value = demoStr[0];
				document.getElementById("deleteModelAlias").value = demoStr[1];
				document.getElementById("deletePrice").value = demoStr[2];
				
				var qty = demoStr[3];
				document.getElementById("deleteQty").value = demoStr[3];
				document.getElementById("deleteimei1").value = demoStr[4];
				document.getElementById("deleteimei11").value = demoStr[4];
				
				var table = document.getElementById("deleteImeiTable");
				var counter=4; //
				var rowCount1 = table.rows.length;
				var tableHeaderRowCount = 0;
				
				if(rowCount1>0){
					for (var i = tableHeaderRowCount; i < rowCount1; i++) {
					    table.deleteRow(tableHeaderRowCount);
					}
				}
				
				
				for(var i=2; i<=qty; i++)
				{
					counter++;
					var rowCount = table.rows.length;

					var row = table.insertRow(rowCount);
					var cell1 = row.insertCell(0);
					cell1.innerHTML = "<br><tr><input type='text' pattern='[0-9]*' maxlength='17' readonly='readonly' style='width: 230px;'  id='deleteimei"+i+"'  name='deleteimei"+i+"' value='"+demoStr[counter]+"' required /> <input type='checkbox' value='"+demoStr[counter]+"' name='deleteimei' id='deleteimei"+i+i+"'/></tr>"
				}
				
				}
			};
		xhttp.open("POST","/MSaleERP/OpeningStock.do?updateid="+id, true);
		xhttp.send();
		
		
	}
	
	
	function addRows(number) {
		var tableHeaderRowCount = 0;
		var table = document.getElementById("imeiTable");
		var rowCount = table.rows.length;
		for (var i = tableHeaderRowCount; i < rowCount; i++) {
		    table.deleteRow(tableHeaderRowCount);
		}
		
		
		
		for(var i=2; i<=number; i++)
		{
			counter++;
			l++;
			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);
			
			var cell1 = row.insertCell(0);
			cell1.innerHTML = "<br><tr><input type='text' pattern='[0-9]*' maxlength='17' style='width: 300px;' name='imei"+i+"' id='imei"+i+"' onblur='checkIMEI(this.value, "+i+")' required /><p style='font-size:14px;     margin-bottom: 0px;' id='exist"+i+"'></p></tr>"
		}
		
		document.getElementById("counter").value = counter+1;
		document.getElementById("imei1").disabled=false;
	}	
	
	
	function checkLink(i) {
		
		document.getElementById('deleteLink'+j).disabled=true;
        document.getElementById('deleteLink'+j).removeAttribute('href');    
        document.getElementById('deleteLink'+j).style.textDecoration = 'none';
        document.getElementById('deleteLink'+j).style.cursor = 'default';
	}
	
	
	
	function getArray(){
		var flag=0;
		var fill=false;
		
		for(var i=1;i<l+1;i++){
			var one=document.getElementById('imei'+i).value;
			ImeiArray.push(one);
		}
		for (var i = 0; i < ImeiArray.length ; i++) {
	    	  document.getElementById("exist"+(i+1)).innerHTML="";
	      }
		
		for (var i = 0; i < ImeiArray.length ; i++) {
			if(document.getElementById("imei"+(i+1)).value=="")
				{
				fill=true;
				flag=1;
				document.getElementById("exist"+(i+1)).style.color="RED";
				document.getElementById("exist"+(i+1)).innerHTML="Fill this first";
				}
		}
		if(!fill)
			{
	      for (var i = 0; i < ImeiArray.length ; i++) {
	        for(var j = i+1 ; j <ImeiArray.length ; j++){ 
	          if (ImeiArray[i]==ImeiArray[j]){
	        	  flag=1;
	          	document.getElementById("imei"+(j+1)).focus();
	          	document.getElementById("exist"+(i+1)).style.color="RED";
	          	document.getElementById("exist"+(j+1)).style.color="RED";
	          	
	          	document.getElementById("exist"+(i+1)).innerHTML="SAME IMEI";
	          	document.getElementById("exist"+(j+1)).innerHTML="SAME IMEI";
	          }
	        }
	      }
			}
	      if(!(flag==1))
	    	  {
	    	  var f=document.getElementById("addstockform");
			    f.action='/MSaleERP/OpeningStock.do';
			    f.method="post";
			    f.submit(); 
	    	  }
	      
	      ImeiArray.length=0;
		//location='/MSaleERP/OpeningStock.do';
		
	}
	
	
	function getArray1(){
		var flag=0;
		var fill=false;
		
		ImeiArray1=[];   
		var table = document.getElementById("updateImeiTable");
		l1 = table.rows.length;
		
		
		for(var i=1;i<=l1+1;i++){
			var one=document.getElementById('updateimei'+i).value;
			ImeiArray1.push(one);
		}
		for (var i = 0; i < ImeiArray1.length ; i++) {
	    	  document.getElementById("uexist"+(i+1)).innerHTML="";
	      }

		for (var i = 0; i < ImeiArray1.length ; i++) {
			if(document.getElementById("updateimei"+(i+1)).value=="")
				{
				fill=true;
				flag=1;
				document.getElementById("uexist"+(i+1)).style.color="RED";
				document.getElementById("uexist"+(i+1)).innerHTML="Fill this first";
				}
		}
		if(!fill)
		{
	      for (var i = 0; i < ImeiArray1.length ; i++) {
	        for(var j = i+1 ; j <ImeiArray1.length ; j++){ 
	          if (ImeiArray1[i]==ImeiArray1[j]){
	        	  flag=1;
	          	document.getElementById("updateimei"+(j+1)).focus();
	          	document.getElementById("uexist"+(i+1)).style.color="RED";
	          	document.getElementById("uexist"+(j+1)).style.color="RED";
	          	
	          	document.getElementById("uexist"+(i+1)).innerHTML="SAME IMEI";
	          	document.getElementById("uexist"+(j+1)).innerHTML="SAME IMEI";
	          }
	        }
	      }
		}
	      if(!(flag==1))
	    	  {
	    	  var f=document.getElementById("updateform");
			    f.action='/MSaleERP/OpeningStock.do';
			    f.method="post";
			    f.submit(); 
	    	  }
	      
	}
	
	
	function checkIMEI(imei,id)
	{

		var request=new XMLHttpRequest();
		var url="/MSaleERP/OpeningStock.do?validateImei="+imei;  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;
						if(val==1)
						{
							document.getElementById("exist"+id).innerHTML="This IMEI already exist in Record";
							document.getElementById("exist"+id).style.color="red";
							document.getElementById("imei"+id).focus();
							document.getElementById("submitbtn").disabled=true;
						}
						else{
							document.getElementById("exist"+id).innerHTML="";
							document.getElementById("submitbtn").disabled=false;
						}
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
	
	
	function checkIMEI1(imei,id)
	{
		var request=new XMLHttpRequest();
		var url="/MSaleERP/OpeningStock.do?validateImei1="+imei;  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;
						if(val==1)
						{
							document.getElementById("uexist"+id).innerHTML="This IMEI already exist in Record";
							document.getElementById("uexist"+id).style.color="red";
							document.getElementById("updateimei"+id).focus();
							document.getElementById("submitbtn1").disabled=true;
						}
						else{
							document.getElementById("uexist"+id).innerHTML="";
							document.getElementById("submitbtn1").disabled=false;
						}
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


	
</body>


<script type="text/javascript">


$('#addStock').on('shown.bs.modal', function () {
    $('#mrpprice').focus();
}) 
</script>
</html>