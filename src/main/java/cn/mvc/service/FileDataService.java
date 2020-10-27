package cn.mvc.service;

import cn.mvc.pojo.FileData;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface FileDataService {
    boolean saveFile(FileData fileData);

    boolean alterFileStatus(FileData fileData);

    int showFilesCountByDay(String factory, String account, String partNo, String uploadTime);

    List<FileData> showFileByUser(String account);

    List<FileData> showFileByStatus(String userId, String status, String factory);

    boolean checkDataUpload(String species, String factory, String fileName);

    //查询报表
    List<FileData> GetDataBySel(String startTime, String endTime, String vendor, String species,
                                String partNo, String status, String userId, String factory);

    //用户查询报表
    List<FileData> GetDataByUserSel(String factory, String partNo, String shipTime, String account);

    List<Map<String, Object>> GetAccountList(String species);
    List<Map<String, Object>> GetAccountList2(String userId);

}
