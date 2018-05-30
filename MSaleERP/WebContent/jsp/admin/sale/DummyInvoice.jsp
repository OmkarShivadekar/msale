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
<link rel="stylesheet" href="/MSaleERP/config/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/MSaleERP/config/css/fullcalendar.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-style.css" />
<link rel="stylesheet" href="/MSaleERP/config/css/matrix-media.css" />
<link href="/MSaleERP/config/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="/MSaleERP/css/jquery.gritter.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
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
</style>



<script type="text/javascript">
	function setValue() {

		document.getElementById('div_modelrate').value = document
				.getElementById('div_modelrate').innerHTML;
		document.getElementById('invoiceno').value = document
				.getElementById('div_invoiceno').innerHTML;

		//alert("Hiiii");
	}
</script>

<script type="text/javascript">
	function myFunction() {
		var x = document.getElementById("div_modelrate").value;

		console.log('x', x);

		x = parseInt(x);

		var total_gst_amt = (x * 12) / 112;
		var totaltaxable_amt = x - total_gst_amt;

		//	    var totaltaxable_amt = temp_mrp;round
		totaltaxable_amt = Math.round(totaltaxable_amt * 100)/100;

		var cgst = totaltaxable_amt * 0.06;
		cgst = Math.round(cgst * 100)/100;//(Math.round(cgst)).toFixed(2);

		var sgst = totaltaxable_amt * 0.06;
		sgst = Math.round(sgst * 100)/ 100; // (Math.round(sgst)).toFixed(2);

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
</script>

<!-- button enable and disable -->
<script type="text/javascript">
	$(document).ready(function() {

		var printenable =
<%=request.getAttribute("printenable")%>
	if (printenable.equals("enable")) {
			$('form#myform').submit(function(e) {
				$(this).children('input[type=button]').removeAttr("disabled");
				// this is just for demonstration
				e.preventDefault();
				return false;
			});
		}

	});

	/* function enable(){
		
		/*  $('form#myform').submit(function(e){
		    $(this).children('input[type=button]').removeAttr("disabled");
		    // this is just for demonstration
		    e.preventDefault(); 
		    return false;
		}); 
	 */
	/* 
	 if(document.forms[0].button1.disabled == 1){
	document.forms[0].button1.disabled=false;
	}
	else if(document.forms[0].button1.disabled == 0){
	document.forms[0].button1.disabled=true;
	}  
	}*/

	function showModel(str) {
		document.getElementById("imeino").innerHTML = "";
		document.getElementById("div_modelrate").value = "";
		var xhttp;
		if (str == "") {
			document.getElementById("imeino").innerHTML = "";
			return;
		}
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				//document.getElementById("imeino").innerHTML = this.responseText;
				var demoStr = this.responseText.split(",");
				var text = "";
				var rateToSale = demoStr[0];
				document.getElementById("div_modelrate").value = rateToSale;
				for (var i = 1; i < demoStr.length; i++) {
					text += "<option value="+demoStr[i]+">" + demoStr[i]
							+ "</option>";
				}
				document.getElementById("imeino").innerHTML = text;
				myFunction();
			}

		};

		xhttp.open("POST", "/MSaleERP/PrintInvoice?q=" + str, true);
		xhttp.send();

	}
	function Submit() {
		var letters = /^[a-zA-Z\s-, ]+$/;
		var CustName = document.form.CustName.value, address = document.form.address.value, phone_no = document.form.mobile.value, modelrate = document.form.div_modelrate1.value;

		if (CustName == "" || !(CustName.match(letters))) {
			document.form.CustName.style.borderColor = "red";
			return false;
		} else if (address == "") {
			document.form.CustName.style.borderColor = "green";
			document.form.address.style.borderColor = "red";
			return false;
		} else if (phone_no == "") {
			document.form.CustName.style.borderColor = "green";
			document.form.address.style.borderColor = "green";
			document.form.mobile.style.borderColor = "red";
			return false;
		} else if ((isNaN(phone_no)) || (!(phone_no.length == 10))) {
			document.form.CustName.style.borderColor = "green";
			document.form.address.style.borderColor = "green";
			document.form.mobile.style.borderColor = "red";
			return false;
		} else if (modelrate == "") {
			document.form.CustName.style.borderColor = "green";
			document.form.address.style.borderColor = "green";
			document.form.mobile.style.borderColor = "green";
			document.form.div_modelrate1.style.borderColor = "red";
			return false;
		} else {
			document.form.mobile.style.borderColor = "green";
			document.form.address.style.borderColor = "green";
			document.form.CustName.style.borderColor = "green";
			document.form.div_modelrate1.style.borderColor = "green";
			printInvoice();
		}

	}

	function printInvoice() {

		document.getElementById("payBtn").disabled = true;
		document.getElementById("printBtn").disabled = false;
	}

	function setFocusToTextBox() {
		document.getElementById("CustName").focus();
		clock();
	}
</script>

