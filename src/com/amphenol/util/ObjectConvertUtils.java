package com.amphenol.util;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class ObjectConvertUtils
{

    public ObjectConvertUtils()
    {
    }
    
    public static BigDecimal getBigDecimalZero(){
    	return new BigDecimal("0");
    }
    public static String getDateFormat(Date currentTime){
    	   SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
    	   return formatter.format(currentTime);
    }

    public static java.sql.Date getCurrentSqlDate()
    {
        Date temp = new Date();
        java.sql.Date date = new java.sql.Date(temp.getTime());
        return date;
    }

    public static java.sql.Date getCurrentSqlDate(Date temp)
    {
        java.sql.Date date = new java.sql.Date(temp.getTime());
        return date;
    }

    public static BigDecimal getBigDecimal(String str)
    {
        if(str == null || str.trim().equals(""))
            str = "0.0";
        return new BigDecimal(str);
    }

    public static int getYear(Date date)
    {
        return date.getYear() + 1900;
    }

    public static int getMonth(Date date)
    {
        return date.getMonth() + 1;
    }

    public static Date getToday()
    {
        Date date = Calendar.getInstance().getTime();
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    public static Date getYesterday()
    {
        Date date = Calendar.getInstance().getTime();
        date.setDate(date.getDate() - 1);
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    public static Date getLastWeek()
    {
        Date date = Calendar.getInstance().getTime();
        date.setDate(date.getDate() - 7);
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    public static Date getLastMonth()
    {
        Date date = Calendar.getInstance().getTime();
        date.setMonth(date.getMonth() - 1);
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    public static Date getBeginMonth()
    {
        Date date = Calendar.getInstance().getTime();
        date.setDate(1);
        date.setHours(0);
        date.setMinutes(0);
        date.setSeconds(0);
        return date;
    }

    public static String getNumber(String str)
    {
        return "1";
    }

    public static java.sql.Date getOffDate(java.sql.Date temp, int offday)
    {
        java.sql.Date date = new java.sql.Date(temp.getTime());
        if(offday > 0)
        {
            date.setMonth(date.getMonth() + 1);
            date.setDate(1);
            date.setDate(offday);
        }else{
          date.setDate(temp.getDate() + offday);
        }
        return date;
    }
}
