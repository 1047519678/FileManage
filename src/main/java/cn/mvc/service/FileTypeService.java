package cn.mvc.service;

import cn.mvc.pojo.Delivery;
import cn.mvc.pojo.FileType;
import cn.mvc.pojo.FileTypeUser;

import java.util.List;

public interface FileTypeService {
    boolean alterTypeNo(String typeNo, String userId);

    public FileTypeUser getTypeNoByUser(String userId);

    boolean setTypeNoByUser(String typeNo, String userId);

    List<FileType> getTypeNoList();

    List<FileType> getQcTypeNoList(String userId);

    List<Delivery> getPartNoList(String userId);
}
