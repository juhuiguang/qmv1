package com.jhg.common;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 */
public class DateUtils {

	/**
	 * 根据指定的字符串用指定的格式进行转化
	 * 
	 * @param strDate
	 *            字符串日�?
	 * @param format
	 *            日期格式
	 * @return Date 返回java.util.Date日期对象
	 * @throws BasicException
	 */
	public static Date getDate(String strDate, String format) {
		DateFormat df = new SimpleDateFormat(format);
		try {
			return df.parse(strDate);
		} catch (Exception e) {

			return null;
		}
	}

	/**
	 * 获取两日期之间的日期，包含当前两个日�?
	 * 
	 * @param date1
	 * @param date2
	 * @param formatStr
	 * @return 包含当前两个日期
	 */
	public static List<String> getAmongDate(String date1, String date2,
			String formatStr) {
		SimpleDateFormat format = new SimpleDateFormat(formatStr);
		List<String> dateList = new ArrayList<String>();
		dateList.add(date1);
		if (date1.equals(date2)) {
			return dateList;
		}

		String tmp;
		if (date1.compareTo(date2) > 0) { // 确保 date1的日期不晚于date2
			tmp = date1;
			date1 = date2;
			date2 = tmp;
		}

		tmp = format
				.format(str2Date(date1, format).getTime() + 3600 * 24 * 1000);
		int num = 0;
		while (tmp.compareTo(date2) < 0) {
			num++;
			dateList.add(tmp);
			tmp = format
					.format(str2Date(tmp, format).getTime() + 3600 * 24 * 1000);

			// System.out.println(tmp);
		}

		dateList.add(date2);
		return dateList;
	}

