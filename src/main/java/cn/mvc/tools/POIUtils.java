package cn.mvc.tools;

import cn.mvc.pojo.Ref;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class POIUtils {


    public static List<String> supportTypeList =
            Arrays.asList("int", "Integer", "float", "Float", "long", "Long", "double", "Double", "String");

    /**
     * 主方法
     *
     * @param file     excel文件流
     * @param sheetNum 第sheetNum个表格
     * @param clazz    实体class
     * @return
     * @throws Exception
     */
    public static List readExcel(MultipartFile file, int sheetNum, Class clazz) throws Exception {
        //1.读取Excel文档对象
        //将class的Field的名称<name, setName()>记录到map中
        Map<String, Method> setMethodMap = new HashMap<>();
        for (Field field : clazz.getDeclaredFields()) {
            String name = field.getName().replaceAll(" ","");
            if ("采购订单".equals(name) || "採購訂單".equals(name)) {
                name = "poNo";
            } else if ("订单项次".equals(name) || "訂單項次".equals(name)) {
                name = "itemNo";
            } else if ("物料编号".equals(name) || "料件編號".equals(name)) {
                name = "partNo";
            } else if ("物料编码".equals(name) || "物料條碼".equals(name)) {
                name = "selfSn";
            } else if ("数量".equals(name) || "數量".equals(name)) {
                name = "incomingQty";
            } else if ("DC".equals(name)) {
                name = "dateCode";
            } else if ("总数量".equals(name) || "總數量".equals(name)) {
                name = "sumQty";
            } else if ("总件数".equals(name) || "總件數".equals(name)) {
                name = "sumPack";
            } else if ("LOTNO".equals(name)) {
                name = "lotNo";
            } else if ("外箱箱号".equals(name)) {
                name = "outCarton";
            }
            if (supportTypeList.contains(field.getType().getSimpleName())) {
                try {
                    Method setMethod = clazz.getDeclaredMethod(
                            "set" + String.valueOf(name.charAt(0)).toUpperCase() + field.getName().substring(1),
                            field.getType());
                    setMethodMap.put(name, setMethod);
                } catch (NoSuchMethodException e) {
                    continue;
                }

            }
        }

        ArrayList excelData = new ArrayList<>();
        Workbook workbook = null;
        try {
            //File file = new File(fileName);
            String filename = file.getOriginalFilename();
            InputStream inputStream = file.getInputStream();
            System.out.println(filename);

            //InputStream resourceAsStream = POIUtils.class.getClassLoader().getResourceAsStream(fileName);
            //hssfWorkbook = new HSSFWorkbook(resourceAsStream);

            //  根据后缀名是否excel文件
            if (filename.endsWith("xls")) {
                //  2003版本
                workbook = new HSSFWorkbook(inputStream);
            } else if (filename.endsWith("xlsx")) {
                //  2007版本
                workbook = new XSSFWorkbook(inputStream);
            }

            Sheet sheet = workbook.getSheetAt(sheetNum);

            for (int i = 0; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                // 删除空行
                if (isRowEmpty(row)) {
                    int lastRow = sheet.getLastRowNum();
                    if (i >= 0 && i < lastRow) {
                        sheet.shiftRows(i + 1, lastRow, -1);// 将行号为i+1一直到行号为lastRowNum的单元格全部上移一行，以便删除i行
                    }
                    if (i == lastRow) {
                        if (row != null) {
                            sheet.removeRow(row);
                        }
                    }
                    i--;
                }
            }
            int lastRowNum = sheet.getLastRowNum();
            //Ref为了将第一行标题取出来
            Ref<List> listRef = new Ref<>();
            getSingleRow(sheet, 0, setMethodMap, listRef, clazz);//<1,name>

            //将每一行的数据注入到class实例中并保存在list中
            for (int i = 1; i <= lastRowNum; i++) {
                Object singleRow = getSingleRow(sheet, i, setMethodMap, listRef, clazz);
                excelData.add(singleRow);
            }
            return excelData;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据传入的clazz 将每一行的数据填充到clazz.instance的实例中，然后返回
     *
     * @param sheet
     * @param rowNum    取第rownum行
     * @param setMethod class中所有属性对应set属性方法的map映射；譬如class类中 public String name; 就会有-> <name, setName()>
     * @param listRef   引用，从参数取方法中的某个局部变量的引用
     * @param clazz     实例类变量
     * @return
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     * @throws NoSuchFieldException
     */
    private static Object getSingleRow(Sheet sheet, int rowNum, Map<String, Method> setMethod, Ref<List> listRef, Class clazz) throws Exception {
        Row row = sheet.getRow(rowNum);
        if (!checkRow(row, rowNum, setMethod)) {
            System.out.println("err: 第" + (rowNum + 1) + "行數據有误");
            throw new Exception("PoiUtil -> excel文件有誤");
        }
        //此次读取是否为标题行读取
        boolean titleRow = (rowNum == 0 && Objects.isNull(listRef.ref));
        List<Object> rowData = new ArrayList<>();
        Object instance = clazz.newInstance();
        int lastCellNum = row.getLastCellNum() & '\uffff'; //盗poi的...
        for (int j = 0; j < lastCellNum; j++) {
            Cell cell = row.getCell(j);
            Object value;
            if (titleRow) {
                value = getValueFromCell(cell, String.class).toString().replaceAll(" ","");
                if ("采购订单".equals(value) || "採購訂單".equals(value)) {
                    value = "poNo";
                } else if ("订单项次".equals(value) || "訂單項次".equals(value)) {
                    value = "itemNo";
                } else if ("物料编号".equals(value) || "料件編號".equals(value)) {
                    value = "partNo";
                } else if ("物料编码".equals(value) || "物料條碼".equals(value)) {
                    value = "selfSn";
                } else if ("数量".equals(value) || "數量".equals(value)) {
                    value = "incomingQty";
                } else if ("DC".equals(value)) {
                    value = "dateCode";
                } else if ("总数量".equals(value) || "總數量".equals(value)) {
                    value = "sumQty";
                } else if ("总件数".equals(value) || "總件數".equals(value)) {
                    value = "sumPack";
                } else if ("LOTNO".equals(value)) {
                    value = "lotNo";
                } else if ("外箱箱号".equals(value)) {
                    value = "outCarton";
                }
                rowData.add(j, value);
            } else {
                //实例化Class对象，并注入数据
                Field declaredField = clazz.getDeclaredField(String.valueOf(listRef.ref.get(j)));
                Class<?> type = declaredField.getType();
                value = getValueFromCell(cell, type);
                Method set = setMethod.get(listRef.ref.get(j));
                set.invoke(instance, value);
            }
        }
        if (titleRow) {
            listRef.ref = rowData;
        }
        return instance;
    }

    /**
     * 获取单元格内容
     *
     * @param cell        单元格
     * @param expectClazz 期望的单元格内容的数据类型
     * @return
     */
    private static Object getValueFromCell(Cell cell, Class expectClazz) {
        Object value = null;
        //**--更改**String typeName = expectClazz.getTypeName();
        String typeName = expectClazz.getSimpleName();

        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                value = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    Date date = cell.getDateCellValue();
                    if (date != null) {
                        if (typeName.equals("String")) {
                            value = new SimpleDateFormat("yyyy-MM-dd").format(date);
                        }
                        if (typeName.equals("Date")) {
                            value = date;
                        }
                    } else {
                        value = null;
                    }
                } else {
                    Double cellValue = cell.getNumericCellValue();
                    value = new DecimalFormat("0").format(cellValue);
                    //做一个基本类型的兼容
                    if (typeName.equals("int") || typeName.equals("Integer")) {
                        value = cellValue.intValue();
                    }
                    if (typeName.equals("double") || typeName.equals("Double")) {
                        value = cellValue.doubleValue();
                    }
                    if (typeName.equals("float") || typeName.equals("Float")) {
                        value = cellValue.floatValue();
                    }
                    if (typeName.equals("long") || typeName.equals("Long")) {
                        value = cellValue.longValue();
                    }
                }
                break;
            case HSSFCell.CELL_TYPE_FORMULA:
                // 导入时如果为公式生成的数据则无值
                if (!cell.getStringCellValue().equals("")) {
                    value = cell.getStringCellValue();
                } else {
                    value = cell.getNumericCellValue() + "";
                }
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                break;
            case HSSFCell.CELL_TYPE_ERROR:
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                value = cell.getBooleanCellValue();
                break;
            default:
                value = null;
        }
        return value;
    }


    private static boolean checkRow(Row row, int rowNum, Map<String, Method> setMethod) {
        int lastCellNum = row.getLastCellNum() & '\uffff'; //盗poi的...
        if (lastCellNum > setMethod.keySet().size()) {
            return false;
        }
        return true;
    }

    public static boolean isRowEmpty(Row row) {
        for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
            Cell cell = row.getCell(i);
            if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK) {
                return false;
            }
        }
        return true;
    }

    //-----------------------测试代码
    public static void main(String[] args) {
//        try {
//            List list = readExcel("E:\\testempy.xlsx", 0, Empy.class);
//            list.forEach(sence->{
//                System.out.println(sence.toString());
//            });
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }
}
