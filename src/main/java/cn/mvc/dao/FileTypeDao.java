package cn.mvc.dao;

import cn.mvc.pojo.Delivery;
import cn.mvc.pojo.FileType;
import cn.mvc.pojo.FileTypeUser;
import cn.mvc.tools.DataSource;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@DataSource(value = "dataSource1")
public interface FileTypeDao {

    int updateTypeNo(@Param("typeNo") String typeNo, @Param("userId") String userId);

    FileTypeUser selectTypeNo(@Param("userId") String userId);

    int insertTypeNo(@Param("typeNo") String typeNo, @Param("userId") String userId);

    //文件类别List
    List<FileType> typeNoList();

    //qc人员负责的文件类别List
    List<FileType> qcTypeNoList(@Param("userId") String userId);

    //厂商所属料号List
    List<Delivery> partNoList(@Param("userId") String userId);
}
