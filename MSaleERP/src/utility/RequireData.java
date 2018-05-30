package utility;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import dao.General.GenericDAO;

public class RequireData 
{
	GenericDAO gd = new GenericDAO();
	
	
	public boolean checkUser()
	{
		String check="SELECT * FROM `user_master` WHERE introll=1";
		if(gd.getData(check).isEmpty())
		{
			return false;
		}
		else
			return true;
		
	}
	
	public String OrgName() {
		String name ="";
		String query="SELECT `org_name` FROM `organization_details_master` WHERE `organization_id`=1";
		List l =gd.getData(query);
		if(!l.isEmpty())
		{
			name = l.get(0).toString();
		}
		return name;
	}
	public List getOrgInvoiceDetails()
	{
		String query="SELECT `invoice_header`, `tag`, `address`, `tal`, `dist`, `phone_no`, `pan`, `gstin`,"
				+ " `place`, `scode` FROM `organization_invoice` WHERE `id`=1";
        List demoList3=gd.getData(query);
         return demoList3;
		
	}

	
	public String macAddress() throws UnknownHostException, SocketException
	{
		InetAddress ip;
		ip = InetAddress.getLocalHost();
		System.out.println("Current IP address : " + ip.getHostAddress());

		NetworkInterface network = NetworkInterface.getByInetAddress(ip);

		byte[] mac = network.getHardwareAddress();

		System.out.print("Current MAC address : ");

		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < mac.length; i++) {
			sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
		}
		String MACAddress=sb.toString();
		String IpAddress=ip.getHostAddress();
		return MACAddress;
	}
	public boolean takeBackup() throws IOException
	{
		new File("D:\\Msale_Backup").mkdir();
		Process exec = Runtime.getRuntime().exec(new String[]{"cmd.exe","/c","C:\\Program Files\\MySQL"
				+ "\\MySQL Server 5.6\\bin\\mysqldump -uroot -proot > D:\\Msale_Backup\\msale.sql;"});
		System.out.println("successfull");
		return true;
	}
	
	public int dummyinvoiceid() {
		String query="SELECT MAX(dummyid) FROM dummy";
		List mobilesaleid = gd.getData(query);
		int id=Integer.parseInt(mobilesaleid.get(0).toString());
		id++;
		return id;
	}
	public List getDummySaleData(String invoiceId){
		String query="SELECT * FROM `dummy` WHERE dummy.dummyid="+invoiceId;
		List InvoicePrint = gd.getData(query);
		return InvoicePrint;
	}
	
	public List getColor()
	{
		 String query="SELECT intcolorid, varcolorname FROM `color_master`;";
		List colorlist = gd.getData(query);
		return colorlist;
	}
	
	public List getColorName()
	{
		String query="SELECT intcolorid, varcolorname FROM `color_master` order by intcolorid desc;";
		List colorlist = gd.getData(query);
		return colorlist;
	}
	
	public List getColorRowData(int id)
	{
		String query="SELECT intcolorid, varcolorname FROM `color_master` where intcolorid="+id+";";
		List colorlist = gd.getData(query);
		return colorlist;
	}
	
	public List getUpdateData()
	{
		String query="SELECT intcolorid, varcolorname FROM `color_master`;";
		List colorlist = gd.getData(query);
		return colorlist;
	}
	
	public List getModel()
	{
		String query="SELECT `varmodel` FROM `model_details_master`";
		List getmodel = gd.getData(query);
		return getmodel;
	}
	
	public String getModel1(String modelid)
	{
		String modelName="";
		String query="SELECT `aliasnamemodel` FROM `model_details_master` where intmodelid="+modelid;
		List getmodel = gd.getData(query);
		
		Iterator itr = getmodel.iterator();
		while(itr.hasNext()){
			modelName = itr.next().toString();
		}
		return modelName;
	}
	
	public List getModelData()
    {
        String query="SELECT brand_master.varbrandname,model_details_master.intmodelid, "
                + "model_details_master.varmodel,color_master.varcolorname,model_details_master.aliasnamemodel FROM brand_master "
                + "INNER JOIN model_details_master on model_details_master.intbrandid=brand_master.intbrandid"
                + " INNER JOIN color_master on model_details_master.intcolorid=color_master.intcolorid order by brand_master.varbrandname";
        List getmodeldata = gd.getData(query);
        return getmodeldata;
    }
	////vijay ranka/////
	
	

	public List getBrandListById(int dealerId)
	{
		
		String query="SELECT brand_master.intbrandid,brand_master.varbrandname FROM brand_master,dealer_master WHERE dealer_master.intdealerid=brand_master.intdealerid AND dealer_master.intdealerid="+dealerId;
		List dealer = gd.getData(query);
		
		if(!(dealer.isEmpty())){
			return dealer;
		}
		return null;
	}


	
	public List getModelList(String dealerId)
	{
		String demoQuery="SELECT brand_master.intbrandid FROM brand_master,"
				+ " dealer_master WHERE dealer_master.intdealerid=brand_master.intdealerid AND brand_master.intdealerid="+dealerId;
		
		List dataOne=gd.getData(demoQuery);
		List dataTwo=null;
		List dataTotal=new ArrayList();
		Iterator itrOne=dataOne.iterator();
		boolean flag=false;
		while(itrOne.hasNext())
		{
			dataTwo=gd.getData("SELECT model_details_master.intmodelid, "
					+ "model_details_master.intcolorid,model_details_master.aliasnamemodel"
					+ " FROM model_details_master, brand_master WHERE brand_master.intbrandid=model_details_master.intbrandid"
					+ " AND brand_master.intbrandid="+itrOne.next());
			
			Iterator itr=dataTwo.iterator();
			while(itr.hasNext())
			{
				dataTotal.add(itr.next());
				dataTotal.add(itr.next());
				dataTotal.add(itr.next());
			}
		}
		return dataTotal;
			
	}
	
	
	//finish////////

	public List getModel(String brandId)
	{
		 String query="SELECT `intmodelid`, `intcolorid`,`aliasnamemodel` FROM `model_details_master` where intbrandid='"+brandId+"'";
		List getmodel = gd.getData(query);
		return getmodel;
	}
	public List getModelPD(String brandId)
	{
		 String query="SELECT model_details_master.intmodelid,model_details_master.intcolorid, model_details_master.aliasnamemodel FROM purchase_master_details,model_details_master WHERE purchase_master_details.intmodelId=model_details_master.intmodelid and purchase_master_details.varratetosale>0 AND model_details_master.intbrandid='"+brandId+"' GROUP BY model_details_master.aliasnamemodel";
		List getmodel = gd.getData(query);
		return getmodel;
	}
	
