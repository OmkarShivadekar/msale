<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
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

<style>
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
	if(session.getAttribute("username")==null)
	{
		response.sendRedirect("/MSaleERP");

	}
%>

<body onload="loadWork()">

<!--Header-part-->
<jsp:include page="../common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->
<% if(request.getAttribute("status1")!=null){ %>
	<div id="snackbar"><%=request.getAttribute("status1")%></div>
	<%} %>
<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a></div>
    <h1>Update Your Organization Invoice</h1>
  </div>
<!--End-breadcrumbs-->

<!--Action boxes-->
   <div class="container-fluid">
    
    <hr>
    <%
              	RequireData rd=new RequireData();
              	List demoList=rd.getOrgInvoiceDetails();
              	if(!demoList.isEmpty()){
              		if(!(demoList.get(1)!=null)){}
              	Iterator itr=demoList.iterator();
              	while(itr.hasNext())
              	{
              		Object orgname=itr.next();
              		Object tag=itr.next();
              		Object orgAddress=itr.next();
              		Object tal=itr.next();
              		Object dist=itr.next();
              		Object phoneNo=itr.next();
              		Object pan=itr.next();
              		Object gstin=itr.next();
              		Object place=itr.next();
              		Object scode=itr.next();
              		             	
              		
              %>
    <div class="row-fluid">
    <div class="span12">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Invoice Details </h5>
			<label style="position:relative;left:10px;top:8px;color:#8c8686"">( <span style="color: red" title="Mendatory Field">*</span> marked fields are mendatory)</label>
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/UpdateInvoice.do" method="POST" class="form-horizontal">
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Invoice Header :</span></label>
              <div class="controls">
                <input type="text" tabindex="1" class="span4" placeholder="Shop name" id="shopName" name="orgname" value="<%=orgname %>"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Tag Line :</label>
              <div class="controls">
                <input type="text" tabindex="2" class="span4" placeholder="Owner's name" name="tag" value="<%=tag %>"  required style="position:relative; left:10px;"  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Address In Short  :</label>
              <div class="controls">
                <input type="text" tabindex="3" class="span4" placeholder="Address In Short" name="orgaddress" value="<%=orgAddress %>"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Tal  :</label>
              <div class="controls">
                <input type="text" tabindex="4" class="span4" placeholder="Tal" name="tal" value="<%=tal %>"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Dist  :</label>
              <div class="controls">
                <input type="text" tabindex="5" class="span4" placeholder="Dist" name="dist" value="<%=dist %>"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Phone No :</label>
              <div class="controls">
                <input type="text" tabindex="6" class="span4" placeholder="Phone No" name="phoneNo" value="<%=phoneNo %>" maxlength="10" onkeypress="return isNumber(event)"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>PAN  :</label>
              <div class="controls">
                <input type="text" tabindex="7" class="span4" placeholder="PAN" name="pan" value="<%=pan %>"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>GSTIN NO :</span></label>
              <div class="controls">
                <input type="text" tabindex="8" class="span4" placeholder="GSTIN NO" id="" name="gstin" value="<%=gstin %>" required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>Place Of Supply  :</label>
              <div class="controls">
                <input type="text" tabindex="9" class="span4" placeholder="Place Of Supply" name="place" value="<%=place %>"  required style="position:relative; left:10px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label offset1"><sup style="color: red" title="Mendatory Field">*</sup>State Code :</label>
              <div class="controls">
                <input type="text" tabindex="10" class="span4" placeholder="State Code" name="scode" value="<%=scode %>"  required style="position:relative; left:10px;" />
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
    <%} }%>
    
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
	if(document.getElementById("ownerName")!=null)
	document.getElementById("ownerName").focus();
	}
  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
	  
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