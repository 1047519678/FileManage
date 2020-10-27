package cn.mvc.dao;


import cn.mvc.pojo.FileData;
import cn.mvc.tools.DataSource;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@DataSource(value = "dataSource1")
public interface FileDataDao {
    int insertFile(FileData fileData);

    int updateFileStatus(FileData fileData);

    int selectCountByDay(@Param("factory") String factory, @Param("account") String account,
                         @Param("partNo") String partNo, @Param("uploadTime") String uploadTime);

    List<FileData> selectFileByUser(@Param("account") String account);

    List<FileData> selectFileByStatus(@Param("userId") String userId, @Param("status") String status, @Param("factory") String factory);

    //校验是否重复上传
    int checkUpload(@Param("species") String species, @Param("factory") String factory,@Param("fileName") String fileName);

    //查询报表
    List<FileData> queryDataBySel(@Param("startTime") String startTime, @Param("endTime") String endTime,
                                  @Param("vendor") String vendor, @Param("species") String species, @Param("partNo") String partNo,
                                  @Param("status") String status, @Param("userId") String userId, @Param("factory") String factory);

    //用户查询报表
    List<FileData> queryDataByUserSel(@Param("factory") String factory, @Param("partNo") String partNo,
                                      @Param("shipTime") String shipTime, @Param("account") String account);

    //查询列表厂商框
    List<Map<String, Object>> accountList(@Param("species") String species);
    //查询列表厂商框2
    List<Map<String, Object>> accountList2(@Param("userId") String userId);

}