<!-- /datepicker -->
</head>
<body onload="setFocusToTextBox()">

	<!--Header-part-->
	<jsp:include page="../common/header_navbar.jsp"></jsp:include>
	
	<!--sidebar-menu-->
	<jsp:include page="../common/left_navbar.jsp"></jsp:include>
	<!--sidebar-menu-->

	<!--main-container-part-->
	<div id="content">


		<!--Action boxes-->

		<!--End-Action boxes-->

		<!--Invoice -->


		<div id="content-header">
			<div id="breadcrumb">
				<a href="/MSaleERP/jsp/admin/homePage.jsp" title="Go to Home"
					class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#"
					class="current">Sale</a>
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

							<h4>Suraj Electricals & Mobile Shopee</h4>
						</div>
						<form name="form" action="/MSaleERP/dummyInvoice.do" method="post"
							onsubmit="">
							<div class="widget-content">
								<div class="row-fluid">
									<div class="span6">
										<table class="">
											<tbody>
												<tr>
													<td><label class="control-label">M/S. :</label> <!-- <div class="controls"> -->
														<input type="text" class="span11"
														placeholder="Buyers Name" name="CustName" id="CustName"
														style="width: 300px;"
														onkeyup="this.value=this.value.toUpperCase();" required />
														<!-- </div> --></td>
												</tr>
												<tr>
													<td><label class="control-label">Address :</label> <!-- <div class="controls"> -->
														<input type="text" class="span11" placeholder="Address"
														name="address" style="width: 300px;"
														onkeyup="this.value=this.value.toUpperCase();" required />
														<!-- </div> --></td>
												</tr>
												<tr>
													<td><label class="control-label">Mobile :</label> <!-- <div class="controls"> -->
														<input type="text" maxlength="10" class="span11"
														placeholder="Contact No." name="mobile"
														style="width: 300px;" required /> <!-- </div> --></td>
												</tr>


											</tbody>
										</table>
									</div>
									<%
										RequireData rd = new RequireData();
									%>
									<div class="span6">
										<table class="table table-bordered table-invoice">
											<tbody>


												<br>
												<tr>
													<td class="width30">Invoice ID:</td>
													<td class="width70"><input type="text"
														readonly="readonly" value="<%=rd.dummyinvoiceid()%>"
														id="invoiceno" name="invoiceno1"></td>
												</tr>
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
										<table style="margin-top: -20px">
											<tr>
												<td><label class="control-label">Buyers
														GSTIN/PAN :</label> <!-- <div class="controls"> --> <input
													type="text" class="span11" placeholder="Customer GSTIN"
													name="custgst" style="width: 300px;" /> <!-- </div> --></td>
											</tr>
										</table>
									</div>
								</div>

								<div class="row-fluid">
									<div class="span12">
										<div class="widget-box">
										
													<table class="table table-bordered table-invoice-full">
														<thead>
															<tr>
																<th class="head0">Type</th>
																<th class="head1">PARTICULARS</th>
																<th class="head0 right">Amount</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td>Model No.</td>
																<td>
																	<div class="control-group">
																		<div class="controls">
																			<input type="text" id="" name="modelname"
																				placeholder="Model" required />
																		</div>
																	</div>
																</td>

																<td class="right" style="width: 100px;"><input
																	type="text" id="div_modelrate" placeholder="Amount"
																	onkeyup="myFunction()" name="div_modelrate1" required />
																</td>

															</tr>
															<tr>
																<td>IMEI No.</td>
																<td class="right">
																	<div class="control-group">
																		<div class="controls">
																			<input type="text" id="" placeholder="IMEI NO 1"
																				name="imeino1" required maxlength="17" /> <input
																				type="text" id="" placeholder="IMEI NO 2"
																				name="imeino2" maxlength="17" />
																		</div>
																	</div>
																</td>

																<td class="right">
																	<div>HSN/SAC No.</div> <select name="hsnsacno"><option>85171290</option>
																		<option>85171210</option></select>
																</td>
															</tr>
															<tr>
																<td>S/N No.</td>
																<td class="right"><input type="text"
																	placeholder="S/N No" id="snno" name="snno1"></td>

																<td class="right"><div readonly="readonly"></div></td>
															</tr>
															<tr>
																<td>BatteryNo.</td>
																<td class="right"><input type="text"
																	placeholder="Battery Number" id="battery"
																	name="battery1"></td>

																<td class="right"><div readonly="readonly"></div></td>
															</tr>
															<tr>
																<td>Charger No.</td>
																<td class="right"><input type="text"
																	placeholder="Charger Number" name="charger1"
																	id="charger"></td>

																<td class="right"><input id="discount"
																	type="hidden" onkeyup="myFunction()" name="discount"
																	placeholder="Discount"></td>
															</tr>

														</tbody>
													</table>
												

										<table class="table table-bordered table<invoice-full">
											<tbody>
												<tr>
													<td class="msg-invoice" width="75%"><h4>Payment
															method:</h4> <input style="margin-left: 0px;" type="radio"
														name="paymentbtn" value="Cash" class="tip-bottom"
														title="Cash" checked="checked" disabled="disabled">&nbsp;
														Cash &nbsp;&nbsp; <br /></td>

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



		<!--End-Invoice-->
		<hr />

	</div>


	<!--end-main-container-part-->

	<!--Footer-part-->

	<div class="row-fluid">
		<div id="footer" class="span12">
			2017 &copy; Vertical Software. <a href="#">www.verticalsoftware.in</a>
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
</script>
</html>