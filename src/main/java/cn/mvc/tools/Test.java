package cn.mvc.tools;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;

import java.time.temporal.ChronoUnit;
import java.util.Calendar;


public class Test {

    public static void main(String[] args) throws ParseException {

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        cal.setTime(sdf.parse("2021-06-14 09:55:55"));
        LocalDateTime other = LocalDateTime.of(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH) + 1,cal.get(Calendar.DAY_OF_MONTH),cal.get(Calendar.HOUR),cal.get(Calendar.MINUTE),cal.get(Calendar.SECOND));
        LocalDateTime now = LocalDateTime.now();
        long until = other.until(now, ChronoUnit.DAYS);
        System.out.println(other);
        System.out.println(now);
        System.out.println(until);

        //LocalDate now1 = LocalDate.now();
        //LocalDate now2 = LocalDate.of(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH) + 1,cal.get(Calendar.DAY_OF_MONTH));
        LocalDate now1 = LocalDate.of(2021,1,6);
        LocalDate now2 = LocalDate.of(2020,12,29);
        long res = now2.until(now1,ChronoUnit.DAYS);
        System.out.println(now2);
        System.out.println(now1);
        System.out.println(res);

    }


}
