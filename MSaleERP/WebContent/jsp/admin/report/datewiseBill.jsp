<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utility.RequireData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Datewise Bill</title>
<style type="text/css">
body
{
zoom:0.73;}

{ margin: 0; padding: 0; }
#page-wrap { border:1px solid; width: 700px;  margin: 0 auto; padding:1px; }

textarea { border: 0; font: 14px Georgia, Serif; overflow: hidden; resize: none; }
table { border-collapse: collapse; }
table td, table th { border: 1px solid black; padding: 5px; }

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
    padding: 0px 0px;}

#address { width: 260px; height: 90px; float: right; }
#customer { overflow: hidden; }

#logo { text-align: right; float: left; position: relative; border: 1px solid #fff; max-width: 540px; max-height: 100px; overflow: hidden; }
#logo:hover, #logo.edit { border: 1px solid #000; margin-top: 0px; max-height: 125px; }
#logoctr { display: none; }
#logo:hover #logoctr, #logo.edit #logoctr { display: block; text-align: right; line-height: 25px; background: #eee; padding: 0 5px; }
#logohelp { text-align: left; display: none; font-style: italic; padding: 10px 5px;}
#logohelp input { margin-bottom: 5px; }
.edit #logohelp { display: block; }
.edit #save-logo, .edit #cancel-logo { display: inline; }
.edit #image, #save-logo, #cancel-logo, .edit #change-logo, .edit #delete-logo { display: none; }
#customer-title { height:55px; font-size: 15px; float: left; }

#meta { margin-top: 1px; width: 300px; float: right; }
#meta td { text-align: right;  }
#meta td.meta-head { text-align: left; background: #eee; }
#meta td textarea { width: 100%; height: 20px; text-align: right; }


#items { clear: both; width: 100%; margin: 2px 0 0 0; border: 1px solid black; }
#items th { background: #eee; }
#items textarea { width: 80px; height: 30px; }
#items tr.item-row td { vertical-align: top; }
#items td.description { width: 300px; }
#items td.item-name {  }
#items td.description textarea, #items td.item-name textarea { width: 100%; }
#items td.total-line { text-align: right; }
#items td.total-value { border-left: 0; padding: 8px; }
#items td.total-value textarea { height: 12px; background: none; }
#items td.balance { background: #eee; }
#items td.blank { text-align: left; }


#terms { text-align: center; margin: 20px 0 0 0; }
#terms h5 { text-transform: uppercase; font: 13px Helvetica, Sans-Serif; letter-spacing: 10px; border-bottom: 1px solid black; padding: 0 0 8px 0; margin: 0 0 8px 0; }
#terms textarea { width: 100%; text-align: center;}

textarea:hover, textarea:focus, #items td.total-value textarea:hover, #items td.total-value textarea:focus, .delete:hover { background-color:#EEFF88; }

