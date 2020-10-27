package cn.mvc.tools;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class GetAutoCode {

    public GetAutoCode() {
    }

    private static final String STR_FORMAT = "00"; //格式化流水号规则

    public static String getSerialNumbers(int count) {
        StringBuffer code = new StringBuffer();
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
        String dateStr = sdf.format(new Date());
        code.append(dateStr);
        int num = count + 1;
        DecimalFormat dft = new DecimalFormat(STR_FORMAT);
        // 将获取到的数量按照所需的格式进行格式化
        String strNum = dft.format(num);
        // 转换成String类型
        String autoCode = code.append(strNum).toString();
        return autoCode;
    }
}
