package com.i7colors.util;



import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class DateUtils
{
    // 日期格式，年份，例如：2004，2008
    public static final String DATE_FORMAT_YYYY = "yyyy";

    // 日期格式，年份和月份，例如：200707，200808
    public static final String DATE_FORMAT_YYYYMM = "yyyyMM";

    // 日期格式，年月日，例如：20050630，20080808
    public static final String DATE_FORMAT_YYYYMMDD = "yyyyMMdd";

    // 日期格式，年月日，用横杠分开，例如：2006-12-25，2008-08-08
    public static final String DATE_FORMAT_YYYY_MM_DD = "yyyy-MM-dd";

    public static final String DATE_FORMAT_HH_MI_SS = "HH:mm:ss";

    // 日期格式，年月日时分秒，例如：20001230120000，20080808200808
    public static final String DATE_TIME_FORMAT_YYYYMMDDHHMISS = "yyyyMMddHHmmss";

    // 日期格式，年月日时分秒，年月日用横杠分开，时分秒用冒号分开，
    // 例如：2005-05-10 23：20：00，2008-08-08 20:08:08
    public static final String DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI_SS = "yyyy-MM-dd HH:mm:ss";

    private static SimpleDateFormat datetimeFormat = new SimpleDateFormat(DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI_SS);
    private static SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD);
    private static SimpleDateFormat timeFormat = new SimpleDateFormat(DATE_FORMAT_HH_MI_SS);

    public static Date parseDateTime(String dateStr)
	{
        Date reDate = null;

        try
        {
            reDate = datetimeFormat.parse(dateStr);
        } catch (ParseException e)
        {
            reDate = null;
        }
        return reDate;
	}


    public static Date parseDate(String dateStr)
    {
        Date reDate = null;

        try
        {
            reDate = dateFormat.parse(dateStr);
        } catch (ParseException e)
        {
            reDate = null;
        }
        return reDate;
    }

    public static Date parseDateTime(String dateStr,String parseStr)
    {
        Date reDate = null;

        try
        {
            SimpleDateFormat timeFormat = new SimpleDateFormat(parseStr);
            reDate = timeFormat.parse(dateStr);
        } catch (ParseException e)
        {
            reDate = null;
        }
        return reDate;
    }

	public static String formatDate(Date date)
	{
		DateFormat df = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD);
		return df.format(date);
	}

	public static String formatTime(Date date,String formatStr)
	{
		DateFormat df = new SimpleDateFormat(formatStr);
		return df.format(date);
	}
	
	public static String formatTime(Date date)
	{
		return datetimeFormat.format(date);
	}
	
	public static List<Date[]> splitTimeByDays(Date start, Date end, int days)
	{
		return splitTimeByHours(start, end, 24 * days);
	}

	public static List<Date[]> splitTimeByHours(Date start, Date end, int hours)
	{
		List<Date[]> dl = new ArrayList<Date[]>();
		while (start.compareTo(end) < 0)
		{
			Date _end = addHours(start, hours);
			if (_end.compareTo(end) > 0)
			{
				_end = end;
			}
			Date[] dates = new Date[]
			{ (Date) start.clone(), (Date) _end.clone() };
			dl.add(dates);

			start = _end;
		}
		return dl;
	}

	public static Date addMinutes(Date date, int amount)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MINUTE, amount);
		return c.getTime();
	}

	public static Date addHours(Date date, int amount)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.HOUR_OF_DAY, amount);
		return c.getTime();
	}

	public static Date addDays(Date date, int amount)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH, amount);
		return c.getTime();
	}

	public static String addDaysToStr(Date date, int amount)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI_SS);
        return df.format(c.getTime());
	}

	public static String addDaysToStr(String dateStr, int amount)
	{
        Date date = parseDateTime(dateStr);
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI_SS);
        return df.format(c.getTime());
	}

	public static String addDaysToStr(Date date, int amount,String format)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH, amount);
        DateFormat df = new SimpleDateFormat(format);
        return df.format(c.getTime());
	}


	public static Date addMonths(Date date, int amount)
	{
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MONTH, amount);
		return c.getTime();
	}

    public static String addMonthsToStr(Date date, int amount)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI_SS);
        return df.format(c.getTime());
    }
    public static String addMonthsToStr(String dateStr, int amount)
    {
        Date date = parseDateTime(dateStr);
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_TIME_FORMAT_YYYY_MM_DD_HH_MI_SS);
        return df.format(c.getTime());
    }
    public static String addMonthsToStr_YMD(String dateStr, int amount)
    {
        Date date = parseDate(dateStr);
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD);
        return df.format(c.getTime());
    }
    
    public static String addMonthsToStr(Date date, int amount,String format)
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH, amount);
        DateFormat df = new SimpleDateFormat(format);
        return df.format(c.getTime());
    }

	/**
	 * 获取今天的开始时刻。
	 */
	public static Date getTodayStartTime()
	{
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

    /**
     * 获取今天的结束时间
     *
     */
    public static Date getTodayEndTime() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        return cal.getTime();
    }
    /**
     * 获取当前日期（yyyy-MM-dd）
     *
     * @return 当前日期
     */
    public static String getCurrentDate()
    {
        return dateFormat.format(new Date());
    }

    /**
     * 获取当前时间（HH:mm:ss）
     *
     * @return 当前时间
     */
    public static String getCurrentTime()
    {
        return timeFormat.format(new Date());
    }

    /**
     * 获取当前日期与时间（yyyy-MM-dd HH:mm:ss）
     *
     * @return 当前日期与时间
     */
    public static String getCurrentDateTime()
    {
        return datetimeFormat.format(new Date());
    }

    /**
     *
     * @Title: dateToStr
     * @Description: 将时间类型转换为字符串
     * @param date
     * @param format
     * @return String
     */
    public static String dateToStr(Date date, String format) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        return dateFormat.format(date);
    }


    public  static long dateDiff(Date start,Date stop){
        Long d = stop.getTime() - start.getTime();
        if (d%(1000*60*60*24)==0){
            return d/(1000*60*60*24);
        }else if(d%(1000*60*60*24) > (1000*60*60*12)){
            return d/(1000*60*60*24)+1;
        }else{
            return d/(1000*60*60*24);
        }
    }
    public  static long dateDiff(String startStr,String stopStr){
        Date start = parseDate(startStr);
        Date stop = parseDate(stopStr);
        Long d = stop.getTime() - start.getTime();
        if (d%(1000*60*60*24)==0){
            return d/(1000*60*60*24);
        }else if(d%(1000*60*60*24) > (1000*60*60*12)){
            return d/(1000*60*60*24)+1;
        }else{
            return d/(1000*60*60*24);
        }
    }

    public static List<String> getDateByYear(String date1, String date2)
            throws ParseException {
        List<String> list = new ArrayList<String>();
        if (date1 ==null || date1.equalsIgnoreCase("") || date2 ==null || date2.equalsIgnoreCase("")) {
            return list;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();
        c1.setTime(sdf.parse(date1));
        c2.setTime(sdf.parse(date2));
        if (c1.getTime().after(c2.getTime())) {
            return list;
        }
        String s1 = "";
        String s2 = "";
        do {
            s1 = sdf.format(c1.getTime());
            c1.set(Calendar.DAY_OF_MONTH, 1);
            c1.set(Calendar.MONTH, 12);
            if (c2.getTime().before(c1.getTime())) {
                s2 = sdf.format(c2.getTime());
            } else {
                s2 = sdf.format(c1.getTime());
            }
            list.add(s1 + "," + s2);
        } while (c1.getTime().before(c2.getTime()));
        return list;
    }

    public static List<String> getDateByMonth(String date1, String date2)
            throws ParseException {
        List<String> list = new ArrayList<String>();
        if (date1 ==null || date1.equalsIgnoreCase("") || date2 ==null || date2.equalsIgnoreCase("")) {
            return list;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();
        c1.setTime(sdf.parse(date1));
        c2.setTime(sdf.parse(date2));
        if (c1.getTime().after(c2.getTime())) {
            return list;
        }
        String s1 = "";
        String s2 = "";
        do {
            s1 = sdf.format(c1.getTime());
            c1.set(Calendar.DAY_OF_MONTH, 1);
            c1.add(Calendar.MONTH, 1);
            if (c2.getTime().before(c1.getTime())) {
                s2 = sdf.format(c2.getTime());
            } else {
                s2 = sdf.format(c1.getTime());
            }
            list.add(s1 + "," + s2);
        } while (c1.getTime().before(c2.getTime()));
        return list;
    }

    public static List<String> getDateByDay(String date1, String date2)
            throws ParseException {
        List<String> list = new ArrayList<String>();
        if (date1 ==null || date1.equalsIgnoreCase("") || date2 ==null || date2.equalsIgnoreCase("")) {
            return list;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();
        c1.setTime(sdf.parse(date1));
        c2.setTime(sdf.parse(date2));
        if (c1.getTime().after(c2.getTime())) {
            return list;
        }
        String s1 = "";
        String s2 = "";
        do {
            s1 = sdf.format(c1.getTime());
            c1.add(Calendar.DAY_OF_MONTH, 1);
            if (c2.getTime().before(c1.getTime())) {
                s2 = sdf.format(c2.getTime());
            } else {
                s2 = sdf.format(c1.getTime());
            }
            list.add(s1 + "," + s2);
        } while (c1.getTime().before(c2.getTime()));
        return list;
    }
    
    /**
     * addMonthsToStr 方法 yyyy-MM-hh
     * @param dateStr
     * @param amount
     * @return
     */
    public static String addMonthsToStr_New(String dateStr, int amount)
    {
        Date date = parseDate(dateStr);
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD);
        String newDate = df.format(c.getTime());
        newDate = newDate.substring(0, 8)+"01";
        return newDate;
    }
    
    /**
     * addDaysToStr 方法 yyyy-MM-hh
     * @param dateStr
     * @param amount
     * @return
     */
	public static String addDaysToStr_New(String dateStr, int amount)
	{
        Date date = parseDate(dateStr);
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.DAY_OF_MONTH, amount);
        DateFormat df = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD);
        return df.format(c.getTime());
	}
    
    
	/**
	 * 传一个日期 获取该日期所在周的最后一天的日期
	 * @param today
	 * @return
	 * @throws Exception
	 */
    public static String getNowWeekBegin(String today) throws Exception {
    	  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
    	   Calendar cal = Calendar.getInstance();  
    	   Date date ;
    	   date = sdf.parse(today);
    	   cal.setTime(date);  
    	   int dayWeek = cal.get(Calendar.DAY_OF_WEEK);
    	   if(1 == dayWeek) {  
    	          cal.add(Calendar.DAY_OF_MONTH, -1);  
    	         }  
    	   cal.setFirstDayOfWeek(Calendar.MONDAY);
    	   int day = cal.get(Calendar.DAY_OF_WEEK); 
    	   cal.add(Calendar.DATE, cal.getFirstDayOfWeek()-day); 
    	   cal.add(Calendar.DATE, 6);  
    	   String imptimeEnd = sdf.format(cal.getTime());  
		return imptimeEnd;
    }
    
    /**
     * getDayOfYear 
     * 传一个日期 获取该日期为那年的第几天
     * @param date
     * @return
     */
    public static Map<String,String>  getDayOfYear(String date){
    		Map<String,String> map = new HashMap<String, String>();
    		Date date2 = null;
    	    String begin_time = null;
    	    String end_time = null;
    		DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
    		Calendar calendar = Calendar.getInstance();
    		try {
    			calendar.setTime(df.parse(date));
    			int i = calendar.get(Calendar.DAY_OF_YEAR);
    			if(i/7>51||i%7==0){
    				return map;
    			}
    		    String begin_date = date.substring(0, 5)+"01-01";
    		    date2 = df.parse(begin_date);
    		    calendar.setTime(date2);
    		    if(i<7){
    		    	calendar.add(Calendar.DATE,0);
    		    	begin_time=df.format(calendar.getTime());
    		    	calendar.add(Calendar.DATE, 7);
    				end_time=df.format(calendar.getTime());
    		    }else{
    		    	calendar.add(Calendar.DATE,(i/7-1)*7+7);
    		    	begin_time=df.format(calendar.getTime());
    		    	if(i/7>=51){
    		    		end_time = date.substring(0, 5)+"12-31";
    		    	}else{
    		    		calendar.add(Calendar.DATE, 7);
    					end_time=df.format(calendar.getTime());
    		    	}
    		    }
    			map.put("begin_time", begin_time);
    			map.put("end_time", end_time);
    		} catch (ParseException e) {
    			e.printStackTrace();
    		}
    		return map;
    	}
    	
    /**
     * 传一个日期获取该日期的前六天的日期
     * @param date
     * @return
     */
    public static String getBeforeDay(String date){
    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
    	Date date2;
    	try {
    			date2 = df.parse(date);
    			Calendar calendar = Calendar.getInstance();
    			calendar.setTime(date2);
    			calendar.add(Calendar.DATE,-6);
    			date = df.format(calendar.getTime());
    		} catch (ParseException e) {
    			e.printStackTrace();
    	}
    		return date;
    }

    public static Long getMinutesDiff(String nowTime,String endTime){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date d1 = df.parse(nowTime);
            Date d2 = df.parse(endTime);
            Long diff = d1.getTime() - d2.getTime();
            return diff / (1000 * 60);
        } catch (Exception e) {
            Logger.error("",e);
        }
        return 0L;
    }
    
    
    public static void main(String[] args) throws Exception
    {
//        String dateStr = "2013/7/24 0:00:01";
//        Date date = DateUtils.parseDateTime(dateStr,"yyyy/M/dd H:mm:ss");
//
//        System.out.println(date);
    	System.out.println(getNowWeekBegin("2016-08-29"));
    }
}