//   mobilePurchase.jsp
	public List getBrandIcon()
	{
		String query="SELECT intbrandid, varbrandname FROM brand_master ORDER BY varbrandname ASC";
		List getBrandIcon = gd.getData(query);
		return getBrandIcon;
	}
	
	public int getTotalStockPurchase(String brandid)
	{
		int sum=0;
		String qtryquery="SELECT purchase_details.varimeino1 FROM purchase_details,purchase_master,purchase_master_details"
				+ " WHERE purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId and "
				+ "purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId "
				+ "AND purchase_master.intbrandid="+brandid+" AND purchase_details.intsalestatus=0";
		List templist=gd.getData(qtryquery);
		Iterator itr=templist.iterator();
		while(itr.hasNext())
		{
			itr.next();
			sum++;
		}
		return sum;
	}
	
	
// mobile purchase updated method
	public List getBrandName()
	{
		 String query="SELECT brand_master.intbrandid, brand_master.varbrandname FROM brand_master where brand_master.intdealerstatus=0;";
		List brandlist = gd.getData(query);
		return brandlist;
	}
	
	public List getBrandList(String dealerName)
	{
		Object brandid="";
		String getBrandId = "select intbrandid from dealer_master WHERE vardealername='"+dealerName+"';";
		List brandIdList = gd.getData(getBrandId);
		Iterator itr = brandIdList.iterator();
		while(itr.hasNext()){
			brandid = itr.next();
		}
		String query="select intbrandid, varbrandname FROM brand_master where intdealerstatus=0 OR intbrandid='"+brandid+"';";
		List brandlist = gd.getData(query);
		return brandlist;
	}
	
	
	
	public List getRowCount()
	{
		String query="SELECT COUNT(*) FROM dealer_master, brand_master WHERE dealer_master.intbrandid=brand_master.intbrandid;";
		List brandlistcount = gd.getData(query);
		return brandlistcount;
	}
	
	
	
	public List getAliasName() {
		String query="SELECT model_details_master.intmodelid,model_details_master.aliasnamemodel"
				+ " FROM purchase_details ,purchase_master_details ,model_details_master "
				+ "WHERE purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId"
				+ " AND purchase_master_details.intmodelId=model_details_master.intmodelid "
				+ "and purchase_details.intsalestatus=0 GROUP BY model_details_master.intmodelid;";
		List aliasnamelist = gd.getData(query);
		return aliasnamelist;
	}
	
	public List getAmount(String b_id)
	{
		int b_id1 = Integer.parseInt(b_id);
		String query="SELECT inttotalbillamount FROM `purchase_master` where intbrandid='"+b_id1+"';";
		List amount = gd.getData(query);
		return amount;
	}
	
	public Object getBrandList1(Object did)
	{
		String query="SELECT varbrandname from brand_master where intbrandid=(select intbrandid from dealer_master where dealer_master.intdealerid='"+did+"');";
		List brandList = gd.getData(query);
		Iterator itr = brandList.iterator();
		String brandName = "";
		while(itr.hasNext()){
			brandName = itr.next().toString();
		}
		return brandName;
	}

	public List getSaleData(String invoiceId, String modelId){
		String query="SELECT m.`intmobilesaleid`,c.`varcustname`, c.`varaddress`,c. `varcontactno`,m.`datesaledate`,md.`aliasnamemodel`,m.`varimeino1`,m.`varimeino2`,m.`varserialno`,m.`varhhsnsacno`,m.`varbatteryno`,m.`varchargerno`,m.`intsaleprice`,c.`varcustgstin`,m.`varsaletype` FROM `mobilesale_master` m, `customer_master` c,`model_details_master` md WHERE m.`intmobilesaleid`="+invoiceId+" AND m.`intcustid`=c.`intcustid` AND md.`intmodelid`="+modelId;
		List InvoicePrint = gd.getData(query);
		return InvoicePrint;
	}
	
	public List getSaleData(String invoiceId){
		String query="SELECT m.`intmobilesaleid`,c.`varcustname`, c.`varaddress`,c.`varcontactno`,m.`datesaledate`,m.`varserialno`,m.`varhhsnsacno`,c.`varcustgstin`,m.`varsaletype`FROM `mobilesale_master` m, `customer_master` c WHERE m.`intmobilesaleid`="+invoiceId+" AND m.`intcustid`=c.`intcustid`";
		String accessories="SELECT `varitem`, `varitem_detail`, `varitem_qty`, `intaccessoriessaleprice`,`gst` FROM `accessoriessale_master` WHERE `intmobilesaleid` ="+invoiceId;
		List InvoicePrint= new ArrayList();
		InvoicePrint.add(gd.getData(query));
		InvoicePrint.add(gd.getData(accessories));
		return InvoicePrint;
	}
	
	public List getBouceChequeData( String chequeno)
	{
		 String query="SELECT chequebook.intchequebookid, chequebook.intdealerid, cheque_payment_master.intchequeamount, cheque_payment_master.intchequebouncecharges FROM `chequebook`, `cheque_payment_master` WHERE chequebook.varchequeno='"+chequeno+"' AND cheque_payment_master.varchequeno='"+chequeno+"';";
		List BouceChequeData = gd.getData(query);
		return BouceChequeData;
	}
	
	public List getRemainingAmount(String brand_id)
	{
		//sarang
		Object dealerid="";
		String getDealerId="SELECT intdealerid FROM dealer_master WHERE intbrandid='"+brand_id+"';";
		List dealerIdList = gd.getData(getDealerId);
		Iterator itr = dealerIdList.iterator();
		while(itr.hasNext()){dealerid = itr.next();}
		String query="SELECT intdealerId,totalremaining FROM dealer_payment_master where intdealerId='"+dealerid+"';";
		List dealeramount = gd.getData(query);
		return dealeramount;
	}

	public List getDealerCheque(String dealerid) {
		//sarang	
		String query="SELECT `varchequeno` FROM `chequebook` WHERE intdealerid="+dealerid+" AND intchequestatus=0;";// AND status=0;
		List cheque_no = gd.getData(query);
		return cheque_no;
	}
	
	public List getReportData(String fromDate,String toDate)
	{
		String query="SELECT m.`intmobilesaleid`,c.`varcustname`,c.`varaddress`,c.`varcontactno`,m.`datesaledate`,md.`aliasnamemodel`,m.`varimeino1`,m.`varbatteryno`,m.`varchargerno`,m.`intsaleprice`,c.`varcustgstin`,m.`intcustdiscount` FROM mobilesale_master m INNER JOIN customer_master c ON m.intcustid=c.intcustid INNER JOIN model_details_master md on m.intmodelid=md.intmodelid where m.`datesaledate` BETWEEN '"+fromDate+"' AND '"+toDate+"'";
		List reportData = gd.getData(query);
		return reportData;
	}
	
	
	//expenses
	public List getExpMaster()
	{
		String query="SELECT `intexp_id`,`dateexpdate`,`intamount`,`varto`,`varreason` FROM `exp_master` ORDER BY `dateexpdate` DESC";
		List expmaster=gd.getData(query);
		return expmaster;
	}
	
	public List getRecord(String id)
	{
		String id2=id;
		String query="select `intexp_id`,`dateexpdate`,`intamount`,`varto`,`varreason` from exp_master where intexp_id='"+id2+"'";
		List expencess=gd.getData(query);
		return expencess;
	}
	
	public List getcolorname(String colorid)
	{
		String query="select varcolorname from color_master where intcolorid="+colorid;
		List colorlist=gd.getData(query);		
		return colorlist;
	}
	
	public List getCustomerRowId(String cust_id)
	{
		//sarang
		String query="SELECT customer_master.varcustname, customer_master.varaddress, customer_master.varcontactno, mobilesale_master.intmobilesaleid, mobilesale_master.datesaledate, mobilesale_master.intsaleprice, mobilesale_master.varimeino1, mobilesale_master.varimeino2, mobilesale_master.varbatteryno,mobilesale_master.varchargerno,mobilesale_master.varpaymentmode,mobilesale_master.intmodelid from msale.customer_master, msale.mobilesale_master where customer_master.intcustid=mobilesale_master.intcustid and mobilesale_master.intmobilesaleid='"+cust_id+"';";		
		List customer_row_id=gd.getData(query);
		return customer_row_id;
	}

	public List getCustomerList()
	{
		//sarang
		SysDate sd=new SysDate();
		String currDate=sd.todayDate();
		String firstDate="SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)";
		String lastDate="SELECT last_day('"+currDate+"')";
		List getFirstDate=gd.getData(firstDate);
		List getLastDate=gd.getData(lastDate);
		String query="SELECT customer_master.varcustname, mobilesale_master.intmobilesaleid, mobilesale_master.datesaledate, mobilesale_master.intsaleprice from msale.customer_master, msale.mobilesale_master where (datesaledate between '"+getFirstDate.get(0)+"' AND '"+getLastDate.get(0)+"' ) and customer_master.intcustid=mobilesale_master.intcustid ";
		List customerdetails=gd.getData(query);
		return customerdetails;
	}
