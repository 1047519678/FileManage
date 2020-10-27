package cn.mvc.service;


import cn.mvc.pojo.Test;

import java.util.Map;

public interface ExcelService {
    Map<String , Object> getDataInfo(Map<String, Object> map);
    int addDataByExcel(Test test);
    boolean selDataByCount(Test test);
}
