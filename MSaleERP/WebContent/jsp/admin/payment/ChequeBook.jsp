<%@page import="java.util.Date"%>
<%@ page errorPage="./error/errorPage.jsp" %> 
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
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
<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico" type="image/x-icon">
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
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
.table td {
   text-align: center;   
}

#chequebook-table{
		width:100%; 
		border-collapse:collapse; 
	}
	#chequebook-table td{ 
		padding:7px; border:#dfe1e2 1px solid;
	}
	/* provide some minimal visual accomodation for IE8 and below */
	#chequebook-table tr{
		background: #f9f9f9;
	}
	/*  Define the background color for all the ODD background rows  */
	#chequebook-table tr:nth-child(odd){ 
		background: #f9f9f9;
	}
	/*  Define the background color for all the EVEN background rows  */
	#chequebook-table tr:nth-child(even){
		background: #efefef;
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

<body onload="setFocusToTextBox()" >


             	   
<script type="text/javascript">

window.counter = 0;

  
function searchInfo2()
{  		
		
		
		var request=new XMLHttpRequest();
		var name = document.getElementById("organization").value;
		var url="/MSaleERP/getDealerName.do?dealerid="+name;  

		try{  
				request.onreadystatechange=function()
				{  
					if(request.readyState==4)
					{  
						var val=request.responseText;  
						document.getElementById('dealername').innerHTML="<input type='text' id='organizationName' style='width: 285px;'; value='"+val+"' disabled='disabled' /> ";  
					}  
				}
				request.open("GET",url,true);  
				request.send();  
		}
		catch(e)
		{
			alert("Unable to connect to server");
		}  
		document.getElementById("lastnum").disabled=false;
		document.getElementById("startnum").disabled=false;
		document.getElementById("startnum").focus();
		
} 



history.pushState(null, null, document.URL);
window.addEventListener('popstate', function () {
    history.pushState(null, null, document.URL);
});

window.oncontextmenu = function () {
	   return false;
	}

  document.onkeydown = function(){
	  switch (event.keyCode){
	        case 116 : //F5 button
	            event.returnValue = false;
	            event.keyCode = 0;
	            return false;
	        case 82 : //R button
	            if (event.ctrlKey){ 
	                event.returnValue = false;
	                event.keyCode = 0;
	                return false;
	            }
	    }
	}
  
 


</script>
<!--Header-part-->

<jsp:include page="../common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->



