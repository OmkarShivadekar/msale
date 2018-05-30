<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="utility.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<style>
body {
	zoom: 0.82;
}

{
margin
:
 
0;
padding
:
 
0;
}
#print{
	margin: 0 auto;
    width: 600px;
    height: 600px;
}
#page-wrap {
	border: 1px solid;
	width: 670px;
	margin-top: -65px;
    margin-bottom: -160px;
    margin-left: -25px;
	padding: 1px;
}

textarea {
	border: 0;
	font: 14px Georgia, Serif;
	overflow: hidden;
	resize: none;
}

table {
	border-collapse: collapse;
}

table td, table th {
	border: 1px solid black;
	padding: 5px;
}

#header {
	color: black;
	height: 5px;
	width: 100%;
	margin: 8px 0;
	/* background: #222; */
	text-align: center;
	color: black;
	font: bold 15px Helvetica, Sans-Serif;
	text-decoration: uppercase;
	letter-spacing: 22px;
	padding: 0px 0px;
}

#address {
	width: 260px;
	height: 90px;
	float: right;
}

#customer {
	overflow: hidden;
}

#logo {
	text-align: right;
	float: left;
	position: relative;
	border: 1px solid #fff;
	max-width: 540px;
	max-height: 100px;
	overflow: hidden;
}

#logo:hover, #logo.edit {
	border: 1px solid #000;
	margin-top: 0px;
	max-height: 125px;
}

#logoctr {
	display: none;
}

#logo:hover #logoctr, #logo.edit #logoctr {
	display: block;
	text-align: right;
	line-height: 25px;
	background: #eee;
	padding: 0 5px;
}

#logohelp {
	text-align: left;
	display: none;
	font-style: italic;
	padding: 10px 5px;
}

#logohelp input {
	margin-bottom: 5px;
}

.edit #logohelp {
	display: block;
}

.edit #save-logo, .edit #cancel-logo {
	display: inline;
}

.edit #image, #save-logo, #cancel-logo, .edit #change-logo, .edit #delete-logo
	{
	display: none;
}

#customer-title {
	height: 55px;
	font-size: 15px;
	float: left;
}

#meta {
	margin-top: 1px;
	width: 300px;
	float: right;
}

#meta td {
	text-align: right;
}

#meta td.meta-head {
	text-align: left;
	background: #eee;
}

#meta td textarea {
	width: 100%;
	height: 20px;
	text-align: right;
}

#items {
	clear: both;
	width: 100%;
	margin: 2px 0 0 0;
	border: 1px solid black;
}

#items th {
	background: #eee;
}

#items textarea {
	width: 80px;
	height: 30px;
}

#items tr.item-row td {
	vertical-align: top;
}

#items td.description {
	width: 300px;
}

#items td.item-name {
	
}

#items td.description textarea, #items td.item-name textarea {
	width: 100%;
}

#items td.total-line {
	text-align: right;
}

#items td.total-value {
	border-left: 0;
	padding: 8px;
}

#items td.total-value textarea {
	height: 12px;
	background: none;
}

#items td.balance {
	background: #eee;
}

#items td.blank {
	text-align: left;
}

#terms {
	text-align: center;
	margin: 20px 0 0 0;
}

#terms h5 {
	text-transform: uppercase;
	font: 13px Helvetica, Sans-Serif;
	letter-spacing: 10px;
	border-bottom: 1px solid black;
	padding: 0 0 8px 0;
	margin: 0 0 8px 0;
}

#terms textarea {
	width: 100%;
	text-align: center;
}

textarea:hover, textarea:focus, #items td.total-value textarea:hover,
	#items td.total-value textarea:focus, .delete:hover {
	background-color: #EEFF88;
}

.delete-wpr {
	position: relative;
}

.delete {
	display: block;
	color: #000;
	text-decoration: none;
	position: absolute;
	background: #EEEEEE;
	font-weight: bold;
	padding: 0px 3px;
	border: 1px solid;
	top: -6px;
	left: -22px;
	font-family: Verdana;
	font-size: 12px;
}

@page {
	size: auto;
	margin: 25mm, 25mm, 25mm, 25mm;
}
</style>

<script type="text/javascript" src="./config/js/numtoword.js"></script>

