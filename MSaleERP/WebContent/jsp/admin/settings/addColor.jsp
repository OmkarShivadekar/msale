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
</style>

<script type="text/javascript">


function setFocusToTextBox() {
	clock();
	document.getElementById("colorname").focus();
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
				<a href="#" class="current">Add Color</a>
			</div>
			<h1>Add New Color</h1>
		</div>
		<!--End-breadcrumbs-->

		<!--Action boxes-->
		<div class="container-fluid">

			<hr>
			<div class="row-fluid">
				<div class="">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Color Details</h5>
						</div>
						<div class="widget-content nopadding">
							<form action="/MSaleERP/AddColor.do" method="post"
								class="form-horizontal" name="colorform">
								<div class="control-group">
									<label class="control-label"><span style="color: red;">*</span>Color Name :</label>
									<div class="controls">
										<input type="text"  onkeyup="this.value = this.value.toUpperCase();" pattern="[a-zA-Z\s]*" class="span11"
											placeholder="Color name" name="colorname" id="colorname"
											style="width: 300px;" required />
									</div>
								</div>

								<div class="form-actions">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

									<button type="submit" id="submitbtn" class="btn btn-success">Save</button>
									<a href="/MSaleERP/jsp/admin/homePage.jsp"
										id="cancelbtn" class="btn btn-danger">Exit</a>
								</div>

							</form>
						</div>
					</div>
				</div>
			</div>


			<div class="widget-box">
				<div class="widget-title">
					<span class="icon"><i class="icon-th"></i></span>
					<h5>Data table</h5>
				</div>
				<form name="color-form" id="color-form" method="post">
					<div class="widget-content nopadding">
						<table class="table table-bordered data-table" id="TFtable">
							<thead>
								<tr>
									<th>Sr.No</th>
									<th>Color Name</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>

							<%
               		RequireData data = new RequireData();
               		List details = data.getColorName();
               		
               		int srno=0;
        			String colorid=""; 
        			String color_name="";
        			String color_id="";
        			String cname="";
        			
        			if(details!= null)
          			{
           				
           	
           				Iterator  itr = details.iterator();
           			
           
                        while(itr.hasNext())
                        { 
                       	 	srno++;
                       		color_id=itr.next().toString();
                       		color_name=itr.next().toString();
                   
                       		
                       		
               %>

							
								<tr class="gradeX">
									<td><%=srno%></td>
									<td><%=color_name %></td>
									<td>
										<a href="#update" data-toggle="modal" onclick="getSr(<%=color_id%>)">Update</a> / <a onclick="getDeleteId(<%=color_id %>)" href="#DeleteColor" data-toggle='modal'>Delete</a> 
									</td>
								</tr>

								<%
                   }
                 }
              %>


							</tbody>
						</table>
					</div>
				</form>
			</div>
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

	
		
		

		<%  session.setAttribute("old", color_name);
			String error = "";
	
			if (request.getAttribute("error") != null) {
				error = request.getAttribute("error").toString();
			}
		%>
		
	 <input type="hidden" name="error" id="error" value="<%=error%>" />



			<div class="modal hide fade" id="DeleteColor" role="dialog">
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
							<form action="/MSaleERP/AddColor.do">
							<input type="hidden" id="deleteId" name="delete">
								<a href=""></a><input type="submit" class="btn btn-primary" id="ok" value="OK" name="ok" />
								<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
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
								<input type="button" class="btn btn-primary" id="submitbtn" data-dismiss="modal" value="OK" />
							</div>
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
					
					<%
					
						 RequireData rd = new RequireData();
						 int rowId=0;
						 
						 if(request.getParameter("colorRowId")!=null){					
			            	rowId = Integer.parseInt(request.getParameter("colorRowId"));
			            	session.setAttribute("sessionId", rowId);		            	
			             }
						
						 if(rowId>0){
					%>
					
						<h4 class="modal-title">Update Details</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal"
								action="/MSaleERP/AddColor.do?update" method="post" name="form3">
								<div class="form-group">
							<%
									
							 List list1 =rd.getColorRowData(rowId);
				             
				             if(list1!=null)
				             {
				                Iterator itr = list1.iterator();	 
				            	 
				                while(itr.hasNext())
				                {
				                	Object intcolorid = itr.next();
				                	Object varcolorname = itr.next();
						
						 %>
									<div class="control-group">
										<label class="control-label"><span style="color: red;">*</span>Color Name :</label>
										<div class="controls">
											<input type="hidden" name="updateColorId" value="<%= intcolorid %>">
											<input type="text" class="form-control input-sm" name="ucolorname" onkeyup="this.value=this.value.toUpperCase()" id="ucolorname" pattern="[a-zA-Z]*" value="<%=varcolorname%>" placeholder="Enter your name" required />
										</div>
									</div>
								</div>
								<% 		}
				             }
				        %>
								<div class="modal-footer">
									<input type="submit" class="btn btn-primary" value="Update" id="submitbtn"
										onSubmit="" /> <input type="button" class="btn btn-primary"
										data-dismiss="modal" id="cancelbtn" value="Cancel" />
								</div>
							</form>
						</div>
				<%	}
					else{
				%>
						<h4 style="color:red;" class="modal-title">Error</h4>
						</div>
						<div class="modal-body">				
								<div class="form-group">
									<div class="widget-content nopadding">
			          					<div class="control-group">
			          					
							              <h4> Color already Exist... </h4>
							            </div>
								</div>
								<div class="modal-footer">
								<input type="button" class="btn btn-primary" data-dismiss="modal" value="OK"/></div>
								</div>
						</div>
				<%
					}
				%>	 
				</div>
			</div>
			

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

	$('#update').on('shown.bs.modal', function () {
	    $('#ucolorname').focus();
	}) 	

	$('#DeleteColor').on('shown.bs.modal', function () {
	    $('#ok').focus();
	}) 	
	
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