<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Chequebook</a> </div>
    <h1>Cheque Book</h1>
  </div>
  <div class="container-fluid">
    <hr>
    
    <div class="row-fluid">
    <div class="">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5> Details </h5>
        </div>
        <div class="widget-content nopadding" >
          <form name="chequebook"  method="get" class="form-horizontal">
            
            <div class="control-group" style=" height: 100px;">
              <label class="control-label"><span style="color: red;">*</span>Select Dealer</label>
              <div class="controls" style="width: 800px;">
              
                <select name="organization" id="organization" class="organization" onchange="searchInfo2()" style="width: 300px; margin-right:15px;">	   
                	<option selected="selected">Select</option>
              <%
              	 String count="", dealerid="", orgname="";
              	 String error=request.getParameter("error");
              	 
              
                 RequireData rd =new  RequireData();
                 
                 List organizationlist = rd.getOrganizationName();
                  
                 
                 if(organizationlist!= null)
                 {
                     Iterator itr =organizationlist.iterator();
                	 while(itr.hasNext())
                	 {
                		 dealerid= itr.next().toString();
                		 orgname = itr.next().toString();
               		 
                		 %>
                		    <option value="<%=dealerid %>" > <%=orgname %> </option>
                		 <%
                	 }
                	 %>
                	 
                	   </select>
                	   <span id="dealername" style=" width:300px; position: relative; float: right; right: 100px; font-size: 15px;" >
                	   </span>
                	   </div>
              
                	 <%
                 }
                 else
                 {
                	 %>
                	   </select>
                	 <%
                	
                 }
                 
              %>
            
             
             
              <label class="control-label"><span style="color: red;">*</span>Cheque Number :</label>
              	<div class="controls controls-row" style="height: 30px;">
            		<input type="text" placeholder="First Cheque Number" disabled="disabled" pattern="[0-9]*" maxlength="6" class="span6 m-wrap" id="startnum" name="startnum" onkeypress="document.chequebook.lastnum.value = this.value" style=" width: 300px; " required > 
            		<label style="margin-left: 340px;">To</label>
            		<input type="text" placeholder="Last Cheque Number" disabled="disabled" maxlength="6" class="span6 m-wrap" id="lastnum" name="lastnum" style="width: 300px; position: relative; float: right; bottom: 25px; right: 242px;" required >
          			
          		
          		</div>
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
               
               
               <button type="button" id="submitbtn" style=" float:right; position:relative; right: 500px;" class="btn btn-success" onclick="checkCondition()">Assign cheques</button>
               <!-- 
	              <button type="submit" class="btn btn-success">Save</button>
	              <button type="submit" class="btn btn-danger">Cancel</button>
	           -->
              
            </div>
           
          </form>
        </div>
      </div>
     </div>
    </div>
    
    <input type="hidden" name="error" id="error" value="<%= error %>" /> 
    
     <div class="row-fluid">
      <div class="span12">
        
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>New ChequeBook Details</h5>
          </div>
          <form name="cheque-book-details" action="/MSaleERP/ChequeBook.do" method="post">
          
       		
 			<%
				String pay_id=request.getParameter("pay_id");
				System.out.println("Pay ID " + pay_id);
				if(pay_id==null){
					pay_id="0";
				}
			%>
			
 	 		<input type="hidden" id="pay_id" name="pay_id" value="<%=pay_id %>" />
       		
          <div class="widget-content nopadding">
            <table id="chequebook-table"  style="text-align: center;" class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th> Chequebook Id</th>
                  <th>Cheque No.</th>
                  <th>Organization Name</th>
                </tr>
              </thead>
              <tbody>
              	<tr class="gradeX">
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              </tbody>
            </table>
             
         
          <div class="form-actions" style=" margin-bottom: 0;" >
          <input type="hidden" name="counter" id="counter" />
          <button type="submit" id="submitbtn" class="btn btn-success" style=" position: relative; float: right;" >Submit</button>
          </div>
           </div>
        </form>
        
        </div>
        
        </div>
    </div>
    
    
    <div class="row-fluid">
      <div class="span12">
        
       <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
         <h5>Old ChequeBook Details</h5>
            
          </div>
          <div class="widget-content nopadding">
           <form name="form2" id="dealerTable" method="post">
            <table id="TFtable" class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>Sr. No.</th>
                  <th>Cheque No.</th>
                  <th>Organization Name</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
       			  <%
          //   RequireData rd = new RequireData();
          
             List list =rd.getchequebookData();
             
             if(list!=null)
             {
            	 int srno = 0;
                Iterator itr = list.iterator();	 
            	 
                while(itr.hasNext())
                {
                	srno++;
                	Object chequebookid = itr.next();
                	Object chequeno = itr.next();
                	Object dealerid1 = itr.next();
                	
                	String orgname1 = rd.getorglist(dealerid1);
                	
                	
        %>            
               	<tr class="gradeX">
                  <td id="<%=chequebookid%>"><%=srno%></td>
                  <td><%=chequeno%></td>
                  <td><%=orgname1%></td>
                   <td> <a onclick="getDeleteId(<%=chequebookid %>)" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a> </td>
                </tr>
                	<%
 
                }
             }
             
          %>
              </tbody>
            </table>
           </form>
       
    
      </div>
    </div>
  </div>
</div>
<!--end-main-container-part-->


<div class="modal fade" id="error-msg" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 style="color: red;" class="modal-title">Error</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/AddBrand.do" method="post" name="form3">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <h4>Given cheque Number(s) already Exist...<br> Please check carefully.. </h4>
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
				<form action="/MSaleERP/ChequeBook.do">
				<input type="hidden" id="deleteId" name="deletechequeid">
					<a href=""></a><input type="submit" class="btn btn-primary" id="ok" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>

<!--Footer-part-->
</div></div>
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Vertical Software.  <a href="http://verticalsoftware.co.in">www.verticalsoftware.in</a> </div>
</div>

<script type="text/javascript">

function setFocusToTextBox() {	
	clock();
	document.getElementById("startnum").focus();
	showModal();
}

function getDeleteId(id)
{
	document.getElementById("deleteId").value=id;
}

function showModal(){
	var someVarName = document.getElementById("error").value;
	if(someVarName>0)
		{
			$('#error-msg').modal('show');
		}
	localStorage.setItem('someVarName', null);
}


function checkCondition(){
	if(document.getElementById("startnum").value=="")
		return false;
	addRows()
}


function addRows() {
	
	var e = document.getElementById("organization");
	var value = e.options[e.selectedIndex].value;
	var text = e.options[e.selectedIndex].text;
	
	
	var orgname = document.getElementById("organizationName").value;
	var num1 = document.getElementById("startnum").value;
	var num2 = document.getElementById("lastnum").value;
	var num3 = +num2 - +num1;	
	
	var table = document.getElementById("chequebook-table");
	
	for(var i=0; i<=num3; i++)
	{
		counter++;
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		
		
		var s = "000000" + num1;
	    
		cell1.innerHTML = "<td>" +  (rowCount-1) +"</td>";
		cell2.innerHTML = "<td>"+ s.substr(s.length-6) + "<input type='hidden' name='chequeno"+(rowCount-1)+"' value='"+s.substr(s.length-6)+"' /></td>";
		cell3.innerHTML = "<td>"+(text)+ "<input type='hidden' name='orgname"+(rowCount-1)+"' value='"+(value)+"' /></td>";
		
		num1++;
	
	}
	
	document.getElementById("counter").value = counter;
	
}

</script>


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
</body>
</html>
