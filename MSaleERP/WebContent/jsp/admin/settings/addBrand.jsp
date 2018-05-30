<%@page import="java.util.Date"%>
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

#addDealerTable td{ 

		border-collapse:collapse; 
		background: #f9f9f9;
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


	function Submit() {
		$('input').focus(
			    function(){
			        $(this).css('border-color','#ff0000');
			    }).blur(
			        function(){
			            $(this).css('border-color','#ccc');
			        });
		var brandname = document.brandform.brandname.value;
		
		if (brandname == "") {
			document.brandform.brandname.focus();
			
			//document.getElementById("brandname_errorBox").innerHTML = "*Enter Your Brand Name";
			return false;
		}
		

	}
	
	
	function getSr(id){
		$('form3')
		var someVarName = id;
		//alert(someVarName);
		localStorage.setItem("someVarName", someVarName);
		var f=document.form3;
	    f.action='/MSaleERP/jsp/admin/settings/addBrand.jsp?update='+id;
	    f.method="post";
	    f.submit();     
	}
	

	function showModal(){
		var someVarName = localStorage.getItem("someVarName");
		var error = document.getElementById("error").value;
		
		if(error==2)
		{
			$('#error-msg').modal('show');
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
	
	function setFocusToTextBox() {
		clock();
		document.getElementById("brandname").focus();
		showModal();
		myFunction();
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

<body onload="setFocusToTextBox()">

	<jsp:include page="../common/header_navbar.jsp"></jsp:include>
	
	<!--sidebar-menu-->
	<jsp:include page="../common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->

	<% if(request.getAttribute("status1")!=null){ %>
	<div id="snackbar"><%=request.getAttribute("status1")%></div>
	<%} %>
	
	
	<div class='modal hide fade' id='update' role='dialog'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
					<h4 class='modal-title'>Update Brand</h4>
				</div>
				<div class='modal-body'>
					<%
						String error = "";
						RequireData rd = new RequireData();
					
						if (request.getAttribute("error") != null) {
							error = request.getAttribute("error").toString();
						}

						String brandName = "";
						String rowId = "";
						if (request.getParameter("update") != null) {
							rowId = request.getParameter("update");
							session.setAttribute("sessionId", rowId);
							brandName = rd.getBrandNameById(rowId);

						}
					%>
					<form class='form-horizontal' action='/MSaleERP/AddBrand.do?update=<%=rowId%>' method='post' name='form3'">
						<div class='form-group'>
							<div class='widget-content nopadding'>
								<div class='control-group'>
									<label class='control-label'><span style="color: red;">*</span>Brand Name :</label>
									<div class='controls'>
										<input type='text' class='span11' value="<%=brandName%>" onkeyup="this.value=this.value.toUpperCase()" placeholder='brand Name'
											name='brandname' id='updatebrandname' style='width: 300px;' required />
									</div>
								</div>
								
								
								
								<div class="control-group">
					              <label class="control-label"><span style="color: red;">*</span>Select Dealer</label>
					              <div class="controls" style="width: 334px;">
					                <select name="update_Dealer" id="update_Dealer" style="width: 315px;" required>
					                <option value="">Select Dealer</option>
					             <%
					                
					                 List dealerList = rd.getDealerList();
					             
					             	String did = rd.getdid(brandName);
					             
					             	String dealerid1 = "";
					                 
					                 if(dealerList!= null)
					                 {
					                	 String selectedDealerId="", name="";
					                     Iterator itr = dealerList.iterator();
					                	 while(itr.hasNext())
					                	 {
					                		 String id= itr.next().toString();
					                		 name = itr.next().toString();
					                		  
					                		 
					                		 if(did.equals(id)){
					                			 selectedDealerId = id;
						                		 %>
						                		 	
						                		    <option value="<%=id %>" selected="selected" ><%=name %></option>
						                		 <%
					                		 }else{
					                			 %>
					                 		    <option value="<%=id %>" ><%=name %></option>
					                 		 	<% 
					                		 }
					                	 }
					                	 %>
					                	 <input type="hidden" name="selectedDealerId" value="<%=selectedDealerId %>" />
					                	   </select>
					              </div>
					                	 <%
					                 }
					              %>
					           	
					          </div>
            
								
								
								
													
							</div>
							<div class='modal-footer'>
								<input type='submit' id="submitbtn"  class='btn btn-primary' value='Submit'
									onSubmit='' /> <input type='button' class='btn btn-primary' id="cancelbtn"
									data-dismiss='modal' value='Cancel' />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>



	<input type="hidden" name="error" id="error" value="<%=error%>" />

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

									<h4>Brand already Exist...</h4>
								</div>
							</div>
							<div class="modal-footer">
								<input type="button" class="btn btn-primary"
									id="submitbtn" data-dismiss="modal" value="OK" />
							</div>
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

									<h4> Cannot delete the Selected record as it is linked with some other records..!! </h4>
								</div>
							</div>
							<div class="modal-footer">
								<input type="button" class="btn btn-primary" id="submitbtn"
									data-dismiss="modal" value="OK" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>



	<div class="modal hide fade" id="add-dealer" role="dialog">
	 <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add New Dealer</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/InsertDealer.do" method="post" name="insertDealer">
					<div class="form-group">
						<div class="widget-content nopadding">
				            
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Organization Name :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Organization Name"  onkeyup="this.value=this.value.toUpperCase();" name="organization_name" id="organization_name" required style="width: 300px;" />
				              </div>
				            </div>
				            <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Dealer Name :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Dealer Name"  name="dealer_name" onkeyup="this.value=this.value.toUpperCase();" style="width: 300px;" required />
				              </div>
				            </div>
				             <div class="control-group">
				              <label class="control-label"><span style="color: red;">*</span>Contact No :</label>
				               
				              	<div class="controls controls-row">
				            		<input type="text" placeholder="Contact No" class="span6 m-wrap"  onkeypress="return isNumber(event)" maxlength="10" name="contact_no"  style="width: 300px;"> 
				          		</div>
				            </div>
				            <div class="control-group">
				              <label class="control-label">Email Id :</label>
				              <div class="controls">
				                <input type="email" class="span11" placeholder="Email Id"  name="email_id" style="width: 300px;: "/>
				              </div>
				            </div>
				            
				            <div class="control-group">
				              <label class="control-label">Balance Amount :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Balance Amount" onkeypress="return isNumber(event)" name="balanceAmount" style="width: 300px;" />
				              	<input type="hidden" value="addBrandPage" name="addBrandPage"/>
				              </div>
				            </div>
				            
							<div class="modal-footer">
								<input type="submit" id="submitbtn" class="btn btn-primary" value="Submit" />
								<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
							</div>
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
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Add Brand</a></div>
    <h1>Add New Brand</h1>
  </div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Add Brand</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/MSaleERP/AddBrand.do" method="post" class="form-horizontal" name="brandform" onsubmit="return Submit()">
								<div class="control-group" style="height: 50px;">
									<label class="control-label"><span style="color: red;">*</span>Brand
										Name :</label>
									<div class="controls">
										<input type="text" class="span11" placeholder="Brand name" onkeyup="this.value = this.value.toUpperCase();" name="brandname" id="brandname" onkeyup="this.value=this.value.toUpperCase()" style="width: 300px;" required />
										<span class="status"></span>
									</div>
								</div>
								
								
								<div class="control-group" style="height: 50px;">
					           	 <table id="addDealerTable">
					           	  <tr>
					           	   <td>
									<label class="control-label"><span style="color: red;">*</span>Select Dealer :</label>
								<div class="controls" style="width: 500px;">
					                <select class="aa" required="required" name="dealer" id="dealer" style="width: 300px; margin-right:15px;"  >
					                	<option value="">Select</option>
					              <%
					              	  String count="";
					            
					                 List brandlist = rd.getDealerList();
					                  
					                 
					                 if(brandlist!= null)
					                 {
					                     Iterator itr =brandlist.iterator();
					                	 while(itr.hasNext())
					                	 {
					                		 String id= itr.next().toString();
					                		 String name = itr.next().toString();
					                		 %>
					                		    <option value="<%=id %>" ><%=name %></option>
					                		 <%
					                	 }
					                	 %>
					                	 
                	 
			                	   </select>
			                	   </div>
			                	   </td>
					              <td>
					           		 <a href="#add-dealer" data-toggle="modal" style="margin-left: -170px;"><span class="badge badge-inverse"><i class="icon-plus"></i></span></a>
					           		 </td>
					           		 </tr>
					           		</table>
			                	   </div>
			                	   
									<%
					                 }
					               
					               %>	
								
								<div class="form-actions" align="center" name="brandform" 
									onsubmit="return Submit()">
									
									<button type="submit" id="submitbtn" class="btn btn-success" onclick="Submit()">Submit</button>
									&nbsp;&nbsp;&nbsp;
									<a href="/MSaleERP/jsp/admin/homePage.jsp" class="btn btn-danger" id="cancelbtn">Exit</a>
								</div>
							</form>
						</div>
					</div>




					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Brands List</h5>
						</div>
						<div class="widget-content nopadding">
							<table  class="table table-bordered data-table" id="TFtable" >
								<thead>
									<tr>
										<th>Sr.No</th>
										<th>Brand Name</th>
										<th>Dealer Organization</th>
										<th>Action</th>
									</tr>
								</thead>
								<%
									RequireData data = new RequireData();

									List details = data.getBrandNameList();
									int srno = 0;
									String brand_name = "";
									String id="";
									String dealerid="";
									String dname="";

									if (details != null) {
										Iterator itr = details.iterator();
								%>
								<tbody>
									<%
										while (itr.hasNext()) {
												srno++;
												brand_name = itr.next().toString(); 
												dealerid=itr.next().toString();
												
												dname = rd.getdealerName(dealerid);
									%>
									<tr class="gradeX">
										<td><%=srno%></td>
										<td name="brandId"><%=brand_name%></td>
										<td><%=dname%></td>
										<td>
											<%
												id = String.valueOf(itr.next());
											%> <a href="#update" data-toggle='modal' onclick='getSr(<%=id%>)'>Update</a> / <a onclick="getDeleteId(<%=id %>)" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a>
										</td>
									</tr>
									<%
										}
										}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--end-main-container-part-->
	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12"> 2017 &copy; Vertical Software. <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
	<script src="/MSaleERP/config/js/jquery.min.js"></script>

	<script src="/MSaleERP/config/js/matrix.tables.js"></script>
	<!--end-Footer-part-->
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
				<form action="/MSaleERP/AddBrand.do">
				<input type="hidden" id="deleteId" name="delete">
					<a href=""></a><input type="submit" class="btn btn-primary" id="ok" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>

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


$('#update').on('shown.bs.modal', function () {
    $('#updatebrandname').focus();
}) 	


	$('.textarea_editor').wysihtml5();
</script>
	<script type="text/javascript">
		// This function is called from the pop-up menus to transfer to
		// a different page. Ignore if the value returned is a null string:
		function goPage(newURL) {

			// if url is empty, skip the menu dividers and reset the menu selection to default
			if (newURL != "") {

				// if url is "-", it is this page -- reset the menu:
				if (newURL == "-") {
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
		function getDeleteId(id)
		{
			document.getElementById("deleteId").value=id;
		}
		
		$('#add-dealer').on('shown.bs.modal', function () {
		    $('#organization_name').focus();   
		}) 
		
		
		function isNumber(evt) {
		    evt = (evt) ? evt : window.event;
		    var charCode = (evt.which) ? evt.which : evt.keyCode;
		    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		        return false;
		    }
		    return true;
		}
		
	</script>
</html>