//method2

	public List getCustomerMonthlyList(String monthID)
	{
		//sarang
		//first date
		String firstDate="SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)";
		List getFirstDate=gd.getData(firstDate);
		String demodate=getFirstDate.get(0).toString().substring(0,5)+monthID+"-01";
		String demo1="SELECT last_day('"+demodate+"')";
		//last date
		List demo2=gd.getData(demo1);
		String query="SELECT customer_master.varcustname, mobilesale_master.intmobilesaleid, mobilesale_master.datesaledate, mobilesale_master.intsaleprice from msale.customer_master, msale.mobilesale_master where (datesaledate between '"+demodate+"' AND '"+demo2.get(0)+"' ) and customer_master.intcustid=mobilesale_master.intcustid ";
		List customerdetails=gd.getData(query);
		return customerdetails;
	}
	
	public List getdealerid(String orgName)
	{
		String getdelaerquery = "select intdealerid from dealer_master where varorganizationname='"+orgName+"';";
		List getdelaerlist=gd.getData(getdelaerquery);
		return getdelaerlist;
	}
	
	public List getPurchaseDetail1(String brandId)
	{
		//vijay
		String query="SELECT purchase_master.varinvoiceno,purchase_master.datePurchaseDate,"
				+ "purchase_master.inttotalbillamount FROM purchase_master "
				+ "where purchase_master.intdealerid='"+brandId+"'";
		List demoList1=gd.getData(query);
		 return demoList1;
	}
	
	public List getPurchaseDetail2(String invoiceId,String brandId)
	{
		//vijay
		String query="SELECT model_details_master.aliasnamemodel"
				+ " FROM purchase_master_details, purchase_master, model_details_master "
				+ "WHERE purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId "
				+ "AND purchase_master_details.intmodelId=model_details_master.intmodelid "
				+ "AND purchase_master.varinvoiceno='"+invoiceId+"' and purchase_master.intdealerid='"+brandId+"'";
		List demoList2=gd.getData(query);
		 return demoList2;
	}
	
	public List getPurchaseDetail3(String aliasName, String invoiceno)
    {
        String query="SELECT purchase_details.varimeino1 FROM purchase_details,purchase_master_details,"
                + " purchase_master,model_details_master "
                + "WHERE purchase_master.intpurchase_masterId=purchase_master_details.intpurchase_masterId "
                + "and purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId"
                + " and purchase_master_details.intmodelId=model_details_master.intmodelid "
                + "and model_details_master.aliasnamemodel='"+aliasName+"' and purchase_master.varinvoiceno='"+invoiceno+"'";
        List demoList3=gd.getData(query);
         return demoList3;
    }	
	
	public boolean getModelStatus(String modelname,String[] colorid)
    {
       //vijay
        String query="SELECT model_details_master.varmodel FROM model_details_master";
        List demoList=gd.getData(query);
        Iterator itr=demoList.iterator();
        while(itr.hasNext())
        {
            if(itr.next().equals(modelname))
            {
                String secondQuery="SELECT model_details_master.intcolorid "
                        + "FROM model_details_master WHERE model_details_master.varmodel='"+modelname+"'";
                List demoList2=gd.getData(secondQuery);
                Iterator itr2=demoList2.iterator();
                while(itr2.hasNext())
                {
                    String demoColid=itr2.next().toString();
                    for(String demoString:colorid)
                    {
                        if(demoColid.equals(demoString))
                            return true;
                    }
                }
            }
        }
        return false;
    }
	
	public Boolean getDealerAssignStatus(String brandId)
	{
		String query="SELECT intdealerstatus FROM brand_master WHERE intbrandid="+brandId;
		List demoList=gd.getData(query);
		Iterator itr=demoList.iterator();
		String status=itr.next().toString();
		if(status.equals("0"))
			return false;
		else
			return true;
	}
	public List getOrgDetails()
	{
		String query="SELECT * FROM `organization_details_master` WHERE `organization_id`=1";
        List demoList3=gd.getData(query);
         return demoList3;
		
	}
	public List DealerPaymentDetails(String dealerid)
	{
		SysDate sd=new SysDate();
		String currDate=sd.todayDate();
		String firstDate="SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)";
		String lastDate="SELECT last_day('"+currDate+"')";
		List getFirstDate=gd.getData(firstDate);
		List getLastDate=gd.getData(lastDate);		
		
		String query="select dealer_payment_master.datetransactiondate, purchase_master.varinvoiceno, dealer_payment_master.intbillamount, "
				+ "dealer_payment_master.intpaidamount, dealer_payment_master.intchequebookid , dealer_payment_master.totalremaining from "
				+ "dealer_payment_master LEFT JOIN purchase_master on purchase_master.intpurchase_masterId=dealer_payment_master.intpurchase_masterId "
				+ "where (datetransactiondate BETWEEN '"+getFirstDate.get(0)+"' AND '"+getLastDate.get(0)+"') and dealer_payment_master.intdealerid="+dealerid;
		
		List dealerPaymentdetails = gd.getData(query);
		return dealerPaymentdetails;
	}
	
	public List getMonthlyDetails(String dealerid,String impdate)
	{
		//sarang
		//first date
		String firstDate="SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)";
		List getFirstDate=gd.getData(firstDate);
		String demodate=getFirstDate.get(0).toString().substring(0,5)+impdate+"-01";
		String demo1="SELECT last_day('"+demodate+"')";
		//last date
		List demo2=gd.getData(demo1);
		
		String monthData="select dealer_payment_master.datetransactiondate, purchase_master.varinvoiceno, dealer_payment_master.intbillamount, "
				+ "dealer_payment_master.intpaidamount, dealer_payment_master.intchequebookid , dealer_payment_master.totalremaining from "
				+ "dealer_payment_master LEFT JOIN purchase_master on purchase_master.intpurchase_masterId=dealer_payment_master.intpurchase_masterId "
				+ "where (datetransactiondate BETWEEN '"+demodate+"' AND '"+demo2.get(0)+"') and dealer_payment_master.intdealerid="+dealerid;

//		String monthData="select datetransactiondate, intbillamount, intpaidamount, intchequebookid , "
//				+ "totalremaining from dealer_payment_master where "
//				+ "(datetransactiondate BETWEEN '"+demodate+"' AND '"+demo2.get(0)+"') and intdealerId='"+dealerid+"'";
		List finaldata=gd.getData(monthData);
		return finaldata;
	}
	public List getPriceDropDetails()
	{
		String query="SELECT price_drop_master.intpdid,price_drop_master.datepricedropdate,model_details_master.aliasnamemodel,price_drop_master.inttotalqty,price_drop_master.intdropamount from price_drop_master INNER JOIN model_details_master ON price_drop_master.intmodelid=model_details_master.intmodelid INNER JOIN pricedrop_detailsmaster on price_drop_master.intpdid=pricedrop_detailsmaster.intpdid GROUP BY price_drop_master.intpdid";
		List priceDropdetails=gd.getData(query);
		return priceDropdetails;
	}
	
	public List getPriceDropDetailsById(String id)
	{
		String query="SELECT price_drop_master.datepricedropdate,model_details_master.aliasnamemodel,price_drop_master.inttotalqty,price_drop_master.intdropamount from price_drop_master INNER JOIN model_details_master ON price_drop_master.intmodelid=model_details_master.intmodelid INNER JOIN pricedrop_detailsmaster on price_drop_master.intpdid=pricedrop_detailsmaster.intpdid where pricedrop_detailsmaster.intpdid="+id+" GROUP BY model_details_master.aliasnamemodel";
		List priceDropdetailsById=gd.getData(query);
		return priceDropdetailsById;
	}
	
	public List getPriceDropDetailsImei(int id)
	{
		String query="SELECT pricedrop_detailsmaster.varimeino FROM pricedrop_detailsmaster WHERE pricedrop_detailsmaster.intpdid="+id;
		List priceDropDetailsImei=gd.getData(query);
		return priceDropDetailsImei;
	}
	public List getLastMonthDue(String dealerid)
	{
		String due="SELECT totalremaining FROM dealer_payment_master "
				+ " WHERE datetransactiondate "
				+ " BETWEEN DATE_SUB( DATE( NOW( ) ) , INTERVAL 1 MONTH ) AND  "
				+ " LAST_DAY( DATE_SUB( DATE( NOW( ) ) , INTERVAL 1 MONTH ) ) AND "
				+ " intdealerId="+dealerid;
		List dueamount=gd.getData(due);

		if(dueamount.isEmpty()){
			dueamount.add("0");
		}
		return dueamount;
	}
	public List getStockByBrandid(String stockbrandId)
	{	
		List getmodeldata = new ArrayList();
		if(stockbrandId.equals("")){
			String query=" SELECT varbrandname, model_details_master.intmodelid, varmodel, varcolorname, aliasnamemodel FROM brand_master  "
					+ "INNER JOIN model_details_master on model_details_master.intbrandid=brand_master.intbrandid "
					+ "INNER JOIN color_master on model_details_master.intcolorid=color_master.intcolorid "
					+ "LEFT JOIN purchase_master_details ON model_details_master.intmodelid = purchase_master_details.intmodelid and "
					+ "purchase_master_details.intpurchase_masterId is null group by aliasnamemodel";
			getmodeldata = gd.getData(query);
			
		}else{
				String query="SELECT varbrandname, model_details_master.intmodelid, varmodel, varcolorname, aliasnamemodel FROM brand_master "
						+ "INNER JOIN model_details_master on brand_master.intbrandid="+stockbrandId+" and model_details_master.intbrandid=brand_master.intbrandid "
						+ "INNER JOIN color_master on model_details_master.intcolorid=color_master.intcolorid "
						+ "LEFT JOIN purchase_master_details ON model_details_master.intmodelid = purchase_master_details.intmodelid and "
						+ "purchase_master_details.intpurchase_masterId is null group by aliasnamemodel";
				getmodeldata = gd.getData(query);
		}
		
		
		return getmodeldata;
	}	
	
	
	public int getQuntity(String aliasName)
	{
		String qntquery="SELECT purchase_details.varimeino1 FROM purchase_master_details,model_details_master,purchase_details WHERE"
				+ " model_details_master.intmodelid=purchase_master_details.intmodelId and "
				+ "purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId and"
				+ " purchase_master_details.intpurchase_masterId is null and model_details_master.aliasnamemodel='"+aliasName+"' "
				+ "and purchase_details.intsalestatus=0";
		
		List templist=gd.getData(qntquery);
		int qty=templist.size();
		return qty;
	}
	
	public List getOpeningStockRowData(String RowId)
	{
		int totalqty = 0; 
		String num="";
		String a= "( ";
		
		String intpurchase_master_detailsIdQuery = "select purchase_master_details.intpurchase_master_detailsId, intqty from purchase_master_details WHERE purchase_master_details.intmodelId="+RowId + " and intpurchase_masterId is null";
		List detailsIdList = gd.getData(intpurchase_master_detailsIdQuery);
		Iterator it = detailsIdList.iterator();
		if(it.hasNext()){
			a += it.next();
			num = it.next().toString();
			totalqty += Integer.parseInt(num);
		}
		
		
		while(it.hasNext()){
			a += ", "+ it.next();
			totalqty += Integer.parseInt(it.next().toString());
		}
		a+=" ) ";
		System.out.println(a +" "+ totalqty);
		
		List stockRowData=null, updateDataList = new ArrayList();
		
		if(totalqty>0){
			
			String stockRowDataQuery = "select purchase_master_details.intpurchase_master_detailsId, purchase_master_details.intmodelId, purchase_master_details.hsnsacno,  purchase_master_details.varratetosale, purchase_master_details.intqty from purchase_master_details WHERE purchase_master_details.intmodelId="+RowId+"  and intpurchase_master_detailsId in " + a +" and intpurchase_masterId is null";
			stockRowData = gd.getData(stockRowDataQuery);
			
			String purchaseMasterDetailsId = stockRowData.get(0).toString();
			
			String modelAliasQuery = "select aliasnamemodel from model_details_master where intmodelid="+stockRowData.get(1).toString();
			List modelAliasList = gd.getData(modelAliasQuery);
			String modelAlias = modelAliasList.get(0).toString();
			
			//final list for update
			updateDataList.add(stockRowData.get(1).toString());
			updateDataList.add(modelAlias);
			updateDataList.add(stockRowData.get(3).toString());
			
			
			String getImeiQuery = "select purchase_details.varimeino1 FROM purchase_details WHERE purchase_details.intpurchase_master_detailsId in "+a+" and intsalestatus=0";
			List imeiList = gd.getData(getImeiQuery);
			
			int count = imeiList.size();
			updateDataList.add(imeiList.size());
			Iterator itr = imeiList.iterator();
			while(count>0){
				String imei = itr.next().toString();
				updateDataList.add(imei);
				count--;
			}
		}
		return updateDataList;
	}
	
	public List getPriceDropDetails(String id)
	{
		String query="SELECT price_drop_master.intpdid,price_drop_master.datepricedropdate,model_details_master.aliasnamemodel,price_drop_master.inttotalqty,price_drop_master.intdropamount from price_drop_master INNER JOIN model_details_master ON price_drop_master.intmodelid=model_details_master.intmodelid INNER JOIN pricedrop_detailsmaster on price_drop_master.intpdid=pricedrop_detailsmaster.intpdid WHERE price_drop_master.intbrandid='"+id+"' GROUP BY price_drop_master.intpdid";
		List priceDropdetails=gd.getData(query);
		return priceDropdetails;
	}
	public int getOpeningQty(String brandid)
	{
		String qtryquery="SELECT purchase_details.varimeino1 FROM purchase_master_details,model_details_master,purchase_details WHERE "
				+ "model_details_master.intmodelid=purchase_master_details.intmodelId and "
				+ "purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId and "
				+ "purchase_master_details.intpurchase_masterId is null and model_details_master.intbrandid ="+brandid+" and purchase_details.intsalestatus=0";
		List templist=gd.getData(qtryquery);
		int qty=templist.size();
		
		return qty;
	}
	public List getBrandwiseReport(String brandid, String start_date, String end_date)
	{
		String query = "SELECT mobilesale_master.datesaledate, mobilesale_master.varimeino1, model_details_master.varmodel, mobilesale_master.intsaleprice, "
				+ "customer_master.varcustname, customer_master.varcontactno FROM mobilesale_master "
				+ "INNER JOIN customer_master ON customer_master.intcustid=mobilesale_master.intcustid "
				+ "INNER JOIN model_details_master ON model_details_master.intmodelid=mobilesale_master.intmodelid "
				+ "WHERE model_details_master.intbrandid="+brandid+" AND mobilesale_master.datesaledate BETWEEN '"+start_date+"' AND '"+end_date+"'";
		List brandwiseReport=gd.getData(query);
		return brandwiseReport;
	}
	
	public List getStockDetails()
	{
		String getDetails="SELECT mobilestock_master.intbrandid, brand_master.varbrandname FROM"
				+ " mobilestock_master, brand_master WHERE brand_master.intbrandid=mobilestock_master.intbrandid  AND mobilestock_master.inttotalqty>0 "
				+ "GROUP BY brand_master.varbrandname";
		List l=gd.getData(getDetails);
		return l;
	}
	
	public int getTotalQuantity(String brandid)
	{
		int sum=0;
		String qtryquery="SELECT inttotalqty FROM mobilestock_master WHERE intbrandid='"+brandid+"'";
		List templist=gd.getData(qtryquery);
		Iterator itr=templist.iterator();
		while(itr.hasNext())
		{
			sum=sum+(Integer.parseInt(itr.next().toString()));
		}
		return sum;
	}
	
	public List getStockDetailsByBrand(Object brandid)
	{
		String getDetails="SELECT mobilestock_master.intbrandid, brand_master.varbrandname FROM"
				+ " msale.mobilestock_master, msale.brand_master WHERE "
				+ "brand_master.intbrandid=mobilestock_master.intbrandid and brand_master.intbrandid="+brandid+" "
				+ " GROUP BY brand_master.varbrandname";
		List l=gd.getData(getDetails);
		return l;
	}
	
	public List getStockDetails2(String brandid)
	{
		String getDetails="SELECT model_details_master.aliasnamemodel, mobilestock_master.inttotalqty,purchase_master_details.varratetosale"
				+ " FROM mobilestock_master, model_details_master,purchase_master_details WHERE "
				+ "model_details_master.intmodelid=mobilestock_master.intmodelid and mobilestock_master.inttotalqty>0 AND mobilestock_master.intbrandid="+brandid+""
						+ " AND purchase_master_details.intmodelId=mobilestock_master.intmodelid group by aliasnamemodel "
						+ "ORDER BY model_details_master.aliasnamemodel";
		List l=gd.getData(getDetails);	
		return l;
	}
	
	public List getDealerRowData(String id)
	{
		String query="SELECT * FROM `dealer_master` where intdealerid='"+id+"';";
		List dealerRow = gd.getData(query);
		return dealerRow;
	}

	public List getDealerData()
		{
			 String query="SELECT dealer_master.intdealerid, dealer_master.vardealername, dealer_master.varcontactno, dealer_master.varemailid, dealer_master.varorganizationname FROM dealer_master";
			List dealerlist = gd.getData(query);
			return dealerlist;
		}
	
	public String getdealerName(String dealerid)
	{
		String getdelaerquery = "select varorganizationname from dealer_master where intdealerid='"+dealerid+"';";
		List getdelaerlist=gd.getData(getdelaerquery);
		String dname="";
		if(getdelaerlist.isEmpty()){
			dname="-";
		}	
		else{
			dname = getdelaerlist.get(0).toString();
		}
		return dname;
	}
	
	public String getDealerName(String dealerid)
	{
		String getdelaerquery = "select vardealername from dealer_master where intdealerid='"+dealerid+"';";
		List getdelaerlist=gd.getData(getdelaerquery);
		String dname="";
		if(getdelaerlist.isEmpty()){
			dname="-";
		}	
		else{
			dname = getdelaerlist.get(0).toString();
		}
		return dname;
	}
	
	public String getBrandNameById(String brandUpdate)
	{
		String brandid = brandUpdate;	
		String brandname ="";
		String query="SELECT `varbrandname`  FROM `brand_master` where intbrandid = '"+brandid+"';";
		List l =gd.getData(query);
		if(!l.isEmpty())
		{
			brandname = l.get(0).toString();
		}
		return brandname;
	}
	
	public String getdid(String bname)
	{
		 String query="SELECT brand_master.intdealerid FROM brand_master where varbrandname='"+bname+"';";
		List dealer = gd.getData(query);
		String did="";
		
		if(!(dealer.isEmpty())){
			did=dealer.get(0).toString();
		}
		return did;
	}
	
	public List getDealerList()
	{
		 String query="SELECT dealer_master.intdealerid, dealer_master.varorganizationname FROM dealer_master;";
		List brandlist = gd.getData(query);
		return brandlist;
	}
	
	public List getBrandNameList()
	{
		 String query="SELECT `varbrandname`, `intdealerid`, `intbrandid` FROM `brand_master` ORDER BY `intbrandid` DESC;";
		List brandlist = gd.getData(query);
		return brandlist;
	}
	
	public List getBrandNameList1()
	{
		 String query="SELECT `varbrandname`,`intbrandid` FROM `brand_master` ORDER BY `intbrandid` DESC;";
		List brandlist = gd.getData(query);
		return brandlist;
	}

	
	public List getIMEIDetails0(Object model_id)
	{
		String getIMEIDetails="SELECT purchase_details.varimeino1, purchase_master.datePurchaseDate, purchase_master_details.intmodelId "
				+ "FROM purchase_details,purchase_master ,purchase_master_details "
				+ "WHERE purchase_master_details.intpurchase_master_detailsId=purchase_details.intpurchase_master_detailsId "
				+ "AND purchase_master_details.intpurchase_masterId=purchase_master.intpurchase_masterId "
				+ "AND purchase_master_details.intmodelId="+model_id+" "
				+ "AND purchase_details.intsalestatus=0 "
				+ "GROUP BY purchase_details.varimeino1";

		List l=gd.getData(getIMEIDetails);
		return l;
	}
	
	public String ageIMEI(Object startDate){
		String query="SELECT DATEDIFF(CURDATE(),'"+startDate+"')";
		List age = gd.getData(query);
		Iterator itr = age.iterator();
		String imeiage = "";
		while(itr.hasNext()){
			imeiage = itr.next().toString();
		}
		return imeiage;
	}
	
	public List getStockDetails3(String brandid)
	{
		String getDetails="SELECT model_details_master.aliasnamemodel, mobilestock_master.intmodelid "
				+ "FROM mobilestock_master, model_details_master WHERE "
				+ "model_details_master.intmodelid=mobilestock_master.intmodelid "
				+ "and mobilestock_master.intbrandid="+brandid+" group by aliasnamemodel ORDER BY inttotalqty DESC ";
		List l=gd.getData(getDetails);
		return l;
	}

	public List getDealerIcon()
	{
		String query="SELECT intdealerid, vardealername FROM dealer_master ORDER BY vardealername ASC";
		List getDealerIcon = gd.getData(query);
		return getDealerIcon;
	}

	public String getTotalReminingAmount(Object dealer_id){
		String query="SELECT totalremaining FROM dealer_payment_master WHERE intdealer_payment_id=(SELECT MAX(intdealer_payment_id) FROM dealer_payment_master WHERE intdealerid='"+dealer_id+"')";
		return gd.getData(query).get(0).toString();
	}	
	
	public List getModelPp(String brandId)
	{
		String query="SELECT model_details_master.intmodelid,model_details_master.varmodel,model_details_master.aliasnamemodel "
				+ "FROM model_details_master WHERE model_details_master.intbrandid='"+brandId+"' GROUP by model_details_master.aliasnamemodel";
		List getmodel =gd.getData(query);
		return getmodel;		
	}
	public String getPriceProfilModelSt(String modelId)
	{
		String demo="SELECT price_profit.intmodelid,price_profit.intamount FROM price_profit";
		List demoList=gd.getData(demo);
		Iterator itr=demoList.iterator();
		while(itr.hasNext())
		{
			String id=itr.next().toString();
			String price=itr.next().toString();
			if(modelId.equals(id))
			{
				return  price;
			}
		}
		return null;
	}
	
	public List getSoldItems(String modelid)
	{
		String query="SELECT COUNT(*) from purchase_details,purchase_master_details WHERE purchase_details.intpurchase_master_detailsId=purchase_master_details.intpurchase_master_detailsId AND purchase_details.intsalestatus=1 AND purchase_master_details.intmodelId='"+modelid+"'";
		List sitems=gd.getData(query);
		return sitems;
	}
	
	public String getorglist(Object did){
		String query="SELECT varorganizationname FROM `dealer_master` where intdealerid='"+did+"';";
		List orglist = gd.getData(query);
		Iterator itr = orglist.iterator();
		String oranizationname = "";
		while(itr.hasNext()){
			oranizationname = itr.next().toString();
		}
		return oranizationname;
	}

public List getOrganizationName()
	{
		String query="SELECT dealer_master.intdealerid, dealer_master.varorganizationname from dealer_master";
		List orglist = gd.getData(query);
		return orglist;
	}
		
	public List getchequebookData()
	{
		 String query="SELECT intchequebookid, varchequeno, intdealerid from chequebook where intchequestatus=0;";
		List chequebookData = gd.getData(query);
		return chequebookData;
	}
}