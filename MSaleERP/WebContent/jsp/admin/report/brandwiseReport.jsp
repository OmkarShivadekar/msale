<%@page import="dao.General.GenericDAO"%>
<%@page import="utility.SysDate"%>
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

function getbrandwiseReport(){
	
	alert("abc");
		var request=new XMLHttpRequest();
		var brandname = document.getElementById("brandname").value;
		var start_date = document.getElementById("start_date").value;
		var end_date = document.getElementById("end_date").value;
		var url="/MSaleERP/BrandwiseReport.do?brandname="+brandname"&start_date="+start_date"&end_date="+end_date;  
		alert(url);
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

	function setFocusToTextBox() {	
		clock();
		document.getElementById("brandname").focus();
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
	<!--End-breadcrumbs-->

	<!--Action boxes-->
	<div id="content">
	
	<div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Brandwise Report</a></div>
  </div>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title">
							<span class="icon"> <i class="icon-align-justify"></i>
							</span>
							<h5>Brandwise Report</h5>
						</div>
						<div class="widget-content nopadding">
							<div class="form-horizontal">
								<div class="control-group">
									<label class="control-label"><span style="color: red; margin-left: 30px;">*</span>Select Brand :</label>
									<div class="controls">
									
					                <select name="brandname" id="brandname" style="width: 250px; margin-left: 33px;">
					              <%
					              	 String  brandid="", brandname="";
					              
					                 RequireData rd =new  RequireData();
					                 
					                 List brandnamelist = rd.getBrandIcon();
					                  
					                 
					                 if(brandnamelist!= null)
					                 {
					                     Iterator itr =brandnamelist.iterator();
					                	 while(itr.hasNext())
					                	 {
					                		 brandid= itr.next().toString();
					                		 brandname = itr.next().toString();
					                		 %>
					                		    <option value="<%=brandid %>" > <%=brandname %> </option>
					                		 <%
					                	 }
					                	 %>
					                	   </select>
					                	 <%
					                 }
					                 %>
										
									</div>
								</div>

  						<% SysDate sd= new SysDate();
                  		   String date =	sd.todayDate();
              			%>
              				<div class="control-group">
								<table>
					   				<tr>
								    	<td><label class="control-label" style="margin-left: -33px;"><span style="color: red;">*</span>To :</label></td>			    	
								    	<td> <div class="controls"><input type="date" class="span2" name="start_date" id="start_date" value="<%=date %>" style="width: 250px; margin-left: -150px;"/></div></td>
								    	<td><label class="control-label" style="margin-left: -120px;">From :</label>
					
					  					</td>
								    	<td> <div class="controls"><input type="date"  name="end_date" id ="end_date" style="width: 250px; margin-left: -180px;"></div></td>			    	
								    	
					  				</tr>
					  			</table>
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
									
									<button type="submit" id="submitbtn" class="btn btn-success" onclick="getbrandwiseReport()">Generate</button>&nbsp;&nbsp;&nbsp;
									<a href="/MSaleERP/jsp/admin/homePage.jsp" class="btn btn-danger" id="cancelbtn">Exit</a>
								</div>
							</div>
						</div>
					</div>

			        <div class="widget-box">
			          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
			            <h5>Report</h5>
			            <span class="label label-info">PRINT</span> </div>
			          <div class="widget-content nopadding">
			            <table class="table table-bordered table-striped">
			              <thead>
			                <tr>
			                  <th>No</th>
			                  <th>Date</th>
			                  <th>Customer Name</th>
			                  <th>Mobile No</th>
			                  <th>Model Name</th>
			                  <th>Price</th>
			                  <th>IMEI No</th>
			                </tr>
			              </thead>
			              <tbody   id="tb">
			              <%
			              	//	rd.getBrandwiseReport(brandid, start_date, end_date);
			              		
			              
			              
			              
			              
			              %>
			              
			              
			                <tr>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                  <td></td>
			                </tr>
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
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>
	<script src="/MSaleERP/config/js/jquery.min.js"></script>
	<script src="/MSaleERP/config/js/matrix.tables.js"></script>
	<!--end-Footer-part-->
		
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
	$('.textarea_editor').wysihtml5();
</script>
</body>
</html>