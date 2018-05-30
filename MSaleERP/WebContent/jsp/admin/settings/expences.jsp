<%@page import="java.util.Date"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page import="utility.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="utility.*"%>
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

	function getSr(id){
		$('form3')
		var someVarName = id;
		localStorage.setItem("someVarName", someVarName);
		var f=document.form3;
	    f.action='/MSaleERP/jsp/admin/settings/expences.jsp?exp_id='+id;
	    f.method="post";
	    f.submit();     
	}
	

	function showModal(){
		var someVarName = localStorage.getItem("someVarName");
		/* alert(someVarName); */
		if(someVarName>0)
			{
				$('#update').modal('show');
			}
		localStorage.setItem('someVarName', null);
	}
	
	function setFocusToTextBox() {	
		clock();
		document.getElementById("to").focus();
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


	<!--Action boxes-->
	<div id="content">
	<div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Expenses</a></div>
    <h1>Expenses</h1>
  </div>
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Expenses Details</h5>
						</div>
						<div class="widget-content nopadding">
							<form  action="/MSaleERP/Expences.do" method="post"
								class="form-horizontal" name="form"
								onsubmit="return Submit()">
								
								<div class="control-group">
									<label class="control-label"><span style="color: red;"></span>To:</label>
									<div class="controls">
										<input type="text" class="span11" placeholder="To"
											name="to" id="to" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" required style="width: 300px;" /><span
											class="status" ></span>
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label"><span style="color: red;"></span>Amount:</label>
									<div class="controls">
										<input type="text" class="span11" placeholder="Amount"
											name="amount" onkeyup="this.value=this.value.toUpperCase()" pattern="[0-9]*" required style="width: 300px;" /><span
											class="status"pattern="[]*"></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><span style="color: red;"></span>Reason:</label>
									<div class="controls">
										<input type="text" class="span11" placeholder="Reason"
											name="reason" onkeyup="this.value=this.value.toUpperCase()" pattern="[a-z A-Z]*" required style="width: 300px;" /><span
											class="status"></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><span style="color: red;"></span>Date :</label>
									<div class="controls">
									 <% SysDate sd= new SysDate(); %> 
										<input type="date" class="span11" placeholder=""
											name="date" value=<%=sd.todayDate() %> style="width: 300px;" required /><span
											class="status"></span>
									</div>
								</div>
								
								
								<div class="form-actions" name="form"
									onsubmit="return Submit()">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="submit" class="btn btn-success" id="submitbtn"
										onclick="Submit()">Save</button>
									<button  type="button" id="cancelbtn" class="btn btn-danger" onclick="location.href='/MSaleERP/jsp/admin/homePage.jsp'">Exit</button>
								</div>
							</form>
						</div>
					</div>




					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"><i class="icon-th"></i></span>
							<h5>Expenses List</h5>
						</div>
						<div class="widget-content nopadding">
							<table class="table table-bordered data-table" id="TFtable">
								<thead>
                <tr>
                  <th>Sr.No.</th>
                  <th>Date</th>
                  <th>Amount</th>
                  <th>To</th>
                  <th>Reason</th>
                  <th>Action</th>
                </tr>               
              </thead>
								<%
								RequireData data=new RequireData();
								List details = data.getExpMaster();
								
								int exp_id= 0, count=1;
								String date="";
								String amount= "";
								String to="";
								String reason="";
								
								if (details != null) 
								{
									Iterator itr = details.iterator();
								%>
								<tbody>
									<%
									while (itr.hasNext()) 
									{
									String id = itr.next().toString();
										exp_id++;
									%>
									<tr class="gradeX">
									
										<td id="<%=id%>"><%=count%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td><%=itr.next()%></td>
										<td name="action">
											 <a href="#update" data-toggle='modal' onclick='getSr(<%=id%>)'>Update</a>
											/ <a onclick="getDeleteId(<%=id %>)" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a> 
										</td>
									</tr>
									<%
											count++;
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
	
	<div class="modal fade" id="update" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Expenses</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/UpdateExpencesMaster.do" method="post" name="form3">
					<div class="form-group">
						<div class="widget-content nopadding">
          
            
            <%
          RequireData rd = new RequireData();
            String id="0";
           
            if(request.getParameter("exp_id")!=null){
            	id= request.getParameter("exp_id");
            	session.setAttribute("sessionId", id);
            }
                        
            
            List list1 =rd.getRecord(id);
             
             if(list1!=null)
             {
                Iterator itr = list1.iterator();	 
            	 
                while(itr.hasNext())
                {
                	Object id1=itr.next();
                	date=itr.next().toString();
                    amount=itr.next().toString();
                	to=itr.next().toString();
                	reason=itr.next().toString();
                	 
                %>
            
              
              <div class="control-group">
              <label class="control-label">To : </label>
               
              	<div class="controls controls-row">
            		<input type="text" placeholder="To" class="span6 m-wrap" value="<%=to%>" onkeyup="this.value=this.value.toUpperCase()" name="to" id="to1"  style="width: 300px;"> 
          		</div>
            </div>
            
            <div class="control-group">
              <label class="control-label">Amount : </label>
              <div class="controls">
              
                <input type="text" class="span11" placeholder="Amount" value="<%=amount%>" name="amount" style="width: 300px;" required />
              </div>
            </div>
                        
             <div class="control-group">
              <label class="control-label">Reason : </label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Reason" value="<%=reason %>" onkeyup="this.value=this.value.toUpperCase()" name="reason" style="width: 300px;: "/>
              </div>
            </div>
           </div>
           
            <div class="control-group">
              <label class="control-label">Date : </label>
           		<div class="controls">
                <input type="date" class="span11" placeholder="Date" value="<%=date%>" name="date" id="date" required style="width: 300px;" />
              </div>
              	
              <% 
             }
           }
             %>
					<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" value="Update" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel"/></div>
					</div></div>
				</form>
			</div>
		</div>
	</div>
</div>
	
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
				<form action="/MSaleERP/DeleteExpences.do">
				<input type="hidden" id="deleteId" name="exp_id">
					<a href=""></a><input type="submit" class="btn btn-primary" id="ok" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>
	
	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
	
	<!--end-Footer-part-->
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
	<script src="/MSaleERP/config/js/jquery.validate.js"></script>
	<script src="/MSaleERP/config/js/matrix.form_validation.js"></script>
	<script src="/MSaleERP/config/js/jquery.wizard.js"></script>
	<script src="/MSaleERP/config/js/jquery.uniform.js"></script>
	<script src="/MSaleERP/config/js/select2.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.popover.js"></script>
	<script src="/MSaleERP/config/js/jquery.dataTables.min.js"></script>

<script> 	


	$('#update').on('shown.bs.modal', function () {
	    $('#to1').focus();
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
		
		function getDeleteId(id)
		{
			document.getElementById("deleteId").value=id;
		}

		// resets the menu selection upon entry to this page:
		function resetMenu() {
			document.gomenu.selector.selectedIndex = 2;
		}
		
		function myFunction() {
		    var x = document.getElementById("snackbar")
		    x.className = "show";
		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
		}
	</script>
</body>
</html>