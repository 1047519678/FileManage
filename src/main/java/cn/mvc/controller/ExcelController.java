package cn.mvc.controller;

import cn.mvc.pojo.Test;
import cn.mvc.service.ExcelService;
import cn.mvc.tools.POIUtils;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/excel")
public class ExcelController {
    @Autowired
    private ExcelService excelService;

    private static Logger logger = LoggerFactory.getLogger(POIUtils.class);

    @RequestMapping(value = "/read")
    @ResponseBody
    public JSONObject readFile(MultipartFile file) {
        JSONObject json = new JSONObject();
        List list = null;
        //String create = DateUtils.getDateTime2("yyyyMMdd");
        String filename = file.getOriginalFilename();
        List<Test> dataList = new ArrayList<>();
        if (filename!=null){
            if (filename.endsWith("xls") || filename.endsWith("xlsx")) {
                try {
                    list = POIUtils.readExcel(file, 0, Test.class);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                json.put("code", 1);
                json.put("msg", "解析出错，请确保文档格式正确后，刷新重试！");
                return json;
            }
        }
        if (list!=null){
            if (list.iterator().hasNext()) {
                for (Object obj : list) {
                    Test test = (Test) obj;
                    if (excelService.selDataByCount(test)){
                        test.setReason("该物料条码数据库已存在！");
                        dataList.add(test);
                    }else{
                        try{
                            excelService.addDataByExcel(test);
                        }catch (Exception e){
                            test.setReason("插入失败！");
                            dataList.add(test);
                            e.printStackTrace();
                        }
                    }
                }
                json.put("code", 0);
                json.put("msg", "文件解析完成！");
                json.put("dataList", dataList);
            }
        }else{
            json.put("code", 1);
            json.put("msg", "解析出错，请确保文档格式正确后，刷新重试！");
        }
        return json;
    }
}
