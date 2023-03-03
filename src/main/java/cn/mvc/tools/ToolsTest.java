package cn.mvc.tools;

import cn.mvc.pojo.Email;
import cn.mvc.pojo.User;
import cn.mvc.service.EmailService;
import cn.mvc.service.ExcelService;
import cn.mvc.service.UserService;
import com.alibaba.fastjson.JSON;
import com.github.houbb.opencc4j.util.ZhConverterUtil;
import org.apache.commons.codec.CharEncoding;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFFormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.*;


class TicketThread implements Runnable {
    //票数
    private int tickets = 50;
    //锁对象：阻塞，达到锁的目的
    final Object obj = new Object();

    @Override
    public void run() {
        while (true) {
            //同步
            synchronized (obj) {
                if (tickets > 0) {
                    System.out.println(Thread.currentThread().getName() + "卖出第：" + tickets-- + " 张票");
                } else {
                    break;
                }
            }
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println(Thread.currentThread().getName() + "卖完了");
    }
}

//实现callable接口的call方法
class NumThread implements Callable<Object> {

    private int sum = 0;//

    //可以抛出异常
    @Override
    public Object call() throws Exception {
        for (int i = 0; i <= 100; i++) {
            if (i % 2 == 0) {
                System.out.println(Thread.currentThread().getName() + ":" + i);
                sum += i;
            }
        }
        return sum;
    }
}

@Component
public class ToolsTest {
    @Autowired
    private RedisCacheUtil redisCacheUtil;
    @Autowired
    private RedisCacheUtil1 redisCacheUtil1;
    @Autowired
    private ExcelService excelService;
    @Autowired
    private UserService userService;
    @Autowired
    private EmailService emailService;


    private final static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public static void main(String[] args) throws UnsupportedEncodingException {
        /*Map<Object, Object> map = new HashMap<>();
        map.put("userId", "sdasda");
        map.put("passWord", "sdasda");
        byte[] bytes = SerializeUtil.serialize(map);
        String str = new String(bytes,"ISO-8859-1");
        byte[] sInput = str.getBytes();
        Map<Object, Object> map1 = (Map<Object, Object>) SerializeUtil.unSerialize(sInput);
        System.out.println(sInput);*/

        Map<Object, Object> map = new HashMap<>();
        map.put("userId", "sdasda");
        map.put("passWord", "sdasda");
        byte[] bytes = SerializeUtil.serialize(map);
        String aaa = new String(bytes, StandardCharsets.ISO_8859_1);
        Map<Object, Object> map1 = (Map<Object, Object>) SerializeUtil.unSerialize(bytes);
        Map<Object, Object> map2 = (Map<Object, Object>) SerializeUtil.unSerialize(aaa.getBytes(StandardCharsets.ISO_8859_1));
        System.out.println(map2);
        // Java调用dos命令示例。
        /*String cmd = "cmd /c " + "ping www.baidu.com & ipconfig & ping www.baidu.com";
        try {
            Process process = Runtime.getRuntime().exec(cmd);
            InputStream is = process.getInputStream();
            InputStreamReader isr = new InputStreamReader(is, "GBK");
            BufferedReader br = new BufferedReader(isr);
            String content = br.readLine();
            while (content != null) {
                System.out.println(content);
                content = br.readLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }*/

        // callable接口示例。
        /*ExecutorService executor = Executors.newCachedThreadPool();
        NumThread numThread = new NumThread();
        //通过futureTask对象的get方法来接收futureTask的值
        FutureTask<Object> futureTask = new FutureTask<>(numThread);
//        Thread t = new Thread(futureTask);
//        t.setName("线程1");
//        t.start();
        executor.submit(futureTask);
        executor.shutdown();
        try {
            // get返回值即为FutureTask构造器参数callable实现类重写的call的返回值
            Object sum = futureTask.get();
            System.out.println(Thread.currentThread().getName() + ":" + sum);
        } catch (ExecutionException | InterruptedException e) {
            e.printStackTrace();
        }*/

        // runnable接口示例。
        TicketThread tt = new TicketThread();
        Thread t1 = new Thread(tt, "窗口一");
        Thread t2 = new Thread(tt, "窗口二");
        Thread t3 = new Thread(tt, "窗口三");
        Thread t4 = new Thread(tt, "窗口四");
        t1.start();
        t2.start();
        t3.start();
        t4.start();

        // 获取数组最大值连续出现的次数示例。
        /*int[] a = {9,3,11,14,14,14,12,14,14,7,0,0,0,6,13,14,14,14,14,14,14,14,14,14,14,10,14,0,14,14,0,14,0,0,11,14,13,13,14,13,14,14,11,13,0,5,9,11,11,14,13,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
        int b = 14;
        int cont = 0;
        int maxNum = 0;
        for (int value : a) {
            if (value == b) {
                cont++;
                if (cont > maxNum) maxNum = cont;
            } else if (value == 0){
                cont = maxNum;
            } else cont = 0;
        }
        System.out.println(maxNum);*/

        // 繁简体转换示例。
        /*String code = "聯系电话";
        String fanti= ZhConverterUtil.convertToTraditional(code);
        String jianti = ZhConverterUtil.convertToSimple(code);
        System.out.println(fanti + "+" +jianti);*/
        /*Map<String, String> map = new HashMap<>();
        map.put("a", "a");
        map.put("b", "b");
        map.put("c", "c");
        map.put("d", "d");
        System.out.println("map拉姆达表达式遍历:");
        map.forEach((k, v) -> {
            System.out.println("k=" + k + "，v=" + v);
        });*/

    }

