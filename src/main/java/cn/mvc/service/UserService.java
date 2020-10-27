package cn.mvc.service;


import cn.mvc.pojo.*;

import java.util.List;

public interface UserService {
    //IQC用户登录
    public User checkLogin(String userId, String password);

    //供应商用户登录
    public User checkLogin2(String userId, String password);

    List<user_account> getUser(String factory,String userId,String userName);

    /**
     * 获取所有类型
     */
    List<FileType> getAllFileType();

    /**
     * 获取用户对应的类型
     * @param userId
     * @return
     */
    List<String> getUserFileType(String userId);

    /**
     * 用户添加类型
     * @param list
     * @param userId
     */
    void addUserFileType(List<ShuttleBox> list, String userId);

    /**
     * 用户移除类型
     * @param list
     * @param userId
     */
    void delUserFileType(List<ShuttleBox> list,String userId);

    /**
     * 新增用户
     */
    int instUserInfo(user_account user);

    /**
     * 修改用户
     */
    int upUserInfo(user_account user);

    /**
     * 删除用户
     */
    int delUserInfo(String userId);

    /**
     * 通过用户id查询用户信息
     */
    List<user_account> getUserById(String userId,String factory);

    /**
     * 获取权限信息
     */
    List<user_permission> getPermissionList();

    /**
     * 通过权限编号获取权限信息
     */
    List<user_permission> getPermissionByNo(String no);

    /**
     * 新增权限
     */
    int inPermission(user_permission up);

    /**
     * 更新权限
     */
    int upPermission(user_permission up);

    /**
     * 通过用户id获取用户权限
     */
    List<String> getUserPermission(String userId);

    /**
     * 用户添加权限
     */
    void addUserPermission(List<ShuttleBox> sbox,String userId);

    /**
     * 用户移除权限
     */
    void delUserPermission(List<ShuttleBox> sbox,String userId);

    /**
     * 修改密码
     */
    int upPwd(String pwd,String userId,String factory);

}
