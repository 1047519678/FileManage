package cn.mvc.dao;

import cn.mvc.pojo.FileType;
import cn.mvc.pojo.User;
import cn.mvc.pojo.user_account;
import cn.mvc.pojo.user_permission;
import cn.mvc.tools.DataSource;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

@DataSource(value = "dataSource1")
public interface UserDao {
    //IQC用户登录
    User login(@Param("userId") String userId);

    //供应商用户登录
    User vendorLogin(@Param("userId") String userId);

    //通过厂别查询用户信息
    List<user_account> getUser(@Param("factory")String factory,@Param("userId")String userId,@Param("userName")String userName);

    //查询全部类别信息
    @Select("select typeNo,typeName from fileType")
    List<FileType> getAllFileType();

    //通过用户id查询对应类别
    @Select("select distinct typeNo from fileType_user where userId=#{userId}")
    List<String> getUserFileType(String userId);

    //添加用户类别
    void addUserFileType( @Param("typeNo")String typeNo,@Param("userId") String userId,@Param("create_date") Date create_date);

    //通过用户id和类型编号移除用户对应类别
    @Delete("delete fileType_user where typeNo=#{typeNo} and userId=#{userId}")
    void delUserFileType(@Param("typeNo")String typeNo,@Param("userId")String userId);

    //通过用户id移除用户对应类别
    @Delete("delete fileType_user where userId=#{userId}")
    void delUserFileTypeByUserId(@Param("userId")String userId);

    //添加用户信息
    int instUserInfo(user_account user);

    //修改用户信息
    int upUserInfo(user_account user);

    //移除用户信息
    @Delete("delete user_account where userId=#{userId}")
    int delUserInfo(@Param("userId")String userId);

    //通过用户id及厂别查询用户信息
    @Select("select id,userId ,userName,password,department,factory,phone,email,state from user_account where userId=#{userId} and factory=#{factory}")
    List<user_account> getUserById(@Param("userId")String userId,@Param("factory")String factory);

    //查询所有权限信息
    @Select("select id,no,name,remark from user_permission")
    List<user_permission>getPermissionList();

    //新增权限
    int inPermission(user_permission up);
    //修改权限
    int upPermission(user_permission up);

    //通过权限编号查询权限信息
    @Select("select  id,no,name,remark from user_permission where no=#{no}")
    List<user_permission>getPermissionByNo(@Param("no")String no);

    //通过用户id查询对应的权限
    @Select("select distinct permission from user_permission_relation where userId=#{userId}")
    List<String> getUserPermission(@Param("userId")String userId);


    //添加用户的权限信息
    void addUserPermission( @Param("permission")String permission,@Param("userId") String userId,@Param("create_date") Date create_date);

    //通过用户id和权限编号移除用户的权限信息
    @Delete("delete user_permission_relation where userId=#{userId} and permission=#{permission}")
    void delUserPermission(@Param("permission")String permission,@Param("userId")String userId);

    //通过用户id移除用户对应权限
    @Delete("delete user_permission_relation where userId=#{userId}")
    void delUserPermissionByUserId(@Param("userId")String userId);

    //修改密码
    int upPwd(@Param("pwd")String pwd,@Param("userId")String userId,@Param("factory")String factory);

}
