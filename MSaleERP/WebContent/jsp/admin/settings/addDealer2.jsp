<%@ page errorPage="../error/errorPage.jsp" %>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> 
<%@ page import="java.util.*" %>
<%@page import="java.sql.ResultSet"%>
<%@ page import="dao.General.*" %>   
    
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

function myFunction() {
    var x = document.getElementById("snackbar")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}


			function searchInfo()
			{
				
				var request=new XMLHttpRequest();
			    var name=document.form1.Dname.value;  
					
					var url="/MSaleERP/purchase_search?categoryName="+name;  
  
					try{  
							request.onreadystatechange=function()
							{  
								if(request.readyState==4)
								{  
									var val=request.responseText;
									
									document.getElementById('mylocation').innerHTML=val;  
								}  
							}//end of function  
							request.open("GET",url,true);  
							request.send();  
					}
					catch(e)
					{
						alert("Unable to connect to server");
					}  
			} 
			
			function searchInfo2(name)
			{    
				
		
				var request=new XMLHttpRequest();
			    var name=document.form1.Dname.value;
				var url="/MSaleERP/purAdres?categoryName="+name;  

				try{ 
					request.onreadystatechange=function()
					{  
					
				
						if(request.readyState==4)
						{  
							
						
							var val=request.responseText;
							
							var obj=JSON.parse(val);
							
							var col = [];
					        for (var i = 0; i < obj.length; i++) {
					            for (var key in obj[i]) {
					                if (col.indexOf(key) == -1) {
					                    col.push(key);
					                }
					            }
					        }
					      
					       (document.getElementById("dname").value=obj[0].col[1]);
					         document.getElementById("intBrandId").value=obj[0].col[0];
					      
					        
						}  
					}
						request.open("GET",url,true);  
						request.send();  
				}
				catch(e)
				{
					alert("Unable to connect ");
				}  

			}
			function onInput() {
			    var val = document.getElementById('dname').value;
			    var opts = document.getElementById('list1').childNodes;
			    
			    for (var i = 0; i < opts.length; i++) {
			      if (opts[i].value === val) {
			        // An item was selected from the list!
			        // yourCallbackHere()
			        searchInfo2(opts[i].value);
			     
			        break;
			      }
			    }
			  }
			
			function getSr(id){
			    $('form2')
				var someVarName = id;
				localStorage.setItem("someVarName", someVarName);
				var f=document.getElementById("dealerTable");
			    f.action='/MSaleERP/jsp/admin/settings/addDealer.jsp?dealerRowId='+id;
			    f.method="post";
			    f.submit();  
			}
			

			function showModal(){
				var someVarName = localStorage.getItem("someVarName");
				/* alert(someVarName); */
				
				var error = document.getElementById("error").value;
				
				if(error==2)
				{
					$('#error-msg').modal('show');
				}
				else if(error==3)
				{
					$('#delete-error').modal('show');
				}
				else if(someVarName>0)
				{
					$('#update').modal('show');
				}
				localStorage.setItem('someVarName', null);
			}
			
			function setFocusToTextBox() {	
				clock();
				document.getElementById("organization_name").focus();
				document.getElementById("brandname").focus();
				showModal();
				myFunction();
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
<% if(request.getAttribute("status1")!=null){ %>
<div id="snackbar"><%=request.getAttribute("status1")%></div>
<%} %>
<body onload="setFocusToTextBox()">

<!--Header-part-->
<jsp:include page="../common/header_navbar.jsp"></jsp:include>

<!--sidebar-menu-->
<jsp:include page="../common/left_navbar.jsp"></jsp:include>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Add Dealer</a></div>
    <h1>Add New Dealer</h1>
  </div>
<!--End-breadcrumbs-->

<!--Action boxes-->
  <div class="container-fluid">
    
    <hr>
    <div class="row-fluid">
    <div class="">
    <div class="widget-box">
        <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
          <h5>Dealer Details </h5>
        </div>
        <div class="widget-content nopadding" >
          <form action="/MSaleERP/InsertDealer.do" method="post" class="form-horizontal" name="form1">
            
            
            <div class="control-group" style="height: 50px;">
           	 <table>
           	  <tr>
           	   <td>
              <label class="control-label"><span style="color: red;">*</span>Select Brand</label>
              <div class="controls" style="width: 500px;">
                <select class="aa" required="required" name="brand" id="brand" style="width: 300px; margin-right:15px;"  >
                	<option value="">Select</option>
              <%
              	  String count="";
	              String error = "";
					
	  			if(request.getAttribute("error")!=null){
	  				error = request.getAttribute("error").toString();
	  			}
            
                 RequireData rd =new  RequireData();
                 
                 List l = rd.getRowCount();
                 Iterator itr1 =l.iterator();
                 
               	 while(itr1.hasNext())
               	 {
               	 	count=itr1.next().toString();
               	 }
                 
                 List brandlist = rd.getBrandName();
                  
                 
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
                	   
                	   
            
                	 <%
                 }
                 else
                 {
                	 %>
                	   </select>
                	 <%
                	
                 }
              %>
              </td>
              <td>
           		 <a href="#add-brand" data-toggle="modal" style="margin-left: -170px;"><span class="badge badge-inverse"><i class="icon-plus"></i></span></a>
           		 </td>
           		 </tr>
           		</table>
                </div>
            
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Organization Name :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Organization Name" onkeyup="this.value=this.value.toUpperCase()" name="organization_name" id="organization_name" required style="width: 300px;" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Dealer Name :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Dealer Name" onkeyup="this.value=this.value.toUpperCase()" name="dealer_name"  required style="width: 300px;" />
              </div>
            </div>
             <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Contact No :</label>
               
              	<div class="controls controls-row">
            		<input type="text" placeholder="Contact No" class="span6 m-wrap" onkeypress="return isNumber(event)" maxlength="10"  name="contact_no" required  style="width: 300px;"> 
          		</div>
            </div>
            <div class="control-group">
              <label class="control-label">Email Id :</label>
              <div class="controls">
                <input type="email" class="span11" placeholder="Email Id" name="email_id" style="width: 300px;"  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">Balance Amount :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Balance Amount" onkeypress="return isNumber(event)" name="balanceAmount" style="width: 300px;" />
              </div>
            </div>
        
           	
            
	  			<input type="hidden" name="error" id="error" value="<%= error %>" /> 
	  			
 
           
              <div class="form-actions" style="margin-top:0px;" align="center">
                <button type="submit" id="submitbtn"  class="btn btn-success">Submit</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/MSaleERP/jsp/admin/homePage.jsp" id="cancelbtn"  class="btn btn-danger">Exit</a>
                <div id="status"></div>
              </div>
              <div id="submitted"></div>
          </form>
          
        </div>
      </div>
     </div>
    </div>
    
    <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
         <h5>Dealer List</h5>
            <span class="label label-important" name="dealerCount" id="dealerCount" style="height: 15px;"><p><%=count %></p></span>
          </div>
          <div class="widget-content nopadding">
           <form name="form2" id="dealerTable" method="post">
            <table class="table table-bordered data-table" id="TFtable">
              <thead>
                <tr>
                  <th>Sr. No.</th>
                  <th>Organization Name</th>
                  <th> Dealer Name </th>
                  <th> Contact No. </th>
				  <th> Email Id </th>
                  <th> Brand Name </th>
                  <th> Action </th>
                </tr>
              </thead>
              <tbody>
          
          <%
          //   RequireData rd = new RequireData();
          
             List list =rd.getDealerData();
             int i=1;
             
             if(list!=null)
             {
                Iterator itr = list.iterator();	 
            	 
                while(itr.hasNext())
                {
                	Object intdealerid=itr.next();
                	Object vardealername=itr.next();
                	Object varcontactno=itr.next();
                	Object varemailid=itr.next();
                	Object intbrandid=itr.next();
                	Object varorganizationname=itr.next();
                	
        %>            
               	<tr class="gradeX">
               	  <td> <%=i %></td>
                  <td id="<%=intdealerid%>"><%=varorganizationname%></td>
                  <td><%=vardealername%></td>
                  <td><%=varcontactno%></td>
                  <td><%=varemailid%></td>
                  <td><%=intbrandid%></td>
                  <td> <a href="#update" data-toggle="modal"  onclick="getSr(<%=intdealerid%>)">Update</a> / <a onclick="getDeleteId('<%=intdealerid %>', '<%=intbrandid %>')" href="#DeleteConfirmBox" data-toggle='modal'>Delete</a>
                  </td>
                </tr>
                	<%
                	i++;
                }
                %>
                
                </tbody>
            </table></form>
                
                <% 
             }
             
          %>
         
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


