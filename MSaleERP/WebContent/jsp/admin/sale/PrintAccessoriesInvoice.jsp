<%@page import="java.util.Iterator"%>
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
#print {
	margin: 0 auto;
	width: 750px;
	height: 600px;
}
#page-wrap {
	border: 1px solid;
	width: 800px;
	margin-top: 25px;
	margin-bottom: -20px;
	margin-left: -25px;
	padding: 1px;
}
table {
	border-collapse: collapse;
}

table td, table th {
	border: 1px solid black;
	padding: 1px;
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

#items {
	clear: both;
	width: 100%;
	margin: 2px 0 0 0;
	border: 1px solid black;
}

#items th {
	background: #eee;
}

#items tr.item-row td {
	vertical-align: top;
	height: 35px;
}

@page {
	size: auto;
	margin: 25mm, 25mm, 25mm, 25mm;
}
</style>

<title>GST Invoice</title>
</head>
<body onload="myFunction()">
	<%
		String invoice = request.getParameter("invoiceId");
		int totbox = Integer.parseInt(request.getParameter("totbox"));
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
		
		
		
		
		
		List details = data.getSaleData(invoice);
		int srno = 0;
		//List details = (List)request.getAttribute("printdetails");

		String invoice_no = "";
		String cust_name = "";
		String cust_address = "";
		String cust_mobno = "";
		String serial_no = "";
		String hsnsac_no = "";
		String sale_date = "";
		String custgst = "";
		String saletype = "";

		//Accessories
		String[] item = new String[totbox];
		String[] item_detail = new String[totbox];
		String[] item_qty = new String[totbox];
		String[] item_saleprice = new String[totbox];
		String[] gst = new String[totbox];
		if (details != null) {
			System.out.println("in Print Invoice.jsp" + details);

			//[[203, HIMANSHU, PUNE, 9687712856, 2017-08-03, null, , null, 2], [acc1, acc de 1, 11, 1000, acc2, acc de 2, 22, 200]]
			Iterator itr = details.iterator();
			List l1 = (List) details.get(0);
			List l2 = (List) details.get(1);

			System.out.print("******" + l1);
			System.out.print("******" + l2);

			//SELECT m.`intmobilesaleid`,c.`varcustname`, c.`varaddress`,c.`varcontactno`,m.`datesaledate`,m.`varserialno`,m.`varhhsnsacno`,c.`varcustgstin`,m.`varsaletype`
			invoice_no = l1.get(0).toString();
			cust_name = l1.get(1).toString();
			cust_address = l1.get(2).toString();
			cust_mobno = l1.get(3).toString();
			sale_date = l1.get(4).toString();
			serial_no = l1.get(5).toString();
			hsnsac_no = l1.get(6).toString();
			custgst = l1.get(7).toString();
			saletype = l1.get(8).toString();

			Iterator itr2 = l2.iterator();

			while (itr2.hasNext()) {
				item[srno] = itr2.next().toString();
				item_detail[srno] = itr2.next().toString();
				item_qty[srno] = itr2.next().toString();
				item_saleprice[srno] = itr2.next().toString();
				gst[srno] = itr2.next().toString();
				srno++;
			}
		}
	%>

	<div id="print">
		<div id="page-wrap">
			<p id="header">TAX-INVOICE</p>

			<table style="width: 800px;">
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
					<td>Buyers Name:- <i><%=cust_name%></i>
					</td>
					<td rowspan="2">Invoice No:&nbsp;<%=invoice_no%>
					</td>
				</tr>
				<tr>
					<td>Address:- <i><%=cust_address%></i></td>

				</tr>
				<tr>
					<td>Mob.No:- <i><%=cust_mobno%></i></td>
					<td rowspan="2">Date:&nbsp;<%=sale_date%></td>
				</tr>
				<tr>
					<td>GSTIN / PAN:-<%
						if (!custgst.equals("null")) {
							out.print(custgst);
						}
					%></td>

				</tr>
			</table>
			<table id="items" style="height: 330px;">
				<tr>
					<th rowspan="2" style="width: 15px;">No</th>
					<th rowspan="2">Material</th>
					<th rowspan="2">Detail</th>
					<th rowspan="2" style="width: 40px;">HSN Code</th>
					<th rowspan="2" style="width: 10px;">Qty</th>
					<th rowspan="2">Price</th>
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

				<tr class="item-row">
					<td align="center">1</td>
					<td><%=item[0]%></td>
					<td><%=item_detail[0]%></td>
					<td><%if(!hsnsac_no.equals("null")){out.print(hsnsac_no);}%></td>
					<td align="center"><%=item_qty[0]%></td>
					<td id="price1"><%=item_saleprice[0]%></td>
					<td id="cgst1"></td>
					<td id="cgstamount1"></td>
					<td id="sgst1"></td>
					<td id="sgstamount1"></td>
					<td id="txtval1"></td>
					
				</tr>
				<tr class="item-row">
					<td align="center">2</td>
					<td><% if(totbox >= 2){out.print(item[1]);} %></td>
					<td><% if(totbox >= 2){out.print(item_detail[1]);} %></td>
					<td><%if(!hsnsac_no.equals("null")){out.print(hsnsac_no);}%></td>
					<td align="center"><% if(totbox >= 2){out.print(item_qty[1]);} %></td>
					<td id="price2"><% if(totbox >= 2){out.print(item_saleprice[1]);} %></td>
					<td id="cgst2"></td>
					<td id="cgstamount2"></td>
					<td id="sgst2"></td>
					<td id="sgstamount2"></td>
					<td id="txtval2"></td>
					
				</tr>
				<tr class="item-row">
					<td align="center">3</td>
					<td><% if(totbox >= 3){out.print(item[2]);} %></td>
					<td><% if(totbox >= 3){out.print(item_detail[2]);} %></td>
					<td><%if(!hsnsac_no.equals("null")){out.print(hsnsac_no);}%></td>
					<td align="center"><% if(totbox >= 3){out.print(item_qty[2]);} %></td>
					<td id="price3"><% if(totbox >= 3){out.print(item_saleprice[2]);} %></td>
					<td id="cgst3"></td>
					<td id="cgstamount3"></td>
					<td id="sgst3"></td>
					<td id="sgstamount3"></td>
					<td id="txtval3"></td>
					
				</tr>
				<tr>
					<th colspan="5" style="text-align: right;">Total : </th>  
					<th id="price_total"></th>
					<th>-</th>
					<th id="price_cgst"></th>
					<th>-</th>
					<th id="price_sgst"></th> 
					<th id="price_txt"></th>
				</tr>
				<tr>
					<td colspan="8" rowspan="5" class="blank" valign="top">
						<div style="font-size: 13px;">
							ONE YEAR Company Service Center Warranty.<br> # Handset
							warrenty as per Mfg. Company terms & condition.<br> # Good's
							once sold will not be taken back or exchange.<br> # Warrant
							avoid if	 it is Water/Physical damage.<br> <br> 
							<b>GSTIN:-<%=gstin %></b><br/>
						<b>PAN:-<%=pan %></b><br/>
						<b>Place of Supply:-<%=place %></b><br/>
						<b>State Code:-<%=scode %></b>

						</div>
					</td>
					<td colspan="2">Taxable Value</td>
					<td id="taxable"></td>
				</tr>
				<tr>
					<td colspan="2">CGST</td>
					<td id="cgst"></td>
				</tr>
				<tr>
					<td colspan="2">SGST</td>
					<td id="sgst"></td>
				</tr>
				<tr>
					<td colspan="2">IGST</td>
					<td>0.00</td>
				</tr>
				<tr>
					<td colspan="2" id="roundoff"></td>
					<td id="round"></td>
				</tr>
				<tr>


					<th colspan="8" style="text-align: left;"><span>(In
							Words)&nbsp;:-<i id="print_inwords"></i>
					</span></th>
					<th colspan="2">Total Value</th>
					<th><div class="gTotal"
							id="totalamt"></div></th>
				</tr>


			</table>
			<table>
				<tr>
					<td style="width: 800px; height: 80px;"><i
						style="font-size: 8px;"> "I/We here by certify that my/our
							registration certificate under the Maharashtra GST Act 2017, is
							in force on the date on which sale<br> of the goods
							specified in this Tax invoice is made by me/us and it shall be
							accounted for in the turnover of sales while filling of return<BR>
							and the due tax,if any payable on the sale has been paid or shall
							be paid."
					</i><br>
					<span style="float: right;">For <%=orgName %></span><br> <br> <br> <i>Buyers Signature </i> <span
						style="float: right;"><i>Authorized Signature</i></span></td>
				</tr>
			</table>
		</div>
		
