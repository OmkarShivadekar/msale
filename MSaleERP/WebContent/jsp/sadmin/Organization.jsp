<%@page import="utility.RequireData"%>
<%@page import="utility.SysDate"%>
<%@page import="java.util.Date"%>
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
<link href="config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<style type="text/css">
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
</head>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	if(session.getAttribute("sAdmin")==null)
	{
		response.sendRedirect("/MSaleERP");

	}
%>

<body onload="loadWork()">

<!--Header-part-->
<jsp:include page="../admin/common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<div id="sidebar"><a href="/MSaleERP/jsp/sadmin/Organization.jsp" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>

    <ul>
    <li><a href="/MSaleERP/jsp/sadmin/Organization.jsp"><i class="fa fa-home"></i> <span>Dashboard</span></a> </li>
  	</ul>
</div>
<!--sidebar-menu-->
<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
<% if(request.getAttribute("status")!=null){ %>
		<div id="snackbar"><%=request.getAttribute("status")%></div>
	<%} %>
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/sadmin/Organization.jsp" title="Go to Home" class="tip-bottom"><i class="fa fa-home"></i> Home</a></div>
    <h1>Register New Organization</h1>
  </div>
<!--End-breadcrumbs-->

<!--Action boxes-->
  <div class="container-fluid">
    
    <hr>
    <div class="row-fluid">
    <div class="span12">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Organization Details </h5>
			<label style="position:relative;left:10px;top:8px;color:#8c8686"">( <span style="color: red" title="Mendatory Field">*</span> marked fields are mendatory)</label>
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/InsertOrg.do" method="POST" class="form-horizontal">
           <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Registration Date :</label>
              <div class="controls">
              <%SysDate sd=new SysDate(); %>
                <input type="date" class="span4" value="<%=sd.todayDate() %>" name="regDate" style="position:relative; left:10px;" readonly="readonly" required  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Organisation Name :</span></label>
              <div class="controls">
                <input type="text" tabindex="1" class="span4" placeholder="Shop name" id="shopName" name="orgname" onkeyup="this.value=this.value.toUpperCase();" required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Owner's Name :</label>
              <div class="controls">
                <input type="text" tabindex="2" class="span4" placeholder="Owner's name" name="ownername" onkeyup="this.value=this.value.toUpperCase();" required style="position:relative; left:10px;"  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Shop Address :</label>
              <div class="controls">
                <input type="text" tabindex="4" class="span4" placeholder="Shop Address" name="orgaddress" onkeyup="this.value=this.value.toUpperCase();" required style="position:relative; left:10px;" />
              </div>
            </div>
             <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Contact No :</label>
               
              	<div class="controls controls-row">
            		<input type="text" tabindex="5" placeholder="Primary Number" onkeypress="return isNumber(event)" class="span4"  name="cno1" required style="position:relative; left:10px;"> 
            		
          		</div>
          		<div class="controls controls-row">
            		<input type="text" tabindex="6" placeholder="Secondary Number(Optional)" onkeypress="return isNumber(event)" class="span4 offset1" name="cno2" style="position:relative; left:7px;" /> 
          		</div>
            </div>
            <div class="control-group">
              <label class="control-label offset1">Email : </label>
              <div class="controls">
                <input type="email" autocomplete="off"  tabindex="7"  class="span4" placeholder="Owner Email ID" name="email" id="email" onkeyup="this.value=this.value.toUpperCase();" style="position:relative; left:10px;" />
              </div>
            </div>
             <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>User Name : </label>
              <div class="controls">
                <input type="text" autocomplete="off"  tabindex="8"  class="span4" placeholder="User Name" name="UName" id="" required  style="position:relative; left:10px;" />
              </div>
              </div>
              <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Password : </label>
              <div class="controls">
                <input type="password" autocomplete="off"  tabindex="9"  class="span4" placeholder="Password" name="UPass" id="uPass" required style="position:relative; left:10px;" />
              <br><div style="position: relative;padding:5px; left:250px;"><input style="position: relative;bottom:3px;" id="chckBox" type="checkbox" onchange="showPass()"/>&nbsp;&nbsp;Show Password</div>
              </div>
              </div>
            <center>
            <div class="form-actions" >
              <button type="submit"  tabindex="10" name="insert" class="btn btn-success">Save</button>
              <a href="/MSaleERP/"><button type="button" tabindex="11" class="btn btn-danger pull-center">Cancel</button></a>
            </div>
           </center>
          </form>
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

<script type="text/javascript">
function loadWork()
{
	clock();
	showsnack();
	if(document.getElementById("shopName")!=null)
		document.getElementById("shopName").focus();
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
function showPass()
{
		if(document.getElementById("chckBox").checked){
			document.getElementById("uPass").type="text";}
		else
			document.getElementById("uPass").type="password";
}
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