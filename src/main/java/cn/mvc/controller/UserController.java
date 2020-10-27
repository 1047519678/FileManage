package cn.mvc.controller;


import cn.mvc.pojo.*;
import cn.mvc.service.UserService;
import cn.mvc.tools.ExportExcelUtil;
import cn.mvc.tools.ExportExcelWrapper;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/user")
public class UserController {
    @Autowired
    public UserService userService;

    //正常访问login页面
    @RequestMapping("/userLogin")
    public String login() {
        return "userLogin";
    }

    //检查登陆
    @RequestMapping("/checkLogin")
    public String checkLogin(Model model, HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        User user = userService.checkLogin(userId, password);
        User user1 = userService.checkLogin2(userId, password);
        if (user != null) {
            if (user.getState() == 1) {
                //获取用户的权限
                Map<String, String> permissions = new HashMap<String, String>();
                List<String> permission = userService.getUserPermission(user.getUserId());
                if (permission.size() > 0) {
                    for (String p : permission) {
                        permissions.put(p, p);
                    }
                }
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("permissions", permissions);

                return "redirect:jumpSuperMain";
            } else {
                model.addAttribute("msg", "账号已停用！");
                return "userLogin";
            }
        } else if (user1 != null) {
            user1.setUserName(userId);
            HttpSession session = request.getSession();
            session.setAttribute("user", user1);
            return "redirect:jumpUserMain";
        }

        model.addAttribute("msg", "用户名或密码错误，请重新登录！");
        return "userLogin";
    }

    //跳转到用户主页面
    @RequestMapping("/jumpUserMain")
    public String jumpUserMain() {
        return "user/userMain";
    }

    //跳转到管理员主页面
    @RequestMapping("/jumpSuperMain")
    public String jumpSuperUserMain() {
        return "user/superMain";
    }

    //注销方法
    @RequestMapping("/userOutLogin")
    public String outLogin(HttpSession session) {
        //通过session.invalidata()方法来注销当前的session
        session.invalidate();
        return "redirect:userLogin";
    }


    //跳转账号添加类别页
    @RequestMapping("/userShowType")
    public String addShowType() {
        return "user/addShowType";
    }

    //获取用户
    @RequestMapping("/getUserList")
    @ResponseBody
    public List<user_account> getUserList(String factory, String userId, String userName) {
        List<user_account> user = userService.getUser(factory, userId, userName);
        return user;
    }


    //获取账号添加类别穿梭框内容
    @RequestMapping("/showListType")
    @ResponseBody
    public JSONObject showListType(HttpServletRequest request, String userId) {
        JSONObject jo = new JSONObject();
        System.out.println(userId);
        System.out.println(request.getParameter("userId"));
        List<FileType> userList = userService.getAllFileType();
//        List<String> str=new ArrayList<String>();
//        str.add("1");
        List<String> str = userService.getUserFileType(userId);
        jo.put("result", userList);
        jo.put("values", str);
        return jo;
    }

    //添加类别
    @RequestMapping("/addShowType")
    @ResponseBody
    public String addShowType(String data, String userId) {
        JSONArray jr = JSONArray.parseArray(data);
        List<ShuttleBox> list = jr.toJavaList(ShuttleBox.class);
        userService.addUserFileType(list, userId);
        System.out.println(list);

        return "";
    }

    //移除类别
    @RequestMapping("/delShowType")
    @ResponseBody
    public String delShowType(String data, String userId) {
        JSONArray jr = JSONArray.parseArray(data);
        List<ShuttleBox> list = jr.toJavaList(ShuttleBox.class);
        userService.delUserFileType(list, userId);
        System.out.println(list);
        return "";
    }

    //跳转用户管理界面
    @RequestMapping("/userInfo")
    public String userInfo() {
        return "user/userInfo";
    }

    //添加用户
    @RequestMapping("/instUserInfo")
    @ResponseBody
    public Map<String, String> instUserInfo(user_account user) {
        Map<String, String> map = new HashMap<String, String>();
        List<user_account> us = userService.getUserById(user.getUserId(), user.getFactory());
        if (us.size() > 0) {
            map.put("result", "工号对应账号已存在，请不要重复添加！");
        } else {
            int i = userService.instUserInfo(user);
            if (i > 0) {
                map.put("result", "提交成功");
            } else {
                map.put("result", "提交失败");
            }
        }
        return map;
    }

    //修改用户
    @RequestMapping("/upUserInfo")
    @ResponseBody
    public Map<String, String> upUserInfo(user_account user) {
        Map<String, String> map = new HashMap<String, String>();
        int i = userService.upUserInfo(user);
        if (i > 0) {
            map.put("result", "修改成功");
        } else {
            map.put("result", "修改失败");
        }
        return map;
    }