<!-- 		New Table -->
<br>

	<div id="page-wrap">
			<p id="header">TAX-INVOICE</p>

			<table style="width: 800px;">
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
					<td>Buyers Name:- <i><%=cust_name%></i>
					</td>
					<td rowspan="2">Invoice No:&nbsp;<%=invoice_no%>
					</td>
				</tr>
				<tr>
					<td>Address:- <i><%=cust_address%></i></td>

				</tr>
				<tr>
					<td>Mob.No:- <i><%=cust_mobno%></i></td>
					<td rowspan="2">Date:&nbsp;<%=sale_date%></td>
				</tr>
				<tr>
					<td>GSTIN / PAN:-<%
						if (!custgst.equals("null")) {
							out.print(custgst);
						}
					%></td>

				</tr>
			</table>
			<table id="items" style="height: 330px;">
				<tr>
					<th rowspan="2" style="width: 15px;">No</th>
					<th rowspan="2">Material</th>
					<th rowspan="2">Detail</th>
					<th rowspan="2" style="width: 40px;">HSN Code</th>
					<th rowspan="2" style="width: 10px;">Qty</th>
					<th rowspan="2">Price</th>
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

				<tr class="item-row">
					<td align="center">1</td>
					<td><%=item[0]%></td>
					<td><%=item_detail[0]%></td>
					<td><%if(!hsnsac_no.equals("null")){out.print(hsnsac_no);}%></td>
					<td align="center"><%=item_qty[0]%></td>
					<td id="price11"><%=item_saleprice[0]%></td>
					<td id="cgst11"></td>
					<td id="cgstamount11"></td>
					<td id="sgst11"></td>
					<td id="sgstamount11"></td>
					<td id="txtval11"></td>
					
				</tr>
				<tr class="item-row">
					<td align="center">2</td>
					<td><% if(totbox >= 2){out.print(item[1]);} %></td>
					<td><% if(totbox >= 2){out.print(item_detail[1]);} %></td>
					<td><%if(!hsnsac_no.equals("null")){out.print(hsnsac_no);}%></td>
					<td align="center"><% if(totbox >= 2){out.print(item_qty[1]);} %></td>
					<td id="price12"><% if(totbox >= 2){out.print(item_saleprice[1]);} %></td>
					<td id="cgst12"></td>
					<td id="cgstamount12"></td>
					<td id="sgst12"></td>
					<td id="sgstamount12"></td>
					<td id="txtval12"></td>
					
				</tr>
				<tr class="item-row">
					<td align="center">3</td>
					<td><% if(totbox >= 3){out.print(item[2]);} %></td>
					<td><% if(totbox >= 3){out.print(item_detail[2]);} %></td>
					<td><%if(!hsnsac_no.equals("null")){out.print(hsnsac_no);}%></td>
					<td align="center"><% if(totbox >= 3){out.print(item_qty[2]);} %></td>
					<td id="price13"><% if(totbox >= 3){out.print(item_saleprice[2]);} %></td>
					<td id="cgst13"></td>
					<td id="cgstamount13"></td>
					<td id="sgst13"></td>
					<td id="sgstamount13"></td>
					<td id="txtval13"></td>
					
				</tr>
				<tr>
					<th colspan="5" style="text-align: right;">Total : </th>  
					<th id="price_total1"></th>
					<th>-</th>
					<th id="price_cgst1"></th>
					<th>-</th>
					<th id="price_sgst1"></th> 
					<th id="price_txt1"></th>
				</tr>
				<tr>
					<td colspan="8" rowspan="5" class="blank" valign="top">
						<div style="font-size: 13px;">
							ONE YEAR Company Service Center Warranty.<br> # Handset
							warrenty as per Mfg. Company terms & condition.<br> # Good's
							once sold will not be taken back or exchange.<br> # Warrant
							avoid if	 it is Water/Physical damage.<br> <br> 
							<b>GSTIN:-<%=gstin %></b><br/>
						<b>PAN:-<%=pan %></b><br/>
						<b>Place of Supply:-<%=place %></b><br/>
						<b>State Code:-<%=scode %></b>

						</div>
					</td>
					<td colspan="2">Taxable Value</td>
					<td id="taxable1"></td>
				</tr>
				<tr>
					<td colspan="2">CGST</td>
					<td id="cgst01"></td>
				</tr>
				<tr>
					<td colspan="2">SGST</td>
					<td id="sgst01"></td>
				</tr>
				<tr>
					<td colspan="2">IGST</td>
					<td>0.00</td>
				</tr>
				<tr>
					<td colspan="2" id="roundoff1"></td>
					<td id="round1"></td>
				</tr>
				<tr>


					<th colspan="8" style="text-align: left;"><span>(In
							Words)&nbsp;:-<i id="print_inwords1"></i>
					</span></th>
					<th colspan="2">Total Value</th>
					<th><div class="gTotal"
							id="totalamt1"></div></th>
				</tr>


			</table>
			<table>
				<tr>
					<td style="width: 800px; height: 80px;"><i
						style="font-size: 8px;"> "I/We here by certify that my/our
							registration certificate under the Maharashtra GST Act 2017, is
							in force on the date on which sale<br> of the goods
							specified in this Tax invoice is made by me/us and it shall be
							accounted for in the turnover of sales while filling of return<BR>
							and the due tax,if any payable on the sale has been paid or shall
							be paid."
					</i><br>
					<span style="float: right;">For <%=orgName %></span><br> <br> <br> <i>Buyers Signature </i> <span
						style="float: right;"><i>Authorized Signature</i></span></td>
				</tr>
			</table>
		</div>

	</div>
	<input type="hidden" id="gst1" value="<%=gst[0] %>">
	<input type="hidden" id="gst2" value="<% if(totbox >= 2){out.print(gst[1]);} %>">
	<input type="hidden" id="gst3" value="<% if(totbox >= 3){out.print(gst[2]);} %>">
		