    //@Scheduled(cron = "0 0/1 * * * ?")
    public void test() {
        // RedisTemplate调用
        System.out.println("start：测试1");
        User user = userService.checkLogin("C72454", "123");
        // 传入时对象序列化
        redisCacheUtil.set("user", SerializeUtil.serialize(user));
        // 将取出的数据反序列化并强制转换为java对象
        User u = (User) SerializeUtil.unSerialize((byte[]) redisCacheUtil.get("user"));
        System.out.println(u);

        // 传入Map测试
        Map<Object, Object> map = new HashMap<>();
        map.put("userId", user.getUserId());
        map.put("passWord", user.getPassword());
        redisCacheUtil.set("map", SerializeUtil.serialize(map));
        Map<Object, Object> map1 = (Map<Object, Object>) SerializeUtil.unSerialize((byte[]) redisCacheUtil.get("map"));
        System.out.println(map1);

        /*redisCacheUtil.hmset("user1", map);
        Map<Object, Object> map1 = redisCacheUtil.hmget("user1");
        System.out.println(redisCacheUtil.hmget("user1"));
        System.out.println(JSON.toJSONString(map1));
        System.out.println("end：测试1");
        // StringRedisTemplate调用
        System.out.println("start：测试2");
        // 传入时对象序列化
        System.out.println(JSON.toJSONString(user));
        redisCacheUtil1.set("user2", JSON.toJSONString(user));
        // 将取出的数据反序列化并强制转换为java对象
        User u1 = JSON.parseObject(redisCacheUtil1.get("user2"), User.class);
        System.out.println(u1.getPassword());
        // 传入Map测试
        redisCacheUtil1.hmset("user3", map);
        Map<Object, Object> map2 = redisCacheUtil1.hmget("user3");
        System.out.println(redisCacheUtil1.hmget("user3"));
        System.out.println(JSON.toJSONString(map2));
        System.out.println("end：测试2");*/
    }

