<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/config/css/jquery.gritter.css" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>
<link rel="shortcut icon" href="/MSaleERP/config/img/icons/favicon.ico"
	type="image/x-icon">
<link rel="icon" href="/MSaleERP/config/img/icons/favicon.ico"
	type="image/x-icon">


<link rel="stylesheet" href="/MSaleERP/config/css/uniform.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/select2.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/datepicker.css" />




<style type="text/css">
#payBtn:focus {
	background-color: green;
}

#payBtn:hover {
	background-color: green;
}

#editbtn:hover {
	background-color: green;
}

.error {
	color: red;
	font-family: verdana, Helvetica;
}

img {
	width: 20px;
	height: 20px;
}
</style>


<script type="text/javascript">
	
function myFunctionUpdate(str) {

	var lastChar = str.substr(str.length -1);

	var b = document.getElementById("update_item_price"+lastChar).value;
	var getgst=document.getElementById("update_gst"+lastChar).value;
	
	var x;
	
	
	if (b != "") {
		x=b;
	}
	console.log('x', x);
	x = parseInt(x);           

	var intgst=parseInt(getgst);
	
	var g=100+intgst;
	var total_gst_amt = (x * intgst) / g;
	var totaltaxable_amt = x - total_gst_amt;

	totaltaxable_amt = Math.round(totaltaxable_amt * 100)/100;
	
	 var newgst=intgst/2;
	
	var cgst=total_gst_amt/2
	cgst = Math.round(cgst * 100)/100;
	
	var sgst = cgst;
	sgst = Math.round(sgst * 100)/100; 
	
	var totalvalue = totaltaxable_amt + cgst + sgst;
	var temp_totalvalue = totalvalue;
	totalvalue = Math.round(totalvalue);
	
	document.getElementById("update_cgst"+lastChar).value=newgst;
	document.getElementById("update_sgst"+lastChar).value=newgst;
	document.getElementById("update_cgstamount"+lastChar).value=cgst;
	document.getElementById("update_sgstamount"+lastChar).value=sgst;
	document.getElementById("update_txtval"+lastChar).value=totaltaxable_amt;
}



	function myFunction(str) {

		var lastChar = str.substr(str.length -1);
		
		var b = document.getElementById("item_price"+lastChar).value;
		var getgst=document.getElementById("gst"+lastChar).value;
		
		var x;
		
		
		if (b != "") {
			x=b;
		}
		console.log('x', x);
		x = parseInt(x);           //10000

		var intgst=parseInt(getgst); //18
		
		var g=100+intgst;
		var total_gst_amt = (x * intgst) / g; //1525.42
		var totaltaxable_amt = x - total_gst_amt;

		// 	    var totaltaxable_amt = temp_mrp;round
		totaltaxable_amt = Math.round(totaltaxable_amt * 100)/100;
		
		//var totgst = totaltaxable_amt * intgst/100;
		
		 var newgst=intgst/2; //9
		
		var cgst=total_gst_amt/2
		cgst = Math.round(cgst * 100)/100;
		//(Math.round(cgst)).toFixed(2);

		var sgst = cgst;
		sgst = Math.round(sgst * 100)/100; 
		//(Math.round(sgst)).toFixed(2);

		var totalvalue = totaltaxable_amt + cgst + sgst;
		var temp_totalvalue = totalvalue;
		totalvalue = Math.round(totalvalue);
		
		document.getElementById("cgst"+lastChar).value=newgst;
		document.getElementById("sgst"+lastChar).value=newgst;
		document.getElementById("cgstamount"+lastChar).value=cgst;
		document.getElementById("sgstamount"+lastChar).value=sgst;
		document.getElementById("txtval"+lastChar).value=totaltaxable_amt;

		totalbill();
	}
	
	function totalbill() {
		var totbox=document.getElementById("totbox").value;
		var pricegst=0;
		var pricecgst=0;
		var pricesgst=0;
		var pricetxt=0;
		for (var i = 1; i <= totbox; i++) {
			pricegst=pricegst+ +document.getElementById("item_price"+i).value;
			pricecgst=pricecgst+ +document.getElementById("cgstamount"+i).value;
			pricesgst=pricesgst+ +document.getElementById("sgstamount"+i).value;
			pricetxt=pricetxt+ +document.getElementById("txtval"+i).value;
		}
		
		document.getElementById("pricegst").innerHTML = pricegst;
		document.getElementById("pricecgst").innerHTML = Math.round(pricecgst * 100)/100;
		document.getElementById("pricesgst").innerHTML = Math.round(pricesgst * 100)/100;
		document.getElementById("pricetxt").innerHTML = Math.round(pricetxt * 100)/100;
		
		document.getElementById("totalamt").innerHTML = pricegst;
		document.getElementById("cgst").innerHTML = Math.round(pricecgst * 100)/100;
		document.getElementById("sgst").innerHTML = Math.round(pricesgst * 100)/100;
		document.getElementById("taxable").innerHTML = Math.round(pricetxt * 100)/100;
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

<!-- button enable and disable -->
<script type="text/javascript">
	

//********************************************Edit*******************************************
	function editPrint(str) {
		
 		var xhttp;
		if (str == "") {
			return;
		}
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				//document.getElementById("imeino").innerHTML = this.responseText;
				var demoStr = this.responseText.split(",");
				var text = "";
				var i = 0
				for (;demoStr[i];) 
				{
					text += "<option id="+demoStr[i];
					i++;
					text += " value="+demoStr[i]+">"
					i++;
					text +=demoStr[i]+ "</option>";
					i++;
				}	
				document.getElementById("browsers").innerHTML = text;
			}

		};
		
		xhttp.open("GET", "/MSaleERP/PrintInvoice?aq=" + str, true);
		xhttp.send();

	}
	function editPrintGetData(){
		var val = document.getElementById('editdata').value;
	      var str = $('#browsers').find('option[value="' + val + '"]').attr('id');
	      //alert(str);
	      var xhttp;
			if (str == "") {
				return;
			}
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText.split("~");
					var saletype=demoStr[0];
					
					if(saletype=="1"){
						alert("This is Mobile Invoice");
						
					}else{
						document.getElementById("editdatasaveAccessories").reset();
						
						var tableHeaderRowCount = 0;
						var table = document.getElementById("edit_accessoriesbox");
						var rowCount = table.rows.length;
						for (var i = tableHeaderRowCount; i < rowCount; i++) {
						    table.deleteRow(tableHeaderRowCount);
						}
						document.getElementById("totboxAccessories").value="0";
						
					    var y = document.getElementById('editdatasaveAccessories');
					    if (y.style.display === 'none') {
					        y.style.display = 'block';
					    }
						document.getElementById("sale_type2").value =saletype;
						document.getElementById("edit_invoiceAccessories").value = demoStr[1];
						document.getElementById("edit_nameAccessories").value = demoStr[2];
						document.getElementById("edit_addressAccessories").value = demoStr[3];
						document.getElementById("edit_contactnoAccessories").value = demoStr[4];
						document.getElementById("edit_saledateAccessories").value = demoStr[5];
						var gstin=demoStr[6];
						if(gstin!="null"){document.getElementById("edit_gstinAccessories").value = gstin;}
						//+++++++++++++++++++++=
						var text = "";
						var i = 7;
						var j=1;
						for (;demoStr[i];) 
						{
							var c1="<input type='text' name='item"+j+"' value='"+demoStr[i]+"' maxlength='25'>";
							 i++;
							var c2="<input type='text' name='item_detail"+j+"' value='"+demoStr[i]+"' maxlength='40'>";
							 i++;
							 var c3="<input type='text' name='item_price"+j+"' id='update_item_price"+j+"' onkeyup='myFunctionUpdate(this.id)' style='width: 40px;' value='"+demoStr[i]+"'>";
						    i++;
						    c3+="<input type='hidden' name='accessoriesid"+j+"' id='accessoriesid"+j+"' value='"+demoStr[i]+"'>";
						    i++;
						    var c4="<input type='text' name='gst"+j+"' id='update_gst"+j+"' onkeyup='myFunctionUpdate(this.id)' style='width: 30px;' value='"+demoStr[i]+"'>";
							 i++;
							 var c5=j;
							 
						    j++;
						    row(c1,c2,c3,c4,c5);
						}	
						function row(c1,c2,c3,c4,c5){
							var totbox=document.getElementById("totboxAccessories").value;
							totbox=parseInt(totbox)+1;
							
							
							var table = document.getElementById("edit_accessoriesbox");
							var rowno=totbox-1;
						    var row = table.insertRow(rowno);
						    var cell1 = row.insertCell(0);
						    var cell2 = row.insertCell(1);
						    var cell3 = row.insertCell(2);
						    var cell4 = row.insertCell(3);
						    var cell5 = row.insertCell(4);
						    var cell6 = row.insertCell(5);
						    var cell7 = row.insertCell(6);
						    var cell8 = row.insertCell(7);
						    var cell9 = row.insertCell(8);
						    
						    cell1.innerHTML = c1;
						   
						    cell2.innerHTML = c2;
						    
						    cell3.innerHTML = c3;
						    
						    cell4.innerHTML = c4;
						    
						    cell5.innerHTML = "<input type='text' name='update_cgst"+c5+"' style='width: 40px;' disabled='disabled' id='update_cgst"+c5+"'>";
						    
						    cell6.innerHTML = "<input type='text' name='update_cgstamount"+c5+"' style='width: 50px;' disabled='disabled' id='update_cgstamount"+c5+"'>";
						   	
						    cell7.innerHTML = "<input type='text' name='update_sgst"+c5+"' style='width: 40px;' disabled='disabled' id='update_sgst"+c5+"'>"
						    
						    cell8.innerHTML = "<input type='text' name='update_sgstamount"+c5+"' style='width: 50px;' disabled='disabled' id='update_sgstamount"+c5+"' >";
						    
						    cell9.innerHTML = "<input type='text' name='update_txtval"+c5+"' style='width: 50px;' disabled='disabled' id='update_txtval"+c5+"'>";
						    
						    
						    document.getElementById("totboxAccessories").value=totbox;
						    var str="update_item_price"+c5;
						    myFunctionUpdate(str);
						}
						
					}
				}

			};
			
			xhttp.open("GET", "/MSaleERP/EditPrintInvoice.do?q=" + str, true);
			xhttp.send();
	}
	
	function deleteAccessoriesInvoice(){
		var x = confirm("Are You Sure You Wont To Delete This Invoice?");
		if (x == true) {
			var saletype=document.getElementById("sale_type2").value;
			var invoiceid=document.getElementById("edit_invoiceAccessories").value;
			var xhttp;
			
			xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText.split(",");
					alert(demoStr);
					document.getElementById("editdatasaveAccessories").reset();
					var x = document.getElementById('editdatasaveAccessories');
				    if (x.style.display === 'block') {
				        x.style.display = 'none';
				    }
				}

			};
			
			xhttp.open("GET", "/MSaleERP/SaleInvoice?saletype="+saletype+"&&invoiceid="+invoiceid, true);
			xhttp.send();
	        //alert(saletype+"\n"+invoiceid);
	        return x;
	    } else {
	    	return x;
	    }
	}
