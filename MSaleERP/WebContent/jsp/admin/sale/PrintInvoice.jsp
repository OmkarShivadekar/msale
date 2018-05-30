<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="utility.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<style>
body
{
zoom:0.85;}

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

</style>

<script type="text/javascript" src="./config/js/numtoword.js"></script>

 <script type="text/javascript">
   function myFunction() {
	   var x =  document.getElementById("price").innerHTML;
	    console.log('x',x)
	    x = parseInt(x);
	    var a= x*0.06;
	    var b = x*0.06;
	    document.getElementById("sgst").innerHTML=a;
	    document.getElementById("cgst").innerHTML=b;
	    
	    document.getElementById("sgst1").innerHTML=a;
	    document.getElementById("cgst1").innerHTML=b;
	    
	    document.getElementById("gross").innerHTML=x-(a+b);
	    document.getElementById("totalamt").innerHTML=x;
	   
	    document.getElementById("gross1").innerHTML=x-(a+b);
	    document.getElementById("totalamt1").innerHTML=x;
	  //  var str ="Ten Thousand Five Hundread Only";
	   // document.getElementById("inwords").innerHTML=str;
	    
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
#hiderow,
.delete
 {
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

<body onload="myFunction()" >
<%  
	List details = (List)request.getAttribute("printdetails");

	String invoice_no=""; 
	String cust_name=""; 
	String cust_address=""; 
	String cust_mobno=""; 
	String model_no=""; 
	String imei_no=""; 
	String battery_no=""; 
	String charger_no="";
	String paid_amount="";
	String sale_date="";

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
    	battery_no = details.get(7).toString();
    	charger_no = details.get(8).toString();
    	paid_amount = details.get(9).toString();
    	
    	
    }

%>


    <div id="page-wrap">CUSTOMER'S COPY
	
		<p id="header">INVOICE</p>
		
		<table style="width: 700px;">
		  <tr>
		   <td>
		   	     <div id="logo">
             	     <div id="logohelp">
                	 	<input id="imageloc" type="text" size="50" value="" /><br />
                    		 (max width: 540px, max height: 100px)
                	</div>
                   			  <img id="image" src= "/MSaleERP/config/img/simplelogo.png" alt="logo" />
                   			  
                   			  <br>
                   			  <span>Pro. Fulchand Dhwale : 7020619986</span>
              	 </div>
		   	</td>
		    <td>
		   	
		   	<div>
            				  M.G Road, Opp. Vaparimal, Uruli Kanchan,
            				  Tal - Havali,
            				  <br> Dist - Pune-412202.
					          <br>Ph.No- 9765669467
			</div>
		   	
		   	</td>
		   	
		  </tr>
		  <tr>
		    <td>
		      
		      <div id="cust_address">

            
            <label style="font-weight:bold; font-size:16px;">Customer Details :</label>
            <br>
            Name:-  <i><%=cust_name %></i>
            <br>
            Address:- <i><%=cust_address %></i>
            <br>
            Mob.No:- <i><%=cust_mobno %> </i>
            <i></i>
                        		
		</div>
		    
		    
		    </td>
		    <td>
		    
		    <div id="invoice_details">
         <table id="meta">
                <tr>
                    <td class="meta-head">Invoice No</td>
                    <td><%=invoice_no %></td>
                </tr>
                <tr>

                    <td class="meta-head">Date</td>
                    <td><%=sale_date %></td>
                </tr>
         </table>
	    </div>
		    </td>
		  </tr>
		
		</table>
		<table id="items">

                <tr>
                    <th style="width:50px;">Sr.No</th>
                    <th>Description</th>
                    <th style="width:30px;">Quantity</th>
                    <th style="width:80px;">Rate</th>
                    <th >Price</th>
                </tr>

                <tr class="item-row">
                    <td align="center">1</td>
                    <td>
                         Model No   : &nbsp;&nbsp;&nbsp;&nbsp;  <%=model_no %><br>
                         IMEI  No   : &nbsp;&nbsp;&nbsp;&nbsp;  <%=imei_no %> <br>
                         Battery No : &nbsp;&nbsp;&nbsp;&nbsp;  <%=battery_no %><br>
                         Charger No : &nbsp;&nbsp;&nbsp;&nbsp;  <%=charger_no %><br>
                     </td>
                    <td align="center">1</td>
                    <td><%=paid_amount %></td>
                    <td id="price"><%=paid_amount %></td>
                </tr>
                
                <tr>
                    <td colspan="2" rowspan="4" class="blank" valign="top">
                    	<div style="font-size: 13px;">
                    	    ONE YEAR Company Service Center Warranty.<br>
                    	    # Handset warrenty as per Mfg. Company terms & condition.<br>
                    	    # Good's once sold will not be taken back or exchange.<br>
                    	    # Warrant avoid if it is Water/Physical damage.<br>
                    	    <br>
                    	    
							<b>GSTIN:-27ATZPD6019LIZ2</b>
							
						</div>
                    </td>
                    <td colspan="2" class="total-line">Gross Amount</td>
                    <td class="total-value"><div id="gross"></div></td>
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
                    
                  
                    <td colspan="2" rowspan="2" class="blank" ><span>(In Word)&nbsp;:-<i id="print_inwords"></i></span></td>
                    <td colspan="2" class="total-line balance">Grand Total</td>
                    <td class="total-value balance"><div class="gTotal" id="totalamt"></div></td>
                </tr>
                
               
            </table>
            <table>
             <tr>
                <td style="width: 800px; height: 60px;">
                    <i style="font-size: 8px;">"I/We here by certify that my/our registration certificate under the Maharashtra GST Act 2017, is in force on the date on which sale of the goods specified in this Tax invoice is made by me/us and it shall be accounted for in the turnover of sales while filling of return and the due tax, if any payable on the sale has been paid or shall be paid."</i>
                	<br>
                	<br>	
                	<i>Customer Signature </i> <span style="float:right;"><i>For Suraj Electricals & Mobile Shopee</i></span> 
                </td>
             </tr>
            </table>
        </div>
        <hr>
        <hr>
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
                   			  <img id="image" src="/MSaleERP/config/img/simplelogo.png" alt="logo" />
                   			  
                   			  <br>
                   			  <span>Pro. Fulchand Dhwale : 7020619986</span>
              	 </div>
		   	</td>
		    <td>
		   	
		   	<div>
            				  M.G Road, Opp. Vaparimal, Uruli Kanchan,
            				  Tal - Havali,
            				  <br> Dist - Pune-412202.
					          <br>Ph.No- 9765669467
			</div>
		   	
		   	</td>
		   	
		  </tr>
		  <tr>
		    <td>
		      
		      <div id="cust_address">

            
            <label style="font-weight:bold; font-size:16px;">Customer Details :</label>
            <br>
            Name:-  <i><%=cust_name %></i>
            <br>
            Address:- <i><%=cust_address %></i>
            <br>
            Mob.No:- <i><%=cust_mobno %> </i>
            <i></i>
                        		
		</div>
		    
		    
		    </td>
		    <td>
		    
		    <div id="invoice_details">
         <table id="meta">
                <tr>
                    <td class="meta-head">Invoice No</td>
                    <td><%=invoice_no %></td>
                </tr>
                <tr>

                    <td class="meta-head">Date</td>
                    <td><%=sale_date %></td>
                </tr>
         </table>
	    </div>
		    </td>
		  </tr>
		
		</table>
		<table id="items">

                <tr>
                    <th style="width:50px;">Sr.No</th>
                    <th>Description</th>
                    <th style="width:30px;">Quantity</th>
                    <th style="width:80px;">Rate</th>
                    <th >Price</th>
                </tr>

                <tr class="item-row">
                    <td align="center">1</td>
                    <td>
                         Model No   : &nbsp;&nbsp;&nbsp;&nbsp;  <%=model_no %><br>
                         IMEI  No   : &nbsp;&nbsp;&nbsp;&nbsp;  <%=imei_no %> <br>
                         Battery No : &nbsp;&nbsp;&nbsp;&nbsp;  <%=battery_no %><br>
                         Charger No : &nbsp;&nbsp;&nbsp;&nbsp;  <%=charger_no %><br>
                     </td>
                    <td align="center">1</td>
                    <td><%=paid_amount %></td>
                    <td id="price"><%=paid_amount %></td>
                </tr>
                
                <tr>
                    <td colspan="2" rowspan="4" class="blank" valign="top">
                    	<div style="font-size: 13px;">
                    	    ONE YEAR Company Service Center Warranty.<br>
                    	    # Handset warrenty as per Mfg. Company terms & condition.<br>
                    	    # Good's once sold will not be taken back or exchange.<br>
                    	    # Warrant avoid if it is Water/Physical damage.<br>
                    	    <br>
                    	    
							<b>GSTIN:-27ATZPD6019LIZ2</b>
							
						</div>
                    </td>
                    <td colspan="2" class="total-line">Gross Amount</td>
                    <td class="total-value"><div id="gross1"></div></td>
                </tr>
                <tr>

                    
                    <td colspan="2" class="total-line">CGST 6.00 %</td>
                    <td class="total-value"><div id="cgst1"></div></td>
                </tr>
                <tr>
                    <td colspan="2" class="total-line">SGST 6.00 %</td>
                    <td class="total-value" id="sgst1"></td>
                </tr>
                <tr>
                     <td colspan="2" class="total-line">IGST 0.00 %</td>
                    <td class="total-value"><textarea id="paid">0.00</textarea></td>
                </tr>
                <tr>
                    
                  
                    <td colspan="2" rowspan="2" class="blank" ><span>(In Word)&nbsp;:-<i id="print_inwords1"></i></span></td>
                    <td colspan="2" class="total-line balance">Grand Total</td>
                    <td class="total-value balance"><div class="gTotal" id="totalamt1"></div></td>
                </tr>
                
               
            </table>
            <table>
             <tr>
                <td style="width: 800px; height: 60px;">
                    <i style="font-size: 8px;">"I/We here by certify that my/our registration certificate under the Maharashtra GST Act 2017, is in force on the date on which sale of the goods specified in this Tax invoice is made by me/us and it shall be accounted for in the turnover of sales while filling of return and the due tax, if any payable on the sale has been paid or shall be paid."</i>
                	<br>
                	<br>	
                	<i>Customer Signature </i> <span style="float:right;"><i>For Suraj Electricals & Mobile Shopee</i></span> 
                </td>
             </tr>
            </table>
        </div>
    </body>
</html>