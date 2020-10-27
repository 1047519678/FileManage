package cn.mvc.tools;

import cn.mvc.pojo.FileData;
import com.alibaba.fastjson.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class GetPageList {

    public GetPageList() {
    }

    public static JSONObject pageInfo(List<FileData> dataList, String page, String limit){
        List<FileData> dataListByLimit = new ArrayList<FileData>();
        int dataListSize = dataList.size();
        int minSize = (Integer.parseInt(page)-1) * Integer.parseInt(limit) + 1;
        int maxSize = Integer.parseInt(page) * Integer.parseInt(limit);
        int size = 0;
        if (dataList.iterator().hasNext()){
            for (FileData fileData : dataList){
                size++;
                if (size>=minSize && size<=maxSize){
                    dataListByLimit.add(fileData);
                }
            }
        }
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("count",dataListSize);
        json.put("data", dataListByLimit);
        return json;
    }
}
