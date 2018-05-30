<%@page import="java.util.Date"%>
<%@ page errorPage="/MSaleERP/admin/error/errorPage.jsp" %>
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
<link rel="stylesheet" href="/MSaleERP/config/css/colorpicker.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-wysihtml5.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'  type='text/css'>

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
</style>


<script type="text/javascript">


function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function updateModel(id){
	$('updateForm')
	var someVarName = id;
	localStorage.setItem("someVarName", someVarName);
	var f=document.updateForm;
    f.action='/MSaleERP/jsp/admin/settings/addModel.jsp?updateScriptId='+id;
    f.method="post";
    f.submit();     
}


function showModal(){
	clock();
	var someVarName = localStorage.getItem("someVarName");
	/* alert(someVarName); */
	
	var error = document.getElementById("error").value;
		
		if(error==4)
		{
			$('#error-msg-color').modal('show');
		}
		else if(error==2)
		{
			$('#error-msg').modal('show');
		}
		else if(error==3)
		{
			$('#error-msg-delete').modal('show');	
		}
		else if(error==6){
			$('#error-msg-model').modal('show');
		}
	localStorage.setItem('someVarName', null);
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

function setFocusToTextBox() {	
	clock();
	document.getElementById("brand").focus();
	showModal();
	myFunction();
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
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Add Model</a></div>
    <h1>Register New Model</h1>
  </div>
<!--End-breadcrumbs-->

<!--Action boxes-->
  <div class="container-fluid">
    
    <hr>
    <div class="row-fluid">
    <div class="">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Add New Model</h5> 
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/addModel.do" method="post" class="form-horizontal">
            <div class="control-group" style="height: 50px;">
             <table>
               <tr>
                <td>
              <label class="control-label"> <span style="color: red">*</span> Select Brand :</label>
              <div class="controls" style="width: 334px;">
                <select name="brand" id="brand" onchange="getModelList(this.value)">
          
             <%
              String error = "";
              
				
  			if(request.getAttribute("error")!=null){
  				error = request.getAttribute("error").toString();
  			}
              
              
                 RequireData rd =new  RequireData();
                 List brandlist = rd.getBrandNameList1();
                  
                 
                 if(brandlist!= null)
                 {
                     Iterator itr =brandlist.iterator();
                	 while(itr.hasNext())
                	 {
                		 String name = itr.next().toString();
                		 String id= itr.next().toString();
                		 %>
                		    <option value="<%=id %>"><%=name %></option>
                		 <%
                	 }
                	 %>
                	   </select>
              </div>
                	 <%
                 }
                 else
                 {
                	 %>
                	 
                	  </select>
              </div> 
                	 <%
                	 
                 }
              %>
                </td>
                <td>
              
<!-- 	                <a href="#brandpopup" data-toggle="modal" width="30px"><button class="btn btn-primary btn-mini" style="width: 40px; border: 2px black solid; font-size: 20px;">+</button></a> -->
	                   <a href="#brandpopup" data-toggle="modal"><span class="badge badge-inverse"><i class="icon-plus"></i></span></a>
	                   </td>
	                 </tr>
	                </table>
	             	
             </div>
             
             <div class="control-group">
              <label class="control-label"> <span style="color: red">*</span> Model Name :</label>
              <div class="controls" style="width: 334px;">
                <input type="text" class="span11" placeholder="Model Name" onkeyup="this.value=this.value.toUpperCase();" name="modelname" style="width: 300px; height: " required/>
              </div>
            </div>
             
             
             <div class="control-group">
             <table>
              <tr>
               <td>
              <label class="control-label">Select Color :</label>
              <div class="controls"  style="width:331px">
                <select multiple name="mcolor" placeholder="Select Color" required>
              
                   <% 
                	List colorlist1 = rd.getColor();
                 
                 if(colorlist1!= null)
                 {
                     Iterator itr1 =colorlist1.iterator();
                	 while(itr1.hasNext())
                	 {		
                		 %>
                  <option value="<%=itr1.next() %>"><%=itr1.next() %></option>
                  <%}}%>
                </select>
                </td>
                <td>

                   <a href="#add-color" data-toggle="modal"><span class="badge badge-inverse"><i class="icon-plus"></i></span></a>
              </div>
              </td>
               </tr>
              </table>
            </div>
             
            
            
            
         	<div class="control-group" style="height: 50px;">
                <label class="control-label">RAM :</label> 
                <input type="text" class="span11" placeholder="RAM" name="ram" id="ram" onkeypress="return isNumber(event)" style=" width: 100px; margin-left: -160px; margin-top: 10px;"/><span class="gb" style=" color: #cfc9c9; position: relative; right:19px;">GB</span>
  	              <label class="control-label">ROM :</label>
                <input type="text" class="span11" placeholder="ROM" name="rom" id="rom" onkeypress="return isNumber(event)" style="position: relative;width: 100px; left: 50px;top: 5px;"/><span class="gb" style=" color: #cfc9c9; position: relative; left: 31px;">GB</span>
    	    </div>
            <div class="form-actions" >
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
              <button type="submit" class="btn btn-success" name="add">Add</button> &nbsp;&nbsp;
              <a href="/MSaleERP/jsp/admin/homePage.jsp" class="btn btn-danger">Exit</a>
              <!-- <button type="submit" class="btn btn-danger">Cancel</button> -->
            </div>
       </form>
       </div>
       </div>
         <div class="widget-box">
          <div class="widget-title"> 
          	<span class="icon"> <i class="icon-th"></i> </span>
            <h5>Model List</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered table-striped" id="TFtable">
              <thead>
                <tr>
                  <th style="width: 2px">S.No.</th>
                  <th style="width: 100px">Brand Name</th>
                  <th style="width: 100px">Model</th>
                  <th style="width: 80px">Color</th>
                  <th style="width: 120px;">AliasName</th>
                  <th style="width: 80px">Actions</th>
                </tr>
              </thead>
              <tbody id="tb">
              <%
                 List modelData = rd.getModelData();
                  
                 
                 if(modelData!= null)
                 {
                     Iterator itr =modelData.iterator();
                     int i=1;
                	 while(itr.hasNext())
                	 {	
                		 %>
                		 
              	<tr>
              	  <td style="text-align:center"><%=i%></td>
                  <td style="text-align:center"><%=itr.next() %></td> <% Object modelId=itr.next(); %>
                  <td style="text-align:center" value="<%=modelId %>"><%=itr.next() %></td>
                  <td style="text-align:center"><%=itr.next() %></td>
                  <td style="text-align:center"><%=itr.next() %></td>
                   <td style="text-align:center"> <a onclick="getDeleteId(<%=modelId %>)" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a></td>
                </tr>
                <% i++;} }%>
                
              </tbody>
            </table>
          </div>
         </div>
        </div>
      </div>

</div>

<!--end-main-container-part-->

<!--Footer-part-->
</div>
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>

<!--end-Footer-part-->
<script src="/MSaleERP/config/js/jquery.min.js"></script> 
<script src="/MSaleERP/config/js/jquery.ui.custom.js"></script> 
<script src="/MSaleERP/config/js/bootstrap.min.js"></script> 
<script src="/MSaleERP/config/js/bootstrap-colorpicker.js"></script> 
<script src="/MSaleERP/config/js/bootstrap-datepicker.js"></script>
<script src="/MSaleERP/config/js/jquery.toggle.buttons.js"></script> 
<script src="/MSaleERP/config/js/masked.js"></script> 
<script src="/MSaleERP/config/js/jquery.uniform.js"></script> 
<script src="/MSaleERP/config/js/select2.min.js"></script> 
<script src="/MSaleERP/config/js/matrix.js"></script> 
<script src="/MSaleERP/config/js/matrix.form_common.js"></script> 
<script src="/MSaleERP/config/js/wysihtml5-0.3.0.js"></script> 
<script src="/MSaleERP/config/js/jquery.peity.min.js"></script> 
<script src="/MSaleERP/config/js/bootstrap-wysihtml5.js"></script> 

<script>

	$('.textarea_editor').wysihtml5();
</script>



<input type="hidden" name="error" id="error" value="<%= error %>" /> 

<div class="modal fade" id="error-msg" role="dialog">
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
          					
				              <h4> Brand already Exist... </h4>
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


<div class="modal fade" id="error-msg-color" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="#" method="post" name="form5">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
          					
				              <h4> Color already Exist... </h4>
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

<div class="modal fade" id="error-msg-model" role="dialog">
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
          					
				              <h4> Model already Exist... </h4>
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


<!-- for adding Colorss -->

	<div class="modal hide fade" id="add-color" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add Color</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/AddColor.do" method="post" name="form1">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <label class="control-label">Add Color :</label>
				              <div class="controls">
								<input type="text" class="form-control input-sm" name="colorname" id="colorname" onkeyup="this.value=this.value.toUpperCase();" pattern="[a-zA-Z]*" placeholder="Color Name" required/>
								<input type="hidden" name="addmodalpage" value="addmodalpage">
				              </div>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="submit" class="btn btn-primary" id="submitbtn" value="Submit" onSubmit="" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" id="cancelbtn" value="Cancel"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
	
	<!-- for adding Brandss -->
	
	<div class="modal hide fade" id="brandpopup" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add Brand</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/AddBrand.do" method="post" name="form3">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <label class="control-label">Brand Name :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Brand Name" id="brandname" onkeyup="this.value=this.value.toUpperCase();"  name="brandname" required style="width: 300px;" />
				                <input type="hidden" name="dealerpage" value="modelpage">
				              </div>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="submit" class="btn btn-primary" value="Submit" id="submitbtn" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" id="cancelbtn" value="Cancel"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
	
	<!-- for updating data -->	
	
	<div class="modal hide fade" id="DeleteConfirmBox" role="dialog">
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
				<form action="/MSaleERP/DeleteModel.do">
				<input type="hidden" id="deleteId" name="modelId">
					<a href=""></a><input type="submit" class="btn btn-primary" id="ok" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>
	
</body>

<script type="text/javascript">

$('#add-color').on('shown.bs.modal', function () {
    $('#colorname').focus();
}) 


$('#brandpopup').on('shown.bs.modal', function () {
    $('#brandname').focus();
})

function getDeleteId(id)
{
	document.getElementById("deleteId").value=id;
}

</script>

</html>