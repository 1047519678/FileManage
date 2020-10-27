package cn.mvc.service.impl;


import cn.mvc.dao.UserDao;
import cn.mvc.pojo.*;
import cn.mvc.service.UserService;
import cn.mvc.tools.timeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    public UserDao userDao;

    @Override
    public User checkLogin(String userId, String password) {
        User user = userDao.login(userId);
        if (user != null && password.equals(user.getPassword()))
            return user;
        else
            return null;
    }

    @Override
    public User checkLogin2(String userId, String password) {
        User user = userDao.vendorLogin(userId);
        if (user != null && password.equals(user.getPassword()))
            return user;
        else
            return null;
    }

    @Override
    public List<user_account> getUser(String factory,String userId,String userName) {
        List<user_account> user = userDao.getUser(factory,userId,userName);
        return user;
    }


    @Override//获取所有类型
    public List<FileType> getAllFileType() {
        List<FileType> fileType = userDao.getAllFileType();
        return fileType;
    }

    @Override//获取用户类型
    public List<String> getUserFileType(String userId) {
        List<String> str = userDao.getUserFileType(userId);
        return str;
    }

    @Override//用户添加类型
    public void addUserFileType(List<ShuttleBox> list, String userId) {
        for (ShuttleBox s : list) {
            userDao.addUserFileType(s.getValue(), userId, timeUtil.now());
        }
    }

    @Override//用户移除类型
    public void delUserFileType(List<ShuttleBox> list, String userId) {
        for (ShuttleBox s : list) {
            userDao.delUserFileType(s.getValue(), userId);
        }
    }

    @Override//新增用户
    public int instUserInfo(user_account user) {
        user.setCreate_date(timeUtil.now());

        int i= userDao.instUserInfo(user);

        return i;

    }

    @Override//修改用户
    public int  upUserInfo(user_account user){
        int i= userDao.upUserInfo(user);
        return i;
    }

    @Override//删除用户
    public int delUserInfo(String userId){
        //删除用户表信息
        int i=userDao.delUserInfo(userId);
        //删除对应权限信息
        userDao.delUserPermissionByUserId(userId);
        //删除对应类别信息
        userDao.delUserFileTypeByUserId(userId);
        return i;
    }

    @Override//通过用户id查询用户信息
    public List<user_account> getUserById(String userId,String factory){
        List<user_account> us=userDao.getUserById(userId,factory);
        return  us;
    }

    @Override//获取权限信息
    public  List<user_permission> getPermissionList(){
        List<user_permission> up=userDao.getPermissionList();
        return up;
    }

    @Override//通过权限获取权限信息
    public List<user_permission> getPermissionByNo(String no){
        List<user_permission> up=userDao.getPermissionByNo(no);
        return up;
    }

    @Override//添加权限
    public int inPermission(user_permission up){
        up.setCreate_date(timeUtil.now());
        int i= userDao.inPermission(up);
        return i;
    }

    @Override//更新权限
    public  int upPermission(user_permission up){
        int i=userDao.upPermission(up);
        return i;
    }

    @Override//通过用户ID获取用户权限
    public List<String> getUserPermission(String userId){
        List<String> upr=userDao.getUserPermission(userId);
        return upr;
    }

    @Override//用户添加权限
    public void addUserPermission(List<ShuttleBox> sbox,String userId){
        for (ShuttleBox s:sbox) {
            userDao.addUserPermission(s.getValue(),userId,timeUtil.now());
        }
    }

    @Override//用户移除权限
    public void delUserPermission(List<ShuttleBox> sbox,String userId){
        for (ShuttleBox s:sbox) {
            userDao.delUserPermission(s.getValue(),userId);
        }
    }
    @Override//修改密码
    public int upPwd(String pwd,String userId,String factory){
        int i=userDao.upPwd(pwd,userId,factory);
        return i;
    }

}
