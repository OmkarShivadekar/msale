<%@ page isErrorPage="true" %> 
<%@page import="dao.General.GenericDAO"%>
<%@page import="java.util.ArrayList"%>
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
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>



<body onload="clock()">

<jsp:include page="../common/header_navbar.jsp"></jsp:include>
<!--close-top-serch-->
<!--sidebar-menu-->

<!--sidebar-menu-->

<!--main-container-part-->

<div id="content" style="margin-left: 0px">
	
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
            <h5>Error 500</h5>
          </div>
          <div class="widget-content">
            <div class="error_ex">
              <h1>500</h1>
              <h3>Something is wrong here. Method not allowed!</h3>
              <p>Access to this page is forbidden</p>
              <a class="btn btn-warning btn-big"  href="/MSaleERP/jsp/admin/homePage.jsp">Back to Home</a> </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!--Footer-part-->

<div class="row-fluid">
<div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>



<!--end-Footer-part-->

<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/matrix.js"></script>
</html>