.delete-wpr { position: relative; }
.delete { display: block; color: #000; text-decoration: none; position: absolute; background: #EEEEEE; font-weight: bold; padding: 0px 3px; border: 1px solid; top: -6px; left: -22px; font-family: Verdana; font-size: 12px; }
@page
{
size:auto;
margin: 25mm,0,25mm,25mm;
}
#hiderow,
.delete
 {
  display: none;
 }

</style>
</head>
<body onload="billPrint()">
<%int lsize=(int)request.getAttribute("listSize");%>
<input type="hidden" id="listSize" value="<%=lsize%>">
<%
			String toDate=(String)request.getAttribute("toDate");
			String fromDate=(String)request.getAttribute("fromDate");
			RequireData rd=new RequireData();
			List reportData=rd.getReportData(fromDate,toDate);
			Iterator itr=reportData.iterator();
			while(itr.hasNext())
			{
			
			Object invoice_no=itr.next(); 
			Object cust_name=itr.next(); 
			Object cust_address=itr.next(); 
			Object cust_mobno=itr.next(); 
			Object sale_date=itr.next(); 
			Object model_no=itr.next(); 
			Object imei_no=itr.next(); 
			Object battery_no=itr.next();
			Object charger_no=itr.next();
			Object paid_amount=itr.next();
			Object custgst=itr.next();
			Object custdis=itr.next();
			
/* 			if(reportData!= null)
		    {
				invoice_no = reportData.get(0).toString();
		    	cust_name = reportData.get(1).toString();
		    	cust_address = reportData.get(2).toString();
		    	cust_mobno = reportData.get(3).toString();
		    	sale_date = reportData.get(4).toString();
		    	model_no = reportData.get(5).toString();
		    	imei_no = reportData.get(6).toString();
		    	battery_no = reportData.get(7).toString();
		    	charger_no = reportData.get(8).toString();
		    	paid_amount = reportData.get(9).toString();
		    	custgst=reportData.get(10).toString();
		    	custdis=reportData.get(11).toString();
 
		    } */
		    	
			
%>
<%-- <% 		String toDate=(String)request.getAttribute("toDate");
		String fromDate=(String)request.getAttribute("fromDate");
		RequireData rd=new RequireData();
		List reportData=rd.getReportData(fromDate,toDate);
		Iterator itr=reportData.iterator();
		while(itr.hasNext())
		{
			
		
		
%> --%>

<div id="duplicater" >
	<!-- <input id="printpagebutton" type="button" value="Print this page" onclick="printpage()"/>
 -->
	<div id="page-wrap">
		<p id="header">INVOICE</p>

		<table style="width: 700px;">
			<tr>
				<td>
					<div id="logo">
						<div id="logohelp">
							<input id="imageloc" type="text" size="50" value="" /><br />
							(max width: 540px, max height: 100px)
						</div>
						<img id="image" src="/MSaleERP/config/img/simplelogo.png"
							alt="logo" /> <br> <span>Pro. Fulchand Dhwale :
							7020619986</span>
					</div>
				</td>
				<td><div>
						M.G Road, Opp. Vaparimal, Uruli Kanchan, Tal - Havali, <br>
						Dist - Pune-412202. <br>Ph.No- 9765669467
					</div>
				</td>

			</tr>
			<tr>
				<td>
						Name:- <i><%=cust_name %></i>
				</td>
				<td rowspan="4">
					<div id="invoice_details">
         <table id="meta">
                <tr>
                    <td class="meta-head">Invoice No</td>
                    <td><%=invoice_no%></td>
                </tr>
                <tr>

                    <td class="meta-head">Date</td>
                    <td><%=sale_date%></td>
                </tr>
         </table>
	    </div>
				</td>
			</tr>
			<tr>
				<td>Address:- <i><%=cust_address%></i></td>
				
			</tr>
			<tr>
				<td>Mob.No:- <i><%=cust_mobno%></i></td>
				
			</tr>
			<tr>
				<td>GSTIN:-<% if(!custgst.equals("0")){out.print(custgst);} %></td>
				
			</tr>
		</table>
		<table id="items">

			<tr>
				<th style="width: 25px;">Sr.No</th>
				<th>Description</th>
				<th style="width: 100px;">HSN/SAC Code</th>
				<th style="width: 20px;">Qty</th>
				<th style="width: 70px;">Rate</th>
				<th>Price</th>
			</tr>

			<tr class="item-row">
				<td align="center">1</td>
				<td><div style="line-height: 1.5">
					Model No : &nbsp;&nbsp;&nbsp;&nbsp; <%=model_no%><br>
					IMEI No : &nbsp;&nbsp;&nbsp;&nbsp; <%=imei_no%> <br> Battery
					No : &nbsp;&nbsp;&nbsp;&nbsp; <%=battery_no%><br> Charger No
					: &nbsp;&nbsp;&nbsp;&nbsp; <%=charger_no%><br>
					</div>
				</td>
				<td></td>
				<td align="center">1</td>
				<td><%=paid_amount%></td>
				<td id="price"><%=paid_amount%></td>
			</tr>

			
			<tr>
				<td colspan="3" rowspan="5" class="blank" valign="top">
					<div style="font-size: 13px;">
						ONE YEAR Company Service Center Warranty.<br> # Handset
						warrenty as per Mfg. Company terms & condition.<br> # Good's
						once sold will not be taken back or exchange.<br> # Warrant
						avoid if it is Water/Physical damage.<br> <br>
						<b>GSTIN:-27ATZPD6019LIZ2</b><br/>
						<b>PAN:-</b><br/>
						<b>Place of Supply:-Uralikanch,Pune</b><br/>
						<b>State Code:-27</b>

					</div>
				</td>
				<td colspan="2" class="total-line">Discount</td>
				<td class="total-value"><div id="discount"><%  if(!custdis.equals("0")){out.print(custdis);}  %></div></td>
			</tr>
			<tr>
				<td colspan="2" class="total-line">Taxable Value</td>
				<td class="total-value"><div id="text"></div></td>
			</tr>
			<tr>
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


				<td colspan="3" rowspan="2" class="blank"><span>(In
						Word)&nbsp;:-<i id="print_inwords"></i>
				</span></td>
				<td colspan="2" class="total-line balance">Total Value</td>
				<td class="total-value balance"><div class="gTotal"
						id="totalamt"></div></td>
			</tr>


		</table>
		<table>
			<tr>
				<td style="width: 800px; height: 60px;"><i
					style="font-size: 8px;">"I/We here by certify that my/our
						registration certificate under the Maharashtra GST Act 2017, is in
						force on the date on which sale of the goods specified in this Tax
						invoice is made by me/us and it shall be accounted for in the
						turnover of sales while filling of return and the due tax, if any
						payable on the sale has been paid or shall be paid."</i> <br> <br>
					<i>Customer Signature </i> <span style="float: right;"><i>Authorized Signature</i></span></td>
			</tr>
		</table>
	</div>
	<hr>
	<hr>
</div>

       <%} %> 

<script type="text/javascript">
var i = 0;
var original = document.getElementById('duplicater');

//to duplicate div
/* function duplicate() {
	//alert('hello');
     var clone = original.cloneNode(true); // "deep" clone
    clone.id = "duplicater" + ++i;
    // or clone.id = ""; if the divs don't need an ID
    original.parentNode.appendChild(clone); 
}

//get list size
function billPrint()
{
	var lsize=document.getElementById("listSize").value;
	//alert(lsize);
	for(var i=2;i<=lsize;i++)
	{
		duplicate();
	}
} */

function printpage() {
	var printButton = document.getElementById("printpagebutton");
    printButton.style.visibility = 'hidden';
    window.print()
    printButton.style.visibility = 'visible';
}

</script>
</body>
</html>