<script type="text/javascript">
   function myFunction() {
	   
	   var x =  document.getElementById("rate").innerHTML;
	   console.log('x',x);
	    
	    x = parseInt(x);
	    
	    
	    var total_gst_amt = (x*12)/112;
	    var totaltaxable_amt = x-total_gst_amt;
	    
//	    var totaltaxable_amt = temp_mrp;round
       	totaltaxable_amt = Math.round(totaltaxable_amt * 100) / 100;  
		
	        
	    var cgst = totaltaxable_amt*0.06;
	    cgst = Math.round(cgst * 100) / 100;//(Math.round(cgst)).toFixed(2);
	    		    	
	    var sgst = totaltaxable_amt*0.06;
	    sgst = Math.round(sgst * 100) / 100; //(Math.round(sgst)).toFixed(2);
	    	
	    var totalvalue = totaltaxable_amt+cgst+sgst;
	    var temp_totalvalue=totalvalue;
	    totalvalue = Math.round(totalvalue);
	    	
	    var round=(x-temp_totalvalue).toFixed(2);
	    if (round > 0)
	    {
	    	document.getElementById("roundoff").innerHTML="(+)Round OFF";
	    	document.getElementById("roundoff1").innerHTML="(+)Round OFF";
	    	document.getElementById("round").innerHTML=round;
	    	document.getElementById("round1").innerHTML=round;
	    }
	    else if(round < 0)
	    {
	    	document.getElementById("roundoff").innerHTML="(-)Round OFF";
	    	document.getElementById("roundoff1").innerHTML="(-)Round OFF";
	    	document.getElementById("round").innerHTML=round;
	    	document.getElementById("round1").innerHTML=round;
	    }
	    else
	    {
	    	document.getElementById("roundoff").innerHTML="Round OFF";
	    	document.getElementById("roundoff1").innerHTML="Round OFF";
	    	document.getElementById("round").innerHTML="0";
	    	document.getElementById("round1").innerHTML="0";
	    }
	    document.getElementById("sgst").innerHTML=sgst;
	    document.getElementById("cgst").innerHTML=cgst;
	    
	    document.getElementById("sgst1").innerHTML=sgst;
	    document.getElementById("cgst1").innerHTML=cgst;
	    
	    //document.getElementById("gross").innerHTML=x-(a+b);
	    document.getElementById("price").innerHTML=totaltaxable_amt;
	    document.getElementById("price1").innerHTML=totaltaxable_amt;
	    
	    document.getElementById("totalamt").innerHTML=totalvalue;
	    document.getElementById("totalamt1").innerHTML=totalvalue;
	    
	   inWords();
	}
   
   function inWords()
   {
	   
	    var str = document.getElementById("totalamt").innerHTML;
	    var splt = str.split("");
	    var rev = splt.reverse();
	    var once = ['Zero', ' One', ' Two', ' Three', ' Four', ' Five', ' Six', ' Seven', ' Eight', ' Nine'];
	    var twos = ['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
	    var tens = ['', 'Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety'];

	    numLength = rev.length;
	    var word = new Array();
	    var j = 0;

	    for (i = 0; i < numLength; i++) {
	        switch (i) {

	            case 0:
	                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = '' + once[rev[i]];
	                }
	                word[j] = word[j];
	                break;

	            case 1:
	                aboveTens();
	                break;

	            case 2:
	                if (rev[i] == 0) {
	                    word[j] = '';
	                }
	                else if ((rev[i - 1] == 0) || (rev[i - 2] == 0)) {
	                    word[j] = once[rev[i]] + " Hundred ";
	                }
	                else {
	                    word[j] = once[rev[i]] + " Hundred and";
	                }
	                break;

	            case 3:
	                if (rev[i] == 0 || rev[i + 1] == 1) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = once[rev[i]];
	                }
	                if ((rev[i + 1] != 0) || (rev[i] > 0)) {
	                    word[j] = word[j] + " Thousand";
	                }
	                break;

	                
	            case 4:
	                aboveTens();
	                break;

	            case 5:
	                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = once[rev[i]];
	                }
	                if (rev[i + 1] !== '0' || rev[i] > '0') {
	                    word[j] = word[j] + " Lakh";
	                }
	                 
	                break;

	            case 6:
	                aboveTens();
	                break;

	            case 7:
	                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = once[rev[i]];
	                }
	                if (rev[i + 1] !== '0' || rev[i] > '0') {
	                    word[j] = word[j] + " Crore";
	                }                
	                break;

	            case 8:
	                aboveTens();
	                break;

	            //            This is optional. 

	            //            case 9:
	            //                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	            //                    word[j] = '';
	            //                }
	            //                else {
	            //                    word[j] = once[rev[i]];
	            //                }
	            //                if (rev[i + 1] !== '0' || rev[i] > '0') {
	            //                    word[j] = word[j] + " Arab";
	            //                }
	            //                break;

	            //            case 10:
	            //                aboveTens();
	            //                break;

	            default: break;
	        }
	        j++;
	    }

	    function aboveTens() {
	        if (rev[i] == 0) { word[j] = ''; }
	        else if (rev[i] == 1) { word[j] = twos[rev[i - 1]]; }
	        else { word[j] = tens[rev[i]]; }
	    }

	    word.reverse();
	    var finalOutput = '';
	    for (i = 0; i < numLength; i++) {
	        finalOutput = finalOutput + word[i];
	    }
	    var print =finalOutput +" Only";
	    document.getElementById("print_inwords").innerHTML = print;
	    document.getElementById("print_inwords1").innerHTML = print;
	}
  
   </script>