	private static Date str2Date(String str, SimpleDateFormat format) {
		if (str == null)
			return null;

		try {
			return format.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 将时间转化为指定格式字符�?
	 * 
	 * @param date
	 * @param outFormat
	 * @return
	 */
	public static String format(Date date, String outFormat) {
		SimpleDateFormat sf = new SimpleDateFormat(outFormat);
		String res = sf.format(date);
		return res;
	}

	/**
	 * 将时间转化为指定格式字符�?
	 * 
	 * @param dateStr
	 * @param inForamt
	 * @param outformat
	 * @return
	 */
	public static String format(String dateStr, String inForamt,
			String outformat) {
		try {
			SimpleDateFormat sf = new SimpleDateFormat(inForamt);
			Date date = sf.parse(dateStr);
			return new SimpleDateFormat(outformat).format(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 对日期某个属性只增加N�?
	 * 
	 * @param date
	 * @param type
	 * @param num
	 * @return
	 */
	public static Date addDate(Date date, int type, int num) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(type, num);

		return cal.getTime();
	}

	/**
	 * 对日期某个属性只增加N�?
	 * 
	 * @param date
	 * @param type
	 * @param num
	 * @return
	 */
	public static Date setDate(Date date, int type, int num) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(type, num);
		return cal.getTime();
	}

	/**
	 * 时间按小时加�?
	 * 
	 * @param date
	 * @param num
	 * @return
	 */
	public static Date addHour(Date date, int num) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.HOUR_OF_DAY, num);
		return cal.getTime();
	}

	/**
	 * 时间按天加法
	 * 
	 * @param date
	 * @param num
	 * @return
	 */
	public static Date addDate(Date date, int num) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, num);
		return cal.getTime();
	}

	/**
	 * 时间按月加法
	 * 
	 * @param date
	 * @param num
	 * @return
	 */
	public static Date addMonth(Date date, int num) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, num);
		return cal.getTime();
	}

	/**
	 * 2个时间的小时差数
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static int differenceHour(Date date1, Date date2) {
		return (int) ((date1.getTime() - date2.getTime()) / (1000 * 60 * 60));

	}

	/**
	 * 当年
	 */
	public static String getCurrentYear() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		return sf.format(new Date());
	}

	/**
	 * 去年
	 * 
	 * @return
	 */
	public static String getPrevYear() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.YEAR, -1);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		return sf.format(calendar.getTime());
	}
	/**
	 * 去年
	 * 
	 * @return
	 */
	public static String getPrevYear(SimpleDateFormat sf) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.YEAR, -1);
		return sf.format(calendar.getTime());
	}
	/**
	 * 当月
	 * 
	 * @return
	 */
	public static String getCurrentMoth() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");
		return sf.format(new Date());
	}

	/**
	 * 上月
	 */

	public static String getPrevMoth() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");
		return sf.format(calendar.getTime());
	}
	/**
	 * 上月
	 */

	public static String getPrevMoth(SimpleDateFormat sf) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		return sf.format(calendar.getTime());
	}
	/**
	 * 去年同月
	 */

	public static String getPrevYearCurrentMonth(String outFormat) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.YEAR, -1);
		calendar.add(Calendar.MONTH, 0);

		SimpleDateFormat sf = new SimpleDateFormat(outFormat);
		return sf.format(calendar.getTime());
	}

	/**
	 * 当天
	 * 
	 * @return
	 */
	public static String getCurrentDate() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		return sf.format(new Date());
	}

	/**
	 * 当天
	 * 
	 * @return
	 */
	public static String getCurrentDate(SimpleDateFormat sf) {
		return sf.format(new Date());
	}
	/**
	 * 当前日期
	 * 
	 * @return
	 */
	public static String getCurrentDate(String format) {
		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(new Date());
	}

	/**
	 * 前一�?
	 * 
	 * @return
	 */
	public static String getPrevDate() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		return sf.format(calendar.getTime());
	}
    
	/**
	 * 前一�?
	 * 
	 * @return
	 */
	public static String getPrevDate(SimpleDateFormat sf ) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);
		return sf.format(calendar.getTime());
	}
	/**
	 * 上周
	 * 
	 * @return
	 */
	public static String getPrevWeek() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		return sf.format(calendar.getTime());
	}
	/**
	 * 上周
	 * 
	 * @return
	 */
	public static String getPrevWeek(SimpleDateFormat sf) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -7);
		return sf.format(calendar.getTime());
	}
	
	/**
	 * 获取当前时间�?在年的周�?
	 */
	public static int getWeekOfYear(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 * 获取某年某周的第�?�?
	 * 
	 * @param year
	 *            �?
	 * @param week
	 *            周数
	 * @return
	 */
	public static Date getStartDateByWeek(int year, int week) {
		Calendar cal = new GregorianCalendar();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.WEEK_OF_YEAR, week);
		// cal.setFirstDayOfWeek(1);
		cal.set(Calendar.DAY_OF_WEEK, 1);
		cal.add(Calendar.DATE, 1);
		Date result = cal.getTime();
		if (result.getTime() < new GregorianCalendar(year, 0, 1)
				.getTimeInMillis())
			return new GregorianCalendar(year, 0, 1).getTime();
		return result;
	}

	/**
	 * 获取某年某周的最后一�?
	 * 
	 * @param year
	 *            �?
	 * @param week
	 *            周数
	 * @return
	 */
	public static Date getEndDateByWeek(int year, int week) {
		Calendar cal = new GregorianCalendar();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.WEEK_OF_YEAR, week);
		cal.set(Calendar.DAY_OF_WEEK, 7);
		cal.add(Calendar.DATE, 1);
		Date result = cal.getTime();
		if (result.getTime() > new GregorianCalendar(year, 11, 31)
				.getTimeInMillis())
			return new GregorianCalendar(year, 11, 31).getTime();
		return result;
	}

	/**
	 * 获取月份
	 * 
	 * @param number
	 *            0为当�?
	 * @param outDateFormat
	 *            返回格式
	 * @return
	 */
	public static String getMonth(int number, String outDateFormat) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH, number);
		SimpleDateFormat sf = new SimpleDateFormat(outDateFormat);
		return sf.format(calendar.getTime());
	}

	/**
	 * 获取月份
	 * 
	 * @param number
	 *            0为当�?
	 * @param outDateFormat
	 *            返回格式
	 * @return
	 */
	public static String getYearMonth(int yearNumber, int monthNumber,
			String outDateFormat) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, yearNumber);
		calendar.add(Calendar.MONTH, monthNumber);
		SimpleDateFormat sf = new SimpleDateFormat(outDateFormat);
		return sf.format(calendar.getTime());
	}

	/**
	 * 取得指定日期�?在周的第�?�?
	 * 
	 */
	public static Date getFirstDayOfWeek(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
		return c.getTime();
	}

	/**
	 * 获取上周第一�?
	 */
	public static Date getPrevWeekOfFirstDay() {
		Calendar calendar = Calendar.getInstance();
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;

		int offset = 1 - (dayOfWeek == 0 ? 7 : dayOfWeek);
		calendar.add(Calendar.DATE, offset - 7);
		// System.out.println(DateUtils.format(calendar.getTime(), "yyyyMMdd"));
		return calendar.getTime();
	}

	/**
	 * 获取上周�?后一�?
	 * 
	 * @return
	 */
	public static Date getPrevWeekOfEndDay() {
		Calendar calendar = Calendar.getInstance();
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
		int offset = 7 - (dayOfWeek == 0 ? 7 : dayOfWeek);
		calendar.add(Calendar.DATE, offset - 7);
		return calendar.getTime();
	}

	/**
	 * 获取某一日期的前、后某天的日�?
	 * 
	 * 
	 * @param date
	 *            某日�?
	 * @param nextDay
	 *            �?(-1,前一�?)、后某天的天�?
	 * 
	 * @return 日期
	 * 
	 */
	public static String getDate(String date, int nextDay) {
		String result = "";
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		try {
			Date ldate = df.parse(date);
			result = df.format(
					new Date(ldate.getTime() + nextDay * 24 * 60 * 60 * 1000))
					.toString();

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 获取上月的最后一�?
	 * 
	 * @return
	 */
	public static String getLastMonthLastDay() {
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);
		int year = 0;
		int month = cal.get(Calendar.MONTH); // 上个月月�?
		// int day1 = cal.getActualMinimum(Calendar.DAY_OF_MONTH);//起始天数
		int day = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 结束天数
		if (month == 0) {
			year = cal.get(Calendar.YEAR) - 1;
			month = 12;
		} else {
			year = cal.get(Calendar.YEAR);
		}
		String endDay = year + "-" + month + "-" + day;
		return endDay;
	}

	/**
	 * 获取上月的最后一�?
	 * 
	 * @return
	 */
	public static String getLastMonthFirstDay() {
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);
		int year = 0;
		int month = cal.get(Calendar.MONTH); // 上个月月�?
		 int day = cal.getActualMinimum(Calendar.DAY_OF_MONTH);//起始天数
		//int day = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 结束天数
		if (month == 0) {
			year = cal.get(Calendar.YEAR) - 1;
			month = 12;
		} else {
			year = cal.get(Calendar.YEAR);
		}
		String endDay = year + "-" + month + "-" + day;
		return endDay;
	}

	
	
	/**
	 * 获取当天月第�?�?
	 * 返回格式 yyyyMMdd
	 * @return
	 */
	public static String getMonthFirstDay(){
		java.text.SimpleDateFormat   df   =   new   java.text.SimpleDateFormat("yyyyMMdd");      
        GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();   
        gc.set(Calendar.DAY_OF_MONTH, 1);   
        String day_first = df.format(gc.getTime());  
		return day_first;
	}
	
	/**
	 * 获取某年某月的最后一�?
	 * @param year
	 * @param month
	 * @return
	 */
	 public static String getLastDayOfMonth(int year, int month) {     
         Calendar cal = Calendar.getInstance();     
         cal.set(Calendar.YEAR, year);     
         cal.set(Calendar.MONTH, month-1);     
         cal.set(Calendar.DAY_OF_MONTH,cal.getActualMaximum(Calendar.DATE));  
        return  new   SimpleDateFormat( "yyyy-MM-dd").format(cal.getTime());  
     }   
	 
	 
	 /**
		 * 获取某年某月的最后一�?
		 * @param year
		 * @param month
		 * @return
		 */
		 public static String getLastDayOfMonth(int year, int month,SimpleDateFormat sf) {     
	         Calendar cal = Calendar.getInstance();     
	         cal.set(Calendar.YEAR, year);     
	         cal.set(Calendar.MONTH, month-1);     
	         cal.set(Calendar.DAY_OF_MONTH,cal.getActualMaximum(Calendar.DATE));  
	        return sf.format(cal.getTime());  
	     } 
	 
	 /**
	  * 获取某年某月�?大天�?
	  * @param year
	  * @param month
	  * @return
	  */
	 public static int getMaxDay(int year,int month){
			Calendar c = Calendar.getInstance();
			c.set(year, month,1);
			c.add(Calendar.DAY_OF_YEAR, -1);
			return c.get(Calendar.DAY_OF_MONTH);
		}
	
	 
	 
	 /**
	  * 返回某年某月日期集合
	  * @param date  yyyyMM
	  * @return  ("20131001","1�?")
	  */
	 public  static Map<String,String>getMonthDays(String date) {
		 Map<String,String> map=new LinkedHashMap<String, String>();
		  Calendar calendar = Calendar.getInstance();
		  calendar.set(Calendar.YEAR, Integer.parseInt(date.substring(0, 4)));
		  calendar.set(Calendar.MONTH, Integer.parseInt(date.substring(4, 6)) -1);

		  int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		  for(int i=1;i<=maxDay;i++){
			  map.put(date+""+(i<10?("0"+i):i), (i<10?("0"+i):i)+"�?");
		  }
		   return map;
		 }
	 /** 
	     * 得到几天前的时间 
	     *  
	     * @param d 
	     * @param day 
	     * @return 
	     */  
	    public static Date getDateBefore(Date d, int day) {  
	        Calendar now = Calendar.getInstance();  
	        now.setTime(d);  
	        now.set(Calendar.DATE, now.get(Calendar.DATE) - day);  
	        return now.getTime();  
	    }  
	  
	    /** 
	     * 得到几天后的时间 
	     *  
	     * @param d 
	     * @param day 
	     * @return 
	     */  
	    public static Date getDateAfter(Date d, int day) {  
	        Calendar now = Calendar.getInstance();  
	        now.setTime(d);  
	        now.set(Calendar.DATE, now.get(Calendar.DATE) + day);  
	        return now.getTime();  
	    } 
	public static void main(String[] args) {
//		 new DateUtils().getMonthDays("201310");
		 String date=DateUtils.getCurrentDate("yyyyMMdd");
		 System.out.println(date);
		//System.out.println(getAmongDate("20131101","20131130","yyyyMMdd"));
	}

}
