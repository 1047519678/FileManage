<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>登录页面</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <style>
        body {
            background-image: url(<%=basePath%>img/bg/beijing1.jpg);
        }

        input {
            box-sizing: border-box;
            border: 1px solid rgba(0, 0, 0, 1.00);
            color: #000000;
            text-decoration: none;
            width: 100%;
            font-family: "幼圆";
        }
    </style>
</head>
<body>
<div style="text-align: center;padding: 18% 0px;">
    <div class="layui-inline">
        <div class="layui-card" style="/*background: center;*/">
            <div class="layui-card-header">用户登录</div>
            <div class="layui-card-body">
                <form class="layui-form layui-form-pane" id="loginForm" action="checkLogin" onsubmit="mycheck()">
                    <div class="layui-form-item">
                        <label class="layui-form-label">账号</label>
                        <div class="layui-input-inline">
                            <input type="username" name="account" required lay-verify="username" placeholder="请输入账号"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <i class="layui-icon" style="font-size: 30px; color: #1E9FFF;"></i>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码</label>
                        <div class="layui-input-inline">
                            <input type="password" name="password" required lay-verify="password" placeholder="请输入密码"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <i class="layui-icon layui-icon-password" style="font-size: 30px; color: #1E9FFF;"></i>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">登录</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                    <br />
                    <p align="center"><front size="2">${msg}</front></p>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="<%=basePath%>layui/layui.all.js"></script>
<script src="<%=basePath%>js/jquery.min.js"></script>
<script>
    function mycheck() {
        if (isNull(loginForm.account.value)) {
            alert("请输入用户名！");
            return false;
        }
        if (isNull(loginForm.password.value)) {
            alert("请输入密码！");
            return false;
        }
    }

    function isNull(str) {
        if (str === "") return true;
        var regu = "^[ ]+$";
        var re = new RegExp(regu);
        return re.test(str);
    }
</script>
</body>
</html>