<style>
#hiderow, .delete {
	display: none;
}
</style>

<title>GST Invoice</title>
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

<body onload="myFunction()">
	<%  
	String invoice=request.getParameter("invoiceId");
	String model=request.getParameter("model");
	RequireData data = new RequireData();

	
	//Invoice Organization
		String orgName = "";
		String tag ="";
		String orgAddress = "";
		String tal = "";
		String dist = "";
		String phoneNo = "";
		String pan= "";
		String gstin = "";
		String place = "";
		String scode = "";
	
	List invoiceList=data.getOrgInvoiceDetails();
	
	
	 orgName = invoiceList.get(0).toString();
	 tag =invoiceList.get(1).toString();
	 orgAddress = invoiceList.get(2).toString();
	 tal = invoiceList.get(3).toString();
	 dist = invoiceList.get(4).toString();
	 phoneNo = invoiceList.get(5).toString();
	 pan= invoiceList.get(6).toString();
	 gstin = invoiceList.get(7).toString();
	 place = invoiceList.get(8).toString();
	 scode = invoiceList.get(9).toString();
	
	
	
	
	
	
	
	List details = data.getSaleData(invoice, model);
	
	//List details = (List)request.getAttribute("printdetails");

	String invoice_no=""; 
	String cust_name=""; 
	String cust_address=""; 
	String cust_mobno=""; 
	String model_no=""; 
	String imei_no="";
	String imei_no2="";
	String serial_no="";
	String hsnsac_no="";
	String battery_no=""; 
	String charger_no="";
	String paid_amount="";
	String sale_date="";
	String custgst="";
	

    if(details!= null)
    {
    	System.out.println("in Print Invoice.jsp"+details);
    	//1 1 2017-07-17 1 99999999999999 11111111111 22222222222 40000 c 1 HIMANSHU PUNE 9687712856
    	invoice_no = details.get(0).toString();
    	cust_name = details.get(1).toString();
    	cust_address = details.get(2).toString();
    	cust_mobno = details.get(3).toString();
    	sale_date = details.get(4).toString();
    	model_no = details.get(5).toString();
    	imei_no = details.get(6).toString();
    	imei_no2 = details.get(7).toString();
    	serial_no = details.get(8).toString();
    	hsnsac_no = details.get(9).toString();
    	battery_no = details.get(10).toString();
    	charger_no = details.get(11).toString();
    	paid_amount = details.get(12).toString();
    	custgst=details.get(13).toString();
    	
    }

%>

