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
#s2id_modelname,#s2id_imeino {
	float: right;
}

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


	function myFunction() {

		var a = document.getElementById("div_modelrate").value;
		var x;
		
		if (a != "") {
			x=a;
		}
		
		console.log('x', x);
		x = parseInt(x);

		var total_gst_amt = (x * 12) / 112;
		var totaltaxable_amt = x - total_gst_amt;

		// 	    var totaltaxable_amt = temp_mrp;round
		totaltaxable_amt = Math.round(totaltaxable_amt * 100)/100;

		var cgst = totaltaxable_amt * 0.06;
		cgst = Math.round(cgst * 100)/100;
		//(Math.round(cgst)).toFixed(2);

		var sgst = totaltaxable_amt * 0.06;
		sgst = Math.round(sgst * 100)/100; 
		//(Math.round(sgst)).toFixed(2);

		var totalvalue = totaltaxable_amt + cgst + sgst;
		var temp_totalvalue = totalvalue;
		totalvalue = Math.round(totalvalue);

		var round = (x - temp_totalvalue).toFixed(2);
		if (round > 0) {
			document.getElementById("roundoff").innerHTML = "Round OFF(+)";
			document.getElementById("round").innerHTML = round;
		} else if (round < 0) {
			document.getElementById("roundoff").innerHTML = "Round OFF(-)";
			document.getElementById("round").innerHTML = round;
		} else {
			document.getElementById("roundoff").innerHTML = "";
			document.getElementById("round").innerHTML = "";
		}

		document.getElementById("sgst").innerHTML = sgst;
		document.getElementById("cgst").innerHTML = cgst;

		document.getElementById("taxable").innerHTML = totaltaxable_amt;

		//document.getElementById("gross").innerHTML=x-(a+b);
		document.getElementById("totalamt").innerHTML = totalvalue;

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


	function showIMEI(str) {
		
		
		if (str == "") {
			return;
		}
		var x = event.keyCode;
	    if (x == 9) {
			xhttp = new XMLHttpRequest();
			try{
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var demoStr = this.responseText.split("~");
					
					if(demoStr != ""){
		 				document.getElementById("modelname").value = demoStr[0];
		 				document.getElementById("mobilemodel").value = demoStr[1];
		 				document.getElementById("div_modelrate").value = demoStr[2];
		 				document.getElementById("hscode").value = demoStr[3];
		 				document.getElementById("hscode_dis").value = demoStr[3];
		 				myFunction();
		 				document.getElementById("payBtn").disabled=false;
					}else{
						alert("Model is not added, please add the model in stock!");
						document.getElementById("modelname").value = "";
		 				document.getElementById("mobilemodel").value = "";
		 				document.getElementById("div_modelrate").value = "";
		 				document.getElementById("hscode").value = "";
		 				document.getElementById("hscode_dis").value = "";
		 				document.getElementById("payBtn").disabled=true;
					}
				}

			};
			
			xhttp.open("POST", "/MSaleERP/PrintInvoice?imei=" + str, true);
			xhttp.send();
			}
			catch(e)
			{
				alert("Unable to connect to server");
			}     
	    }
	}

		function setFocusToTextBox() {
		document.getElementById("CustName").focus();
		clock();
	}
		
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
						text += " value="+demoStr[i]+">";
						i++;
						text +=demoStr[i]+ "</option>";
						i++;
					}	
					document.getElementById("browsers").innerHTML = text;
				}

			};
			
			xhttp.open("GET", "/MSaleERP/PrintInvoice?q=" + str, true);
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
							document.getElementById("editdatasave").reset();
							var x = document.getElementById('editdatasave');
						    if (x.style.display === 'none') {
						        x.style.display = 'block';
						    }
						    
						    document.getElementById("sale_type1").value =saletype;
							document.getElementById("edit_invoice").value = demoStr[14];
							document.getElementById("edit_name").value = demoStr[1];
							document.getElementById("edit_address").value = demoStr[2];
							document.getElementById("edit_contactno").value = demoStr[3];
							document.getElementById("edit_saledate").value = demoStr[4];
							document.getElementById("edit_model").value = demoStr[5];
							document.getElementById("edit_imei1").value = demoStr[6];
							var imei2=demoStr[7];
							if(imei2!="null"){
							document.getElementById("edit_imei2").value = imei2;}
							var serial=demoStr[8];
							if(serial!="null"){
							document.getElementById("edit_serial").value = serial;}
							document.getElementById("edit_hsn").value = demoStr[9];
							document.getElementById("edit_battery").value = demoStr[10];
							document.getElementById("edit_charer").value = demoStr[11];
							document.getElementById("edit_amount").value = demoStr[12];
							var gstin=demoStr[13];
							if(gstin!="null"){
							document.getElementById("edit_gstin").value = gstin;}
							document.getElementById("edit_modelid").value = demoStr[15];
							
						}else{
							alert("This is Accesspries Invoice")						
						}
					}

				};
				
				xhttp.open("GET", "/MSaleERP/EditPrintInvoice.do?q=" + str, true);
				xhttp.send();
		}
		
		function deleteinvoice(){
			var x = confirm("Are You Sure You Wont To Delete This Invoice?");
			if (x == true) {
				var saletype=document.getElementById("sale_type1").value;
				var invoiceid=document.getElementById("edit_invoice").value;
				var imei=document.getElementById("edit_imei1").value;
				var xhttp;
				
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var demoStr = this.responseText.split(",");
						alert(demoStr);
						document.getElementById("editdatasave").reset();
						var x = document.getElementById('editdatasave');
					    if (x.style.display === 'block') {
					        x.style.display = 'none';
					    }
					}

				};
				
				xhttp.open("GET", "/MSaleERP/SaleInvoice?saletype="+saletype+"&&invoiceid="+invoiceid+"&&imei="+imei, true);
				xhttp.send();
		        //alert(saletype+"\n"+invoiceid);
		        return x;
		    } else {
		    	return x;
		    }
		}
		
	//********************************************************************************************