    @Scheduled(cron = "0/10 * * * * ?")
    public void run_test() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Workbook workbook = null;
        FormulaEvaluator formulaEvaluator = null;
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        //calendar.setTime(sdf.parse("2020-07-24"));
        String endTime = sdf.format(calendar.getTime());
        String fileName = null;
        int monthDay = calendar.get(Calendar.DAY_OF_MONTH);
        for (int j = monthDay; j >= 2; j--) {
            calendar.add(Calendar.DAY_OF_MONTH, -1);
            String startTime = sdf.format(calendar.getTime());
            int mouth = calendar.get(Calendar.MONTH) + 1;
            int year = calendar.get(Calendar.YEAR);
            fileName = "D:/自動化線线生產数据" + year + "年" + mouth + "月.xlsx";
            FileInputStream fs;
            int lie = calendar.get(Calendar.DAY_OF_MONTH) + 4;
            int hang = 12;
            try {
                fs = new FileInputStream(fileName);
                if (fileName.endsWith("xls")) {
                    //  2003版本
                    workbook = new HSSFWorkbook(fs);
                    formulaEvaluator = new HSSFFormulaEvaluator((HSSFWorkbook) workbook);
                } else if (fileName.endsWith("xlsx")) {
                    //  2007版本
                    workbook = new XSSFWorkbook(fs);
                    formulaEvaluator = new XSSFFormulaEvaluator((XSSFWorkbook) workbook);
                }
                fs.close();
                //int sss = workbook.getNumberOfSheets();
                if (workbook != null) {
                    CellStyle cellStyle = workbook.createCellStyle();
                    cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
                    cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0"));
                    for (int i = 1; i <= 8; i++) {
                        Sheet sheet = workbook.getSheetAt(i);
                        String line = sheet.getSheetName().substring(0, 4);
                        //String productModel = sheet.getRow(2).getCell(0).getStringCellValue().substring(3);
                        Row row = sheet.getRow(1);
                        row.getCell(0).setCellValue("月份：" + year + "年" + mouth + "月");
                        row = sheet.getRow(4);
                        row.getCell(3).setCellValue(mouth + "月目标");
                        FileOutputStream out = new FileOutputStream(fileName);
                        Map<String, Object> param = new HashMap<>();
                        param.put("line", line);
                        param.put("startDateTime", startTime);
                        param.put("endDateTime", endTime);
                        Map<String, Object> map = excelService.getDataInfo(param);
                        if (map.size() > 0) {
                            for (Map.Entry<String, Object> entry : map.entrySet()) {
                                String key = entry.getKey();
                                //Object value = entry.getValue();
                                if ("real_out".equals(key)) {
                                    row = sheet.getRow(9);
                                    row.getCell(lie).setCellValue((int) entry.getValue());
                                    row.getCell(lie).setCellStyle(cellStyle);
                                } else if ("yield".equals(key.substring(key.length() - 5))) {
                                    row = sheet.getRow(hang);
                                    row.getCell(lie).setCellValue(entry.getValue().toString());
                                    hang++;
                                } else {
                                    row = sheet.getRow(hang);
                                    row.getCell(lie).setCellValue((int) entry.getValue());
                                    row.getCell(lie).setCellStyle(cellStyle);
                                    hang++;
                                }
                            }
                            hang = 12;
                        }
                        for (int f = 1; f <= 48; f++) {
                            row = sheet.getRow(hang);
                            formulaEvaluator.evaluateFormulaCell(row.getCell(4));
                            hang++;
                        }
                        hang = 12;
                        out.flush();
                        workbook.write(out);
                        out.close();
                        //System.out.println(map);
                    }
                }
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            endTime = startTime;
        }
        System.out.println("111");

        // 发送邮件
        List<String> list1 = new ArrayList<>();
        List<Email> list = emailService.GetSendToList(100010);
        if (list.iterator().hasNext()) {
            for (Email Email : list) {
                list1.add(Email.getEmail());
            }
        }
        String[] sendTo = list1.toArray(new String[0]);
        //String[] sendTo = {"Junjia_Chen@phihong.com.tw"};
        emailService.Send(sendTo, "自动化报表", "", fileName);
        //System.out.println(fileName.substring(fileName.lastIndexOf("/") + 1) + "   " + Arrays.toString(sendTo));
    }
}