<div id="print">
	<div id="page-wrap" style="transform : rotate(90deg); ">
		<p id="header">TAX-INVOICE</p>

	<table style="width: 670px;">
			<tr>
				<td width="350px">
					<div id="logo">
						<img id="image" src="/MSaleERP/config/img/simplelogo.png"
							alt="logo" />
						 <br> <span><%=tag %></span>
					</div>
				</td>
				<td><div>
						 <%=orgAddress %>,
						Tal -<%=tal %>, <br>
						Dist -<%=dist %> . <br>
						Ph.No-<%=phoneNo %> 
					</div>
				</td>

			</tr>
			<tr>
				<td>
						Buyers Name:- <i><%=cust_name %></i>
				</td>
				<td rowspan="2">
					Invoice No:&nbsp;<%=invoice_no %>
				</td>
             </tr>
			<tr>
				<td>Address:- <i><%=cust_address %></i></td>
				
			</tr>
			<tr>
				<td>Mob.No:- <i><%=cust_mobno %></i></td>
				<td rowspan="2">Date:&nbsp;<%=sale_date %></td>
			</tr>
			<tr>
				<td>GSTIN / PAN:-<% if(!custgst.equals("null")){out.print(custgst);} %></td>
				
			</tr>
		</table>
		<table id="items">

			<tr>
				<th style="width: 25px;">Sr.No</th>
				<th>Description</th>
				<th style="width: 80px;">HSN/SAC Code</th>
				<th style="width: 20px;">Qty</th>
				<th style="width: 60px;">Rate</th>
				<th>Price</th>
			</tr>

			<tr class="item-row">
				<td align="center">1</td>
				<td><div style="line-height: 1.5">
					Model No : &nbsp;&nbsp;&nbsp;&nbsp; <%=model_no %><br><br>
					IMEI No-1 : &nbsp;&nbsp;&nbsp;&nbsp; <%=imei_no %> <br><br> 
					IMEI No-2: &nbsp;&nbsp;&nbsp;&nbsp; <% if(!imei_no2.equals("null")){out.print(imei_no2);} %> <br><br>
					Serial No :  &nbsp;&nbsp;&nbsp;&nbsp; <% if(!serial_no.equals("null")){out.print(serial_no);} %> <br> <br>
					Battery	No : &nbsp;&nbsp;&nbsp;&nbsp; <%=battery_no %><br><br>
					Charger No : &nbsp;&nbsp;&nbsp;&nbsp; <%=charger_no %><br>
					</div>
				</td>
				<td><%=hsnsac_no %></td>
				<td align="center">1</td>
				<td id="rate"><%=paid_amount %></td>
				<td id="price"></td>
			</tr>

			
			<tr>
				<td colspan="3" rowspan="4" class="blank" valign="top">
					<div style="font-size: 13px;">
						ONE YEAR Company Service Center Warranty.<br> # Handset
						warrenty as per Mfg. Company terms & condition.<br> # Good's
						once sold will not be taken back or exchange.<br> # Warrant
						avoid if it is Water/Physical damage.<br> <br>
						<b>GSTIN:-<%=gstin %></b><br/>
						<b>PAN:-<%=pan %></b><br/>
						<b>Place of Supply:-<%=place %></b><br/>
						<b>State Code:-<%=scode %></b>

					</div>
				</td>
				<td colspan="2" class="total-line">CGST 6.00 %</td>
				<td class="total-value"><div id="cgst"></div></td>
			</tr>
			
			<tr>
				<td colspan="2" class="total-line">SGST 6.00 %</td>
				<td class="total-value" id="sgst"></td>
			</tr>
			<tr>
				<td colspan="2" class="total-line">IGST 0.00 %</td>
				<td class="total-value"><textarea id="paid">0.00</textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="total-line"><div id="roundoff"></div></td>
				<td class="total-value"><div id="round"></div></td>
			</tr>
			<tr>


				<td colspan="3" rowspan="2" class="blank"><span>(In
						Words)&nbsp;:-<i id="print_inwords"></i>
				</span></td>
				<td colspan="2" class="total-line balance">Total Value</td>
				<td class="total-value balance"><div class="gTotal"
						id="totalamt"></div></td>
			</tr>


		</table>
		<table>
			<tr>
				<td style="width: 800px; height: 80px;"><i style="font-size: 8px;">
				        "I/We here by certify that my/our
						registration certificate under the Maharashtra GST Act 2017, is in
						force on the date on which sale<br> of the goods specified in this Tax
						invoice is made by me/us and it shall be accounted for in the
						turnover of sales while filling of return<BR> and the due tax,if any
						payable on the sale has been paid or shall be paid."</i><br><span style="float: right;">For <%=orgName %></span><br> <br> <br>
					<i>Buyers Signature </i> <span style="float: right;"><i>Authorized Signature</i></span>
			   </td>
			</tr>
		</table>
	</div>

		<div id="page-wrap" style="transform : rotate(90deg); ">
		<p id="header">TAX-INVOICE</p>

		<table style="width: 670px;">
			<tr>
				<td width="350px">
					<div id="logo">
						<img id="image" src="/MSaleERP/config/img/simplelogo.png"
							alt="logo" />
						 <br> <span><%=tag %></span>
					</div>
				</td>
				<td><div>
						 <%=orgAddress %>,
						Tal -<%=tal %>, <br>
						Dist -<%=dist %> . <br>
						Ph.No-<%=phoneNo %> 
					</div>
				</td>

			</tr>
			<tr>
				<td>
						Buyers Name:- <i><%=cust_name %></i>
				</td>
				<td rowspan="2">
					Invoice No:&nbsp;<%=invoice_no %>
				</td>
             </tr>
			<tr>
				<td>Address:- <i><%=cust_address %></i></td>
				
			</tr>
			<tr>
				<td>Mob.No:- <i><%=cust_mobno %></i></td>
				<td rowspan="2">Date:&nbsp;<%=sale_date %></td>
			</tr>
			<tr>
				<td>GSTIN / PAN:-<% if(!custgst.equals("null")){out.print(custgst);} %></td>
				
			</tr>
		</table>
		<table id="items">

			<tr>
				<th style="width: 25px;">Sr.No</th>
				<th>Description</th>
				<th style="width: 80px;">HSN/SAC Code</th>
				<th style="width: 20px;">Qty</th>
				<th style="width: 60px;">Rate</th>
				<th>Price</th>
			</tr>

			<tr class="item-row">
				<td align="center">1</td>
				<td>
					<div style="line-height: 1.5">
					Model No : &nbsp;&nbsp;&nbsp;&nbsp; <%=model_no %><br><br>
					IMEI No-1 : &nbsp;&nbsp;&nbsp;&nbsp; <%=imei_no %> <br><br> 
					IMEI No-2 : &nbsp;&nbsp;&nbsp;&nbsp; <% if(!imei_no2.equals("null")){out.print(imei_no2);} %> <br><br>
					Serial No :  &nbsp;&nbsp;&nbsp;&nbsp; <% if(!serial_no.equals("null")){out.print(serial_no);} %> <br><br>
					Battery No : &nbsp;&nbsp;&nbsp;&nbsp; <%=battery_no %><br><br>
					 Charger No : &nbsp;&nbsp;&nbsp;&nbsp; <%=charger_no %><br>
					</div>
				</td>
				<td><%=hsnsac_no %></td>
				<td align="center">1</td>
				<td id="rate"><%=paid_amount %></td>
				<td id="price1"></td>
			</tr>

			
			<tr>
				<td colspan="3" rowspan="4" class="blank" valign="top">
					<div style="font-size: 13px;">
						ONE YEAR Company Service Center Warranty.<br> # Handset
						warrenty as per Mfg. Company terms & condition.<br> # Good's
						once sold will not be taken back or exchange.<br> # Warrant
						avoid if it is Water/Physical damage.<br> <br>
						<b>GSTIN:-<%=gstin %></b><br/>
						<b>PAN:-<%=pan %></b><br/>
						<b>Place of Supply:-<%=place %></b><br/>
						<b>State Code:-<%=scode %></b>
					</div>
				</td>
				<td colspan="2" class="total-line">CGST 6.00%</td>
				<td class="total-value"><div id="cgst1"></div></td>
			</tr>
			<tr>
				<td colspan="2" class="total-line">SGST 6.00%</td>
				<td class="total-value" id="sgst1"></td>
			</tr>
			<tr>
				<td colspan="2" class="total-line">IGST 0.00%</td>
				<td class="total-value"><textarea id="paid">0.00</textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="total-line"><div id="roundoff1"></div></td>
				<td class="total-value"><div id="round1"></div></td>
			</tr>
			<tr>


				<td colspan="3" rowspan="2" class="blank"><span>(In
						Words)&nbsp;:-<i id="print_inwords1"></i>
				</span></td>
				<td colspan="2" class="total-line balance">Total Value</td>
				<td class="total-value balance"><div class="gTotal"
						id="totalamt1"></div></td>
			</tr>


		</table>
		<table>
			<tr>
				<td style="width: 800px; height: 80px;"><i style="font-size: 8px;">
				        "I/We here by certify that my/our
						registration certificate under the Maharashtra GST Act 2017, is in
						force on the date on which sale<br> of the goods specified in this Tax
						invoice is made by me/us and it shall be accounted for in the
						turnover of sales while filling of return<BR> and the due tax,if any
						payable on the sale has been paid or shall be paid."</i><br><span style="float: right;">For <%=orgName %></span><br> <br> <br>
					<i>Buyers Signature </i> <span style="float: right;"><i>Authorized Signature</i></span>
			   </td>
			</tr>
		</table>
	</div>
	</div>
</body>
</html>