    //删除用户
    @RequestMapping("/delUserInfo")
    @ResponseBody
    public Map<String, String> upUserInfo(String userId, HttpServletRequest request) {
        Map<String, String> map = new HashMap<String, String>();
        HttpSession session = request.getSession(true);
        Map<String, String> permissions = (Map<String, String>) session.getAttribute("permissions");
        if (permissions.get("u4") != null) {
            int i = userService.delUserInfo(userId);
            if (i > 0) {
                map.put("result", "删除成功");
            } else {
                map.put("result", "删除失败");
            }
        } else {
            map.put("result", "你没有删除用户的权限！");
        }
        return map;
    }

    //跳转用户权限界面
    @RequestMapping("/userPermission")
    public String userPermission() {
        return "user/userPermission";
    }

    //获取权限信息
    @RequestMapping("/getPermissionList")
    @ResponseBody
    public List<user_permission> getPermissionList() {
        List<user_permission> up = userService.getPermissionList();
        return up;
    }

    //添加权限
    @RequestMapping("/inPermission")
    @ResponseBody
    public Map<String, String> inPermission(user_permission up) {
        Map<String, String> map = new HashMap<String, String>();
        List<user_permission> upList = userService.getPermissionByNo(up.getNo());
        if (upList.size() > 0) {
            map.put("result", "权限编号已存在，请不要重复添加");
        } else {
            int i = userService.inPermission(up);
            if (i > 0) {
                map.put("result", "添加成功");
            } else {
                map.put("result", "添加失败");
            }
        }
        return map;
    }

    //更新权限
    @RequestMapping("/upPermission")
    @ResponseBody
    public Map<String, String> upPermission(user_permission up) {
        Map<String, String> map = new HashMap<String, String>();
        int i = userService.upPermission(up);
        if (i > 0) {
            map.put("result", "更新成功");
        } else {
            map.put("result", "更新失败");
        }
        return map;
    }

    //获取账号添加权限穿梭框内容
    @RequestMapping("/showListPermission")
    @ResponseBody
    public JSONObject showListPermission(HttpServletRequest request, String userId) {
        JSONObject jo = new JSONObject();
        System.out.println(userId);
        System.out.println(request.getParameter("userId"));
        List<user_permission> upList = userService.getPermissionList();

        List<String> str = userService.getUserPermission(userId);
        jo.put("result", upList);
        jo.put("values", str);
        return jo;
    }

    //用户添加权限
    @RequestMapping("/addUserPermission")
    @ResponseBody
    public String addUserPermission(String data, String userId) {
        JSONArray jr = JSONArray.parseArray(data);
        List<ShuttleBox> list = jr.toJavaList(ShuttleBox.class);
        userService.addUserPermission(list, userId);
        System.out.println(list);

        return "";
    }

    //用户移除权限
    @RequestMapping("/delUserPermission")
    @ResponseBody
    public String delUserPermission(String data, String userId) {
        JSONArray jr = JSONArray.parseArray(data);
        List<ShuttleBox> list = jr.toJavaList(ShuttleBox.class);
        userService.delUserPermission(list, userId);
        System.out.println(list);
        return "";
    }

    //导出用户
    @RequestMapping("/getUserExcel")
    public void getUserExcel(String factory, String userId, String userName, HttpServletRequest request, HttpServletResponse resp) {
        List<user_account> user = userService.getUser(factory, userId, userName);
        String[] columnNames = {"序号", " 工号", " 姓名", " 部门", "电话", " 邮箱地址", "状态", "厂别"};
        String fileName = "账号表";
        ExportExcelWrapper<user_account> util = new ExportExcelWrapper<user_account>();
        util.exportExcel(fileName, fileName, columnNames, user, resp,
                ExportExcelUtil.EXCEL_FILE_2003);

    }

    //修改密码
    @RequestMapping("/changePwd")
    @ResponseBody
    public  Map<String, String> changePwd(String oldPwd, String newPwd,  HttpServletRequest request) {
        Map<String, String> map = new HashMap<String, String>();
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                //验证原来密码是否正确
               if(oldPwd.equals(user.getPassword())){
                   //更新密码
                   int i=userService.upPwd(newPwd,user.getUserId(),user.getFactory());
                   if(i>0){
                       map.put("msg", "修改成功");
                   }else {
                       map.put("msg", "修改失败");
                   }
               }else {
                   map.put("msg", "原来密码不正确");
               }
            }
        }else {
            map.put("msg", "修改失败");
        }


        return map;
    }

}
