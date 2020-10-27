package cn.mvc.dao;

import cn.mvc.pojo.Test;
import cn.mvc.tools.DataSource;

import java.util.Map;

@DataSource(value = "dataSource2")
public interface ExploreDao {
    Map<String , Object> selDataInfo(Map<String, Object> map);
}