//********************************************************************************************
	function setFocusToTextBox() {
		document.getElementById("CustName").focus();
		clock();
	}
// 	**************************Accessories*************************************************************
	function AddAccessories() {
		var totbox=document.getElementById("totbox").value;
		totbox=parseInt(totbox)+1;
		if (totbox === 3) {
			document.getElementById('addbox').style.display = 'none';
		 
		}
		//alert(totbox);
		
		var table = document.getElementById("accessoriesbox");
		var rowno=totbox-1;
	    var row = table.insertRow(rowno);
	    var cell1 = row.insertCell(0);
	    var cell2 = row.insertCell(1);
	    var cell3 = row.insertCell(2);
	    var cell4 = row.insertCell(3);
	    var cell5 = row.insertCell(4);
	    var cell6 = row.insertCell(5);
	    var cell7 = row.insertCell(6);
	    var cell8 = row.insertCell(7);
	    var cell9 = row.insertCell(8);
	    cell1.innerHTML = "<input type='text' name='item"+totbox+"' style='width: 150px;' maxlength='25' required>";
	    cell2.innerHTML = "<input type='text' name='item_detail"+totbox+"' style='width: 150px;' maxlength='40'>";
	    cell3.innerHTML = "<input type='text' name='item_price"+totbox+"' id='item_price"+totbox+"' onkeyup='myFunction(this.id)' style='width: 60px;' required>";
	    cell4.innerHTML = "<input type='text' name='gst"+totbox+"' value='18' style='width: 40px;' id='gst"+totbox+"' onkeyup='myFunction(this.id)' required>";
	    cell5.innerHTML = "<input type='text' name='cgst"+totbox+"' style='width: 40px;' disabled='disabled' id='cgst"+totbox+"'>";
	    cell6.innerHTML = "<input type='text' name='cgstamount"+totbox+"' style='width: 50px;' disabled='disabled' id='cgstamount"+totbox+"'>";
	   	cell7.innerHTML = "<input type='text' name='sgst"+totbox+"' style='width: 40px;' disabled='disabled' id='sgst"+totbox+"'>"
	    cell8.innerHTML = "<input type='text' name='sgstamount"+totbox+"' style='width: 50px;' disabled='disabled' id='sgstamount"+totbox+"' >";
	    cell9.innerHTML = "<input type='text' name='txtval"+totbox+"' style='width: 50px;' disabled='disabled' id='txtval"+totbox+"'>";
	    
	    document.getElementById("totbox").value=totbox;
	    
	}
	function DeleteAccessories() {
		var totbox=document.getElementById("totbox").value;
		totbox=parseInt(totbox);
		if(totbox>1)
		{
			//alert(totbox);
			totbox=totbox-1;
	    	document.getElementById("accessoriesbox").deleteRow(totbox);
	    	document.getElementById("totbox").value=totbox;
	    	document.getElementById('addbox').style.display = 'inline';
		}
		totalbill();
	}
