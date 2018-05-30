package utility;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class SysDate {
	public String todayDate()
	{
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis); 
	   String dateString = null;
	   SimpleDateFormat sdfr = new SimpleDateFormat("yyyy-MM-dd");
	   
	   try{
		dateString = sdfr.format( date );
	   }catch (Exception ex ){
		System.out.println(ex);
	   }
	   return dateString;
	}
public String currentTime(){
		
		String sdft=new SimpleDateFormat("HH:mm:ss").format(Calendar.getInstance().getTime());
		return sdft;
	}
}