<script type="text/javascript">

function myFunction() {

		var lastChar = <%=Integer.parseInt(request.getParameter("totbox"))%>;
		
		for(var i=1; i<=lastChar; i++){
			var b = document.getElementById("price"+i).innerText;
			var getgst=document.getElementById("gst"+i).value;
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
	
			totaltaxable_amt = Math.round(totaltaxable_amt * 100)/100;
			
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
			
			document.getElementById("cgst"+i).innerHTML=newgst;
			document.getElementById("sgst"+i).innerHTML=newgst;
			document.getElementById("cgstamount"+i).innerHTML=cgst;
			document.getElementById("sgstamount"+i).innerHTML=sgst;
			document.getElementById("txtval"+i).innerHTML=totaltaxable_amt;
			
			document.getElementById("cgst1"+i).innerHTML=newgst;
			document.getElementById("sgst1"+i).innerHTML=newgst;
			document.getElementById("cgstamount1"+i).innerHTML=cgst;
			document.getElementById("sgstamount1"+i).innerHTML=sgst;
			document.getElementById("txtval1"+i).innerHTML=totaltaxable_amt;
	
			totalbill();
		}
	}
	
	function totalbill() {
		var totbox=<%=Integer.parseInt(request.getParameter("totbox"))%>;
		var pricegst=0;
		var pricecgst=0;
		var pricesgst=0;
		var pricetxt=0;
		
		for (var i = 1; i <= totbox; i++) {
			pricegst=pricegst+ +document.getElementById("price"+i).innerText;
			pricecgst=pricecgst+ +document.getElementById("cgstamount"+i).innerText;
			pricesgst=pricesgst+ +document.getElementById("sgstamount"+i).innerText;
			pricetxt=pricetxt+ +document.getElementById("txtval"+i).innerText;
			
		}
		
		document.getElementById("price_total").innerHTML = pricegst;
		document.getElementById("price_cgst").innerHTML = Math.round(pricecgst * 100)/100;
		document.getElementById("price_sgst").innerHTML = Math.round(pricesgst * 100)/100;
		document.getElementById("price_txt").innerHTML = Math.round(pricetxt * 100)/100;
		
		document.getElementById("price_total1").innerHTML = pricegst;
		document.getElementById("price_cgst1").innerHTML = Math.round(pricecgst * 100)/100;
		document.getElementById("price_sgst1").innerHTML = Math.round(pricesgst * 100)/100;
		document.getElementById("price_txt1").innerHTML = Math.round(pricetxt * 100)/100;
		
		document.getElementById("totalamt").innerHTML = pricegst;
		document.getElementById("cgst").innerHTML = Math.round(pricecgst * 100)/100;
		document.getElementById("sgst").innerHTML = Math.round(pricesgst * 100)/100;
 		document.getElementById("taxable").innerHTML = Math.round(pricetxt * 100)/100;
 		
 		document.getElementById("totalamt1").innerHTML = pricegst;
		document.getElementById("cgst01").innerHTML = Math.round(pricecgst * 100)/100;
		document.getElementById("sgst01").innerHTML = Math.round(pricesgst * 100)/100;
 		document.getElementById("taxable1").innerHTML = Math.round(pricetxt * 100)/100;
 		
 		var temp_totalvalue=pricetxt+pricesgst+pricecgst;
 		 var round=(pricegst-temp_totalvalue).toFixed(2);
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

		inWords();
	}
	

	
	

	function inWords() {

		var str = document.getElementById("totalamt").innerHTML;
		var splt = str.split("");
		var rev = splt.reverse();
		var once = [ 'Zero', ' One', ' Two', ' Three', ' Four', ' Five',
				' Six', ' Seven', ' Eight', ' Nine' ];
		var twos = [ 'Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen',
				' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen' ];
		var tens = [ '', 'Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty',
				' Sixty', ' Seventy', ' Eighty', ' Ninety' ];

		numLength = rev.length;
		var word = new Array();
		var j = 0;

		for (i = 0; i < numLength; i++) {
			switch (i) {

			case 0:
				if ((rev[i] == 0) || (rev[i + 1] == 1)) {
					word[j] = '';
				} else {
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
				} else if ((rev[i - 1] == 0) || (rev[i - 2] == 0)) {
					word[j] = once[rev[i]] + " Hundred ";
				} else {
					word[j] = once[rev[i]] + " Hundred and";
				}
				break;

			case 3:
				if (rev[i] == 0 || rev[i + 1] == 1) {
					word[j] = '';
				} else {
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
				} else {
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
				} else {
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

			default:
				break;
			}
			j++;
		}

		function aboveTens() {
			if (rev[i] == 0) {
				word[j] = '';
			} else if (rev[i] == 1) {
				word[j] = twos[rev[i - 1]];
			} else {
				word[j] = tens[rev[i]];
			}
		}

		word.reverse();
		var finalOutput = '';
		for (i = 0; i < numLength; i++) {
			finalOutput = finalOutput + word[i];
		}
		var print = finalOutput + " Only";
		document.getElementById("print_inwords").innerHTML = print;
		document.getElementById("print_inwords1").innerHTML = print;
	}
</script>
	
	</body>
</html>