</script>

<!-- /datepicker -->
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

<body onload='setFocusToTextBox()'>
	<div class="modal hide fade" id="edit" role="dialog"
		style="width: 65%; margin-left: -32%;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Edit Print</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<div class="widget-content nopadding" style="height: 100px;">
							<div class="control-group">
								<span class="label" style="margin-left: 50px;">Enter
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
					<form class='form-horizontal' method='post' name="editdatasave"
						id="editdatasave" style="display: none;"
						action="/MSaleERP/EditPrintInvoice?page=scanner">
						<div class='form-group'>
							<div class='widget-content nopadding'>
								<table class="table table-bordered table-invoice-full"
									style="border-color: white;">

									<tr>
										<td><label>Buyer Name :</label></td>
										<td><input type="text" class="span11" value=""
											onkeyup="this.value=this.value.toUpperCase()"
											name="edit_name" id="edit_name" style="width: 200px;" /></td>
										<td><label>Invoice No :</label></td>
										<td><input type="text" class="span11" value=""
											onkeyup="this.value=this.value.toUpperCase()"
											style="width: 200px;" name="edit_invoice" id="edit_invoice"
											readonly="readonly" /><input type="hidden" name="sale_type"
											id="sale_type1"></td>
									</tr>

									<tr>
										<td><label>Address :</label></td>
										<td><input type="text" class="span11" value=""
											onkeyup="this.value=this.value.toUpperCase()"
											name="edit_address" id="edit_address" style="width: 200px;" /></td>
										<td><label>Sale Date :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_saledate" id="edit_saledate" style="width: 200px;"
											readonly="readonly" /></td>
									</tr>

									<tr>
										<td><label>Contact No :</label></td>
										<td><input type="text" class="span11" value=""
											onkeypress="return isNumber(event)" name="edit_contactno"
											id="edit_contactno" maxlength="10" style="width: 200px;" /></td>
										<td><label>Buyers GSTIN/PAN :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_gstin" id="edit_gstin" style="width: 200px;" /></td>
									</tr>
									<tr>
										<td><label>Model Name :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_model" id="edit_model" style="width: 200px;"
											readonly="readonly" /><input type="hidden"
											name="edit_modelid" id="edit_modelid"></td>
										<td><label>Amount :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_amount" id="edit_amount" style="width: 200px;" req /></td>
									</tr>
									<tr>
										<td><label>IMEI NO 1 :</label></td>
										<td><input type="text" class="span11" value=""
											readonly="readonly" name="edit_imei1" id="edit_imei1"
											style="width: 200px;" /></td>
										<td><label>IMEI NO 2 :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_imei2" id="edit_imei2" style="width: 200px;" /></td>
									</tr>
									<tr>
										<td><label>Battery No :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_battery" id="edit_battery" style="width: 200px;" /></td>
										<td><label>Charger No :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_charer" id="edit_charer" style="width: 200px;" /></td>
									</tr>

									<tr>
										<td><label>HSN/SAC Code :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_hsn" id="edit_hsn" style="width: 200px;" /></td>
										<td><label>Serial No :</label></td>
										<td><input type="text" class="span11" value=""
											name="edit_serial" id="edit_serial" style="width: 200px;" /></td>
									</tr>

								</table>
							</div>

							<div class='modal-footer'>
								<input type='submit' class='btn btn-primary'
									value='PRINT & SAVE' onSubmit='' /> <input type='button'
									class='btn btn-primary' data-dismiss='modal' value='Cancel' /><a
									onclick="return deleteinvoice()" class="btn btn-danger">DELETE
									THIS INVOICE</a>
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
						class="current">Sale</a><a href="#" class="current">Mobile</a>
				</div>

				<h1>Sale Mobile Here...</h1>
			</div>
			<div class="container-fluid">
				<hr />
				<div class="row-fluid">
					<div class="span12">
						<div class="widget-box" style="width: 800px; margin: 0 auto;">
							<div class="widget-title">
								<span class="icon"> <i class="icon-briefcase"></i>
								</span>

								<h5>Suraj Electrical & Mobile Shopee</h5>
								<a href="#edit" data-toggle='modal' onclick=''><span
									class="label label-info" id="editbtn">Edit</span></a>
							</div>
							<form name="form" id="form" action="/MSaleERP/SaleInvoice?page=scanner"
								method="post">
								<div class="widget-content">
									<div class="row-fluid">
										<div class="span6">
											<table class="">
												<tbody>
													<tr>
														<td><label class="control-label"><span style='color: red;'>*</span>Buyer Name:</label>
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
															onkeyup="this.value=this.value.toUpperCase();"/>
															<!-- </div> --></td>
													</tr>
													<tr>
														<td><label class="control-label"><span style='color: red;'>*</span>Mobile :</label> <!-- <div class="controls"> -->
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
															value="<%=sd.todayDate()%>" id="saledateid"></td>
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
									
									<hr>
									<div class="row-fluid" style="margin-top: 10px;">
										<div class="span12">

											<table style="margin: 0 auto; width: 770px;">
												<tbody>
													<tr>

														<td style="text-align: right;"><span style='color: red;'>*</span>IMEI
															No.<input type="text" id="imeino" name="imeino" onkeydown="showIMEI(this.value)" class="span9" required>
																</td>

														<td style="text-align: right;">IMEI No.<input
															type="text" id="imeino2" name="imeino2" class="span9"
															placeholder="IMEI NO 2." maxlength="16"
															onkeypress="return isNumber(event)"></td>
													</tr>
													<tr>
														<td style="text-align: right;"><span style='color: red;'>*</span>Model No.
														<input type="text" value="" id="mobilemodel" class="span9" required readonly="readonly" tabindex="-1">
														<input type="hidden" id="modelname" name="modelname" >
														</td>

														<td style="text-align: right;"><span style='color: red;'>*</span>Amount : <input
															type="text" id="div_modelrate" onkeyup="myFunction()" class="span9"
															maxlength="9" onkeypress="return isNumber(event)"
															name="div_modelrate1" required />
															
															</td>

													</tr>
													<tr>
														<td style="text-align: right;">BatteryNo.<input type="text"
															id="battery" maxlength="25" class="span9"
															name="battery1"></td>

														<td style="text-align: right;">Serial No.<input
															type="text" id="snno" name="snno" class="span9"
															placeholder="Serial No." maxlength="25"></td>
													</tr>
													<tr>
														<td style="text-align: right;">Charger No.<input type="text"
															name="charger1" id="charger" class="span9"
															maxlength="25"></td>

														<td style="text-align: right;">HSN/SAC Code.<input
															id="hscode" type="hidden" name="hscode" class="span9">
															<input
															id="hscode_dis" type="text" disabled="disabled" name="hscode" class="span9"
															placeholder="HSN/SAC Code"></td>
													</tr>

												</tbody>
											</table>
											<hr>
											<table class="table table-bordered table-invoice-full">
												<tbody>
													<tr>
														<td class="msg-invoice" width="75%"><h4>Payment
																method:</h4> <input style="margin-left: 0px;" type="radio"
															id="cash_radio" name="paymentbtn" value="Cash" tabindex="-1"
															class="tip-bottom" title="Cash" checked="checked"
															onchange="enablefield()">&nbsp; Cash &nbsp;&nbsp;
															<br /> <input style="margin-left: 0px;" type="radio"
															id="check_radio" name="paymentbtn" value="Check"
															class="tip-bottom" title="Check" onchange="enablefield()">
															&nbsp;Cheque &nbsp;
															<div id="ifYes" style="visibility: hidden;">
																<label style="padding-left: 150px;">Cheque No. </label>
																<input type="text" class="span11" placeholder="Check No"
																	maxlength="10" onkeypress="return isNumber(event)"
																	name="check_no" id="cash"
																	style="width: 220px; padding-left: 6px; margin-left: 150px;" /><br>
																<label style="padding-left: 150px;">Withdrawal
																	Date : </label> <input type="date" name="withdrawalDate"
																	value="<%=sd.todayDate()%>" id="withdrawal"
																	style="margin-left: 150px;">
															</div></td>

														<td class="right"><strong>Taxable Value</strong> <br>
															<strong>SGST(6%)</strong> <br> <strong>CGST(6%)</strong>
															<br> <strong>IGST</strong><br> <strong
															id="roundoff"></strong></td>
														<td class="right">
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


												<button type="submit" disabled="disabled"
													class="btn btn-primary btn-large pull-right" id="payBtn">Pay
													Bill</button>
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