<div class="modal hide fade" id="update" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Update Dealer Details</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/UpdateDealer.do" method="post" name="updateDealer">
					<div class="form-group">
						<div class="widget-content nopadding">
          
            
            <%
            String rowId="0";
            String brandName ="";
            String vardealername ="";
            
            if(request.getParameter("dealerRowId")!=null){
            	rowId = request.getParameter("dealerRowId");
            	session.setAttribute("sessionId", rowId);
            	
            }
                        
            
            List list1 =rd.getDealerRowData(rowId);
             
             if(list1!=null)
             {
                Iterator itr = list1.iterator();	 
            	 
                while(itr.hasNext())
                {
                	Object intdealerid=itr.next();
                	vardealername=itr.next().toString();
                	Object varcontactno=itr.next();
                	Object varemailid=itr.next();
                	Object intbrandid=itr.next();
                	Object varorganizationname=itr.next();
                	 
                %>
            
            
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Organization Name :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Organization Name" value="<%=varorganizationname%>" onkeyup="this.value=this.value.toUpperCase();" name="update_organization_name" id="update_organization_name" required style="width: 300px;" />
              </div>
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Dealer Name :</label>
              <div class="controls">
              
                <input type="text" class="span11" placeholder="Dealer Name" value="<%=vardealername%>" name="update_dealer_name" style="width: 300px;" required />
              </div>
            </div>
             <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Contact No :</label>
               
              	<div class="controls controls-row">
            		<input type="text" placeholder="Contact No" class="span6 m-wrap" value="<%=varcontactno%>" name="update_contact_no"  style="width: 300px;"> 
          		</div>
            </div>
            <div class="control-group">
              <label class="control-label">Email Id :</label>
              <div class="controls">
                <input type="text" class="span11" placeholder="Email Id" value="<%=varemailid %>" name="update_email_id" style="width: 300px;: "/>
              </div>
            </div>
            
            <% brandName =intbrandid.toString(); %>
            
            <div class="control-group">
              <label class="control-label"><span style="color: red;">*</span>Select Brand</label>
              <div class="controls" style="width: 334px;">
                <select name="update_brand" id="update_brand" style="width: 315px;" required>
                	
                	
              <% 
             }
           }
             %>
             <%
                
                 List brandlist1 = rd.getBrandList(vardealername);
                  
                 
                 if(brandlist!= null)
                 {
                	 String selectedBrandId="", name="";
                     Iterator itr =brandlist1.iterator();
                	 while(itr.hasNext())
                	 {
                		 String id= itr.next().toString();
                		 name = itr.next().toString();
                		 if(brandName.equals(id)){
                			 selectedBrandId = id;
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
                	 <input type="hidden" name="selectedBrandId" value="<%=selectedBrandId %>" />
                	   </select>
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
           	
          </div>
            
					</div>
					
					<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" value="Update" />
					<input type="button" id="cancelbtn" class="btn btn-danger" data-dismiss="modal" value="Cancel"/></div>
					</div>
					</div>
				</form>
			</div>
				
			</div>
		</div>
	</div>








<!-- add new dealer -->


<div class="modal hide fade" id="add-brand" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Add New Brand</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="/MSaleERP/AddBrand.do" method="post" name="form3">
					<div class="form-group">
						<div class="widget-content nopadding">
          					<div class="control-group">
				              <label class="control-label">Brand Name :</label>
				              <div class="controls">
				                <input type="text" class="span11" placeholder="Brand Name" id="brandname" onkeyup="this.value=this.value.toUpperCase();"  name="brandname" style="width: 300px;" required />
				                <input type="hidden" name="dealerpage" value="dealerpage">
				              </div>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="submit" id="submitbtn" class="btn btn-primary" value="Submit" onSubmit="" />
					<input type="button" id="cancelbtn" class="btn btn-primary" data-dismiss="modal" value="Cancel"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>






<div class="modal hide fade" id="error-msg" role="dialog">
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
          					
				              <h4>Brand already Exist... </h4>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="button" id="submitbtn" class="btn btn-primary" data-dismiss="modal" value="OK"/></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<div class="modal hide fade" id="delete-error" role="dialog">
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
          					
				              <h4> Cannot delete the Selected record as it is linked with some other records..!!  </h4>
				            </div>
					</div>
					<div class="modal-footer">
					<input type="button" id="submitbtn" class="btn btn-primary" data-dismiss="modal" value="OK"/></div>
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
				<form action="/MSaleERP/DeleteDealer.do">
				<input type="hidden" id="deleteId" name="dealerid">
				<input type="hidden" id="brandId" name="deletebrandname">
					<a href=""></a><input type="submit" class="btn btn-primary" id="okButton" value="OK" name="ok" />
					<input type="button" class="btn btn-danger" data-dismiss="modal" on value="Cancel"/>
				</form>
			</div>
		</div>	
	</div>
</div>

<!-- end -->	
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

	
	function setModalFocus() {
		document.form3.brandname.focus();
	}
	
	$('#add-brand').on('shown.bs.modal', function () {
	    $('#brandname').focus();
	}) 	
	$('#update').on('shown.bs.modal', function () {
	    $('#update_organization_name').focus();   
	}) 	
	$('#DeleteConfirmBox').on('shown.bs.modal', function () {
	    $('#okButton').focus();   
	}) 
	
	function getDeleteId(deleteid, brandid)
	{	
		document.getElementById("deleteId").value=deleteid;
		document.getElementById("brandId").value=brandid;
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

</html>