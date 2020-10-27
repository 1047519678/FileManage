package cn.mvc.service.impl;

import cn.mvc.dao.FileDataDao;
import cn.mvc.pojo.FileData;
import cn.mvc.service.FileDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class FileDataServiceImpl implements FileDataService {

    @Autowired
    public FileDataDao fileDataDao;

    @Override
    public boolean saveFile(FileData fileData) {
        return fileDataDao.insertFile(fileData) > 0;
    }

    @Override
    public boolean alterFileStatus(FileData fileData) {
        return fileDataDao.updateFileStatus(fileData) > 0;
    }

    @Override
    public int showFilesCountByDay(String factory, String account,String partNo, String uploadTime) {
        return fileDataDao.selectCountByDay(factory,account, partNo,uploadTime);
    }

    @Override
    public List<FileData> showFileByUser(String account) {
        List<FileData> fileDatas = fileDataDao.selectFileByUser(account);
        return fileDatas;
    }

    @Override
    public List<FileData> showFileByStatus(String userId, String status, String factory) {
        List<FileData> fileDatas = fileDataDao.selectFileByStatus(userId,status,factory);
        return fileDatas;
    }

    @Override
    public boolean checkDataUpload(String species, String factory, String fileName) {
        return fileDataDao.checkUpload(species,factory,fileName)>0;
    }

    @Override
    public List<FileData> GetDataBySel(String startTime, String endTime, String vendor, String species, String partNo, String status, String userId, String factory) {
        if (startTime != null && !"".equals(startTime)) {
            startTime += " 00:00:00";
        }
        if (endTime != null && !"".equals(endTime)) {
            endTime += " 23:59:59";
        }
        return fileDataDao.queryDataBySel(startTime, endTime, vendor, species, partNo, status, userId, factory);
    }

    @Override
    public List<FileData> GetDataByUserSel(String factory, String partNo, String shipTime, String account) {
        return fileDataDao.queryDataByUserSel(factory, partNo, shipTime, account);
    }

    @Override
    public List<Map<String, Object>> GetAccountList(String species) {
        return fileDataDao.accountList(species);
    }

    @Override
    public List<Map<String, Object>> GetAccountList2(String userId) {
        return fileDataDao.accountList2(userId);
    }
}