//******************************************************************************************************
	
</script>

<!-- /datepicker -->
</head>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	if (session.getAttribute("username") == null) {
		response.sendRedirect("/MSaleERP");

	}
%>

<body onload='setFocusToTextBox()'>


	<div class="modal fade hide" id="edit" role="dialog"
		style="width: 80%; margin-left: -40%;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Edit Print</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<div class="widget-content nopadding" style="height: 100px;">
							<div class="control-group">
								<span class="label" style="margin-left: 105px;">Enter
									Buyer Mobile Number <span class="label label-info">OR</span>
									Invoice ID <span class="label label-info">OR</span> Buyer Name
									: <input list="browsers" name="browser" id="editdata"
									onkeyup="editPrint(this.value)" autocomplete="off" required style="width: 280px;">
									<datalist id="browsers"> </datalist>

									<button type="button" onclick="editPrintGetData()">Submit</button>
								</span>
							</div>
						</div>
					</div>
					<form class='form-horizontal' method='post'
						name="editdatasaveAccessories" id="editdatasaveAccessories"
						style="display: none;" action="/MSaleERP/EditPrintInvoice">
						<div class='form-group'>
							<div class='widget-content nopadding'>
								<table class="table table-bordered table-invoice-full"
									style="border-color: white;">

									<tr>
										<td><label>Buyer Name :</label></td>
										<td><input type="text" class="span11" value=""
											onkeyup="this.value=this.value.toUpperCase()"
											name="edit_name" id="edit_nameAccessories"
											style="width: 200px;" /></td>
										<td><label>Invoice No :</label></td>
										<td><input type="text" class="span11" value=""
											style="width: 200px;" name="edit_invoice"
											id="edit_invoiceAccessories" readonly="readonly" /><input
											type="hidden" name="sale_type" id="sale_type2"></td>
									</tr>

									<tr>
										<td><label>Address :</label></td>
										<td><input type="text" class="span11" value=""
											onkeyup="this.value=this.value.toUpperCase()"
											name="edit_address" id="edit_addressAccessories"
											style="width: 200px;" /></td>
										<td><label>Sale Date :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_saledate" id="edit_saledateAccessories"
											style="width: 200px;" readonly="readonly" /></td>
									</tr>

									<tr>
										<td><label>Contact No :</label></td>
										<td><input type="text" class="span11" value=""
											onkeypress="return isNumber(event)" name="edit_contactno"
											id="edit_contactnoAccessories" maxlength="10"
											style="width: 200px;" /></td>
										<td><label>Buyers GSTIN/PAN :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_gstin" id="edit_gstinAccessories"
											style="width: 200px;" /><input type="hidden"
											name="totboxAccessories" id="totboxAccessories" value="0">
										</td>
									</tr>

								</table>
								<table class="table table-bordered table-invoice-full">
									<thead>
										<tr>
											<th rowspan="2"><span style='color: red;'>*</span>Material</th>
											<th rowspan="2">Detail</th>
											<th rowspan="2"><span style='color: red;'>*</span>Price</th>
											<th rowspan="2"><span style='color: red;'>*</span>GST</th>
											<th colspan="2">CGST</th>
											<th colspan="2">SGST</th>
											<th rowspan="2">Taxable Value</th>
										</tr>
										<tr>
											<th>Rate</th>
											<th>Amount</th>
											<th>Rate</th>
											<th>Amount</th>
										</tr>
									</thead>
									<tbody id="edit_accessoriesbox">

									</tbody>
								</table>

							</div>

							<div class='modal-footer'>
								<input type='submit' class='btn btn-primary'
									value='PRINT & SAVE' onSubmit='' /> <input type='button'
									class='btn btn-primary' data-dismiss='modal' value='Cancel' /><a
									onclick="return deleteAccessoriesInvoice()"
									class="btn btn-danger">DELETE THIS INVOICE</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>




	<jsp:include page="../common/header_navbar.jsp"></jsp:include>

	<!--close-top-serch-->
	<!--sidebar-menu-->
	<jsp:include page="../common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->
	<div id="content">


		<!--Action boxes-->
		<div id="content-header">

			<!--End-Action boxes-->

			<!--Invoice -->
			<div id="content-header">
				<div id="breadcrumb">
					<a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home"
						class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#"
						class="current">Sale</a><a href="#" class="current">Accessories</a>
				</div>

				<h1>Sale Accessories Here...</h1>
			</div>
			<div class="container-fluid">
				<hr />
				<div class="row-fluid">
					<div class="span12">
						<div class="widget-box" style="margin: 0 auto;">
							<div class="widget-title">
								<span class="icon"> <i class="icon-briefcase"></i>
								</span>

								<h5>Suraj Electrical & Mobile Shopee</h5>
								<a href="#edit" data-toggle='modal' onclick=""><span
									class="label label-info" id="editbtn">Edit</span></a>
							</div>
							<form name="form" id="form" action="/MSaleERP/SaleInvoice.do"
								method="post">
								<div class="widget-content">
									<div class="row-fluid">
										<div class="span6">
											<table class="">
												<tbody>
													<tr>
														<td><label class="control-label">Buyer Name:</label>
															<!-- <div class="controls"> --> <input type="text"
															class="span11" placeholder="Buyers Name" id="CustName"
															name="CustName" style="width: 300px;"
															onkeyup="this.value=this.value.toUpperCase();" required />
															<!-- </div> --></td>
													</tr>
													<tr>
														<td><label class="control-label">Address :</label> <!-- <div class="controls"> -->
															<input type="text" class="span11" placeholder="Address"
															name="address" style="width: 300px;"
															onkeyup="this.value=this.value.toUpperCase();" /> <!-- </div> --></td>
													</tr>
													<tr>
														<td><label class="control-label">Mobile :</label> <!-- <div class="controls"> -->
															<input type="text" maxlength="10" class="span11"
															placeholder="Contact No." name="mobile"
															style="width: 300px;" onkeypress="return isNumber(event)"
															required /> <!-- </div> --></td>
													</tr>


												</tbody>
											</table>
										</div>

										<div class="span6">
											<table class="table table-bordered table-invoice">
												<tbody>


													<br>

													<tr>
														<td>Sale Date:</td>
														<%
															SysDate sd = new SysDate();
														%>
														<td><input type="date" name="saledate"
															value="<%=sd.todayDate()%>" id="saledateid" readonly></td>
													</tr>


												</tbody>

											</table>
											<table style="margin-top: -10px">
												<tr>
													<td><label class="control-label"> Buyers
															GSTIN/PAN :</label> <!-- <div class="controls"> --> <input
														type="text" class="span11" placeholder="GSTIN."
														name="custgst" style="width: 300px;" /> <!-- </div> --></td>
												</tr>
											</table>
										</div>
									</div>



									<div class="row-fluid">
										<div class="span12">
											<table class="table table-bordered table-invoice-full">
												<thead>
													<tr>
														<th rowspan="2"><span style='color: red;'>*</span>Material</th>
														<th rowspan="2">Detail</th>
														<th rowspan="2"><span style='color: red;'>*</span>Price</th>
														<th rowspan="2"><span style='color: red;'>*</span>GST</th>
														<th colspan="2">CGST</th>
														<th colspan="2">SGST</th>
														<th rowspan="2">Taxable Value</th>
													</tr>
													<tr>

														<th>Rate</th>
														<th>Amount</th>
														<th>Rate</th>
														<th>Amount</th>
													</tr>
												</thead>
												<tbody id="accessoriesbox">
													<tr>
														<td>
															<input type="text" name="item1" maxlength="25" id="item1" style="width: 150px;" required>
															<input type="hidden" id="totbox" name="totbox" value="1">
														</td>
														<td>
															<input type="text" name="item_detail1" maxlength="40" style="width: 150px;">
														</td>
														<td>
															<input type="text" name="item_price1" id="item_price1" onkeyup="myFunction(this.id)" maxlength="16" onkeypress="return isNumber(event)" style="width: 60px;" required>
														</td>
														<td>
															<input type="text" name="gst1" id="gst1" onkeyup="myFunction(this.id)" style="width: 40px;" value="18" onkeypress="return isNumber(event)" required>
														</td>
														<td>
															<input type="text" name="cgst1" id="cgst1" style="width: 40px;" disabled="disabled">
														</td>
														<td>
															<input type="text" name="cgstamount1" id="cgstamount1" style="width: 50px;" disabled="disabled">
														</td>
														<td>
															<input type="text" name="sgst1" id="sgst1" style="width: 40px;" disabled="disabled">
														</td>
														<td>
															<input type="text" name="sgstamount1" id="sgstamount1" style="width: 50px;" disabled="disabled">
														</td>
														<td>
															<input type="text" name="txtval1" id="txtval1" style="width: 50px;" disabled="disabled">
														</td>
													</tr>
												</tbody>
											</table>
											<button type="button" onclick="AddAccessories()" id="addbox"
												class="btn btn-primary btn-mini"
												style="float: left; width: 40px; border: 2px black solid; font-size: 20px; display: inline;">+</button>
											<label style="float: left; width: 10px; font-size: 20px"></label>
											<button type="button" class="btn btn-primary btn-mini"
												onclick="DeleteAccessories()"
												style="float: left; width: 40px; border: 2px black solid; font-size: 20px;">-</button>
											
											<table class="table table-bordered table-invoice-full">
											<tr>
														<td style="text-align: right; width: 400px;"><h4>Total :</h4></td>
														<td style="width: 87px;" id="pricegst"></td>
														<td style="width: 65px;">-</td>
														<td style="width: 65px;">-</td>
														<td style="width: 75px;" id="pricecgst"></td>
														<td style="width: 65px;">-</td>
														<td style="width: 75px;" id="pricesgst"></td>
														<td id="pricetxt"></td>
													</tr>
											</table>
											<table class="table table-bordered table-invoice-full">
												<tbody>
													<tr>
														<td class="msg-invoice" width="75%"></td>

														<td class="right"><strong>Taxable Value</strong> <br>
															<strong>SGST</strong> <br> <strong>CGST</strong>
															<br> <strong>IGST</strong><br> <strong
															id="roundoff"></strong></td>
														<td class="right" >
															<div id="taxable">
																<strong></strong><br>
															</div>
															<div id="sgst">
																<strong></strong><br>
															</div>
															<div id="cgst">
																<strong> </strong><br>
															</div>
															<div>
																-<br>
															</div>
															<div id="round">
																<strong></strong>
															</div>
														</td>
													</tr>
												</tbody>
											</table>
											<div class="pull-right">
												<h4>
													<span>Amount Due:</span> <span id="totalamt"></span>
												</h4>
												<br>


												<button type="submit"
													class="btn btn-primary btn-large pull-right" id="payBtn">Pay
													Bill</button>
											</div>

										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!--End-Invoice-->
		<hr />

	</div>


	<!--end-main-container-part-->

	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a
				href="http://verticalsoftware.co.in">www.verticalsoftware.in</a>
		</div>
	</div>

	<!--end-Footer-part-->




	<script type="text/javascript">
		function enablefield() {

			if (document.getElementById('check_radio').checked) {
				document.getElementById('ifYes').style.visibility = 'visible';
			} else
				document.getElementById('ifYes').style.visibility = 'hidden';
			//document.getElementById('cash').disabled='enable';
			//document.getElementById('withdrawal').disabled='enable';
		}

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
	</script>
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
	$('#edit').on('shown.bs.modal', function () {
	    $('#editdata').focus();
	})
</script>
</html>