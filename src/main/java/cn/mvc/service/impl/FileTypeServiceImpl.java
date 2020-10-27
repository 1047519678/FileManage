package cn.mvc.service.impl;


import cn.mvc.dao.FileTypeDao;
import cn.mvc.pojo.Delivery;
import cn.mvc.pojo.FileType;
import cn.mvc.pojo.FileTypeUser;
import cn.mvc.service.FileTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FileTypeServiceImpl implements FileTypeService {
    @Autowired
    public FileTypeDao fileTypeDao;

    @Override
    public boolean alterTypeNo(String typeNo, String userId) {
        return fileTypeDao.updateTypeNo(typeNo,userId) > 0;
    }

    @Override
    public FileTypeUser getTypeNoByUser(String userId) {
        return fileTypeDao.selectTypeNo(userId);
    }

    @Override
    public boolean setTypeNoByUser(String typeNo, String userId) {
        return fileTypeDao.insertTypeNo(typeNo,userId)>0;
    }

    @Override
    public List<FileType> getTypeNoList() {
        return fileTypeDao.typeNoList();
    }

    @Override
    public List<FileType> getQcTypeNoList(String userId) {
        return fileTypeDao.qcTypeNoList(userId);
    }

    @Override
    public List<Delivery> getPartNoList(String userId) {
        return fileTypeDao.partNoList(userId);
    }

}
